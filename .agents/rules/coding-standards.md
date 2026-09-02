---
trigger: always_on
---

# Poka CE — Coding Standards

## 1. Absolute CE Blindness

- CE must be **100% self-contained**. Never write sync logic, cloud integration, multi-currency fields, or proprietary
  feature flags.
- CE is **strictly single-currency**. Do not include currency fields in domain models or database tables. Pass currency
  symbols to UI components via constructors only.

## 2. Clean Architecture & Domain Mapping

- UI layers (screens, widgets) **MUST NEVER** import Drift-generated `*Data` classes.
- Repositories **MUST** map Drift objects to pure `Freezed` domain models.
- UI components are "dumb" Lego bricks — they accept pure domain models only.

## 3. Strict Typing (Zero Dynamic)

`strict-casts`, `strict-inference`, and `strict-raw-types` are permanently enabled.

- **Never** use `dynamic`. Every generic must be explicit: `Future<void>`, `List<String>`, `Map<String, int>`.
- Every field, local variable, and parameter must be typed.

## 4. Immutability by Default

- Every class field and local variable must be `final` or `const` unless mutating inside a Riverpod Notifier.
- All domain models **must** use `Freezed`.

## 5. Error Handling (Result Pattern — No Throw)

- **Never** call `throw` inside a Repository or Notifier.
- Always return a `Result<T, Failure>` sealed class.
- Unpack results exhaustively with Dart 3 `switch` expressions.

```dart
// ✅ Correct
return switch (result) {
  Success(:final data) => state = AsyncData(data),
  Failure(:final error) => state = AsyncError(error, StackTrace.current),
};

// ❌ Wrong
throw Exception('something went wrong');
```

## 6. Logging — `talker` Only

- **Never** use `print()` or `debugPrint()`. Use `talker` from `talker_flutter`.
- Log errors with `_talker.error(message, exception, stackTrace)`.
- Log info with `_talker.info(message)`.

## 7. UI & Design Constraints

- **No Material widgets.** `Scaffold`, `AppBar`, `ElevatedButton`, `Card`, `ListTile`, etc. are forbidden.
- **No shadows.** `boxShadow`, `Shadow`, `elevation > 0`, `PhysicalModel` are forbidden everywhere.
- **No inline gradients.** `LinearGradient([...])` must not be inlined in a widget — define it in the theme.
- **No inline text styles.** `TextStyle(fontSize: N)` must not appear outside `lib/theme/`.
- **No hardcoded colors.** `Colors.white`, `Colors.black`, `Colors.grey`, `Color(0xFF...)` are forbidden outside
  gradient overlays defined in the theme.
- **ForUI only.** Use `FScaffold`, `FButton`, `FDialog`, `FSheet`, etc.
- **No inline ForUI style overrides.** Never pass custom styles inline to ForUI components. To modify a component's
  appearance, run `dart run forui style create <component>`, edit the generated file in `lib/theme/styles/`, and
  register it in `lib/theme/theme.dart`. Prefer the default style — only deviate when there is a clear design
  justification.

## 8. Primary Keys — UUIDv7

Every table's primary key **must** be a `UUIDv7`:

```dart
import 'package:uuid/uuid.dart';

final id = const Uuid().v7();
```

## 9. Dumb UI (Zero Business Logic in Widgets)

Widgets are forbidden from performing business calculations. If a widget's appearance depends on complex logic, compute
it inside a Riverpod Notifier and expose it as a `bool`, `String`, or `enum`.

## 10. Code Comments & Documentation

- **File/Class level:** Every file and class must have a `///` DartDoc comment explaining its purpose and
  responsibility.
- **Method level:** Every public method must have a `///` DartDoc comment.
- **Inline:** Use `//` only for mid-to-heavy logic to explain *why* (not what) the code does.
- **No dead code:** Commented-out code blocks are forbidden. Delete unused code.

```dart
/// Repository responsible for all [Account] CRUD operations.
/// Maps Drift [AccountData] rows to pure [AccountModel] domain objects.
class AccountRepository {
  /// Creates a new account and returns the created domain model.
  Future<Result<AccountModel, Failure>> create(AccountModel model) async { ... }
}
```

## 11. Git & Workflow Conventions

- **Conventional Commits:** `feat:`, `fix:`, `refactor:`, `test:`, `docs:`, `chore:`, `ui:`.
- **Semantic subjects:** Short, business-descriptive subject lines. Do not include file names, class names, or variable
  names in the subject.
- **Multi-change commits:** Include a body breakdown below the subject.
- **AI is prohibited** from running `git push` or opening PRs automatically. PRs must always be created as **Draft**
  first.

## 12. Mandatory Checks Before "Done"

You are **prohibited** from marking any task complete without passing both:

1. `make fix` — runs `dart fix --apply` + `dart format .`
2. `make check` → must report **"No issues found!"**

## 13. Test File Parity

Every file in `lib/` must have a corresponding test file in `test/` mirroring the exact path:

```
lib/features/accounts/data/account_repository.dart
→ test/features/accounts/data/account_repository_test.dart
```