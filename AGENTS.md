# AGENTS.md — Poka CE

Single Flutter app (not monorepo). `lib/main.dart` → `ProviderScope(overrides: [sharedPreferences])` → `PokaApp` (`lib/app/`). Feature-first: `lib/{app,core,database,features,shared,theme,i18n}`.

## Commands

```bash
flutter run --dart-define-from-file=.env        # .env required — copy .env.example (POKA_ENABLE_SEEDER=true)
flutter build apk --dart-define-from-file=.env
make generate  # dart run build_runner build — add --delete-conflicting-outputs if stale
make check     # dart fix --apply && flutter analyze — must be "No issues found!" before done
make fix       # dart fix --apply
flutter test test/path/to/foo_test.dart         # single test; test/ must mirror lib/
flutter test --coverage                         # coverage gate 85%, lcov at coverage/lcov.info
```

## Codegen & env gotchas

- One codegen pass covers all: Riverpod (`@riverpod` + `riverpod_generator`), Freezed, Drift (`lib/database/database.g.dart`), `slang` (`lib/i18n/*.i18n.json` → `strings.g.dart`), `go_router_builder` (`lib/app/router/router.g.dart`). Rerun `make generate` after any annotation/table/i18n change.
- `forui.yaml` → `lib/theme/styles/` + `lib/theme/theme.dart`. Never style Forui widgets inline — `dart run forui style create <component>`.
- `.env` via `String.fromEnvironment` (`lib/core/config.dart: AppConfig.enableSeeder`, `bool.fromEnvironment('POKA_ENABLE_SEEDER')`). Drift `PRAGMA foreign_keys = ON` at `lib/database/database.dart:70`.
- Lints: `very_good_analysis`, `formatter.page_width:120`, `strict-casts/inference/raw-types:true` — no `dynamic`, explicit generics (`Future<void>`, `List<String>`). Excludes in `analysis_options.yaml`: `**/*.g.dart`, `**/*.freezed.dart`, `lib/i18n/strings*.g.dart`, `build/`, `test/`.

## Architecture (read before editing)

- **CE blindness (absolute)** — CE is single-currency, no `syncStatus`/`deletedAt`/`currency` fields, no `if(isEE)` or EE imports/comments. Must compile if EE deleted. EE overrides only via `ProviderScope(overrides: [...])` / polymorphism. See `.agents/rules/agent_rules.md` + `system_design.md`.
- **3-layer per feature** `features/<name>/{data,domain,presentation}` (`presentation/{controllers,screens,widgets}`). `lib/database/` owns Drift exclusively — tables in `tables/`, DAOs in `daos/`.
- **Domain mapping** — UI/widgets never import Drift `*Data` classes. Repository maps row → `freezed` domain model. Pass currency strings via widget constructors, never store in domain/DB.
- **State** — `@riverpod` notifiers; UI only `ref.watch` + call methods, zero business logic in widgets. Hooks for controllers (`useTextEditingController`). `slang` for i18n (no `BuildContext`).
- **Error handling** — `Result<T, Failure>` (`lib/core/error/result.dart` + `failure.dart`) — never `throw` in repos/notifiers. Exhaustive `switch` on `Success`/`ErrorResult` (`DatabaseFailure`/`ValidationFailure`/`UnexpectedFailure`).
- **DB invariants** (`lib/database/database.dart`, `schemaVersion: 2`): enums lowercase (`income`/`expense`/`transfer`), `accounts.balance` init `0` (initial balance = `income` tx), header-item `transactions`/`transaction_items` (sum must match header `amount`), hard-delete with balance + `budget_records` reversal, goal = auto `Goal`-type pocket, `recurring_transactions.next_date` automation on startup, debt/loan = paired income/expense tx + `debt_id`.

## UI constraints

- `forui` only — no `Scaffold`/`AppBar`/`ElevatedButton`. Use `FScaffold`, `FButton`, `FCard`, etc. **No shadows ever** (`boxShadow`/`elevation` forbidden) — flat with borders/gradients/alpha.
- `FScaffold` already pads SafeArea → `ListView`/`SingleChildScrollView` needs `padding: EdgeInsets.zero`; don't use `childPad: false` unless bleed needed.
- Spacing: sections `20`, sheet body `EdgeInsets.fromLTRB(12,0,12,0)`, header→body `12`, form fields `12`, save button `20`. Transaction sheet tighter: tab→account `10`, account→calc `14`, category/pocket gaps `6`, reserved `18` for history, meta bar `top:2 bottom:6`.
- `PokaIcon` (`lib/shared/widgets/poka_icon.dart`) for all account/category/pocket icons (`small`36/`medium`42/`large`48/`hero`64); on gradients use `Container(white 0.2)+Icon(white)` without border.

## Testing & workflow

- `test/` must mirror `lib/` exactly. Helpers: `test/coverage_booster_test.dart`, `test/notifiers_coverage_test.dart`. Mutation testing via `mutation_test` dev dep.
- Conventional Commits: `feat:`/`fix:`/`ui:` with business-descriptive subject (no filenames/class names in subject — details in body). Amend same-task follow-ups (`git commit --amend`), don't auto-commit unless asked.
- `opencode.json` loads `.agents/rules/*.md` (agent_rules, forui-rules, database_schema, system_design, graphify) + missing `CONTRIBUTING.md`; MCPs `flutter` (`dart mcp-server`) and `graphify` (`uv run ... graphify.serve ./graphify-out/graph.json`).
- After code edits run `graphify update .` — query with `graphify query`/`path`/`explain` before broad greps. Optional: `rtk <cmd>` prefix (Rust Token Killer, `.agents/rules/antigravity-rtk-rules.md`) to compress shell output.
