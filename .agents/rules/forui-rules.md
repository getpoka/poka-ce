---
trigger: always_on
---

# ForUI Rules

- `FScaffold` already provides padding and Safe Area adjustments by default.
    - Set `padding: EdgeInsets.zero` on scrollable children like `ListView` or `SingleChildScrollView` to prevent
      duplicating the safe area padding at the top and bottom.
    - Do NOT use `childPad: false` unless there is a specific need, such as having a colored background or colored
      header that requires content to bleed to the edges.
- The standard spacing between sections and to the bottom of the page is `20` (using `SizedBox(height: 20)`). Ensure
  that list builders or mapped items do not accidentally inject extra trailing spacing to the last item.
- **NO SHADOWS**: Strictly do NOT use shadows (`boxShadow`, `Shadow`, `elevation`, etc.) anywhere in the app. Use flat
  design with borders, gradients, and subtle background opacity instead.

## PokaIcon

- Always use `PokaIcon` (from `shared/widgets/poka_icon.dart`) instead of raw `Icon(...)` or manual `Container + Icon`
  combinations for account/category/pocket icons in lists and cards.
- `PokaIcon` has a semantic size scale: `small` (36px, dense lists/menu items), `medium` (44px, standard data rows),
  `large` (52px, primary touch targets), `hero` (64px, decorative focal points/dialogs).
- **Exception — icon on gradient background**: When an icon sits on a colored gradient (e.g., hero balance card), use a
  plain `Container(color: Colors.white.withValues(alpha: 0.2)) + Icon(color: Colors.white)` **without a border**. The
  semi-transparent overlay is sufficient; adding a border on a gradient creates visual noise.
- Do NOT override `hasBorder` unless there is a specific design reason. The default is now `false` (borderless) for a
  cleaner UI, but you can enable it when a subtle accent-colored border is needed on flat/card backgrounds.

## ForUI Style Customization

> [!IMPORTANT]
> **NEVER** modify a ForUI component's appearance inline inside a widget or screen file.
> The only allowed pattern is the ForUI style generation workflow below.

**When you need to change how a ForUI component looks:**

1. Run the CLI command for the specific component:
   ```bash
   dart run forui style create button
   dart run forui style create card
   dart run forui style create text-field
   # etc. — any ForUI component name
   ```
2. The generated style file lands in `lib/theme/styles/`. Edit **only** that file.
3. Register the new style in `lib/theme/theme.dart`.

**Prefer defaults.** Only deviate from the ForUI default style when there is a clear, justified design reason. Do not
customize just because you can — every deviation increases maintenance burden. If the default works, use it.

## Spacing & Gap

**1. Global Screens & List Pages**

- Gap between major *sections* on a *screen*: **`20`** (`SizedBox(height: 20)`).
- *Padding* before the bottom of the *screen* (bottom safe area): **`20`**.

**2. Global PokaSheet Layout**

- **Body Padding**: Left-right padding is `12` (`EdgeInsets.fromLTRB(12, 0, 12, 0)`).
- **Header Padding**: `PokaSheetHeader` has a bottom padding of **`12`** towards the *body* content.
- *Crucial Rule*: Never add an empty manual `SizedBox` at the very top of the `PokaSheet` *body* to avoid *double
  padding* with the header.

**3. Standard Form Sheets (Account, Budget, Goal, Debt, Category)**

- Gap between form fields / inputs: **`12`**.
- Gap before the main bottom action button (Save Button): **`20`**.

**4. Transaction Form Sheet Exceptions (Ultra-Compact)**
Due to its complexity, the Transaction Sheet uses tighter gaps:

- Gap between basic components (Tab → Date → Account, Numpad Top): **`10`**.
- Gap from Account pills to Amount Calculator: **`14`**.
- *Reserved Height* for "=" (History Expression) above the Divider: **`18`** fixed height.
- Internal parent-to-child gap on Category Shelf and Pocket Selector: **`6`**.
- Meta Bar (Note & Allocation) Padding: `top: 2`, `bottom: 6`.
- Gap before the Split save button: **`18`**.