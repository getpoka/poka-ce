# Contributing to Poka CE

Thank you for your interest in contributing to Poka CE — the open-source personal finance app built with Flutter.

---

## Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- Dart SDK (bundled with Flutter)
- Android Studio or VS Code with Flutter & Dart extensions

### Setup

```bash
git clone https://github.com/getpoka/poka-ce.git
cd poka-ce
flutter pub get
dart run build_runner build
flutter run
```

---

## Project Architecture

Poka CE uses a **Feature-First Clean Architecture** with strict layer separation. Key points:

- **3-layer feature structure**: `data/` (repositories) → `domain/` (Freezed models) → `presentation/` (controllers +
  screens + widgets)
- **State management**: Riverpod (`@riverpod`) — no business logic in widgets
- **Database**: Drift ORM — never expose `*Data` classes to UI, always map to domain models
- **UI**: ForUI only — no Material widgets, no shadows, no inline styles
- **CE is local-first and single-currency** — no sync or multi-currency logic

All rules and constraints are documented in the sections below. Read them before writing code.

---

## Development Workflow

### Branching

| Type        | Pattern                  | Example                       |
|-------------|--------------------------|-------------------------------|
| New feature | `feat/<description>`     | `feat/recurring-transactions` |
| Bug fix     | `fix/<description>`      | `fix/balance-calculation`     |
| UI change   | `ui/<description>`       | `ui/account-list-redesign`    |
| Refactor    | `refactor/<description>` | `refactor/goal-repository`    |

### Mandatory Checks (before every PR)

You **must** pass all of these before opening a PR:

```bash
# Fix linting issues, format, and analyze in one step
make fix      # dart fix --apply + dart format .
make check    # flutter analyze — must print "No issues found!"
make generate # regenerate code (Riverpod, Freezed, Drift, Slang)
make test     # run all tests
```

---

## Code Rules (Zero Tolerance)

These are hard constraints — PRs violating any of these will not be merged:

| #  | Rule                                                                                                |
|----|-----------------------------------------------------------------------------------------------------|
| 1  | No Material widgets (`Scaffold`, `AppBar`, `ElevatedButton`, `Card`) — use ForUI                    |
| 2  | No shadows (`boxShadow`, `elevation > 0`, `PhysicalModel`)                                          |
| 3  | No hardcoded colors (`Color(0xFF...)`, `Colors.white/black/grey`) outside `lib/theme/`              |
| 4  | No inline typography (`TextStyle(fontSize: N)`, `fontWeight`, `letterSpacing`) outside `lib/theme/` |
| 5  | No `throw` inside a Repository or Notifier — return `Result<T, Failure>`                            |
| 6  | No `print()` or `debugPrint()` — use `talker`                                                       |
| 7  | No `dynamic` type anywhere — use explicit generic types                                             |
| 8  | No sync logic, cloud integration, or multi-currency support                                         |
| 9  | No Drift `*Data` class passed to or imported in a Widget/Screen — use Freezed instead               |
| 10 | Every new `lib/` file must have a matching `test/` file                                             |

See [`AGENTS.md`](./AGENTS.md) for the complete violation table.

---

## Architecture Rules

- **Single Currency:** The project is local-first and single-currency. CE has no sync, cloud, or multi-currency
  capabilities.
- **Layered Features:** Use a 3-layer architecture per feature: `features/<name>/{data,domain,presentation}`.
  `presentation` is further divided into `controllers`, `screens`, and `widgets`.
- **Database (Drift):** `lib/database/` exclusively owns Drift logic. Tables in `tables/`, DAOs in `daos/`. Do not
  import Drift `*Data` classes in UI/widgets. Map them to `freezed` domain models in repositories.
- **State Management:** Use `@riverpod` notifiers. Widgets should only use `ref.watch` and call methods. No business
  logic in widgets. Use `flutter_hooks` for controllers (`useTextEditingController`).
- **Error Handling:** Use `Result<T, Failure>` (`lib/core/error/result.dart`). Never `throw` in repositories or
  notifiers. Exhaustive `switch` on `Success`/`Failure`.

---

## Database Invariants

- Use lowercase enums (`income`, `expense`, `transfer`).
- `accounts` have an `initial_balance` column. Current `balance` is calculated. Do not generate fake initial
  transactions.
- Transaction items sum must match the header `amount`.
- Hard-delete is used, with balance and `budget_records` reversal.
- Debt/Loan involves paired income/expense transactions with a `debt_id`.

---

## UI Constraints (ForUI)

- **Strictly ForUI:** Do not use Material `Scaffold`, `AppBar`, `ElevatedButton`. Use `FScaffold`, `FButton`, `FCard`,
  etc.
- **No Shadows:** `boxShadow` and `elevation` are strictly forbidden. Use flat designs with borders, gradients, or alpha
  colors.
- **No Inline Typography:** Never write `TextStyle(fontSize: N)` inside widgets. Use typography roles from
  `lib/theme/typography_roles.dart`.
- **No Inline Colors:** Never write `Color(0xFF...)` or `Colors.white/black` inside widgets. Use color tokens from
  `lib/theme/colors.dart`.
- **Spacing:** Standard gap between sections is `20`. Sheet body padding `12` horizontally. Use `PokaIcon` for
  account/category/pocket icons.
- **Styling:** Never style ForUI widgets inline. Use `dart run forui style create <component>` and update
  `lib/theme/styles/` + `lib/theme/theme.dart`.

---

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add recurring transaction list screen
fix: correct balance calculation on pocket delete
ui: redesign goal progress card
refactor: extract account mapper to dedicated class
test: add unit tests for budget repository
docs: update database schema diagram
chore: upgrade forui to latest
```

**Rules:**

- Subject line must be short and business-descriptive
- Do **not** include file names, class names, or function names in the subject
- If the commit covers multiple changes, add a body breakdown below the subject

---

## Testing

Every contribution must include tests. Follow the priority order:

1. **Unit tests** (highest priority) — Repositories, Notifiers, Mappers
2. **Widget tests** (selective) — Complex/stateful widgets and reusable core components
3. **Integration tests** (core user journeys only)

Test files must mirror `lib/` structure exactly:

```
lib/features/accounts/data/account_repository.dart
→ test/features/accounts/data/account_repository_test.dart
```

Minimum coverage target: **85%** per file.

---

## Pull Requests

- Always open PRs as **Draft** first — do not mark ready until all checks pass
- Link the relevant issue in the PR description
- If the change affects UI, attach screenshots or a screen recording
- Fill in the [PR checklist](.github/PULL_REQUEST_TEMPLATE.md) completely

---

## Code of Conduct

Please be respectful and constructive in issues and pull requests.

---

## Questions?

Open a [GitHub Discussion](https://github.com/getpoka/poka-ce/discussions) for architecture questions or feature
proposals before opening a PR.
