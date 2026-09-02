---
trigger: always_on
---

# Poka CE — Architecture Reference

## Tech Stack

| Layer            | Package                                                            |
|------------------|--------------------------------------------------------------------|
| UI Framework     | `forui` — strictly follow [forui.dev/docs](https://forui.dev/docs) |
| State Management | `flutter_riverpod`, `hooks_riverpod`, `flutter_hooks`              |
| Routing          | `go_router`                                                        |
| Data Modeling    | `freezed`                                                          |
| Localization     | `slang` (translates from Providers without `BuildContext`)         |
| Local Database   | `drift` + `sqlite3_flutter_libs`                                   |
| Code Generation  | `build_runner`, `riverpod_generator`, `json_serializable`          |
| Logging          | `talker_flutter`                                                   |
| Utilities        | `uuid`, `math_expressions`, `local_auth`                           |
| Icons            | `phosphoricons_flutter`, `flutter_animate`                         |

> **Dependency version rule:** Always use the latest **major** version (e.g., `slang: ^4.0.0`). Downgrade minor versions
> only if there is a hard dependency conflict.

---

## Folder Structure (Feature-First)

```
lib/
├── app/          # Root widget, GoRouter setup, global providers
├── core/         # Non-UI infrastructure (Dio, error classes, env/config)
├── shared/       # ForUI themes, atomic UI components (Lego Bricks), extensions
├── database/     # Drift table definitions (SQLite schema) & DAOs
├── theme/        # All typography, colors, and theme tokens — single source of truth
├── features/
│   ├── auth/
│   ├── accounts/
│   ├── transactions/
│   ├── budgets/
│   ├── goals/
│   ├── debts/
│   └── recurring/
└── main.dart     # Entry point — extremely concise, only calls runApp
```

### Internal Feature Anatomy (every feature follows this 3-layer pattern)

```
features/<name>/
├── data/         # Repositories: Drift queries → mapped to pure domain models
├── domain/       # Freezed domain models — blind to Drift & UI
└── presentation/
    ├── controllers/  # Riverpod Notifiers (all business logic lives here)
    ├── screens/      # Full pages
    └── widgets/      # Feature-exclusive UI components
```

---

## CE Blindness (Strict Isolation)

Poka CE must compile and run flawlessly as a fully self-contained app.

- UI screens are **FORBIDDEN** from importing Drift-generated `*Data` classes.
- Repositories map Drift objects into pure `Freezed` domain models in the `domain/` layer.
- CE must never implement sync logic, cloud integration, or multi-currency support. These capabilities are provided
  externally without modifying CE files.
- CE behavior is extended externally via **Riverpod `ProviderScope(overrides: [...])` or polymorphism** — CE files
  themselves are never modified by external consumers.

---

## State Management (Riverpod + Hooks)

- Use `@riverpod` annotation (code-generated providers).
- Screens may only `ref.watch` and call Notifier methods — no business logic in widgets.
- Use `flutter_hooks` (`useTextEditingController`, `useAnimationController`) to avoid boilerplate `initState`/`dispose`.

---

## Synchronization Architecture

CE ships a `core/sync/` folder with an abstract `SyncableRepository` contract (`getPendingPush`, `processPull`,
`markAsSynced`). This contract is a placeholder — CE itself does not implement sync. External consumers implement the
contract in their own `data/` layer, keeping the CE Sync Engine generic and unmodified.

---

## Error Handling (Result Pattern)

- **Never `throw`** in repositories or notifiers.
- All operations return a `Result<T, Failure>` sealed class (`Success` / `Failure`).
- Notifiers unpack results with Dart 3 `switch` expressions, forcing exhaustive failure handling at compile time.

```dart
// ✅ Correct — repository returns Result
Future<Result<Account, Failure>> createAccount(AccountModel model) async {
  try {
    final row = await _dao.insert(...);
    return Success(_mapper.toDomain(row));
  } catch (e, st) {
    _talker.error('createAccount failed', e, st);
    return Failure(Failure.unexpected(e));
  }
}
```

---

## UI Design Principles

- **No Material Design.** Never use `Scaffold`, `AppBar`, `ElevatedButton`, `Card`, or any `elevation > 0`.
- **No shadows.** `boxShadow`, `Shadow`, `PhysicalModel`, or elevation anywhere is forbidden. Use flat design with
  borders, gradients, and subtle background opacity.
- **ForUI only.** Use `FScaffold`, `FButton`, `FCard`, `FTextField`, etc.
- **Single source of truth.** All typography and colors must come from `lib/theme/`. Inline `TextStyle(fontSize: N)` or
  `Color(0xFF...)` outside the theme folder is forbidden.
- **Atomic composition (Lego Bricks).** Split complex UIs into small stateless components (e.g., `GoalTitleInput`,
  `GoalAmountInput`). Avoid monolithic widgets.
- **Forui style overrides.** To alter a ForUI component's appearance, run `dart run forui style create <component>` and
  edit the generated file — never override inline.