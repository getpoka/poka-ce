# Changelog

All notable changes to Poka CE will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [v1.0.1] - 2026-09-12

Post-GA stabilization, security hardening, and database query optimization release.

### Security

- Disabled Android ADB backup (`android:allowBackup="false"`) in `AndroidManifest.xml` to prevent plaintext data extraction via USB debugging.
- Strengthened backup encryption key derivation to 100,000 PBKDF2 iterations and enforced standard UTF-8 password encoding.
- Hardened encrypted backup validation with a 50MB file size ceiling and verified SQLite 3 magic header before database restoration.
- Sanitized Riverpod talker observer logging by masking provider state values and restricting verbose lifecycle logging to debug mode.
- Implemented background app lifecycle auto-lock with a 1-minute grace period respecting active system sheets and photo pickers.

### Performance

- Added database indexes for `transaction_date`, `account_id`, `transaction_items.transaction_id`, `transaction_items.category_id`, and `accounts.parent_id`.
- Configured SQLite runtime PRAGMAs (`synchronous = NORMAL`, `temp_store = MEMORY`, `cache_size = -64000`) for improved throughput and reduced flash storage wear.
- Offloaded Excel file compression and encoding to a background Dart isolate (`Isolate.run`), eliminating UI thread hitches during transaction exports.
- Executed atomic WAL checkpoint (`PRAGMA wal_checkpoint(TRUNCATE)`) prior to backup packaging to ensure complete transaction persistence.

### Changed

- Bundled regular offline fonts locally and removed runtime `google_fonts` network fetching dependency.
- Removed redundant font fallbacks and unused Cupertino widget dependencies.
- [internal] Overhauled automated PR review and issue triage workflows with OpenRouter app attribution and English prompt guidelines.

### Fixed

- Fixed unreleased `TextEditingController` and `FocusNode` memory leaks across transaction, split item, and debt repayment note modal dialogs.
- Ensured unresolved arithmetic keypad expressions evaluate automatically upon saving transactions.

## [v1.0.0] - 2026-09-11

Initial General Availability release of Poka CE.

### Changed

- Enforced offline-only typography runtime mode (`allowRuntimeFetching = false`), guaranteeing Inter and Plus Jakarta Sans render from local assets with zero external network access.
- Standardized Android application launcher label to TitleCase `Poka CE`.
- Expanded default category catalog to 62 expense and income categories with rich sub-categories and diverse iconography.
- Excluded sub-pockets and virtual goal accounts from the active accounts counter badge on Net Worth cards while preserving full balance aggregation across all active accounts and pockets.
- Hardened Android ProGuard/R8 rules for local notifications, biometric authentication, secure storage, and Drift SQLite engine.
- Configured Dart code obfuscation, debug symbol splitting, and packaging metadata stripping for release builds.
- Standardized release APK distribution naming convention to `poka-v<version>-<abi>.apk` and automated SHA-256 checksums generation in release workflow.
- Enhanced About settings page with a direct 'Check for Updates' release link referencing centralized repository configuration.
- Enhanced empty views across Debt, Goal, Budget, Recurring, Account, Dashboard, and Report sections with informative subtitles and contextual descriptions.
- Streamlined Goals page into a unified single-stream layout, replacing header filter chips with a dedicated section for completed goals.
- Aligned Debt repayment sheet layout with the transaction form sheet, replacing the floating outline button with an integrated meta bar featuring note editing and an interactive quick pay-in-full toggle action.

### Fixed

- Resolved `RecurringListNotifier` lifecycle disposal error during active screen navigation and background runner processing.
- Fixed content clipping in `PokaEmptyViewCentered` on tall viewports by enforcing safe min-height constraints.
- Standardized container borders on empty view components to appear only when succeeded by additional page sections.

## [v1.0.0-rc.2] - 2026-09-10

Release Candidate 2 for Poka CE v1.0.0. Incorporates all smoke testing bug fixes and stabilization improvements discovered during RC.1 evaluation.

### Fixed

- Fixed missing allocation badge (Need, Want, Saving) on split item preview list in transaction creation sheet.
- Resolved category resolution for split transaction child items when expanded, preventing them from falling back to "Uncategorized".
- Restored standard close button on Debt edit sheet and eliminated unconfirmed direct delete action.
- Added swipe-to-edit and swipe-to-delete interactions to repayment history items in Debt detail page.
- Add semantic debt and loan labels and handshake icon for unassigned debt repayment transactions in `RecentTransactionTile`.
- Correct confirmation dialog description for backup restore to accurately describe data replacement instead of data deletion.
- Ensure clean database teardown and WAL/SHM file cleanup before disk write on backup restore, and reload all feature state providers reactively without requiring app restart.
- Ensure base currency selected during onboarding immediately takes effect across the session by marking `SettingsNotifier` with `keepAlive: true` and removing fragile disposal guards.
- Fixed unlocalized date headers and month navigation labels on the Transactions page by wiring intl locale initialization and date formatters to active locale.
- Fixed hardcoded transaction type tab labels in `TransactionTypeSwitcher` to use localized strings.
- Fixed balance visibility privacy toggle being bypassed across Dashboard cards (Cash Flow, Spending Activity, Categories, and Budgets).
- Added header privacy eye action button on the Reports page and obscured financial amounts across category rankings, spending allocation rules, and cashflow charts when privacy mode is enabled.
- Resolved toast notification freeze on mobile touch interactions and route transitions by introducing `showPokaToast` with an independent watchdog timer and post-frame dismissal.
- Standardized actionable undo toast positioning to `bottomCenter` (`showPokaActionToast`) for optimal one-handed thumb ergonomics.
- Added notification runtime permission verification and rationale sheet for Android 13+ and iOS when configuring backup reminders, preventing silent reminder delivery drops.
- Added `POST_NOTIFICATIONS` permission declaration in AndroidManifest.
- Added direct test notification trigger in the backup reminder sheet to verify local notification delivery and vibration immediately.

## [v1.0.0-rc.1] - 2026-09-09

Release Candidate 1 for Poka CE v1.0.0. All planned features for v1 are code-frozen. This build enters the smoke testing phase prior to the official v1.0.0 release.

### Added

- 5-second Undo Delete for transactions with a temporary toast allowing users to restore deleted transactions, line items, and account balance mutations.
- Periodic backup reminder with customizable intervals (Off, Weekly, Monthly), tracking last backup timestamps and alerting users when backups are due.
- Multi-sheet Excel export (`.xlsx`) exporting transactions, accounts, and categories via native system sharing.
- [internal] Drift schema verification suite and schema v1 snapshot to guarantee schema integrity for upcoming releases.
- Insufficient balance confirmation warning dialog when creating or editing outgoing transactions (expense and transfer) that exceed available account balance, allowing users to proceed or review.
- Reusable `PokaDonutChart` component unifying donut chart styling across Home and Reports with modern slim geometry and crisp section dividers.

### Changed

- Modernized dashboard spending bar chart with subtle background tracks, bottom-aligned fill, and unified 6px border radius.
- Elevated reports cashflow bar chart with widened rods (13px), consistent top corner radius (6px), and softer gridlines.
- Harmonized category breakdown chart and summary hero card in reports with unified donut styling.

## [v0.1.0-beta.5] - 2026-09-08

Comprehensive bilingual localization (English & Indonesian), visual Net Worth sparkline trends, entity creation prefill support, and critical database integrity fixes for transaction reversals and recurring schedules.

### Added

- Comprehensive bilingual localization support for English and Indonesian across all screens, navigation bars, bottom sheets, form dialogs, and local notifications.
- Visual net worth trend sparkline on the dashboard hero balance card.
- Support for pre-filling initial values (accounts, transaction types, dates) when opening creation form sheets.
- Intelligent pluralization formatting for account pocket counters (`1 pocket` / `N pockets`).

### Changed

- Replaced all hardcoded UI text with dynamic Slang localization bindings across all feature modules.
- Localized financial report date ranges, navigation headers, and relative period comparisons (`last month`, `previous month`).

### Fixed

- Resolved database integrity issues by ensuring balance mutations and budget deductions are reliably reversed when transactions are deleted.
- Fixed debt creation and repayment flows to accurately synchronize and deduct linked budget spending records.
- Prevented date drift in recurring transactions so scheduled bills advance accurately.
- Preserved adaptive vector icons for Android App Shortcuts on release builds (ProGuard/R8).
- Fixed sparkline endpoint dot clipping on compact screens.
- [internal] Added automated AI issue triage workflow with DeepSeek grounding.
- [internal] Added Cloudflare deploy hook trigger to release workflow.

## [v0.1.0-beta.4] - 2026-09-05

### Added

- Android App Shortcuts for home screen quick navigation (`Add Transaction`, `Add Account`, `Add Category`, `Add Goal`) with dedicated adaptive vector icons.
- Interactive collapsible daily transaction groups with smooth expanding/collapsing animations, rotating carets, and transaction count badges.
- Standardized dual-font typography system: **Plus Jakarta Sans** for UI text and **Tabular Inter** for all financial numbers and amounts.
- Global currency master catalog decoupled from essential database seeding for faster app initialization.

### Changed

- Refined balance and hero card typography to 22px (`amountSection`) across Home Net Worth, Account Hero, and Transaction Summary cards.
- Polished transaction list item styling: standardized 14px semibold category label, removed split tree lines in favor of clean 16px YAML-style indentation.
- Replaced 8×8 circular date bullets with 4×16px vertical accent bars matching `PokaSectionLabel`.
- Streamlined Transaction Filter sheet by removing redundant labels and normalizing active chip borders.

### Fixed

- Preserved date group collapse states across `SliverList.builder` viewport recycling and data mutations.
- Resolved codebase architectural violations (eliminated `dynamic`, removed `throw` inside repositories/notifiers, centralized inline styling).
- Updated mock interfaces and assertions across reports, filters, and settings test suites.

### Testing & Quality

- Raised test suite code coverage past 85% across models, repositories, and UI widgets.

### Docs & Chores

- Established CE-specific architectural boundary rules, coding standards, and contribution guidelines.
- Configured automated PR-Agent workflow with custom review guidelines and enhanced PR template.
- Suppressed Gradle deprecation warnings and added branding asset generation scripts.

## [v0.1.0-beta.3] - 2026-09-02

### Added

- `dashboardHeaderBuilderProvider` to allow dynamic injection of custom dashboard headers via Riverpod, preserving CE blindness.
- Integrated Codium PR Agent workflow using DeepSeek via LiteLLM for automated code reviews.

### Changed

- Refactored `DashboardQuickActions` to display a maximum of 5 items horizontally centered, with text overflow handled via `ellipsis`.
- Migrated all form sheets across the app to use proper Form-based validation logic.
- Refined Markdown typography and beautified the FAQ page layout.
- Flattened presentation widget structures for smaller, more focused features.
- Switched to UUIDv7 for deterministic, time-sorted transaction IDs.

### Fixed

- Resolved asset loading path bugs and state lifecycle issues.
- Ensured form inputs are properly validated inside notifiers before triggering save actions.
- Reset FAB (Floating Action Button) visibility states correctly when switching tabs in the main shell.
- Fixed e2e test failures introduced by the new form validation migration.

### CI & Chores

- Formatted and organized `pubspec.yaml` dependencies.
- Optimized GitHub Actions workflows to save runner minutes by only triggering when a PR is marked as "Ready for Review".

## [v0.1.0-beta.2] - 2026-09-01

### Added

- Bundled Google Fonts offline to preserve visual consistency without network dependencies.
- Transaction list search — find transactions by note or amount directly from the list.
- Category management with strict hierarchy and improved UX (parent/child constraints, better empty states).
- Goal accounts shown in a dedicated section on the accounts screen.
- About page now shows the release version based on the current GitHub tag.

### Changed

- Standardized empty states across the application.
- Removed extra top padding on list screens for better visual consistency.
- Theme icon set migrated from Lucide to Phosphor for consistent iconography.
- Category screens: reactive detail updates, synced sheet tabs, standardized hero card radius, and cleaner empty states.
- Sub-category sheets hide expense/income tabs and use a clearer "Sub-category" title.
- Transaction deletion confirmation dialog standardized across the app.
- FAB (add button) visibility is more forgiving near the top edge of the shell.
- About page logo enlarged with an updated description.
- Accounts screen components modularized to enforce the design system.

### Fixed

- Resolved Google Fonts network exception in theme coverage tests.
- Fixed e2e test timeout caused by active stream listeners.
- Fixed empty state test assertions.
- Sub-category creation flow corrected and bottom sheet title updated.

### Docs

- Added `TRADEMARK.md` to protect brand identities.
- Overhauled README and TRADEMARK guidelines.

### CI & Chores

- CI no longer triggers on push to save GitHub Actions minutes.
- Reorganized and cleaned up `.gitignore`; ignored opencode/tui configs and private agent files.
- Updated launcher and branding assets.

## [v0.1.0-beta.1] - 2026-08-31

🎉 Initial Community Release — Poka CE has officially entered the Beta phase.

All core features are feature-complete and ready to be explored:

- **Transactions** — income, expense, and transfer tracking with split transaction support (header + item detail), real-time balance mutation, and hard-delete with reversal.
- **Budgets** — spending limits with monthly/weekly/yearly/custom periods and accurate progress deduction from transaction items.
- **Goals** — saving targets backed by auto-generated Goal pockets with transfer-based deposits.
- **Debts & Loans** — inter-personal cash flows with paired income/expense transactions and remaining balance tracking.
- **Recurring Transactions** — automatic bills that generate real transactions and shift their next date on app startup.
- **Accounts & Pockets** — parent accounts with sub-wallets and category restrictions.
- **Categories** — income/expense categories with sub-categories.
- **Dashboard, Reports, Settings, Onboarding & Backup** supporting the core experience.

> **⚠️ Important Note:** This version is still under testing. Deep edge cases (such as editing or deleting complex interconnected data) have not been fully verified. Unexpected bugs may occur — we recommend trying it with dummy data first, or regularly backing up your data from the Settings menu. Help us reach v1.0 by reporting bugs via the [Issues](https://github.com/getpoka/poka-ce/issues) tab.

[Unreleased]: https://github.com/getpoka/poka-ce/compare/v1.0.1...main
[v1.0.1]: https://github.com/getpoka/poka-ce/compare/v1.0.0...v1.0.1
[v1.0.0]: https://github.com/getpoka/poka-ce/compare/v1.0.0-rc.2...v1.0.0
[v1.0.0-rc.2]: https://github.com/getpoka/poka-ce/compare/v1.0.0-rc.1...v1.0.0-rc.2
[v1.0.0-rc.1]: https://github.com/getpoka/poka-ce/compare/v0.1.0-beta.5...v1.0.0-rc.1
[v0.1.0-beta.5]: https://github.com/getpoka/poka-ce/compare/v0.1.0-beta.4...v0.1.0-beta.5
[v0.1.0-beta.4]: https://github.com/getpoka/poka-ce/compare/v0.1.0-beta.3...v0.1.0-beta.4
[v0.1.0-beta.3]: https://github.com/getpoka/poka-ce/compare/v0.1.0-beta.2...v0.1.0-beta.3
[v0.1.0-beta.2]: https://github.com/getpoka/poka-ce/compare/v0.1.0-beta.1...v0.1.0-beta.2
[v0.1.0-beta.1]: https://github.com/getpoka/poka-ce/releases/tag/v0.1.0-beta.1