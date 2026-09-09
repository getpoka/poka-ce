# Roadmap & Execution Plan Toward Poka CE v1.0.0

This document provides a structured roadmap, test scenarios, decision protocols, and strategic recommendations starting from **Release Candidate 1 (`v1.0.0-rc.1`)** through the official **`v1.0.0`** release and beyond.

> **Timeline Principle:** The smoke testing phase is asynchronous and flexible, accommodating your schedule without rigid time constraints.

---

## 📌 Current Status

- **Active Version:** `1.0.0-rc.1+6` (Published as GitHub pre-release).
- **Codebase State:** **Feature & Code Freeze** — No new feature scope for v1.0. Strict focus on stability, local-first data integrity, and release build performance.

---

## 🧪 Phase 1: Real-World Smoke Testing & Validation Scenarios

As an offline-first personal finance app built on SQLite (Drift), testing focuses heavily on **data integrity, balance mutations, and production APK stability**.

### 1. Database Integrity & Balance Mutations (Critical)
- [x] **Standard & Split Transactions:**
  - Create Income, Expense, and Transfer transactions, as well as Split Transactions (single receipt with multiple line items).
  - Verify that item totals always validate properly and balance mutations on source/destination accounts update accurately in real time.
- [x] **5-Second Undo Delete:**
  - Delete a transaction, then tap **Undo** before the toast dismisses. Ensure items, account balance mutations, and linked budget histories are fully restored.
  - Delete a transaction and let the toast expire (permanent delete). Verify that balance reversals and budget deductions remain intact.
- [x] **Accounts & Sub-Wallet (Pocket) Calculations:**
  - Create a main account (e.g., Bank Account) and multiple Pockets beneath it (e.g., Vacation Savings, Emergency Fund).
  - Verify that the parent account balance accurately aggregates all pocket balances.
  - Verify that starting balances are stored directly in `initial_balance` without dummy initial transactions.
- [x] **Overdraft Prevention (Warning Dialog):**
  - Create an expense or transfer exceeding available account balance.
  - Ensure the insufficient balance warning dialog appears correctly and the *Review* / *Proceed* actions function as expected.
- [x] **Recurring Transactions (Scheduled Bills):**
  - Create recurring bills on daily/monthly schedules.
  - Verify that when the due date arrives, the transaction automatically generates in the transaction list and the next schedule date advances properly.

### 2. Data Portability & Safety (Critical)
- [x] **Backup & Restore JSON:**
  - Create a diverse set of accounts, categories, budgets, and transactions.
  - Export a backup file via `Settings → Backup & Export` (`.json`).
  - Clear app data or reinstall the app, open the fresh instance, and perform **Restore Backup**.
  - **Verification:** Ensure 100% of accounts, pockets, categories, transactions, and budget records restore seamlessly without corrupted relations.
- [ ] **Backup Reminder:**
  - Configure reminder intervals (Weekly / Monthly / Off).
  - Ensure last backup timestamps track and display accurately.
- [x] **Multi-Sheet Excel Export (`.xlsx`):**
  - Export financial reports to Excel.
  - Open the file in Microsoft Excel or Google Sheets. Confirm that Accounts, Categories, and Transactions sheets format correctly with clean numbers and proper UTF-8 character encoding.

### 3. Production Release Build on Physical Android Device
- [x] **Install Release APK:**
  - Download `app-arm64-v8a-release.apk` from GitHub Release `v1.0.0-rc.1` and install it on an actual physical Android phone.
- [ ] **Verify R8 / ProGuard Minification:**
  - Confirm that the app runs smoothly without unexpected crashes when accessing reports, donut charts, or form sheets (verifying ProGuard keep rules for Drift, Freezed, and JSON serialization).
- [x] **Android App Shortcuts:**
  - Long-press the Poka icon on the Android launcher.
  - Confirm shortcuts (*Add Transaction*, *Add Account*, *Add Category*, *Add Goal*) render crisp vector icons and launch directly into their respective creation sheets.
- [x] **Bilingual & Theme Switching:**
  - Switch between English and Indonesian in `Settings → Language`. Ensure text labels do not clip or revert to raw translation keys.
  - Toggle between Light and Dark themes. Ensure color contrast remains sharp and flat UI elements maintain visual separation through borders and layering.

---

## ⚖️ Phase 2: Decision Protocol (Bug Triage)

During testing, handle any discovered issues according to severity:

| Severity | Examples | Action Required |
| :--- | :--- | :--- |
| **Blocker / Critical** | App crashes, data loss, balance miscalculations, backup restore failure, R8 minification errors | **Must Fix Immediately.** Commit fix, bump build to `1.0.0-rc.2+7`, and release RC2. |
| **Minor / Cosmetic** | Minor typo in copy, 1–2px margin misalignment, minor animation hitch | **Defer to v1.0.1.** Log in backlog to avoid delaying v1.0.0 stability. |

### Sign-Off Criteria for v1.0.0:
1. All database integrity scenarios (CRUD, Undo Delete, Backup Restore) pass cleanly.
2. The release APK runs without crashes on physical Android hardware.
3. No open issues labeled as blockers.

---

## 🚀 Phase 3: v1.0.0 Launch Execution Steps

Once smoke testing concludes and the candidate is deemed stable, follow this deployment sequence:

### Step 1: Bump Version in `pubspec.yaml`
Set version to the official release:
```yaml
version: 1.0.0+7
```

### Step 2: Finalize `CHANGELOG.md`
Promote `[Unreleased]` / RC section into the official v1.0.0 milestone:
```markdown
## [v1.0.0] - YYYY-MM-DD

🎉 Official Stable Release of Poka Community Edition!

Poka CE reaches its first official milestone: a 100% offline-first, private personal finance manager built with Flutter and SQLite. Your financial data stays strictly on your device.

### Highlights
- 100% Offline-first local storage via Drift (SQLite).
- Split Transactions with multi-category allocation.
- 5-second Undo Delete for transactions and pockets.
- Multi-account management with parent-child pocket hierarchies.
- Bilingual localization (English & Bahasa Indonesia).
- Multi-sheet Excel (.xlsx) export and secure JSON backup & restore.
- Zero-shadow flat design system powered by ForUI.
```
Update comparison links at the bottom:
```markdown
[Unreleased]: https://github.com/getpoka/poka-ce/compare/v1.0.0...main
[v1.0.0]: https://github.com/getpoka/poka-ce/releases/tag/v1.0.0
```

### Step 3: Run Mandatory Quality Checks
```bash
rune fix
rune check    # Must report: "No issues found!"
rune test     # Ensure unit, feature, and e2e test suites pass
```

### Step 4: Commit, Tag, & Push
```bash
git add pubspec.yaml CHANGELOG.md
git commit -m "chore: release official version 1.0.0"
git tag -a v1.0.0 -m "Official release v1.0.0"
git push origin main
git push origin v1.0.0
```

### Step 5: Publish GitHub Release
Create the official (non-prerelease) release:
```bash
gh release create v1.0.0 --title "Poka CE v1.0.0 — Official Release" --notes "..."
```
GitHub Actions (`release.yml`) will automatically:
1. Build final Universal and Split APKs.
2. Attach release binaries to the GitHub release.
3. Trigger the Cloudflare deploy hook to update `getpoka.app`.

---

## 📢 Phase 4: Distribution & Public Visibility Strategy

Following the v1.0.0 launch, these distribution channels will expand reach and user trust:

1. **Submit to F-Droid (Highly Recommended)**
   - Poka CE is Apache 2.0 licensed and 100% open-source without proprietary binaries or trackers, making it a prime candidate for **F-Droid**.
   - F-Droid is the primary distribution channel for privacy-conscious users seeking offline-first software.
2. **Setup IzzyOnDroid Repository First**
   - While official F-Droid review may take several weeks, submit to [IzzyOnDroid](https://apt.izzysoft.de/fdroid/) first.
   - IzzyOnDroid syncs APKs directly from GitHub Releases automatically.
3. **Align Landing Page (`poka-ln`)**
   - Ensure `getpoka.app`:
     - Removes beta badges and messaging.
     - Points download buttons directly to the latest v1.0.0 APK assets.
4. **Community Showcase**
   - Share the v1.0.0 launch across relevant channels:
     - **Reddit:** r/selfhosted, r/androidapps, r/FlutterDev, r/indonesia.
     - **Product Hunt & Hacker News (Show HN):** Emphasize *"100% Offline, No Account Needed, No Analytics, Zero-Shadow Flat Design"*.

---

## 🔮 Phase 5: Post-v1 Roadmap (Looking Ahead to v1.1+)

Candidate features for subsequent minor releases:

1. **Biometric Security (App Lock):**
   - Add fingerprint / Face ID / PIN authentication via `local_auth` when returning from background.
2. **CSV Import Wizard:**
   - Allow users to migrate financial data from other apps (e.g., Money Lover, Wallet, Bluecoins) via customizable CSV mapping.
3. **Cashflow Flow Chart (Sankey Diagram):**
   - Visual flow of funds from income sources into wallets and out across expense categories.
4. **Desktop Support (macOS / Linux / Windows):**
   - Package native desktop builds leveraging Flutter and Drift's desktop SQLite engine.
