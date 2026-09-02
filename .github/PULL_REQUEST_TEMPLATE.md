## 🎯 Description

<!-- Please include a summary of the change and which issue is fixed. Please also include relevant motivation and context. -->
<!-- Fixes # (issue) -->

## 🚀 Type of Change

<!-- Check the appropriate box below: -->

- [ ] 🐛 Bug fix (non-breaking change which fixes an issue)
- [ ] ✨ New feature (non-breaking change which adds functionality)
- [ ] 💄 UI/UX update (changes to styling, animations, or layouts)
- [ ] ♻️ Refactoring (no functional changes, no API changes)
- [ ] 💥 Breaking change (fix or feature that would cause existing functionality to not work as expected)

## 🛠️ Testing Instructions

<!-- Please describe the steps to test this change locally: -->

1.
2.
3.

## ✅ Checklist

### Mandatory

- [ ] `make fix` — dart fix + format applied
- [ ] `make check` — reports **"No issues found!"**
- [ ] `make generate` — codegen up to date (if annotated files changed)
- [ ] `make test` — all tests pass
- [ ] Every new `lib/` file has a matching `test/` file
- [ ] My commit messages follow the Conventional Commits format (`feat:`, `fix:`, `ui:`)

### Code Quality

- [ ] No Material widgets (`Scaffold`, `AppBar`, `ElevatedButton`, `Card`) — ForUI only
- [ ] No shadows (`boxShadow`, `elevation > 0`, `PhysicalModel`)
- [ ] No hardcoded colors (`Color(0xFF...)`, `Colors.white/black/grey`) outside `lib/theme/`
- [ ] No inline typography (`TextStyle(fontSize: N)`, `fontWeight`) outside `lib/theme/`
- [ ] No ForUI component styled inline — used `dart run forui style create <component>` instead
- [ ] No `throw` inside a Repository or Notifier
- [ ] No `print()` or `debugPrint()` — uses `talker`
- [ ] No `dynamic` type anywhere
- [ ] No sync logic, cloud integration, or multi-currency support
- [ ] No Drift `*Data` class passed to or imported in a Widget/Screen — use Freezed domain models from `domain/` instead

## 📸 Screenshots / Video (If Applicable)

<!-- Use the table below for visual changes to easily compare Before and After -->

|       Before        |        After        |
|:-------------------:|:-------------------:|
| *(Drop image here)* | *(Drop image here)* |

<br>

---
<!-- pr-agent:describe -->
