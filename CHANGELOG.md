# Changelog

All notable changes to Poka CE will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

[Unreleased]: https://github.com/getpoka/poka-ce/compare/v0.1.0-beta.2...main
[v0.1.0-beta.2]: https://github.com/getpoka/poka-ce/compare/v0.1.0-beta.1...v0.1.0-beta.2
[v0.1.0-beta.1]: https://github.com/getpoka/poka-ce/releases/tag/v0.1.0-beta.1