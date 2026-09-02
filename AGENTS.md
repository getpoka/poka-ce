# AGENTS.md

Poka CE — an open-source Flutter personal-finance app (single-currency, local-first).

## Source-of-truth docs (read before writing code)

**Read all these documents before writing a single line of code:**

- `.agents/rules/architecture.md` — **READ FIRST.** Architecture patterns, state management, folder structure, CE/EE
  separation boundary.
- `.agents/rules/coding-standards.md` — Mandatory coding rules: typing, Result pattern, CE blindness, logging, git
  conventions.
- `.agents/rules/database-schema.md` — Full ERD and business logic for every table.
- `.agents/rules/forui-rules.md` — ForUI spacing, PokaIcon usage, no-shadows constraint.

## Available Skills

Activate relevant skills before working on a task:

- `.agents/skills/add-ce-feature/SKILL.md` — **Must read** every time you add a new CE feature.

## Load On-Demand (when relevant to the task)

- `.agents/rules/testing-rules.md` — Test strategy, priorities, and widget test guidelines.

## Commands

- Fix + format: `make fix`
- Analyze (mandatory, must report "No issues found!"): `make check`
- Codegen: `make generate`
- Test: `make test` (all) or `flutter test test/<dir>/<file>_test.dart` (single)

## ⛔ Violations that Trigger Mandatory Rollbacks

If you generate code that violates any of the following, **the entire session's work MUST be rolled back and
restarted:**

| #  | Violation                                                                                          |
|----|----------------------------------------------------------------------------------------------------|
| 1  | `flutter analyze` returns any error or warning                                                     |
| 2  | `throw` inside a Repository or Notifier                                                            |
| 3  | Widget imports a Drift `*Data` class directly — use Freezed domain models instead                  |
| 4  | `TextStyle(fontSize: N)` outside `lib/theme/`                                                      |
| 5  | `Colors.white/black/grey` or `Color(0xFF...)` outside gradient overlays                            |
| 6  | `boxShadow`, `elevation > 0`, or `PhysicalModel` anywhere                                          |
| 7  | `LinearGradient([...])` inlined in a widget                                                        |
| 8  | Material widgets (`Scaffold`, `AppBar`, `ElevatedButton`, `Card`)                                  |
| 9  | `TODO` or `UnimplementedError` in a concrete class                                                 |
| 10 | New file in `lib/` without a matching test file in `test/`                                         |
| 11 | `print()` or `debugPrint()` — use `talker` instead                                                 |
| 12 | Sync logic, cloud integration, or multi-currency support inside CE code                            |
| 13 | `dynamic` anywhere — use explicit generic types                                                    |
| 14 | ForUI component appearance modified inline — use `dart run forui style create <component>` instead |
