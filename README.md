<p align="center">
  <img src="assets/images/logo.png" width="100" alt="Poka CE Logo" />
</p>

<h1 align="center">Poka CE — Community Edition</h1>
<p align="center"><i>Simple. Offline. Yours. — Personal finance management, no cloud required.</i></p>
<p align="center"><a href="https://getpoka.app">getpoka.app</a></p>

<p align="center">
  <a href="https://github.com/getpoka/poka-ce/releases">
    <img src="https://img.shields.io/github/v/release/getpoka/poka-ce?style=for-the-badge&logo=github&label=Release" alt="Release" />
  </a>
  <a href="https://github.com/getpoka/poka-ce/actions/workflows/ci.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/getpoka/poka-ce/ci.yml?style=for-the-badge&logo=github&label=CI" alt="CI" />
  </a>
  <a href="https://github.com/getpoka/poka-ce/blob/main/LICENSE">
    <img src="https://img.shields.io/badge/license-Apache%202.0-blue?style=for-the-badge" alt="License" />
  </a>
  <a href="https://flutter.dev">
    <img src="https://img.shields.io/badge/Flutter-3.47%2B-02569B?style=for-the-badge&logo=flutter" alt="Flutter" />
  </a>
</p>

<p align="center">
  <img src="assets/screenshots/01_home-portrait.png" width="220" />&nbsp;&nbsp;
  <img src="assets/screenshots/02_transactions-portrait.png" width="220" />&nbsp;&nbsp;
  <img src="assets/screenshots/11_transaction_expense-portrait.png" width="220" />
</p>

<details>
  <summary><b>More screenshots</b></summary>
  <br/>

|                                       Home                                       |                                Home (Dark)                                |                               Transactions                                |                              Transactions (Dark)                               |
|:--------------------------------------------------------------------------------:|:-------------------------------------------------------------------------:|:-------------------------------------------------------------------------:|:------------------------------------------------------------------------------:|
|        <img src="assets/screenshots/01_home-portrait.png" width="200" />         |  <img src="assets/screenshots/14_dark_home-portrait.png" width="200" />   | <img src="assets/screenshots/02_transactions-portrait.png" width="200" /> | <img src="assets/screenshots/15_dark_transactions-portrait.png" width="200" /> |
|                                 **Expense Form**                                 |                            **Expense (Dark)**                             |                                **Reports**                                |                                  **Budgets**                                   |
| <img src="assets/screenshots/11_transaction_expense-portrait.png" width="200" /> | <img src="assets/screenshots/16_dark_expense-portrait.png" width="200" /> |   <img src="assets/screenshots/03_reports-portrait.png" width="200" />    |      <img src="assets/screenshots/05_budgets-portrait.png" width="200" />      |

</details>

---

## About Poka

Poka CE is a personal finance tracker with one core principle: **your financial data belongs to you, and only you.**
There is no account to create, no server to sync with, and no subscription to manage. Every transaction, balance, and
record lives exclusively in a local SQLite database on your device.

Unlike most finance apps that treat cloud sync as a default, Poka CE treats local-first storage as a hard architectural
constraint — not an optional mode. It is open-source, built with Flutter, and designed to be simple enough for daily use
without being stripped of the features that matter.

> [!NOTE]
> **Data Safety & Backups.** Because Poka CE stores 100% of your data locally on your device with zero cloud syncing,
> we strongly recommend creating periodic backups via **Settings → Backup & Export** to safeguard against device loss or replacement.

---

## Key Features

- **Multi-Account Management** — Track multiple accounts and sub-wallet pockets simultaneously with real-time balance updates.
- **Income, Expense & Transfer** — Record all transaction types with full history, search, and multidimensional filters.
- **Split Transactions** — Allocate a single receipt across multiple categories or pockets with automatic amount balance verification.
- **5-Second Undo Delete** — Instantly restore accidentally deleted transactions, line items, and balance mutations with a single tap.
- **Budgeting** — Set monthly spending limits per category or account and track actual progress directly from item receipts.
- **Goals** — Define savings targets linked to dedicated pockets and track progress automatically.
- **Debt & Loan Tracking** — Log borrowed or lent funds with paired wallet cashflow entries and installment tracking.
- **Smart Input Parsing** — Type arithmetic expressions directly into the amount field (e.g., `150000+50000*2`) with real-time evaluation.
- **Bilingual Support** — Fully localized interface in English and Bahasa Indonesia with seamless in-app language switching.
- **Multi-Sheet Data Export** — Export comprehensive financial records to Excel (`.xlsx`) or export/import JSON backups.
- **Android App Shortcuts** — Quick-action shortcuts from your home screen for rapid transaction entry.
- **Offline First & Private** — 100% local SQLite storage via Drift. No internet required, no analytics, no trackers.
- **Flat Design System** — Built strictly with [ForUI](https://github.com/forui-dev/forui); zero shadows, dual typography (Plus Jakarta Sans & Tabular Inter), clean and sharp.

---

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) & Dart
- **Database**: [Drift](https://drift.simonbinder.eu/) (SQLite, local-only)
- **State Management**: [Riverpod](https://riverpod.dev/) with `riverpod_generator`
- **UI & Design System**: [ForUI](https://github.com/forui-dev/forui)
- **Routing**: [GoRouter](https://pub.dev/packages/go_router) with `go_router_builder`
- **Localization**: [Slang](https://pub.dev/packages/slang)
- **Code
  Generation**: [Freezed](https://pub.dev/packages/freezed), [build_runner](https://pub.dev/packages/build_runner)

---

## Download & Install

Download the latest release directly from the [GitHub Releases page](https://github.com/getpoka/poka-ce/releases).

**System Requirements & Platform Support:**

- **OS**: Android 5.0 (Lollipop) or newer (API level 21+)
- **Storage**: ~30 MB free space (if using Split APK)
- **Internet**: Not required — Poka CE is 100% offline.
- **iOS & Desktop**: Poka CE is currently distributed as an Android APK. iOS and desktop support remain on the project roadmap.

**Which APK should I choose?**

- `app-arm64-v8a-release.apk` **(Recommended)**: Almost all modern Android phones (2016 and newer).
- `app-armeabi-v7a-release.apk`: Older 32-bit Android devices.
- `app-universal-release.apk`: Works on all devices, but larger in size. Use this if you are unsure or if the others
  fail to install.

---

## Quickstart

### Prerequisites

- Flutter SDK **3.47.1** or newer
- Dart SDK **3.13.1** or newer
- [Rune](https://github.com/octopyid/rune) task runner (recommended)

#### Installing Rune

Poka CE uses [Rune](https://github.com/octopyid/rune) — a fast, opinionated project-local task runner written in Go by [@octopyid](https://github.com/octopyid).

**Homebrew (macOS / Linux):**

```bash
brew install octopyid/tap/rune
```

**Go:**

```bash
go install github.com/octopyid/rune/cmd/rune@latest
```

### Steps

**1. Clone the repository:**

```bash
git clone https://github.com/getpoka/poka-ce.git
cd poka-ce
```

**2. Install dependencies:**

```bash
flutter pub get
```

**3. Set up environment and generate code:**

```bash
cp .env.example .env
rune generate
```

> The `.env` file is required. Set `POKA_ENABLE_SEEDER=true` to populate the database with seed data for development.
> If you don't have Rune installed, run `dart run build_runner build && dart run slang` instead.

**4. Run the application:**

```bash
rune run
```

> If you don't have Rune installed, run `flutter run --dart-define-from-file=.env` instead.
> For the full contribution workflow, testing setup, watch mode code generation, and database migration guide —
> see [CONTRIBUTING.md](CONTRIBUTING.md).

---

## Trademark & Brand Policy

The Apache 2.0 license covers the code — it does **not** grant rights to the **Poka**, **GetPoka**, or **Octopy ID**
brand identities. You may freely fork, modify, and self-host this project, but you may not publish a derivative under
our name, logo, or domains, or imply official affiliation.

Read the full policy: [TRADEMARK.md](TRADEMARK.md).

---

## Security & Privacy

Poka CE uses an **offline-first, local-only architecture**. All financial data is stored in a SQLite database on the
user's device. No data is transmitted to any server, and no analytics or telemetry is collected.

**Reporting a Vulnerability:** If you discover a security issue, please follow the responsible disclosure process
described in [SECURITY.md](SECURITY.md). Do not open a public GitHub issue for security vulnerabilities — contact
**security@getpoka.app** directly.

---

## Contributing

Contributions are welcome — bug reports, feature discussions, and pull requests alike. If you are new to the codebase,
look for issues labeled `good first issue` as a starting point.

Before submitting a pull request, please read [CONTRIBUTING.md](CONTRIBUTING.md). It covers the architecture
constraints, code style, commit conventions, branch workflow, and the PR review process.

---

## License

Poka CE is licensed under the **Apache License 2.0**. See [LICENSE](LICENSE) for the full license text.
