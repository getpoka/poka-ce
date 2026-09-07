#!/usr/bin/env node

/**
 * Poka CE Issue Triage & Bug Report Checker
 * Analyzes GitHub issues and comments with /triage or /check using DeepSeek API.
 * Uses codebase grounding (real file index, database schema, snippet extraction) and comment upserting.
 */

const fs = require('fs');
const path = require('path');

const ALLOWED_ASSOCIATIONS = new Set(['OWNER', 'MEMBER']);

const ALLOWED_LABELS = new Set([
  'bug',
  'enhancement',
  'question',
  'needs-info',
  'database',
  'accounts',
  'budgets',
  'categories',
  'debts',
  'goals',
  'recurring',
  'transactions',
  'ui',
]);

const TRIAGE_COMMENT_IDENTIFIER = '<!-- poka-issue-triage-report -->';

/**
 * Recursively collect non-generated Dart files under lib/
 */
function collectDartFiles(dir) {
  let list = [];
  if (!fs.existsSync(dir)) return list;
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const entry of entries) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      list = list.concat(collectDartFiles(full));
    } else if (
      entry.isFile() &&
      entry.name.endsWith('.dart') &&
      !entry.name.endsWith('.g.dart') &&
      !entry.name.endsWith('.freezed.dart')
    ) {
      list.push(full.replace(/\\/g, '/'));
    }
  }
  return list;
}

/**
 * Extract relevant code snippets from lib/ based on issue content
 */
function extractSnippets(issueText, allFiles) {
  const snippets = [];
  const addedFiles = new Set();

  // 1. Stack traces / file paths with optional line numbers
  const fileRegex = /(?:package:poka_ce\/|lib\/|[(\s/])([a-zA-Z0-9_\/]+\.dart)(?::(\d+))?/gi;
  let match;
  while ((match = fileRegex.exec(issueText)) !== null) {
    const rawFile = match[1];
    const lineNum = match[2] ? parseInt(match[2], 10) : null;
    const target = allFiles.find((f) => f.endsWith(rawFile));
    if (target && !addedFiles.has(target)) {
      addedFiles.add(target);
      try {
        const lines = fs.readFileSync(target, 'utf8').split('\n');
        if (lineNum && lineNum > 0 && lineNum <= lines.length) {
          const start = Math.max(0, lineNum - 25);
          const end = Math.min(lines.length, lineNum + 25);
          snippets.push({
            file: target,
            lines: `${start + 1}-${end}`,
            code: lines.slice(start, end).join('\n'),
          });
        } else {
          snippets.push({
            file: target,
            lines: `1-${Math.min(lines.length, 100)}`,
            code: lines.slice(0, 100).join('\n'),
          });
        }
      } catch (e) {
        console.warn(`Could not read file ${target}:`, e.message);
      }
    }
  }

  // 2. Specific identifiers in backticks or function calls
  const idRegex = /`([a-zA-Z0-9_]{4,})`|([a-zA-Z0-9_]{4,})\(/g;
  const ids = new Set();
  while ((match = idRegex.exec(issueText)) !== null) {
    const id = match[1] || match[2];
    if (
      id &&
      !['const', 'final', 'await', 'async', 'false', 'true', 'null', 'class', 'void', 'return', 'import'].includes(id)
    ) {
      ids.add(id);
    }
  }

  for (const id of ids) {
    if (snippets.length >= 4) break;
    for (const f of allFiles) {
      if (addedFiles.has(f)) continue;
      try {
        const content = fs.readFileSync(f, 'utf8');
        if (content.includes(id)) {
          addedFiles.add(f);
          const lines = content.split('\n');
          const idx = lines.findIndex((l) => l.includes(id));
          if (idx !== -1) {
            const start = Math.max(0, idx - 15);
            const end = Math.min(lines.length, idx + 35);
            snippets.push({
              file: f,
              matchedIdentifier: id,
              lines: `${start + 1}-${end}`,
              code: lines.slice(start, end).join('\n'),
            });
          }
          break;
        }
      } catch (e) {
        // ignore read error
      }
    }
  }

  // 3. Fallback: Domain keywords if snippets are still sparse
  if (snippets.length === 0) {
    const domainMap = {
      budget: 'lib/database/daos/budgets_dao.dart',
      transaction: 'lib/database/daos/transactions_dao.dart',
      transfer: 'lib/database/daos/transactions_dao.dart',
      debt: 'lib/database/daos/debts_dao.dart',
      loan: 'lib/database/daos/debts_dao.dart',
      goal: 'lib/database/daos/goals_dao.dart',
      pocket: 'lib/database/daos/accounts_dao.dart',
      account: 'lib/database/daos/accounts_dao.dart',
      category: 'lib/database/daos/categories_dao.dart',
      recurring: 'lib/database/daos/recurring_dao.dart',
    };

    const lower = issueText.toLowerCase();
    for (const [kw, file] of Object.entries(domainMap)) {
      if (lower.includes(kw) && allFiles.includes(file) && !addedFiles.has(file)) {
        addedFiles.add(file);
        try {
          const lines = fs.readFileSync(file, 'utf8').split('\n');
          snippets.push({
            file: file,
            matchedKeyword: kw,
            lines: `1-${Math.min(lines.length, 80)}`,
            code: lines.slice(0, 80).join('\n'),
          });
        } catch (e) {
          // ignore
        }
        if (snippets.length >= 2) break;
      }
    }
  }

  return snippets;
}

async function main() {
  const token = process.env.GITHUB_TOKEN;
  if (!token) {
    console.error('Missing GITHUB_TOKEN');
    process.exit(1);
  }

  // Strictly use DeepSeek API key (accommodate OPENAI_KEY if set on repo)
  const apiKey = process.env.DEEPSEEK_API_KEY || process.env.OPENAI_KEY;
  if (!apiKey) {
    console.error('Missing DEEPSEEK_API_KEY or OPENAI_KEY');
    process.exit(1);
  }

  const eventPath = process.env.GITHUB_EVENT_PATH;
  if (!eventPath || !fs.existsSync(eventPath)) {
    console.error('Event payload file not found');
    process.exit(1);
  }

  const event = JSON.parse(fs.readFileSync(eventPath, 'utf8'));

  // 1. Prevent bot loops and spam
  const isBot =
    event.sender?.type === 'Bot' ||
    event.comment?.user?.type === 'Bot' ||
    event.sender?.login?.endsWith('[bot]') ||
    event.comment?.user?.login?.endsWith('[bot]');
  if (isBot) {
    console.log('Event triggered by a bot account. Skipping execution.');
    return;
  }

  const repoFullName = process.env.GITHUB_REPOSITORY;
  if (!repoFullName) {
    console.error('Missing GITHUB_REPOSITORY');
    process.exit(1);
  }

  const [owner, repo] = repoFullName.split('/');

  // Determine trigger context
  const issue = event.issue;
  const comment = event.comment;
  const isCommentTrigger = Boolean(comment);

  // If triggered by issue_comment
  if (isCommentTrigger) {
    const commentBody = comment.body || '';
    const hasCommand = /\/(triage|check)\b/i.test(commentBody);
    if (!hasCommand) {
      console.log('No /triage or /check command found in comment. Skipping.');
      return;
    }

    const authorAssociation = comment.author_association;
    if (!ALLOWED_ASSOCIATIONS.has(authorAssociation)) {
      console.log(
        `User @${comment.user?.login} has author_association "${authorAssociation}", which is not authorized to trigger triage commands. Skipping.`
      );
      return;
    }

    // Add eyes reaction to indicate processing
    await addReaction(owner, repo, comment.id, 'eyes', token);
  } else if (issue) {
    // If triggered by issues: opened
    const issueAuthorAssociation = issue.author_association;
    if (!ALLOWED_ASSOCIATIONS.has(issueAuthorAssociation)) {
      console.log(
        `Issue opened by @${issue.user?.login} with author_association "${issueAuthorAssociation}". Only OWNER or MEMBER can trigger automated triage. Skipping.`
      );
      return;
    }
  } else {
    console.log('Not an issue or issue_comment event. Skipping.');
    return;
  }

  // Ensure issue object is available
  if (!issue) {
    console.error('Issue data missing from payload');
    process.exit(1);
  }

  const issueNumber = issue.number;
  const issueTitle = issue.title || '';
  const issueBody = issue.body || '(No description provided)';
  const author = issue.user?.login || 'unknown';
  const existingLabels = (issue.labels || []).map((l) => l.name);

  console.log(`Analyzing issue #${issueNumber}: "${issueTitle}"`);

  // Gather ground-truth context from checked-out repository
  const allDartFiles = collectDartFiles('lib');
  const relevantSnippets = extractSnippets(`${issueTitle}\n${issueBody}`, allDartFiles);

  let dbSchemaContext = '';
  const schemaPath = '.agents/rules/database-schema.md';
  if (fs.existsSync(schemaPath)) {
    try {
      dbSchemaContext = fs.readFileSync(schemaPath, 'utf8');
    } catch (e) {
      console.warn('Could not read database schema rule:', e.message);
    }
  }

  // Build prompt
  const systemPrompt = `You are the automated AI Issue & Bug Triage Assistant for "Poka CE", an open-source Flutter personal-finance app (single-currency, local-first).

Architecture & Tech Stack:
- Local database: SQLite managed with Drift (tables: accounts, budgets, budget_records, categories, debts, goals, recurring_transactions, transactions, transaction_items, settings, currencies).
- State management: flutter_riverpod (using @riverpod annotation), hooks_riverpod, flutter_hooks.
- UI: ForUI component library (FScaffold, FButton, FCard, etc.) with Phosphor Icons. Strictly NO Material widgets (Scaffold, AppBar, etc.), NO shadows.
- Architecture pattern: 3-layer feature structure (data/repositories, domain/freezed models & use cases, presentation/controllers & screens/widgets).
- Core Principles: Strictly single-currency, UUIDv7 primary keys, Result<T, Failure> error handling (no throw in repos/notifiers), strict typing (zero dynamic), CE blindness (no cloud sync or multi-currency).

You are provided with real source code snippets and verified repository file paths. Base your analysis directly on the real codebase, avoiding hypothetical assumptions.

Formatting Instructions:
1. **Header & Summary**:
   - Use heading level 3: \`### 1. Summary\`.
   - Write a concise 1-2 sentence overview. Use **bold inline** for key technical terms.
2. **Quality Assessment Table**:
   - Use a 3-column Markdown table: \`| Kriteria | Status | Catatan |\`.
   - Use visual status emojis:
     - \`🟢 Clear\` / \`🟡 Partial\` / \`🔴 Missing\` for Steps to Reproduce, Expected vs Actual, and Environment / Logs.
     - \`🚀 Ready to Investigate\` / \`⚠️ Needs More Info\` for Overall Verdict.
3. **Technical Root Cause & Affected Areas**:
   - Use heading level 3: \`### 3. Technical Root Cause & Affected Areas\`.
   - Use a bullet list for **Suspected Feature Area** and **Target Files** (format file paths in inline code backticks, referencing ONLY real files that exist in the repository).
   - Wrap the technical hypothesis inside a Markdown blockquote (\`>\`).
4. **Action Items**:
   - Use heading level 3: \`### 4. Action Items\`.
   - Divide into two sub-headings: \`#### 👤 For Reporter\` and \`#### 🛠️ For Maintainer / Developer\`.
   - Use GitHub Task List format (\`- [ ]\`) for all checklist items so they can be interactively checked.
5. **Suggested Labels**:
   - Use heading level 3: \`### 5. Suggested Labels\`.
   - Display suggested labels as inline code chips (e.g. \`bug\` \`database\` \`transactions\`).
   - Allowed labels: "bug", "enhancement", "question", "needs-info", "database", "accounts", "budgets", "categories", "debts", "goals", "recurring", "transactions", "ui".
   - On a separate line at the very end, include the exact machine marker:
     LABELS_JSON: ["label1", "label2"]

Strict Output Template (Follow this exact format):
### 1. Summary
[1-2 focused sentences summarizing the problem with **bold inline** technical keywords.]

### 2. Quality Assessment
| Kriteria | Status | Catatan |
|---|---|---|
| Steps to Reproduce | 🟢 Clear | [Brief evaluation] |
| Expected vs Actual | 🟢 Clear | [Brief evaluation] |
| Environment / Logs | 🟡 Partial | [Brief evaluation] |
| Overall Verdict | 🚀 Ready to Investigate | [Brief conclusion] |

### 3. Technical Root Cause & Affected Areas
- **Suspected Feature Area**: [Feature Area Name]
- **Target Files**:
  - \`lib/database/daos/...\`
  - \`lib/features/...\`

> **Technical Hypothesis**: [Concise explanation of the suspected cause or required changes based on the real code.]

### 4. Action Items
#### 👤 For Reporter
- [ ] [Action or clarification needed from reporter]

#### 🛠️ For Maintainer / Developer
- [ ] [Investigation, test case, or implementation step]

### 5. Suggested Labels
\`label1\` \`label2\`

LABELS_JSON: ["label1", "label2"]`;

  // Build grounded code snippets section
  let codeSnippetSection = '';
  if (relevantSnippets.length > 0) {
    codeSnippetSection = `\n\n---
### Real Code Snippets Retrieved From Repository:
${relevantSnippets
  .map(
    (s) => `#### File: \`${s.file}\` (Lines ${s.lines}):
\`\`\`dart
${s.code}
\`\`\``
  )
  .join('\n\n')}`;
  }

  // Build database schema reference
  let dbSchemaSection = '';
  if (dbSchemaContext) {
    dbSchemaSection = `\n\n---
### Database Schema & Business Logic Reference:
${dbSchemaContext}`;
  }

  // Build file catalog sample
  const fileCatalogSample = `\n\n---
### Verified Repository Files (lib/):
${allDartFiles.join('\n')}`;

  const userPrompt = `Issue Number: #${issueNumber}
Title: ${issueTitle}
Author: @${author}
Existing Labels: ${existingLabels.join(', ') || 'None'}

Body:
${issueBody}
${codeSnippetSection}
${dbSchemaSection}
${fileCatalogSample}`;

  // Strictly use DeepSeek API & models
  const baseUrl = 'https://api.deepseek.com';
  const rawModel = (process.env.PR_AGENT_MODEL || 'deepseek-chat').trim();
  let model = rawModel.replace(/^deepseek\//i, '').replace(/^openai\//i, '');
  if (!['deepseek-chat', 'deepseek-reasoner'].includes(model)) {
    model = 'deepseek-chat';
  }

  console.log(`Calling DeepSeek API at ${baseUrl} using model ${model}...`);
  const response = await fetch(`${baseUrl}/chat/completions`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${apiKey}`,
    },
    body: JSON.stringify({
      model: model,
      temperature: 0.2,
      messages: [
        { role: 'system', content: systemPrompt },
        { role: 'user', content: userPrompt },
      ],
    }),
  });

  if (!response.ok) {
    const errorText = await response.text();
    console.error(`DeepSeek API failed with status ${response.status}: ${errorText}`);
    process.exit(1);
  }

  const data = await response.json();
  const replyContent = data.choices?.[0]?.message?.content || '';

  if (!replyContent) {
    console.error('Empty response from LLM');
    process.exit(1);
  }

  // 3 & 4. Robust LABELS_JSON parsing, extraction, whitelist, and deduplication
  let suggestedLabels = [];
  let cleanMarkdown = replyContent;

  const labelsRegex = /(?:^|\n)\s*(?:`{1,3}(?:json)?\s*)?(?:\*{0,2})LABELS_JSON(?:\*{0,2})\s*[:\s]+(?:\*{0,2})\s*(?:`{1,3}(?:json)?\s*)?(\[[\s\S]*?\])(?:\s*`{1,3})?/i;
  const labelsMatch = replyContent.match(labelsRegex);

  if (labelsMatch) {
    try {
      const parsed = JSON.parse(labelsMatch[1]);
      if (Array.isArray(parsed)) {
        const existingSet = new Set(existingLabels.map((l) => l.toLowerCase()));
        suggestedLabels = [
          ...new Set(
            parsed
              .map((label) => (typeof label === 'string' ? label.trim().toLowerCase() : ''))
              .filter((label) => ALLOWED_LABELS.has(label) && !existingSet.has(label))
          ),
        ];
      }
    } catch (e) {
      console.warn('Could not parse LABELS_JSON:', e.message);
    }

    // Clean up LABELS_JSON marker block while preserving visual label chips
    cleanMarkdown = replyContent
      .replace(new RegExp(labelsRegex.source, 'gi'), '')
      .trim();
  }

  // Add signature footer
  const commentText = `## 🤖 Poka Triage Report\n\n${cleanMarkdown}\n\n---\n*Automated triage powered by Poka Triage Assistant. Re-run anytime by commenting \`/triage\` or \`/check\`.*`;

  // Upsert triage report comment (update existing comment or create a new one)
  await upsertComment(owner, repo, issueNumber, commentText, token);

  // Apply suggested labels (only whitelisted and not already present)
  if (suggestedLabels.length > 0) {
    console.log(`Applying suggested labels: ${suggestedLabels.join(', ')}`);
    await applyLabels(owner, repo, issueNumber, suggestedLabels, token);
  } else {
    console.log('No new labels to apply.');
  }

  // If comment triggered, add rocket reaction to the trigger comment
  if (isCommentTrigger) {
    await addReaction(owner, repo, comment.id, 'rocket', token);
  }

  console.log('Triage finished successfully!');
}

async function addReaction(owner, repo, commentId, reaction, token) {
  try {
    await fetch(`https://api.github.com/repos/${owner}/${repo}/issues/comments/${commentId}/reactions`, {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${token}`,
        Accept: 'application/vnd.github+json',
        'User-Agent': 'poka-ce-triage-bot',
      },
      body: JSON.stringify({ content: reaction }),
    });
  } catch (e) {
    console.warn(`Failed to add reaction ${reaction}:`, e.message);
  }
}

/**
 * Upsert triage comment: checks if a triage comment with identifier exists;
 * updates it if found, or creates a new comment if not found.
 */
async function upsertComment(owner, repo, issueNumber, body, token) {
  const fullBody = `${TRIAGE_COMMENT_IDENTIFIER}\n${body}`;

  let existingCommentId = null;
  try {
    const listRes = await fetch(
      `https://api.github.com/repos/${owner}/${repo}/issues/${issueNumber}/comments?per_page=100`,
      {
        headers: {
          Authorization: `Bearer ${token}`,
          Accept: 'application/vnd.github+json',
          'User-Agent': 'poka-ce-triage-bot',
        },
      }
    );

    if (listRes.ok) {
      const comments = await listRes.json();
      if (Array.isArray(comments)) {
        const found = comments.find(
          (c) => typeof c.body === 'string' && c.body.includes(TRIAGE_COMMENT_IDENTIFIER)
        );
        if (found) {
          existingCommentId = found.id;
        }
      }
    } else {
      console.warn(`Failed to fetch comments (status ${listRes.status}).`);
    }
  } catch (err) {
    console.warn('Could not check existing comments:', err.message);
  }

  if (existingCommentId) {
    console.log(`Found existing triage comment #${existingCommentId}. Updating in place...`);
    const patchRes = await fetch(
      `https://api.github.com/repos/${owner}/${repo}/issues/comments/${existingCommentId}`,
      {
        method: 'PATCH',
        headers: {
          Authorization: `Bearer ${token}`,
          Accept: 'application/vnd.github+json',
          'User-Agent': 'poka-ce-triage-bot',
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ body: fullBody }),
      }
    );

    if (!patchRes.ok) {
      const text = await patchRes.text();
      console.error(`Failed to update comment: ${patchRes.status} ${text}`);
    } else {
      console.log(`Successfully updated existing triage comment #${existingCommentId}`);
    }
  } else {
    console.log(`Posting new triage comment to issue #${issueNumber}...`);
    const postRes = await fetch(
      `https://api.github.com/repos/${owner}/${repo}/issues/${issueNumber}/comments`,
      {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${token}`,
          Accept: 'application/vnd.github+json',
          'User-Agent': 'poka-ce-triage-bot',
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ body: fullBody }),
      }
    );

    if (!postRes.ok) {
      const text = await postRes.text();
      console.error(`Failed to post comment: ${postRes.status} ${text}`);
    } else {
      console.log('Successfully posted new triage comment.');
    }
  }
}

async function applyLabels(owner, repo, issueNumber, labels, token) {
  const res = await fetch(`https://api.github.com/repos/${owner}/${repo}/issues/${issueNumber}/labels`, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${token}`,
      Accept: 'application/vnd.github+json',
      'User-Agent': 'poka-ce-triage-bot',
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ labels }),
  });

  if (!res.ok) {
    const text = await res.text();
    console.warn(`Failed to apply labels: ${res.status} ${text}`);
  }
}

main().catch((err) => {
  console.error('Fatal error in triage script:', err);
  process.exit(1);
});
