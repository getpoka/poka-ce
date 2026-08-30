# Contributing to Poka CE

Thank you for your interest in contributing to Poka CE! This document outlines the technical guidelines and architecture rules you need to follow.

## Code of Conduct

Please be respectful and constructive in issues and pull requests.

## Workflow

1. Fork the repository and create your branch from `main`.
2. Make your changes following the architectural and UI constraints below.
3. Run `make generate` to update generated code (Riverpod, Freezed, Drift, Slang, GoRouter, etc.).
4. Run `make check` to ensure there are no linting or formatting issues. The output must be "No issues found!". Use `make fix` to auto-fix minor issues.
5. Ensure tests pass and maintain the 85% coverage gate (`flutter test --coverage`). Mirror the `lib/` directory structure in `test/`.
6. Write Conventional Commits (`feat:`, `fix:`, `ui:`). Subject must be business-descriptive (no filenames/class names in the subject, details in the body).

## Architecture Rules

- **Single Currency:** The project is single-currency. There are no `syncStatus`, `deletedAt`, or `currency` fields.
- **Layered Features:** Use a 3-layer architecture per feature: `features/<name>/{data,domain,presentation}`. `presentation` is further divided into `controllers`, `screens`, and `widgets`.
- **Database (Drift):** `lib/database/` exclusively owns Drift logic. Tables in `tables/`, DAOs in `daos/`. Do not import Drift `*Data` classes in UI/widgets. Map them to `freezed` domain models in repositories.
- **State Management:** Use `@riverpod` notifiers. Widgets should only use `ref.watch` and call methods. No business logic in widgets. Use `flutter_hooks` for controllers (`useTextEditingController`).
- **Error Handling:** Use `Result<T, Failure>` (`lib/core/error/result.dart`). Never `throw` in repositories or notifiers. Exhaustive `switch` on `Success`/`ErrorResult`.

## Database Invariants

- Use lowercase enums (`income`, `expense`, `transfer`).
- `accounts.balance` starts at `0`. Initial balances are `income` transactions.
- Transaction items sum must match the header `amount`.
- Hard-delete is used, with balance and `budget_records` reversal.
- Debt/Loan involves paired income/expense transactions with a `debt_id`.

## UI Constraints (ForUI)

- **Strictly ForUI:** Do not use Material `Scaffold`, `AppBar`, `ElevatedButton`. Use `FScaffold`, `FButton`, `FCard`, etc.
- **No Shadows:** `boxShadow` and `elevation` are strictly forbidden. Use flat designs with borders, gradients, or alpha colors.
- **Spacing:** Standard gap between sections is `20`. Sheet body padding `12` horizontally. Use `PokaIcon` for account/category/pocket icons.
- **Styling:** Never style Forui widgets inline. Use `dart run forui style create <component>` and update `lib/theme/styles/` + `lib/theme/theme.dart`.

## Submitting Pull Requests

Ensure your PR describes *why* the change is made. If the change affects UI, please attach screenshots or a video.
