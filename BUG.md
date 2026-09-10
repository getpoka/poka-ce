# 🐛 Smoke Testing Bug Report (BUG.md)

This document records the bug findings identified during the **Smoke Testing** phase in Poka CE (`v1.0.0-rc.1+6`).

---

## Bug Summary

| ID | Module | Description | Severity | Status |
|---|---|---|---|---|
| **BUG-001** | `Transactions / Split Sheet` | Allocation tag (Need / Want / Saving) does not appear in the split item preview list during transaction creation | Medium (UI/UX Inconsistency) | ✅ Valid ([#37](https://github.com/getpoka/poka-ce/issues/37)) |
| **BUG-002** | `Transactions / Transaction Tile` | Expanding a split transaction in the transaction history renders all sub-items as "Uncategorized" | High (Data Presentation Defect) | ✅ Valid ([#38](https://github.com/getpoka/poka-ce/issues/38)) |
| **BUG-003** | `Recurring / Ledger Snapshot` | Generated recurring transactions lack an immutable frequency/period snapshot (e.g. Daily / Weekly / Monthly), causing period display ambiguity upon schedule editing | High (Data Integrity & Ledger Immutability) | ❌ Invalid (Working as Designed) |
| **BUG-004** | `Settings / Onboarding & Currency` | After "Reset Data", selecting a currency (e.g. CHF) in Onboarding does not update the active session — transactions default to IDR and base currency shows "Not Set" until app restart | High (UX & Session State Defect) | ✅ Valid ([#39](https://github.com/getpoka/poka-ce/issues/39)) |
| **BUG-005** | `Backup & Restore / Dialog Copy` | Restore confirmation dialog uses "Reset Data" copy (*"erase all app data locally, this action cannot be undone"*), misleading users into thinking data is only being erased | Medium (Misleading Copy / UX) | ✅ Valid ([#40](https://github.com/getpoka/poka-ce/issues/40)) |
| **BUG-006** | `Backup & Restore / Reactive Reload` | Successfully restoring an encrypted backup does not refresh active app state; user must force-close and reopen the app to see restored data | High (Reactive State & DB Lock Defect) | ✅ Valid ([#41](https://github.com/getpoka/poka-ce/issues/41)) |
| **BUG-007** | `Transactions / Localization & Formatting` | Incomplete translations on Transactions page: unlocalized date headers ("Wed, 10 Sep"), English month labels ("September 2026"), hardcoded creation form tabs ("Income", "Expense", "Transfer"), and English default categories | High (Localization & UX Quality) | ✅ Valid ([#42](https://github.com/getpoka/poka-ce/issues/42)) |
| **BUG-008** | `Debts / Repayment History Interaction` | Repayment history items in Debt Detail Page cannot be swiped to edit or delete (missing `onEdit` / `onDelete` callbacks in `RecentTransactionTile`) | Medium (UX Inconvenience) | ✅ Valid ([#43](https://github.com/getpoka/poka-ce/issues/43)) |
| **BUG-009** | `Debts & Transactions / Repayment Categorization` | Repayment transactions lack category assignment and render as "Uncategorized" across lists, needing semantic debt transaction recognition or optional category selection | Medium (Data Presentation Defect) | ✅ Valid ([#44](https://github.com/getpoka/poka-ce/issues/44)) |
| **BUG-010** | `Debts / Form Sheet UX` | Debt Edit sheet replaces the standard 'X' close button with an unconfirmed direct delete (trash) button in header trailing | High (Destructive UX / Misleading Action) | ✅ Valid ([#45](https://github.com/getpoka/poka-ce/issues/45)) |
| **BUG-011** | `Transactions & Feedback / Toast Ergonomics` | Delete confirmation toast with actionable "Undo" button is positioned at topCenter instead of floating bottomCenter, making the time-sensitive "Undo" action unreachable with one thumb on mobile devices | Medium (Ergonomics & Actionable UX Defect) | ✅ Valid (Subsumed by [#46](https://github.com/getpoka/poka-ce/issues/46)) |
| **BUG-012** | `App Shell / Toast System (FToaster)` | Toasts frequently freeze and fail to auto-dismiss ("tidak hilang-hilang / kadang hilang, kadang stuck") due to mobile touch events killing `_timer` without resuming, tap-to-toggle autoDismiss, and route transition race conditions | High (Reliability & UX Defect) | ✅ Valid ([#46](https://github.com/getpoka/poka-ce/issues/46)) |
| **BUG-013** | `Dashboard / Privacy Eye (Hide Balance)` | Cashflow, Spending Activity, Categories, and Budget carousel cards ignore `balanceVisibilityProvider` and continue displaying raw monetary values when privacy eye is toggled | High (Privacy & Data Protection Defect) | ✅ Valid ([#47](https://github.com/getpoka/poka-ce/issues/47)) |
| **BUG-014** | `Reports / Privacy Eye (Hide Balance)` | Category ranking, spending allocation splits, and chart tooltips bypass `balanceVisibilityProvider`, and ReportListPage lacks a header privacy eye toggle | High (Privacy & Data Protection Defect) | ✅ Valid ([#48](https://github.com/getpoka/poka-ce/issues/48)) |
| **BUG-015** | `Backup & Notifications / Permission & Testing` | Changing Backup Reminder from 'Off' to 'Weekly'/'Monthly' never requests notification runtime permission on Android 13+ & iOS (silent reminder failure), and app lacks an immediate test notification trigger | High (Core Feature Reliability & Testability) | ✅ Valid ([#49](https://github.com/getpoka/poka-ce/issues/49)) |

---

## 🔍 Detailed Bug Reports

### 1. BUG-001: Allocation Missing in Split Item Preview List on Creation Sheet

> [!NOTE]
> **Verification Status:** ✅ **Valid** | **GitHub Issue:** [#37](https://github.com/getpoka/poka-ce/issues/37)

#### A. Problem Description
When creating a transaction with split items via the transaction form sheet (`TransactionSplitItemFormSheet`), users can select an allocation target (e.g., **Need**, **Want**, or **Saving**).

However, after confirming the item, the allocation badge/pill is **never displayed** on the split item card (`_SplitItemCard`) within the preview list (`TransactionSplitItemList`). Although the allocation is stored in the in-memory `SplitItem` model and properly persisted to the database on save, the lack of visual feedback in the creation sheet causes confusion as to whether the allocation selection was registered.

#### B. Steps to Reproduce
1. Open the **Add Transaction** sheet (Expense).
2. Tap the **Split Item** button to enter split transaction mode.
3. Tap **Add Item (+)**.
4. Enter an amount (e.g., `50,000`), select a category (e.g., `Food`), and pick an allocation (e.g., `Need`).
5. Confirm / save the item.
6. **Observe the split item preview list:**
   - **Actual Behavior:** Only the category icon, category name, optional note, and amount are shown. The allocation badge (`Need`) is missing.
   - **Expected Behavior:** An allocation badge/chip (e.g., a mini pie chart icon with "Need") should be rendered next to or below the category name, matching the display pattern used across transaction lists.

#### C. Affected Files & Components
- **File:** [`lib/features/transactions/presentation/widgets/split/transaction_split_item_list.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/transactions/presentation/widgets/split/transaction_split_item_list.dart)
- **Component:** `_SplitItemCard` (lines 140–189).

#### D. Root Cause Analysis
In `_SplitItemCard`:
- The domain model `item` (`SplitItem`) already holds `item.allocation` (`TransactionAllocation?`).
- The layout in lines 157–179 only renders `catName` and `item.note` inside a `Column`, completely ignoring `item.allocation`.

#### E. Proposed Technical Fix
Add an allocation badge beside the category name or inside the metadata row when `item.allocation != null`, matching the styling pattern in `TransactionTileContent`.

---

### 2. BUG-002: Sub-Items Render as "Uncategorized" When Split Transaction Is Expanded

> [!NOTE]
> **Verification Status:** ✅ **Valid** | **GitHub Issue:** [#38](https://github.com/getpoka/poka-ce/issues/38)

#### A. Problem Description
After a split transaction is saved and rendered in transaction history lists (Dashboard Recent Transactions or Transaction List Page), the parent tile displays the split item count summary (e.g., *"2 split items"*).

However, tapping the tile to expand its child items causes all sub-items to display **"Uncategorized"** with default theme coloring, even though distinct categories were selected for each item during creation (e.g., Food, Transport).

#### B. Steps to Reproduce
1. Create a new transaction with multiple split items (e.g., Item 1: `Food`, Item 2: `Transport`).
2. Save the transaction.
3. Open the transaction history list or Recent Transactions on Dashboard.
4. Tap the transaction tile to expand and reveal its sub-items.
5. **Observe the expanded child items:**
   - **Actual Behavior:** Both items show "Uncategorized" as their label with the fallback tag icon and primary color.
   - **Expected Behavior:** Item 1 should display "Food" with its respective icon/color, and Item 2 should display "Transport" with its respective icon/color.

#### C. Affected Files & Components
- **File:** [`lib/features/transactions/presentation/widgets/tile/transaction_tile.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/transactions/presentation/widgets/tile/transaction_tile.dart)
- **Component:** `RecentTransactionTile` (lines 147–185 and lines 307–333).

#### D. Root Cause Analysis
1. **The `category` parameter is not passed when instantiating child tiles:**
   In lines 324–332 of `RecentTransactionTile`, sub-items are mapped to child `RecentTransactionTile` instances with `fakeTx`, but the `category:` parameter is omitted (`category` defaults to `null`).
2. **`RecentTransactionTile` lacks automatic fallback to `effectiveCategoriesById`:**
   Inside `RecentTransactionTile.build()`, category styling and label resolution rely solely on `category` (`this.category`). When `category == null`, it immediately falls back to `t.common.uncategorized`.

#### E. Proposed Technical Fix
1. Auto-resolve category in `RecentTransactionTile` via `resolvedCategory = category ?? effectiveCategoriesById[firstItem.categoryId]`.
2. Explicitly pass `category: effectiveCategoriesById[item.categoryId]` when creating child sub-item tiles.

---

### 3. BUG-003: Recurring Transactions Lack Immutable Period Snapshot in Ledger

> [!NOTE]
> **Verification Status:** ❌ **Invalid (Working as Designed / Feature Request)**
> - **Verification Analysis:** The database schema specification (`database-schema.md`) specifies that `transactions` links to recurring blueprints via foreign key `recurring_transaction_id` only. In `transaction_tile_content.dart`, the badge is an immutable indicator of origin (`t.transactions.recurring`), not a dynamic schedule frequency badge.
> - **Conclusion:** The code operates exactly as specified in the database architecture and ERD. Storing recurring frequency snapshots on transactions would require a schema change (`schemaVersion: 2`) and is a future enhancement/feature request rather than an existing defect. Per workflow rules: marked as invalid, skipping GitHub issue creation.

#### A. Problem Description
Transactions generated by recurring schedules lack an explicit frequency/period indicator in both the main transaction history list and the dedicated **Trigger History** section (`RecurringDetailPage`). Furthermore, because the `transactions` table only holds a loose foreign key `recurring_transaction_id` without capturing the period snapshot at execution time:
- Editing a schedule from Daily to Weekly retroactively alters the frequency interpretation of all past transactions.
- Deleting a recurring schedule strips the badge completely.

#### B. Steps to Reproduce
1. Create a recurring template set to **Daily** (Start Date = Today).
2. Trigger the recurring processor. Transaction 1 is generated.
3. Edit the recurring template: change frequency to **Weekly**.
4. Trigger the recurring processor again. Transaction 2 is generated.
5. **Observe the transactions:** Both transactions lack distinct frequency indicators or retroactively reflect the current template period.

#### C. Affected Files & Components
- **Database Schema:** [`lib/database/tables/transactions_table.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/database/tables/transactions_table.dart)
- **Database Migration:** [`lib/database/database.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/database/database.dart)
- **Execution Service:** [`lib/features/recurring/domain/recurring_processor_service.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/recurring/domain/recurring_processor_service.dart)
- **UI Tiles:** [`lib/features/transactions/presentation/widgets/tile/transaction_tile_content.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/transactions/presentation/widgets/tile/transaction_tile_content.dart)

#### D. Proposed Technical Fix
1. Add `recurringPeriod` column in `Transactions` table and bump `schemaVersion` to 2 via Drift `m.addColumn`.
2. Snapshot `recurring.period` during `RecurringProcessorService._processOne`.
3. Display frequency badges: `[🔁 Daily]`, `[🔁 Weekly]`, `[🔁 Monthly]`, `[🔁 Yearly]`.

---

### 4. BUG-004: Post-Reset Onboarding Currency Selection Not Reflected (Defaults to IDR & "Not Set")

> [!NOTE]
> **Verification Status:** ✅ **Valid** | **GitHub Issue:** [#39](https://github.com/getpoka/poka-ce/issues/39)

#### A. Problem Description
When resetting app data via `Settings → Reset Data`, the user is redirected to the Onboarding screen to select their base currency. If the user selects a currency other than IDR (e.g. **CHF** - Swiss Franc) and proceeds to the Dashboard:
- All created transactions and displays show the currency symbol as **IDR (`Rp`)**.
- In `Settings → Preferences`, the Base Currency displays as **"Not Set"**.
- However, closing and force-restarting the application makes the selected currency (CHF) appear normally.

#### B. Steps to Reproduce
1. Go to `Settings → Data Management → Reset Data`. Confirm the dialog and security authentication.
2. The app resets and navigates to the Onboarding screen (`/onboarding`).
3. Search and select **"CHF"** (Swiss Franc) or any non-IDR currency.
4. Tap **Continue with currency**.
5. The app navigates to the Dashboard.
6. Create an account or transaction, or navigate to `Settings → Preferences`.
   - **Actual Behavior:** Transactions display `Rp`, and Base Currency in Settings shows "Not Set" (`Belum Diatur`).
   - **Expected Behavior:** The selected currency (CHF) immediately takes effect across the entire active session without requiring an app restart.

#### C. Affected Files & Components
- **Controller:** [`lib/features/settings/presentation/controllers/settings_notifier.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/settings/presentation/controllers/settings_notifier.dart)
- **Navigation Flow:** [`lib/features/settings/presentation/widgets/sections/data_management_section.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/settings/presentation/widgets/sections/data_management_section.dart)
- **Screen:** [`lib/features/onboarding/presentation/screens/onboarding_page.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/onboarding/presentation/screens/onboarding_page.dart)

#### D. Root Cause Analysis
1. **Manual `_disposed` flag in `SettingsNotifier`:**
   In `SettingsNotifier`, an internal flag `bool _disposed = false;` is updated in `ref.onDispose(() => _disposed = true)`. When `data_management_section.dart` invalidates `settingsProvider`, `_disposed` becomes `true`.
2. **`SettingsNotifier` is configured with auto-dispose:**
   `SettingsNotifier` was generated with default auto-dispose (`@riverpod`). On `OnboardingPage`, `settingsProvider` is not watched by any mounted widget. When `ref.read(settingsProvider.notifier).setBaseCurrency(...)` runs, the asynchronous `_loadSettings()` is cut short by `if (_disposed) return;`, leaving the state indefinitely in `isLoading: true` with `settings: null`.
3. **Fallback to IDR:**
   When `settingsState.settings?.baseCurrency` is null due to `settings` being null, `PokaAmountText` falls back to `fallbackCurrencySymbol = 'Rp'`, and `PreferencesSection` displays `context.t.settings.notSet`.
4. **App Restart Fixes It:**
   On a fresh app launch, `SettingsNotifier` is built with `_disposed = false`, successfully reading the persisted `baseCurrencyId` from SQLite.

#### E. Proposed Technical Fix
1. Mark `SettingsNotifier` with `@Riverpod(keepAlive: true)` so global settings are never prematurely disposed during route transitions.
2. Remove the manual `_disposed` pattern and use standard Riverpod state safety.
3. In `onboarding_page.dart`, await `setBaseCurrency` and trigger a clean state reload before navigating to Dashboard.

---

### 5. BUG-005: Misleading Restore Confirmation Dialog Warning Text

> [!NOTE]
> **Verification Status:** ✅ **Valid** | **GitHub Issue:** [#40](https://github.com/getpoka/poka-ce/issues/40)

#### A. Problem Description
When tapping **Restore** from the Backup & Restore sheet, the confirmation dialog displays:
> *"Erase all app data locally, this action cannot be undone."*

This is the exact description used for **Reset Data** (factory wipe). It misinforms users that they are merely deleting their data, rather than explaining that current local data will be replaced by the contents of the chosen backup file.

#### B. Steps to Reproduce
1. Navigate to `Settings → Backup & Restore`.
2. Tap the action menu and select **Restore** (`Pulihkan`).
3. **Observe the confirmation dialog:**
   - **Actual Behavior:** Dialog body says *"Erase all app data locally, this action cannot be undone."* (`context.t.settings.resetDataDesc`).
   - **Expected Behavior:** Dialog body should clearly warn that restoring a backup file will replace existing local data with the backup file data.

#### C. Affected Files & Components
- **File:** [`lib/features/settings/presentation/widgets/sections/data_management_section.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/settings/presentation/widgets/sections/data_management_section.dart) (line 106).
- **Localization Files:**
  - [`lib/i18n/en/backup.i18n.json`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/i18n/en/backup.i18n.json)
  - [`lib/i18n/id/backup.i18n.json`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/i18n/id/backup.i18n.json)

#### D. Root Cause Analysis
In `data_management_section.dart` line 106:
```dart
final confirmed = await showPokaConfirmDialog(
  context,
  title: context.t.backup.restoreAction,
  body: context.t.settings.resetDataDesc, // ⚠️ Copy-paste bug referencing resetDataDesc
);
```

#### E. Proposed Technical Fix
Add dedicated localization keys to `backup.i18n.json`:
- `en`: `"restoreWarningDesc": "Restoring will replace all current data with the data from the selected backup file. Any unbacked-up changes will be lost. Do you want to proceed?"`
- `id`: `"restoreWarningDesc": "Memulihkan cadangan akan menggantikan semua data saat ini dengan data dari file cadangan. Perubahan yang belum dicadangkan akan hilang. Lanjutkan?"`
And update `data_management_section.dart` line 106 to reference `context.t.backup.restoreWarningDesc`.

---

### 6. BUG-006: Data Not Reloaded After Successful Backup Restore (Requires App Restart)

> [!NOTE]
> **Verification Status:** ✅ **Valid** | **GitHub Issue:** [#41](https://github.com/getpoka/poka-ce/issues/41)

#### A. Problem Description
After selecting an encrypted backup file, entering the correct password, and seeing the toast *"Restore successful"*, the app returns to the Dashboard, but none of the restored accounts, transactions, or categories appear. The user must force-close and restart the app for the restored database to be read.

#### B. Steps to Reproduce
1. Ensure you have an encrypted backup file with data (accounts, transactions).
2. On a device with fresh/different data, go to `Settings → Backup & Restore → Restore`.
3. Pick the backup file and enter the password.
4. The toast *"Restore successful"* appears and redirects to Dashboard.
5. **Observe the Dashboard and Account list:**
   - **Actual Behavior:** The screen still shows the previous data or empty state. Restored data only appears after killing and restarting the app.
   - **Expected Behavior:** The active database and all dependent state providers reload immediately, rendering the restored accounts and transactions without restarting the app.

#### C. Affected Files & Components
- **Backup Service:** [`lib/features/backup/data/backup_service.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/backup/data/backup_service.dart) (lines 148–170).
- **Settings Section:** [`lib/features/settings/presentation/widgets/sections/data_management_section.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/settings/presentation/widgets/sections/data_management_section.dart) (lines 147–166).

#### D. Root Cause Analysis
1. **Overwriting active SQLite file during open connection:**
   In `backup_service.dart`, `dbFile.writeAsBytes(clearText, flush: true)` directly overwrites the SQLite file on disk while `AppDatabase` is still open, holding active locks, cached pages, and associated WAL files (`poka.sqlite-wal` and `poka.sqlite-shm`).
2. **Unawaited database close:**
   In `data_management_section.dart` line 148, `unawaited(container.read(databaseProvider).close())` is called *after* the file has already been overwritten, without awaiting completion before invalidating providers.
3. **Stale WAL/SHM files:**
   When SQLite is running in WAL mode, overwriting the primary database file without cleaning up or checkpointing `-wal` and `-shm` files causes SQLite to keep serving cached/unmerged pages until process termination.

#### E. Proposed Technical Fix
1. **Clean Database Teardown Before Disk Write:**
   Before decrypting and writing the backup file, close the active database connection cleanly:
   `await container.read(databaseProvider).close();`
2. **Clean up WAL and SHM files on disk:**
   Delete any associated `-wal` and `-shm` sibling files before writing `clearText` bytes to the primary database file.
3. **Proper Provider Reconnection:**
   Invalidate `databaseProvider` and await reload of `settingsProvider`, `dashboardProvider`, `accountListProvider`, `categoryListProvider`, and `transactionListNotifierProvider`.

---

### 7. BUG-007: Incomplete Translations & Unlocalized Dates on Transactions Page

> [!NOTE]
> **Verification Status:** ✅ **Valid** | **GitHub Issue:** [#42](https://github.com/getpoka/poka-ce/issues/42)

#### A. Problem Description
When the application language is set to Indonesian (`id`), the **Transactions Page** displays glaring English strings across multiple primary components:
1. **Date Section Headers:** Every daily group header for dates older than yesterday renders with English day and month abbreviations (e.g. *"Wed, 10 Sep"*, *"Mon, 08 Sep"*, *"Sun, 07 Sep"*) instead of Indonesian (*"Rab, 10 Sep"*, *"Sen, 08 Sep"*, *"Min, 07 Sep"*).
2. **Sticky Date Navigator & Empty State:**
   - Day Mode: Displays English relative dates (*"Wed, 10 Sep"*).
   - Week Mode: Displays English month (*"Minggu 37 · Sep 2026"*).
   - Month Mode: Displays English month name (*"September 2026"*, *"August 2026"*, *"March 2026"* instead of *"Agustus"*, *"Maret"*).
   - Empty State Subtitle: Inlines English month (*"Belum ada catatan untuk wed, 10 sep."*).
3. **Transaction Creation Sheet (Switcher Tabs):** The top tab switcher displays hardcoded English labels (*"Income"*, *"Expense"*, *"Transfer"*) rather than Indonesian (*"Pemasukan"*, *"Pengeluaran"*, *"Transfer"*).
4. **Default Categories:** Seeded categories in SQLite (`Food & Dining`, `Groceries`, `Transport`, `Housing`, etc.) are English-only and do not translate dynamically based on the active locale.

#### B. Steps to Reproduce
1. In `Settings → Preferences`, set language to **Indonesian (Bahasa Indonesia)**.
2. Navigate to the **Transactions** tab.
3. Observe the daily section headers: dates older than yesterday show English text like `"Wed, 10 Sep"`.
4. Switch the navigator to **Month** view: navigate to August or March; month names display as `"August 2026"`, `"March 2026"`.
5. Tap **Add Transaction (+)**: observe the top switcher tabs showing `"Income"`, `"Expense"`, `"Transfer"`.

#### C. Affected Files & Components
- **Date Extensions:** [`lib/core/extensions/datetime_extension.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/core/extensions/datetime_extension.dart) (lines 15, 30–31).
- **List Controller:** [`lib/features/transactions/presentation/controllers/transaction_list_notifier.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/transactions/presentation/controllers/transaction_list_notifier.dart) (lines 117, 120).
- **Form Tab Switcher:** [`lib/features/transactions/presentation/widgets/forms/components/transaction_type_switcher.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/transactions/presentation/widgets/forms/components/transaction_type_switcher.dart) (line 36).
- **Application Setup:** [`lib/main.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/main.dart) & [`lib/app/app.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/app/app.dart).
- **Category Presentation:** [`lib/features/categories/domain/category_model.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/categories/domain/category_model.dart) & [`lib/features/transactions/presentation/widgets/tile/transaction_tile.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/transactions/presentation/widgets/tile/transaction_tile.dart).

#### D. Root Cause Analysis
1. **Missing `intl` Locale Initialization:** `initializeDateFormatting()` is never called on app startup, and `Intl.defaultLocale` is never updated when the user changes language or device locale.
2. **Hardcoded Locale in `DateTimeExtension`:**
   `DateFormat('EEE, dd MMM')` and `DateFormat('dd MMM yyyy')` are instantiated without a locale argument, defaulting to `en_US`.
3. **Hardcoded String Manipulation in `TransactionTypeSwitcher`:**
   Line 36 uses `type.name.substring(0, 1).toUpperCase() + type.name.substring(1)` rather than `slang` translation keys (`t.transactions.income`, `t.transactions.expense`, `t.transactions.transfer`).
4. **Static English Seed Data for Categories:**
   The SQLite database seeds categories from `assets/data/categories.json` using static English strings without localized display name resolution.

#### E. Proposed Technical Fix
1. Call `await initializeDateFormatting()` in `main.dart` and set `Intl.defaultLocale = LocaleSettings.currentLocale.languageTag` in `app.dart` on locale change.
2. Update `DateTimeExtension.toRelativeDateString()` and `DateTimeExtension.toFormattedDate()` to accept an optional locale and default to `LocaleSettings.currentLocale.languageTag`.
3. Update `TransactionListNotifier.periodLabel` to pass `LocaleSettings.currentLocale.languageTag` to `DateFormat('MMM yyyy')` and `DateFormat('MMMM yyyy')`.
4. Replace string manipulation in `TransactionTypeSwitcher` with `switch (type) { TransactionType.income => t.transactions.income, ... }`.
5. Provide a localized category name helper/extension so default system categories dynamically display in the user's active language.

---

### 8. BUG-008: Repayment History Tiles in Debt Detail Page Lack Swipe-to-Edit & Swipe-to-Delete

> [!NOTE]
> **Verification Status:** ✅ **Valid** | **GitHub Issue:** [#43](https://github.com/getpoka/poka-ce/issues/43)

#### A. Problem Description
In [`DebtDetailPage`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/debts/presentation/screens/debt_detail_page.dart), all repayment transactions associated with a debt/loan are listed under the **Repayment History** (`Riwayat Pembayaran`) section using [`RecentTransactionTile`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/transactions/presentation/widgets/tile/transaction_tile.dart).

However, unlike tiles on the Dashboard or Transaction List Page, swiping left or right on a repayment tile does nothing. To edit a note, modify an amount, or delete a mistaken repayment, users are forced to leave the debt feature, open the main transaction list page, and locate the transaction there. Since debt repayments are exclusively created within the Debt module to prevent bloating the main transaction sheet, restricting repayment modifications away from `DebtDetailPage` severely degrades UX.

#### B. Steps to Reproduce
1. Open any Debt or Loan with active repayment transactions in `DebtDetailPage`.
2. Scroll to **Repayment History**.
3. Attempt to swipe left or right on any repayment transaction tile.
   - **Actual Behavior:** The tile is static; no edit or delete actions appear.
   - **Expected Behavior:** Swiping reveals Edit and Delete actions (with confirmation dialog for deletion), updating the repayment and debt balance directly.

#### C. Affected Files & Components
- **File:** [`lib/features/debts/presentation/screens/debt_detail_page.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/debts/presentation/screens/debt_detail_page.dart) (lines 140–147).

#### D. Root Cause Analysis
In `debt_detail_page.dart`:
```dart
child: RecentTransactionTile(
  transaction: transaction,
  isBalanceVisible: true,
  categoriesById: categoriesById,
  category: category,
  account: account,
  // ⚠️ onEdit, onDelete, and onTap are omitted
),
```
Inside `RecentTransactionTile`, the `Slidable` widget is conditionally created only when `onEdit != null || onDelete != null`. Because both callbacks are omitted in `DebtDetailPage`, the tile remains completely inert to swipe gestures.

#### E. Proposed Technical Fix
1. Provide `onTap:` and `onEdit:` to launch `TransactionFormSheet.show(context, initialTransaction: transaction)`.
2. Provide `onDelete:` with `showPokaConfirmDialog`. Upon confirmation, invoke `ref.read(transactionRepositoryProvider).deleteTransaction(transaction.id)`, invalidate `debtTransactionsProvider(activeDebt)` and `debtListProvider`, and refresh `dashboardProvider`.

---

### 9. BUG-009: Repayment Transactions Render as "Uncategorized"

> [!NOTE]
> **Verification Status:** ✅ **Valid** | **GitHub Issue:** [#44](https://github.com/getpoka/poka-ce/issues/44)

#### A. Problem Description
When a repayment is logged via [`DebtRepaymentSheet`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/debts/presentation/widgets/debt_repayment_sheet.dart), the transaction is recorded with `categoryId = null`. As a result, the transaction tile in both `DebtDetailPage` and the main transaction ledger displays as **"Uncategorized"** (`Tanpa Kategori`) with a generic grey tag icon.

#### B. Architectural Analysis & Proposed Approaches
In financial accounting, debt settlement is a **balance sheet liability movement** rather than an operational expense (e.g., it should not inadvertently deduct from a "Food & Dining" or "Groceries" spending budget).

Three architectural options were evaluated:

| Option | Concept | Pros | Cons |
|---|---|---|---|
| **Option A (Recommended: Semantic Special Transaction)** | Treat Debt transactions like Transfers. When `transaction.debtId != null` and `category == null`, render title as *"Pelunasan Utang"* (for expense) or *"Penerimaan Piutang"* (for income) with `FPhosphorIcons.handshake`. | 1-tap fast numpad entry, clean accounting semantics, 100% eliminates "Uncategorized" without UI bloat. | Users cannot assign a custom budget category if they want to track repayments under a "Cicilan / Utang" budget. |
| **Option B (Hybrid: Semantic Default + Optional Category Picker)** | Implement Option A as the default, plus add an optional Category Selector in `DebtRepaymentSheet`. | Maximum flexibility: fast by default, customizable when needed. | Adds a category picker row to the repayment sheet. |
| **Option C (Auto-inherit from Parent Debt)** | Repayment inherits the category selected during debt creation. | Zero UI change in repayment sheet. | Can be semantically inaccurate (e.g., a debt borrowed for "Medical" would categorise repayments as "Medical" income). |

#### C. Recommendation
Adopt **Option A / Option B**:
1. Update `RecentTransactionTile` so that whenever `transaction.debtId != null` and `category == null`:
   - Title: `t.debts.debtTypeDebt` (*"Utang"*) or `t.debts.debtTypeLoan` (*"Piutang"*) / *"Pelunasan"*.
   - Icon: `FPhosphorIcons.handshake`.
   - Color: `theme.colors.app.expense` or `theme.colors.app.income`.
2. (Optional) Provide a lightweight category picker in `DebtRepaymentSheet` for users who explicitly want budget allocation.

---

### 10. BUG-010: Debt Edit Sheet Replaces 'X' Close Button with Unconfirmed Immediate Delete

> [!NOTE]
> **Verification Status:** ✅ **Valid** | **GitHub Issue:** [#45](https://github.com/getpoka/poka-ce/issues/45)

#### A. Problem Description
When opening a debt record in edit mode via `DebtDetailPage → Edit` ([`DebtFormSheet`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/debts/presentation/widgets/debt_form_sheet.dart)), the header trailing action displays a **Trash icon** instead of the standard 'X' (close/cancel) button.

Tapping the Trash icon **immediately deletes the entire debt and reverses all transactions with zero confirmation dialog**, risking catastrophic accidental data loss. Furthermore, the user has no top-bar close button to dismiss the sheet without saving changes.

#### B. Steps to Reproduce
1. Open any Debt or Loan detail page.
2. Tap the **Pencil (Edit)** button in the header.
3. Observe the top-right corner of the `DebtFormSheet`:
   - **Actual Behavior:** A red Trash icon is shown in place of the standard 'X' button. Tapping it instantly destroys the debt without confirmation.
   - **Expected Behavior:** A standard 'X' (close) button should be displayed to dismiss the sheet safely. Deleting the debt is already properly handled in `DebtDetailPage` header with a confirmation dialog.

#### C. Affected Files & Components
- **File:** [`lib/features/debts/presentation/widgets/debt_form_sheet.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/debts/presentation/widgets/debt_form_sheet.dart) (lines 164–179).

#### D. Root Cause Analysis
In `debt_form_sheet.dart`:
```dart
return PokaSheet(
  title: isEditing ? t.debts.editRecord : t.debts.newRecord,
  trailing: isEditing
      ? GestureDetector(
          onTap: () async {
            await ref.read(debtListProvider.notifier).deleteDebt(initialDebt!.id);
            if (context.mounted) Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(FPhosphorIcons.trash, color: context.theme.colors.destructive),
          ),
        )
      : null,
```
Passing `trailing` overrides `PokaSheetHeader`'s default `showCloseButton` behavior, replacing the cancel 'X' button with an unconfirmed, hazardous delete shortcut.

#### E. Proposed Technical Fix
Remove `trailing: isEditing ? ... : null` from `PokaSheet` in `DebtFormSheet`. `PokaSheet` will automatically render the standard 'X' close button via `PokaSheetHeader`. Safe deletion with a confirmation dialog is already implemented in `DebtDetailPage`.

---

### 11. BUG-011: Delete Confirmation Toast Position & Sizing Ergonomics (Top vs Bottom, Card vs 1/3 Width)

> [!NOTE]
> **Verification Status:** ✅ **Valid (No Standalone Issue — Subsumed by BUG-012)**
> - **Verification Analysis:** Top-center alignment is ForUI's default alignment for touch devices. For actionable "Undo" toasts, positioning at `bottomCenter` provides vastly superior one-thumb ergonomics.
> - **Conclusion:** This ergonomic requirement is directly implemented as part of the centralized toast system overhaul in **BUG-012 ([#46](https://github.com/getpoka/poka-ce/issues/46))**. A separate standalone issue is omitted to prevent duplication.

#### A. Problem Description
When a transaction is deleted (via swipe action or item menu), the app displays an **undo toast notification** (`showFToast`) offering a destructive reversal button (*"Batalkan / Undo"*).

Currently, this toast appears at the **top center** (`topCenter`) of the screen. Because deletion undo notifications are **time-sensitive (auto-dismisses within 4–5 seconds)** and **interactive**, positioning them at `topCenter` creates severe ergonomics and usability issues:
1. On modern smartphones (6.1" to 6.8" screens, 800–950dp tall), the top 25% of the screen lies in the **"Unreachable / Hard to Reach" zone** in Steven Hoober's mobile thumb zone ergonomic mapping.
2. When operating the device with one hand, reaching the top edge forces the user to shift their palm grip or bring in a second hand. By the time the user adjusts their grip, the 4-second timeout has often expired, causing permanent loss of the deleted transaction.

Additionally, determining the appropriate width format (e.g. 1/3 width center pill vs almost full-width floating card) requires careful UX evaluation against accessibility and localization constraints.

#### B. Ergonomic & Structural Analysis

##### 1. Position: Top (`topCenter`) vs Bottom (`bottomCenter`)

| Factor | Top Center (`topCenter`) | Bottom Center (`bottomCenter` - Recommended) |
|---|---|---|
| **One-Handed Reachability** | ❌ **Poor:** In the extreme stretch zone for one-handed thumb use. High risk of device slippage. | ✅ **Optimal:** Directly inside the "Natural Thumb Zone" (lower 30–40% of viewport). Zero grip adjustment needed. |
| **Time-Critical Actionability** | ❌ **High failure rate:** Users need ~1.5–2s to notice and reposition fingers, leaving <2s to tap "Undo" before auto-dismiss. | ✅ **Fast reaction:** Users can tap "Undo" in <0.5s with their resting thumb position. |
| **Visual Interference** | ⚠️ Obscures app bar title, search filters, and top navigation tabs. | ⚠️ May overlap bottom navigation bar if not offset with proper floating margin or safe area padding. |
| **Platform Convention** | Used for passive system alerts (e.g., dynamic island, push notifications). | Universal mobile convention for undo / snackbars across iOS, Android, and web apps. |

##### 2. Width: 1/3 Width Center (Mini Pill) vs Almost Full-Width (Floating Card)

| Factor | 1/3 Width Center (~120–130dp) | Floating Card / Almost Full-Width (~320–360dp - Recommended) |
|---|---|---|
| **Content Capacity** | ❌ **Severe bottleneck:** Only fits 1 icon + 1–2 short words. Multi-lingual copy (*"1 transaksi dihapus"*, *"1 transaction deleted"*) will be truncated (*"1 transa..."*). | ✅ **Comfortable:** Elegantly accommodates status icon + descriptive text + prominent action button without clipping. |
| **Touch Target Accessibility** | ❌ **Violates WCAG / Material guidelines:** Squeezing an "Undo" button into 1/3 width leaves <30dp touch target width (standard minimum is 44x44dp / 48x48dp), causing high mis-tap rates. | ✅ **Compliant touch targets:** Full 44–48dp touch target width and height for the "Undo" button, effortless to tap. |
| **Visual Balance & Hierarchy** | ⚠️ Can look awkward or cramped when actionable buttons are embedded inside. | ✅ Premium floating card / capsule aesthetic with subtle border and theme-aware background, strictly respecting Poka's no-shadow constraint. |

#### C. Affected Files & Components
- **Transaction List Page:** [`lib/features/transactions/presentation/screens/transaction_list_page.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/transactions/presentation/screens/transaction_list_page.dart) (lines 568–585)
- **Transaction Group Sliver:** [`lib/features/transactions/presentation/widgets/list/transaction_group_sliver.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/transactions/presentation/widgets/list/transaction_group_sliver.dart) (lines 137–156)
- **Global App Shell:** [`lib/app/app.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/app/app.dart) (line 76: `FToaster` registration)
- **Debts Repayment Deletion (Upcoming):** [`lib/features/debts/presentation/screens/debt_detail_page.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/debts/presentation/screens/debt_detail_page.dart)

#### D. Root Cause Analysis
1. `showFToast` invocations throughout the transactions module omit the `alignment` parameter.
2. In ForUI (`package:forui`), touch devices default to `.topCenter` (`FToasterStyle.toastAlignment: touch ? .topCenter : .bottomEnd`).
3. There is no centralized Poka toast helper for actionable notifications, leading to copy-pasted `showFToast` logic with inconsistent styling, default top alignment, and unhandled bottom safe area offsets.

#### E. Proposed Technical Fix
1. **Create Standardized Toast Helper:**
   Introduce `showPokaActionToast` (or `showPokaUndoToast`) in [`lib/shared/widgets/poka_toast.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/shared/widgets/poka_toast.dart):
   ```dart
   showFToast(
     context: context,
     alignment: FToastAlignment.bottomCenter,
     duration: const Duration(seconds: 5),
     title: Text(message),
     suffixBuilder: (toastContext, entry) => FButton(
       size: FButtonSizeVariant.sm,
       variant: FButtonVariant.outline,
       onPress: () {
         entry.dismiss();
         onAction();
       },
       child: Text(actionLabel),
     ),
   );
   ```
2. **Ergonomic Floating Alignment:**
   - Explicitly use `alignment: FToastAlignment.bottomCenter`.
   - Ensure the toast floats ~16–20px above the bottom safe area or bottom navigation bar to avoid blocking bottom controls.
3. **Card Width & Styling:**
   - Retain ForUI's responsive floating card layout (`maxWidth: 400` with 16px horizontal margins) so it adapts naturally across mobile screen widths (360–420dp).
   - Flat styling with subtle border and zero shadow in compliance with Poka CE design rules.

---

### 12. BUG-012: Toast Notifications Freezing Indefinitely ("Tidak Hilang-Hilang / Kadang Hilang, Kadang Stuck")

> [!NOTE]
> **Verification Status:** ✅ **Valid** | **GitHub Issue:** [#46](https://github.com/getpoka/poka-ce/issues/46)

#### A. Problem Description
Across multiple modules in Poka CE—most prominently after performing a **Backup Restore** (`restoreSuccess`), **Reset Data** (`appDataReset`), or submitting form sheets with errors—toast notifications displayed via ForUI's `showFToast` frequently become **permanently stuck on screen**, failing to auto-dismiss after the standard 4–5 second countdown.

The symptom exhibits erratic intermittent behavior (*"kadang hilang, kadang stuck"*):
- Under passive, untouched conditions, some toasts eventually auto-dismiss.
- However, if the user interacts with the screen (tapping on the toast to dismiss it, scrolling a list underneath, or if the toast is triggered immediately prior to a route transition like `const DashboardRoute().go(context)`), the toast freezes permanently and never leaves the viewport until the application is force-closed.

#### B. Root Cause Analysis (Technical Deep-Dive)
Extensive debugging and test harness analysis in `package:forui/src/widgets/toast/` uncovered four compounding root causes:

1. **Mobile Touch `MouseRegion` Hover Trap:**
   In [`animated_toast.dart`](file:///Users/SupianIDz/.pub-cache/hosted/pub.dev/forui-0.26.0/lib/src/widgets/toast/animated_toast.dart) (lines 314–320):
   ```dart
   MouseRegion(
     onEnter: (_) => _timer?.cancel(),
     onExit: (_) {
       if (widget.autoDismiss) {
         _resumeDismissing();
       }
     },
   ```
   On Android and iOS touchscreens, a finger touch down synthesizes a `PointerEnterEvent`, triggering `onEnter` and destroying `_timer`. However, mobile touch releases **never synthesize `PointerExitEvent`** (`onExit`), so `_resumeDismissing()` is never invoked. A single physical touch over any portion of the toast destroys the countdown timer permanently.

2. **`ToasterStack` Tap-to-Toggle-AutoDismiss Trap:**
   In [`toaster_stack.dart`](file:///Users/SupianIDz/.pub-cache/hosted/pub.dev/forui-0.26.0/lib/src/widgets/toast/toaster_stack.dart) (lines 119–127):
   ```dart
   GestureDetector(
     onTap: () {
       if (!_hovered) {
         setState(() => _autoDismiss = !_autoDismiss);
   ```
   When a user taps on the toast (e.g., trying to dismiss it or tapping an item), `_autoDismiss` is inverted from `true` to `false`. In `AnimatedToast.didUpdateWidget`:
   ```dart
   if (widget.autoDismiss != old.autoDismiss) {
     if (widget.autoDismiss) {
       _resumeDismissing(...);
     } else {
       _timer?.cancel();
     }
   }
   ```
   Tapping once permanently halts auto-dismissal. If tapped a second time, it may resume—explaining why the toast is *"kadang hilang, kadang stuck"*.

3. **Gesture Arena Drag Cancellation:**
   When a user initiates a swipe or scrolls a list under an active toast, `onVerticalDragStart` cancels `_timer`. If the scrollable widget claims the gesture arena, Flutter cancels the drag. Because `GestureDetector` in ForUI omits `onVerticalDragCancel` and `onHorizontalDragCancel`, `_completeSwipe()` is never triggered and the timer remains cancelled indefinitely.

4. **Synchronous `notifyListeners` Assertion Exception on Dismiss:**
   When `entry.dismiss()` is invoked while the entrance animation has not finished (`_entranceDismissController.value == 0`) or during route teardown, `AnimationController.reverse()` completes synchronously. This invokes `_remove(entry)` inside the same frame, which calls `entry.dismissing.dispose()` while `dismissing.notifyListeners()` is still active on the call stack, throwing:
   `Failed assertion: '_notificationCallStackDepth == 0'`.
   This uncaught exception causes Flutter to abort `setState`, leaving the toast in `_entries` forever.

5. **Route Navigation Race Condition on Restore:**
   In [`DataManagementSection`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/settings/presentation/widgets/sections/data_management_section.dart) (lines 159–165):
   ```dart
   showFToast(context: context, title: Text(context.t.backup.restoreSuccess));
   const DashboardRoute().go(context);
   ```
   Triggering `showFToast` immediately before unmounting the route context exacerbates the above issues while `PokaApp` rebuilds from Riverpod provider invalidations (`settingsProvider`).

#### C. Affected Files & Components
- **All Toast Invocations (22+ occurrences):**
  - [`lib/features/settings/presentation/widgets/sections/data_management_section.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/settings/presentation/widgets/sections/data_management_section.dart) (restore, backup, reset, reminder)
  - [`lib/features/transactions/presentation/screens/transaction_list_page.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/transactions/presentation/screens/transaction_list_page.dart) (delete & undo)
  - [`lib/features/transactions/presentation/widgets/list/transaction_group_sliver.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/transactions/presentation/widgets/list/transaction_group_sliver.dart) (delete & undo)
  - [`lib/features/transactions/presentation/widgets/forms/transaction_form_sheet.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/transactions/presentation/widgets/forms/transaction_form_sheet.dart)
  - [`lib/features/recurring/presentation/widgets/recurring_form_sheet.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/recurring/presentation/widgets/recurring_form_sheet.dart)
  - [`lib/features/categories/presentation/widgets/forms/category_form_sheet.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/categories/presentation/widgets/forms/category_form_sheet.dart)
  - [`lib/features/budgets/presentation/widgets/forms/budget_form_sheet.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/budgets/presentation/widgets/forms/budget_form_sheet.dart)
  - [`lib/features/accounts/presentation/widgets/forms/account_form_sheet.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/accounts/presentation/widgets/forms/account_form_sheet.dart)
  - [`lib/features/goals/presentation/widgets/goal_form_sheet.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/goals/presentation/widgets/goal_form_sheet.dart)
  - [`lib/features/debts/presentation/widgets/debt_form_sheet.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/debts/presentation/widgets/debt_form_sheet.dart)
  - [`lib/features/reports/presentation/screens/report_list_page.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/reports/presentation/screens/report_list_page.dart)
  - [`lib/features/settings/presentation/screens/lock_screen.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/settings/presentation/screens/lock_screen.dart)
  - [`lib/features/settings/presentation/widgets/easter_egg_icon.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/settings/presentation/widgets/easter_egg_icon.dart)

#### D. Proposed Technical Fix
Introduce a centralized, battle-tested toast helper in [`lib/shared/widgets/poka_toast.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/shared/widgets/poka_toast.dart) and mirror tests in [`test/shared/widgets/poka_toast_test.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/test/shared/widgets/poka_toast_test.dart):

1. **Independent Watchdog Timer:**
   Attach an external `Timer(duration + 300ms)` directly to the returned `FToasterEntry`. When the timer fires, if `entry.showing == true`, invoke `entry.dismiss()`:
   ```dart
   Timer? watchdogTimer;
   final entry = showFToast(
     context: context,
     title: title,
     duration: duration,
     alignment: alignment,
     onDismiss: () {
       watchdogTimer?.cancel();
       onDismiss?.call();
     },
     ...
   );
   watchdogTimer = Timer(duration + const Duration(milliseconds: 300), () {
     if (entry.showing) {
       WidgetsBinding.instance.addPostFrameCallback((_) {
         if (entry.showing) {
           entry.dismiss();
         }
       });
     }
   });
   ```
2. **Safe Post-Frame Dismissal:**
   Always invoke `entry.dismiss()` inside `WidgetsBinding.instance.addPostFrameCallback` so that `entry.dismissing.dispose()` never collides with active `notifyListeners()` frames.
3. **Cancel Watchdog on Early Dismiss:**
   Cancel `watchdogTimer` in `onDismiss` so no orphan timers linger when dismissed manually or swiped away.
4. **Ergonomic Default Alignment:**
   Default to `FToastAlignment.bottomCenter` with `swipeToDismiss: [AxisDirection.down, AxisDirection.left, AxisDirection.right]`.
5. **Migrate All Calls:**
   Replace raw `showFToast` across all 22+ call sites with `showPokaToast` (informational) and `showPokaActionToast` (actionable).

---

### 13. BUG-013: Privacy Eye / Balance Obfuscation Bypassed on Dashboard Sections (Cashflow, Spending Activity, Categories, Budgets)

> [!NOTE]
> **Verification Status:** ✅ **Valid** | **GitHub Issue:** [#47](https://github.com/getpoka/poka-ce/issues/47)

#### A. Problem Description
Poka provides an eye icon toggle (`balanceVisibilityProvider`) to obscure sensitive monetary balances (e.g. `••••••` or `Rp ••••••`) when looking at the screen in public.
While Net Worth and Account cards respect this privacy state, several core sections on the **Dashboard (Home)** completely ignore `balanceVisibilityProvider` and continue rendering raw numeric values:
1. **Cash Flow View (`DashboardCashFlowView`):**
   - Income (`income.toCompactFormat()`) and Expense (`expense.toCompactFormat()`) are permanently visible with formatted currency figures (e.g., `1.5M`, `450K`).
2. **Spending Activity Card (`DashboardSpendingChart`):**
   - Total Expense (`totalExpenseFormatted`), Daily Average (`avgExpenseFormatted`), and Daily Budget (`dailyBudgetFormatted`) remain fully exposed.
3. **Category Spending Carousel (`DashboardCategoriesView`):**
   - Sub-item spending figures in `buildCategoryStatRow()` (`cat.amount.toCompactFormat()` and `otherAmount.toCompactFormat()`) are unhidden.
4. **Budget Allocation Carousel (`DashboardBudgetView`):**
   - Needs (`needAmt.toCompactFormat()`), Wants (`wantAmt.toCompactFormat()`), and Savings (`saveAmt.toCompactFormat()`) are unhidden.

#### B. Steps to Reproduce
1. On the Dashboard (Home) screen, tap the eye icon on the Net Worth card to hide balance (`isBalanceVisible = false`).
2. Observe the Net Worth card: balance successfully changes to `••••••`.
3. Scroll down to **Cash Flow**, **Spending Activity**, **Categories**, and **Budgets** cards.
4. **Observe the values:**
   - **Actual Behavior:** Raw monetary figures (e.g., `1.2M`, `850K`, `45K`) are still clearly visible across all carousel slides and stats.
   - **Expected Behavior:** All monetary numbers should be obscured (e.g., `••••••`), honoring the user's privacy preference.

#### C. Affected Files & Components
- [`lib/core/extensions/num_extension.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/core/extensions/num_extension.dart) (`toCompactFormat()`)
- [`lib/features/dashboard/presentation/widgets/cards/views/dashboard_cash_flow_view.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/dashboard/presentation/widgets/cards/views/dashboard_cash_flow_view.dart)
- [`lib/features/dashboard/presentation/widgets/cards/dashboard_spending_chart.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/dashboard/presentation/widgets/cards/dashboard_spending_chart.dart)
- [`lib/features/dashboard/presentation/widgets/cards/views/dashboard_categories_view.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/dashboard/presentation/widgets/cards/views/dashboard_categories_view.dart)
- [`lib/features/dashboard/presentation/widgets/cards/views/dashboard_budget_view.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/dashboard/presentation/widgets/cards/views/dashboard_budget_view.dart)

#### D. Root Cause Analysis
1. `NumExtension.toCompactFormat()` does not accept an `isVisible` parameter (unlike `toCurrencyFormat(..., isVisible: bool)`), defaulting unconditionally to compact number formatting.
2. The Dashboard carousel views and chart components never read `ref.watch(balanceVisibilityProvider)` and thus have no awareness of whether the user toggled privacy mode.

#### E. Proposed Technical Fix
1. Update `NumExtension.toCompactFormat({bool isVisible = true})`:
   ```dart
   String toCompactFormat({bool isVisible = true}) {
     if (!isVisible) return '••••••';
     if (this >= 1000000000) return '${(this / 1000000000).toStringAsFixed(1)}B';
     if (this >= 1000000) return '${(this / 1000000).toStringAsFixed(1)}M';
     if (this >= 1000) return '${(this / 1000).toStringAsFixed(1)}K';
     return toStringAsFixed(0);
   }
   ```
2. In `DashboardCashFlowView`, `DashboardSpendingChart`, `DashboardCategoriesView`, and `DashboardBudgetView`:
   - Watch `final isBalanceVisible = ref.watch(balanceVisibilityProvider);`
   - Pass `isVisible: isBalanceVisible` to `.toCompactFormat(isVisible: isBalanceVisible)`.

---

### 14. BUG-014: Privacy Eye / Balance Obfuscation Bypassed on Reports Page & Missing Header Privacy Toggle

> [!NOTE]
> **Verification Status:** ✅ **Valid** | **GitHub Issue:** [#48](https://github.com/getpoka/poka-ce/issues/48)

#### A. Problem Description
On the **Reports Page (`ReportListPage`)**:
1. **Missing In-Page Privacy Toggle:**
   The page header only offers an Excel export action (`FHeaderAction`). There is no eye toggle icon in the header to allow users to quickly toggle privacy on/off while analyzing reports.
2. **Un-obscured Sub-Components & Breakdown Rows:**
   Even if the user toggled privacy mode on the Home page (`isBalanceVisible = false`), multiple components across both tabs ("Cashflow" and "Budgets") bypass privacy:
   - **Category Ranking List (`CategoryItemTile`):** `item.amount.toCompactFormat()` displays raw amounts.
   - **Spending Allocation 50/30/20 (`AllocationRowTile`):** `amount.toCompactFormat()` displays raw amounts.
   - **Budget Item Progress (`BudgetItemTile`):** while `PokaAmountText` is used, the labels use `type: TransactionType.income` which adds a misleading `+` sign for budget caps.

#### B. Steps to Reproduce
1. Hide balance on the Dashboard screen via the Net Worth card.
2. Navigate to the **Reports** tab (`/reports`).
3. **Observe the screen:**
   - **Actual Behavior:** Top Categories and Spending Allocation rows show real monetary numbers (`1.4M`, `500K`). The page header has no eye icon to toggle visibility.
   - **Expected Behavior:** All monetary figures should display `••••••`, and the header should feature an eye action button mirroring Dashboard and Accounts pages.

#### C. Affected Files & Components
- [`lib/features/reports/presentation/screens/report_list_page.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/reports/presentation/screens/report_list_page.dart)
- [`lib/features/reports/presentation/widgets/category_item_tile.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/reports/presentation/widgets/category_item_tile.dart)
- [`lib/features/reports/presentation/widgets/allocation_row_tile.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/reports/presentation/widgets/allocation_row_tile.dart)

#### D. Root Cause Analysis
`CategoryItemTile` and `AllocationRowTile` are dumb stateless widgets that call `toCompactFormat()` without checking `balanceVisibilityProvider`. Furthermore, `ReportListPage` does not include an eye action in `PokaHeader.suffixes`.

#### E. Proposed Technical Fix
1. Add an eye toggle action button to `ReportListPage` header `suffixes`:
   ```dart
   final isVisible = ref.watch(balanceVisibilityProvider);
   ...
   FHeaderAction(
     icon: Icon(isVisible ? FPhosphorIcons.eye : FPhosphorIcons.eyeSlash, size: 20),
     onPress: () => ref.read(balanceVisibilityProvider.notifier).toggle(),
   ),
   ```
2. Update `CategoryItemTile` and `AllocationRowTile` to accept or watch `isVisible` and pass it to `toCompactFormat(isVisible: isVisible)`.

---

### 15. BUG-015: Backup Reminder Notification Permission Missing (Silent Failure on Android 13+ / iOS) & Missing Test Trigger

> [!NOTE]
> **Verification Status:** ✅ **Valid** | **GitHub Issue:** [#49](https://github.com/getpoka/poka-ce/issues/49)

#### A. Problem Description
1. **Silent Notification Failure on Android 13+ & iOS:**
   Android 13+ (API 33+) requires the `POST_NOTIFICATIONS` runtime permission, and iOS requires explicit notification authorization.
   Currently, `NotificationService` only initializes basic notification channel settings in `init()`, but **never requests runtime permission**.
   When a user sets Backup Reminder to **Weekly** or **Monthly** in Settings:
   - The interval is saved to `SharedPreferences`.
   - However, the OS silently blocks all notifications dispatched via `showBackupReminderNotification()`.
   - The user assumes reminders are working, but they never receive any backup prompt.
2. **Untestable Interval Delays:**
   `BackupReminderService.checkAndNotify()` strictly enforces `now.difference(lastBackup).inDays >= 7` (or `30`) and a 24-hour debounce. On first launch, `lastBackup` is automatically set to `DateTime.now()`. Consequently, a developer or tester cannot verify that the notification sound, channel, icon, and title render properly without waiting 7 days or tampering with the device's system clock.

#### B. Steps to Reproduce
1. Install Poka CE on an Android 13+ device or emulator.
2. Go to **Settings** > **Data Management** > **Backup Reminder**.
3. Select **Weekly**.
4. **Observe the system:**
   - **Actual Behavior:** No OS permission dialog appears. No rationale sheet is shown. The interval updates to "Weekly", but the app cannot post notifications.
   - **Expected Behavior:**
     - If notification permission is not granted, display a clear, friendly rationale sheet (explaining that reminders are 100% offline, local, and privacy-first).
     - When confirmed, trigger the native OS notification permission dialog.
     - If permission is denied, keep interval as "Off" (or warn the user).

#### C. Affected Files & Components
- [`lib/core/services/notification_service.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/core/services/notification_service.dart)
- [`lib/features/backup/domain/backup_reminder_service.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/backup/domain/backup_reminder_service.dart)
- [`lib/features/backup/presentation/sheets/backup_reminder_sheet.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/backup/presentation/sheets/backup_reminder_sheet.dart)
- [`lib/features/settings/presentation/widgets/sections/data_management_section.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/settings/presentation/widgets/sections/data_management_section.dart)

#### D. Proposed Technical Fix
1. **Runtime Permission Check & Request in `NotificationService`:**
   Add `hasNotificationPermission()` and `requestNotificationPermission()` methods leveraging `flutter_local_notifications`:
   ```dart
   Future<bool> requestNotificationPermission() async {
     final android = _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
     final grantedAndroid = await android?.requestNotificationsPermission();

     final ios = _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<DarwinFlutterLocalNotificationsPlugin>();
     final grantedIos = await ios?.requestPermissions(alert: true, badge: true, sound: true);

     return (grantedAndroid ?? grantedIos) ?? true;
   }
   ```
2. **Notification Rationale Bottom Sheet (`PokaSheet`):**
   When the user selects Weekly or Monthly, if notification permission is not yet granted:
   - Present an explanatory bottom sheet:
     - Header: "Pengingat Cadangan Lokal"
     - Icon: `FPhosphorIcons.bellRing`
     - Body: "Poka membutuhkan izin notifikasi untuk mengingatkan Anda mencadangkan database secara berkala. Pengingat berjalan sepenuhnya di perangkat Anda tanpa pelacak atau analitik."
     - Actions: "Izinkan Notifikasi" & "Batal"
   - If user confirms, request OS permission. If granted, update interval to Weekly/Monthly; if denied, keep interval as Off.
3. **Developer / Manual Test Notification Trigger:**
   Add a direct test trigger (`triggerTestReminder()`) in `BackupReminderService` and a test button (e.g. trailing icon in Backup Reminder tile or debug menu) so testers and users can immediately test the notification banner and vibration without waiting 7 days.

---

## 📋 Recommended Action Items

1. [x] Implement allocation badge display in [`lib/features/transactions/presentation/widgets/split/transaction_split_item_list.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/transactions/presentation/widgets/split/transaction_split_item_list.dart) (BUG-001 — [#37](https://github.com/getpoka/poka-ce/issues/37)).
2. [x] Implement category auto-resolution and child tile passing in [`lib/features/transactions/presentation/widgets/tile/transaction_tile.dart`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/transactions/presentation/widgets/tile/transaction_tile.dart) (BUG-002 — [#38](https://github.com/getpoka/poka-ce/issues/38)).
3. [x] ~~Add `recurring_period` column in Drift schema and snapshot period in `RecurringProcessorService`~~ (BUG-003 — **Marked Invalid / Working as Designed per `database-schema.md`**; candidate for future feature discussion).
4. [x] Make `SettingsNotifier` keep-alive (`@Riverpod(keepAlive: true)`), remove `_disposed` flag issue, and ensure base currency changes take effect immediately across all sessions (BUG-004 — [#39](https://github.com/getpoka/poka-ce/issues/39)).
5. [x] Add `restoreWarningDesc` localization key and fix copy in restore confirmation dialog (BUG-005 — [#40](https://github.com/getpoka/poka-ce/issues/40)).
6. [x] Properly close database connection, clean WAL/SHM files, and reload all providers reactively on restore without requiring app restart (BUG-006 — [#41](https://github.com/getpoka/poka-ce/issues/41)).
7. [ ] Fix date formatting locale, `TransactionTypeSwitcher` tabs, and default category translations on the Transactions page (BUG-007 — [#42](https://github.com/getpoka/poka-ce/issues/42)).
8. [x] Enable swipe-to-edit and swipe-to-delete on repayment tiles in [`DebtDetailPage`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/debts/presentation/screens/debt_detail_page.dart) (BUG-008 — [#43](https://github.com/getpoka/poka-ce/issues/43)).
9. [x] Handle debt repayment semantic labeling and icon in `RecentTransactionTile` to eliminate "Uncategorized" (BUG-009 — [#44](https://github.com/getpoka/poka-ce/issues/44)).
10. [x] Restore standard 'X' close button on [`DebtFormSheet`](file:///Users/SupianIDz/Work/getpoka/poka-ce/lib/features/debts/presentation/widgets/debt_form_sheet.dart) by removing the unconfirmed header trash action (BUG-010 — [#45](https://github.com/getpoka/poka-ce/issues/45)).
11. [ ] Create standardized `showPokaActionToast` / `showPokaUndoToast` with `bottomCenter` floating card ergonomics (BUG-011 — **Subsumed by BUG-012 [#46](https://github.com/getpoka/poka-ce/issues/46)**).
12. [ ] Implement `showPokaToast` with watchdog timer to eliminate stuck toasts across mobile touch events and route transitions (BUG-012 — [#46](https://github.com/getpoka/poka-ce/issues/46)).
13. [ ] Implement privacy eye obfuscation (`isVisible`) across Dashboard Cashflow, Spending Activity, Categories, and Budgets (BUG-013 — [#47](https://github.com/getpoka/poka-ce/issues/47)).
14. [ ] Implement privacy eye obfuscation and add header toggle button on Reports page (BUG-014 — [#48](https://github.com/getpoka/poka-ce/issues/48)).
15. [ ] Implement Notification Permission Rationale Sheet and manual test trigger for Backup Reminder (BUG-015 — [#49](https://github.com/getpoka/poka-ce/issues/49)).
16. [ ] Run `rune generate`, `rune fix`, `rune check`, and `rune test` to verify zero issues upon bug resolution.



