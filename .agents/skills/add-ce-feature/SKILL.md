---
name: add-ce-feature
description: >
  Step-by-step checklist for adding a new feature to Poka CE.
  Trigger: "create feature X", "add feature X", "implement X in CE".
---

# Add CE Feature — Skill

Use this checklist **every time** you implement a new feature in Poka CE. Do not skip steps.

---

## Step 1 — Read Architecture First

Before writing a single line of code:

1. Read `.agents/rules/architecture.md` (folder structure, CE blindness, Result pattern).
2. Read `.agents/rules/coding-standards.md` (typing, UI constraints, mandatory checks).
3. Read `.agents/rules/database-schema.md` (ERD and business logic for relevant tables).
4. Read `.agents/rules/forui-rules.md` (spacing tokens, PokaIcon, no-shadows rule).

---

## Step 2 — Plan the Feature

Answer these before coding:

- **Domain model**: What `Freezed` model (s) does this feature need in `domain/`?
- **Database**: What Drift table (s) or DAO queries are needed in `database/`?
- **Repository**: What `Result<T, Failure>` methods does the repository expose?
- **Notifier**: What state shape does the Riverpod Notifier manage?
- **UI**: What screens and atomic widget components (Lego Bricks) are needed?
- **CE blindness**: Does anything implement sync, cloud, or multi-currency logic? If yes, stop — CE is strictly
  local-first and single-currency.

---

## Step 3 — Scaffold the Feature Folder

Create the standard 3-layer structure:

```
lib/features/<feature_name>/
├── data/
│   ├── <feature>_repository.dart       # Implements repository interface
│   └── mappers/
│       └── <feature>_mapper.dart       # Drift *Data → domain model mapper
├── domain/
│   ├── models/
│   │   └── <feature>_model.dart        # @freezed Freezed model
│   └── repositories/
│       └── i_<feature>_repository.dart # Abstract interface
└── presentation/
    ├── controllers/
    │   └── <feature>_notifier.dart     # @riverpod Notifier
    ├── screens/
    │   └── <feature>_screen.dart
    └── widgets/
        └── <widget_name>.dart          # Atomic UI components
```

Every new file in `lib/` **must** have a matching test file in `test/`.

---

## Step 4 — Implement Domain Model

```dart
// lib/features/<feature>/domain/models/<feature>_model.dart

/// Immutable domain model for [Feature].
/// This model is completely blind to Drift and UI layers.
@freezed
class FeatureModel with _$FeatureModel {
  const factory FeatureModel({
    required String id,        // UUIDv7
    required String name,
    // ... other fields
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FeatureModel;
}
```

---

## Step 5 — Implement Repository

```dart
// lib/features/<feature>/domain/repositories/i_<feature>_repository.dart

/// Abstract contract for [FeatureModel] persistence operations.
abstract interface class IFeatureRepository {
  Stream<List<FeatureModel>> watchAll();
  Future<Result<FeatureModel, Failure>> create(FeatureModel model);
  Future<Result<FeatureModel, Failure>> update(FeatureModel model);
  Future<Result<void, Failure>> delete(String id);
}
```

```dart
// lib/features/<feature>/data/<feature>_repository.dart

/// Drift-backed implementation of [IFeatureRepository].
/// Maps [FeatureData] rows to [FeatureModel] domain objects.
class FeatureRepository implements IFeatureRepository {
  FeatureRepository(this._dao, this._mapper, this._talker);

  final FeatureDao _dao;
  final FeatureMapper _mapper;
  final Talker _talker;

  @override
  Future<Result<FeatureModel, Failure>> create(FeatureModel model) async {
    try {
      final row = await _dao.insert(/* ... */);
      return Success(_mapper.toDomain(row));
    } catch (e, st) {
      _talker.error('FeatureRepository.create failed', e, st);
      return Failure(Failure.unexpected(e));
    }
  }
}
```

---

## Step 6 — Implement Notifier

```dart
// lib/features/<feature>/presentation/controllers/<feature>_notifier.dart

/// Riverpod Notifier that manages [FeatureModel] list state.
/// All business logic lives here — screens only call methods and watch state.
@riverpod
class FeatureNotifier extends _$FeatureNotifier {
  @override
  Future<List<FeatureModel>> build() async {
    final repo = ref.watch(featureRepositoryProvider);
    // Watch a stream or load data
    return [];
  }

  /// Creates a new feature item and refreshes state.
  Future<void> create(FeatureModel model) async {
    final repo = ref.read(featureRepositoryProvider);
    final result = await repo.create(model);
    switch (result) {
      case Success(:final data):
        // update state
      case Failure(:final error):
        // surface error to UI
    }
  }
}
```

---

## Step 7 — Build UI (ForUI + Lego Bricks)

UI rules:

- Use `FScaffold`, `FButton`, `FTextField`, `FSheet`, `FDialog` — never Material widgets.
- No `boxShadow`, `elevation`, or `Shadow` anywhere.
- No inline `TextStyle`, `Color(0xFF...)`, or `Colors.white/black/grey`.
- No `LinearGradient` inlined in a widget — define in theme.
- **No inline ForUI style overrides.** If a ForUI component needs a visual change, run
  `dart run forui style create <component>` (e.g. `button`, `card`, `text-field`), edit the generated file in
  `lib/theme/styles/`, and register it in `lib/theme/theme.dart`. Prefer defaults — only deviate with clear
  justification.
- Break complex UIs into small stateless `Widget` components (Lego Bricks).
- Screens only call Notifier methods and `ref.watch` — zero business logic.

```dart
// lib/features/<feature>/presentation/screens/<feature>_screen.dart

/// Main screen for the [Feature] module.
/// Displays a list of [FeatureModel] items and handles navigation.
class FeatureScreen extends HookConsumerWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(featureNotifierProvider);
    // ... ForUI layout
  }
}
```

---

## Step 8 — Register Route

Add the feature route to `lib/app/router.dart` (or equivalent GoRouter setup file).

---

## Step 9 — Run Mandatory Checks

Do **not** mark the feature done until both pass with zero issues:

```bash
make fix      # dart fix --apply + dart format .
make check    # flutter analyze — must print: "No issues found!"
make generate # regenerate code (if annotated files changed)
make test     # all tests must pass
```

---

## Step 10 — Write Tests

For every file created in `lib/`, create the matching test in `test/`:

| Priority         | Target                                                          |
|------------------|-----------------------------------------------------------------|
| **Must**         | Repository unit tests (mock DAO, verify Result wrapping)        |
| **Must**         | Notifier unit tests (mock Repository, verify state transitions) |
| **Must**         | Mapper unit tests (Drift row → domain model)                    |
| **Should**       | Widget tests for stateful or reusable components                |
| **Nice-to-have** | Integration test for the core happy path                        |

Minimum coverage target: **85%** per file.
