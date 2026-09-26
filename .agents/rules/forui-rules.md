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
- **Dynamic Alpha Boost**: `PokaIcon` automatically adapts its opacity to maintain vibrance across theme modes:
  - **Light mode**: background `alpha: 0.15`, border `alpha: 0.25` (produces a soft pastel aesthetic on white canvas).
  - **Dark mode**: background boosted to `alpha: 0.28`, border `alpha: 0.35` (prevents brand purple `#5560D6` and category accents from collapsing into dull charcoal against the `#0B0C14` dark canvas).
  - Never manually wrap icons in custom containers with hardcoded alpha; always use `PokaIcon`.

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

## Spacing & Gap (Tiered Rhythm System)

Rhythm spacing follows a tiered scale (*bertingkat*) to maintain clear visual hierarchy. It is not uniform across every element:

**1. Global Screens & List Pages**

- **Tier 1 — Gap between major sections**: Strictly **`20`** (`SizedBox(height: 20)`). This separates distinct functional blocks (e.g. Hero summary card to list sections, Pockets to Transactions, or between menu groups).
- **Tier 2 — Padding to bottom of screen (safe area)**: Strictly **`20`** (`SizedBox(height: 20)` or `EdgeInsets.only(bottom: 20)`).
- **Tier 3 — Section header to content**: **`8`** to **`12`** (`8` for `PokaSectionLabel` to card lists, `12` for label to grids/pockets).
- **Tier 4 — Intra-list item gap (card to card)**: **`8`** to **`10`** (e.g. `10` between `GoalCard` / `RecentTransactionTile`, `8` between simple list tiles).
- **Tier 5 — Micro spacing**: **`2`** to **`6`** (title to subtitle, badge padding, icon to label).

**2. Global PokaSheet Layout**

- **Body Padding**: Left-right padding is `12` (`EdgeInsets.fromLTRB(12, 0, 12, 0)`).
- **Header Padding**: `PokaSheetHeader` has a bottom padding of **`12`** towards the *body* content.
- *Crucial Rule*: Never add an empty manual `SizedBox` at the very top of the `PokaSheet` *body* to avoid *double
  padding* with the header.

**3. Standard Form Sheets (Account, Budget, Goal, Debt, Category)**

- Gap between form fields / inputs: **`12`** (`SizedBox(height: 12)`).
- Gap before the main bottom action button (Save Button): Strictly **`20`** (`SizedBox(height: 20)`).

**4. Transaction Form Sheet Exceptions (Ultra-Compact)**
Due to its complexity, the Transaction Sheet uses tighter gaps:

- Gap between basic components (Tab → Date → Account, Numpad Top): **`10`**.
- Gap from Account pills to Amount Calculator: **`14`**.
- *Reserved Height* for "=" (History Expression) above the Divider: **`18`** fixed height.
- Internal parent-to-child gap on Category Shelf and Pocket Selector: **`6`**.
- Meta Bar (Note & Allocation) Padding: `top: 2`, `bottom: 6`.
- Gap before the Split save button: **`18`**.

## Segmented Controls & Pill Tabs

Custom segmented controls and pill tabs must match `FTabs` visual behaviour:

- **Container (track) background**: Always `Colors.transparent` + `Border.all(color: theme.colors.border)`. Never use `theme.colors.muted` solid color.
- **Inactive option**: No background (transparent). Text in `theme.colors.mutedForeground`.
- **Active option**: `theme.colors.primary` fill, `theme.colors.primaryForeground` text.

For pill rows *inside* a card (e.g., dashboard analytics tab pills, report period chips, icon picker tabs):

| Mode       | Inactive pill background                        |
|------------|-------------------------------------------------|
| Light mode | `theme.colors.secondary`                        |
| Dark mode  | `theme.colors.card`                             |

## Donut Chart Center Space

`PokaDonutChart` **must** set `centerSpaceColor: Colors.transparent` explicitly in `PieChartData`. Never rely on the library default — it introduces a 3-way color discrepancy between empty-state, data-state, and the `FCard` background.

## Dashboard Analytics Carousel

All three tab views (Cash Flow, Categories, Budgets) **must** be wrapped in a `SizedBox(height: 140)` to maintain consistent carousel height across tab switches.