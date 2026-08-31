# DESIGN.md — Poka CE Design System

> **Normative rules only.** Every rule below is mandatory unless a specific comment in the source explicitly documents the exception and the PR author who approved it.

---

## 1. Typography Roles

All text in the app **must** be expressed through one of the semantic roles below.
Direct `TextStyle(fontSize: N)` calls, `copyWith(fontSize: N)` overrides, and bare
`Text('…')` without a resolved role are **prohibited** (see §4).

Use `theme.typography` (ForUI `FTypography`) extended via the project token layer to
resolve each role. Where ForUI primitives already map to a role, prefer the primitive;
only fall back to the token layer for roles ForUI does not expose natively.

### 1.1 Complete Typography Roles Table

| Token Name       | Size (px) | Weight       | Letter‑Spacing | Semantic Usage                                          |
|------------------|-----------|--------------|----------------|---------------------------------------------------------|
| `titleScreen`    | 22        | `w600`       | −0.4           | Top‑level page/screen header (one per route)            |
| `titleCard`      | 16–18     | `w600`       | −0.2           | Card headers, section panel titles, sheet headings      |
| `titleItem`      | 13        | `w600`       | 0.0            | List tile primary text, category row names              |
| `labelSection`   | 12–13     | `w700`       | +0.8           | Uppercase section group dividers (apply `.toUpperCase()`)|
| `labelField`     | 12        | `w600`       | 0.0            | Form input labels, filter chip labels                   |
| `bodyPrimary`    | 15–16     | `w400`       | 0.0            | Paragraph body, description text, modal body copy       |
| `bodySecondary`  | 13–14     | `w400`       | 0.0            | Supporting body text, secondary row details             |
| `caption`        | 11–12     | `w400`       | 0.0            | Timestamps, dates, subtitles, metadata notes            |
| `labelBadge`     | 9         | `w700`       | +0.2           | Micro badges, status chips, count indicators            |
| `amountHero`     | 28–30     | `w800`       | −1.0           | Hero balance / total on dashboard & summary cards       |
| `amountSection`  | 20–22     | `w700`       | −0.5           | Period totals, section subtotals, goal progress amounts |
| `amountTile`     | 13        | `w600`       | −0.2           | Transaction amount inside a list tile (aligns `titleItem`)|

### 1.2 Role Application Rules

- **`titleItem` / `amountTile`** must be the same rendered size (13 px) so amount and
  name are optically balanced on the same row.
- **`caption`** always renders in `theme.colors.mutedForeground`. Never override to a
  custom color inline.
- **`labelSection`** text **must** be transformed to uppercase at the call site
  (`.toUpperCase()`). Do not rely on `TextCapitalization` widget settings.
- **`labelBadge`** containers must have a minimum padding of `EdgeInsets.symmetric(horizontal: 5, vertical: 2)` and a border-radius of `4`.
- **Numeric / financial roles** (`amountHero`, `amountSection`, `amountTile`) must use a
  monospaced or tabular‑figures font variant when available so digits align in lists.
- **No fallback chaining**: every text widget must resolve to exactly one token; do not
  mix two roles on one `RichText` span unless the spec explicitly calls for it.

---

## 2. Iconography

### 2.1 Icon Library

**Phosphor Icons only.** Do not import `material`, `cupertino`, or any third-party icon
pack. The single allowed exception is platform-required icons surfaced by the OS (e.g.
native navigation chevrons on iOS rendered by `CupertinoNavigationBar`).

### 2.2 Standard Scale

The project defines five semantic icon scales. Each entry lists the **visual icon size**
and the **minimum touch target size** (tap area, achieved via `GestureDetector` / `InkWell`
padding or `SizedBox` wrapper — never by inflating the icon itself).

| Scale Name | Visual Size | Touch Target | Typical Context                                  |
|------------|-------------|--------------|--------------------------------------------------|
| `nano`     | 9–13 px     | 24 px        | Badge glyphs, inline indicator marks             |
| `small`    | 18 px       | 36 px        | Dense list tile leading/trailing, chip icons     |
| `medium`   | 22 px       | 44 px        | Standard action buttons, nav bar icons           |
| `large`    | 26 px       | 52 px        | FAB-equivalent, prominent CTAs                   |
| `hero`     | 32 px       | 64 px        | Empty-state illustrations, onboarding accents    |

### 2.3 Touch Target Rules

1. Every tappable icon **must** meet its minimum touch target; use `Padding` or an
   explicit `SizedBox` around the `GestureDetector` — never a bare `Icon` as the only
   tap receiver.
2. Icons inside `FButton` inherit the button's touch target automatically; do not add
   extra padding.
3. `nano` icons are **decorative only** — they must never be the sole interactive
   element; pair them with a text label or a larger sibling target.

### 2.4 Icon Color Rules

- Use `theme.colors.foreground` for default icon color.
- Use `theme.colors.mutedForeground` for secondary / disabled icons.
- On gradient surfaces use `Colors.white` via `primaryForeground` (see §3.3) — never
  hard-code `Colors.white` elsewhere.
- Icon color must **never** be hard-coded as a hex literal or raw `Color(0xFF…)`.

### 2.5 PokaIcon Wrapper

Use the project's `PokaIcon` widget (from `shared/widgets/poka_icon.dart`) for all
account, category, and pocket icons in lists and cards. Raw `Icon(…)` + `Container`
combinations are prohibited for these semantic roles.

`PokaIcon` size mapping to scale:

| `PokaIcon` size param | Maps to Scale | Container px |
|-----------------------|---------------|--------------|
| `small`               | `small`       | 36 px        |
| `medium`              | `medium`      | 42 px        |
| `large`               | `large`       | 48 px        |
| `hero`                | `hero`        | 64 px        |

---

## 3. Surface & Color System

### 3.1 Token Overview

The app resolves all color values through `theme.colors` (ForUI `FColorScheme`). The
following tokens are in active use; every usage site must reference the token, not a
literal color.

#### Light Surface Tokens

| Token                     | Semantic Role                                         |
|---------------------------|-------------------------------------------------------|
| `background`              | Page / scaffold background                            |
| `foreground`              | Primary text & icons on `background`                  |
| `card`                    | Card / sheet surface (slightly elevated)              |
| `cardForeground`          | Text / icons on `card`                                |
| `popover`                 | Tooltip, dropdown, contextual overlay surface         |
| `popoverForeground`       | Text on `popover`                                     |
| `primary`                 | Brand accent, CTA fill                                |
| `primaryForeground`       | Text / icons on `primary` (gradient) surfaces         |
| `muted`                   | Subtle tinted fill (chips, disabled backgrounds)      |
| `mutedForeground`         | Secondary text, captions, placeholder text            |
| `border`                  | Dividers, input borders, card outlines                |
| `destructive`             | Delete actions, error states                          |
| `destructiveForeground`   | Text / icons on destructive surfaces                  |

#### Dark Surface Tokens

Dark mode mirrors the light tokens. All dark-mode values are defined in the ForUI theme
override at `lib/theme/theme.dart`. **Do not define inline dark overrides** in widget
files.

### 3.2 Forbidden Color Literals

The following raw Flutter color references are **strictly prohibited** anywhere in
`lib/`:

| Prohibited                  | Correct Alternative                          |
|-----------------------------|----------------------------------------------|
| `Colors.white`              | `theme.colors.primaryForeground`             |
| `Colors.black`              | `theme.colors.foreground`                    |
| `Colors.grey`               | `theme.colors.mutedForeground`               |
| `Colors.grey[N]`            | `theme.colors.muted` or `mutedForeground`    |
| `Color(0xFF…)` literals     | Named token from `theme.colors`              |
| `Colors.transparent` (fill) | `Colors.transparent` is allowed for overlays only |

### 3.3 Gradient Rules

1. Any surface painted with a linear/radial gradient must use `primaryForeground` for
   all overlaid text and icons — no exceptions.
2. Gradient definitions live in `lib/theme/` only. Widget files must reference a named
   gradient constant, not define a `LinearGradient([…])` inline.
3. Overlay containers on gradients (e.g. icon backgrounds) use
   `Colors.white.withValues(alpha: 0.2)` — this is the **only** permitted use of a
   white literal, and only in this specific context.

### 3.4 Flat Design Rule

**No shadows.** The following are prohibited across all surfaces:

- `BoxDecoration(boxShadow: […])`
- `Material(elevation: N)` with N > 0
- `PhysicalModel`
- `CardTheme(elevation: N)` overrides that result in visible shadow

Depth is communicated exclusively via **border**, **background-color contrast**,
**gradient**, and **alpha**.

---

## 4. Prohibited Anti-Patterns

Violations of the rules below will be rejected at code review. Static analysis lint rules
enforce the machine-checkable subset.

### 4.1 Inline Typography Overrides

```dart
// PROHIBITED
Text('Balance', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600))
Text('Balance', style: theme.typography.sm.copyWith(fontSize: 22))

// REQUIRED — resolve a named token role
Text('Balance', style: theme.typography.titleScreen)
```

Any `copyWith(fontSize: N)` where N is a numeric literal is prohibited.
Any `TextStyle()` constructor call with explicit `fontSize` or `fontWeight` is
prohibited outside of `lib/theme/`.

### 4.2 Bare TextStyle Declarations

`TextStyle()` with hardcoded size/weight/color values must not appear outside the theme
layer (`lib/theme/`). All widget files must derive text styles from `theme.typography`
or a role token.

### 4.3 Unpadded GestureDetector Links

```dart
// PROHIBITED — touch target below minimum
GestureDetector(
  onTap: _onTap,
  child: Icon(PhosphorIcons.arrowRight, size: 18),
)

// REQUIRED — enforce minimum 36 px touch area
GestureDetector(
  onTap: _onTap,
  child: Padding(
    padding: EdgeInsets.all(9),  // 18 icon + 9x2 = 36 touch target
    child: Icon(PhosphorIcons.arrowRight, size: 18),
  ),
)
```

### 4.4 Direct Drift `*Data` Usage in Widgets

Widget and presentation layer files must never import Drift `*Data` classes directly.
All data must flow through freezed domain models returned by the repository layer.

### 4.5 Inline Gradient Definitions

```dart
// PROHIBITED
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(colors: [Color(0xFF112233), Color(0xFF445566)]),
  ),
)

// REQUIRED
Container(
  decoration: BoxDecoration(gradient: AppGradients.primaryCard),
)
```

Gradient constants live in `lib/theme/gradients.dart`. All other locations are read-only.

### 4.6 EE / Multi-Currency Leakage

CE code must not reference, import, or conditionally compile any EE-only symbol
(`syncStatus`, `deletedAt`, `currency` fields, `isEE` flags). CE must compile correctly
if every EE file is deleted. See `AGENTS.md §CE blindness`.

### 4.7 Business Logic in Widgets

All business logic (calculations, validation, DB access, error handling) must reside in
Riverpod notifiers or domain/data layers. Widgets are allowed only:

- `ref.watch(…)` calls
- Method calls on the notifier (`ref.read(…).method()`)
- UI state only hooks (`useTextEditingController`, `useState<bool>`)

### 4.8 Raw `throw` in Repositories / Notifiers

Error propagation must use `Result<T, Failure>` from `lib/core/error/`. Throwing
exceptions from repositories or notifiers is prohibited. `switch` on `Success` /
`ErrorResult` must be exhaustive.

### 4.9 Outer Borders on Action Sheets

```dart
// PROHIBITED
PokaSheet(
  child: FItemGroup(
    children: [ PokaSheetActionItem(...) ],
  ),
)

// REQUIRED
PokaSheet(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [ PokaSheetActionItem(...) ],
  ),
)
```

Action sheets (e.g. bottom sheets presenting a list of actions like Edit/Delete or selectors like Backup & Restore) must not contain an outer border around the items. Use a plain `Column` with `PokaSheetActionItem` children instead of `FItemGroup` to ensure a clean, borderless list.

---

## 5. Layout & Empty States

### 5.1 Empty State Variations
`PokaEmptyView` must be styled differently depending on its context to maintain visual hierarchy:

1. **Page-Level Empty States (Full Screen / Tab)**
   - Must be centered vertically in the available viewport.
   - Must **not** have a border (`hasBorder: false`).
   - *Rationale*: When the screen is completely empty, the empty state is the primary focus. A border creates a confined box that looks artificially cramped in a large white space.

2. **Component-Level Empty States (Inline / Sections)**
   - Must be positioned inline below the section header (not vertically centered on the screen).
   - Must have a border (`hasBorder: true`).
   - *Rationale*: When placed alongside other populated UI components (like a Hero Card), the border acts as a bounding box to clearly define where the missing content belongs. Without a border, the text appears to float randomly.

---

*Last updated: 2026-08-29. Maintained by the Poka CE core team.*
