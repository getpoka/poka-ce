///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsId extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsId({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.id,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <id>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsId _root = this; // ignore: unused_field

	@override 
	TranslationsId $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsId(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$accounts$id accounts = _Translations$accounts$id._(_root);
	@override late final _Translations$app$id app = _Translations$app$id._(_root);
	@override late final _Translations$backup$id backup = _Translations$backup$id._(_root);
	@override late final _Translations$budgets$id budgets = _Translations$budgets$id._(_root);
	@override late final _Translations$categories$id categories = _Translations$categories$id._(_root);
	@override late final _Translations$common$id common = _Translations$common$id._(_root);
	@override late final _Translations$dashboard$id dashboard = _Translations$dashboard$id._(_root);
	@override late final _Translations$debts$id debts = _Translations$debts$id._(_root);
	@override Map<String, String> get error => {
		'generic': 'Terjadi kesalahan yang tidak terduga',
		'network': 'Periksa koneksi Anda dan coba lagi',
		'database': 'Gagal mengakses data lokal',
	};
	@override late final _Translations$goals$id goals = _Translations$goals$id._(_root);
	@override late final _Translations$lock$id lock = _Translations$lock$id._(_root);
	@override late final _Translations$onboarding$id onboarding = _Translations$onboarding$id._(_root);
	@override late final _Translations$recurring$id recurring = _Translations$recurring$id._(_root);
	@override late final _Translations$reports$id reports = _Translations$reports$id._(_root);
	@override late final _Translations$settings$id settings = _Translations$settings$id._(_root);
	@override late final _Translations$shared$id shared = _Translations$shared$id._(_root);
	@override late final _Translations$transactions$id transactions = _Translations$transactions$id._(_root);
}

// Path: accounts
class _Translations$accounts$id extends Translations$accounts$en {
	_Translations$accounts$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get accountName => 'Nama Akun';
	@override String get initialBalance => 'Saldo Awal';
	@override String get icon => 'Ikon';
	@override String get color => 'Warna';
	@override String get assets => 'Aset';
	@override String get liability => 'Liabilitas';
	@override String get income => 'Pemasukan';
	@override String get expense => 'Pengeluaran';
	@override String get balance => 'Balance';
	@override String get walletsPockets => 'Wallets & Pockets';
	@override String get accounts => 'Accounts';
	@override String get mainAccounts => 'Akun Utama';
	@override String get goalsAndSavings => 'Target & Tabungan';
	@override String get deleteAccount => 'Delete Account';
	@override String get areYouSureYouWantToDeleteThisAccountItWillBeHiddenFromTheApp => 'Are you sure you want to delete this account? It will be hidden from the app.';
	@override String get delete => 'Delete';
	@override String get account => 'Account';
	@override String get totalBalance => 'Total Balance';
	@override String get pockets => 'Pockets';
	@override String get deletePocket => 'Delete Pocket';
	@override String get areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp => 'Are you sure you want to delete this pocket? It will be hidden from the app.';
	@override String get nameCannotBeEmpty => 'Name cannot be empty';
	@override String get egMainWallet => 'e.g., Main Wallet';
	@override String get selectIcon => 'Pilih Ikon';
	@override String get allowedCategories => 'Allowed Categories';
	@override String get transactions => 'Transactions';
	@override String get editAccount => 'Edit Account';
	@override String get updateNameIconOrColor => 'Update name, icon, or color';
	@override String get permanentlyRemoveThisAccount => 'Permanently remove this account';
	@override String get seeAll => 'See All';
	@override String get noTransactionsYet => 'No transactions yet';
	@override String get addAccount => 'Add Account';
	@override String get noAccountsFound => 'Akun tidak ditemukan.';
	@override String get addPocket => 'Add Pocket';
	@override String get noPocketsYet => 'No pockets yet';
	@override String get pocketsHelpYouSplitYourWalletIntoCategories => 'Pockets help you split your wallet into categories';
	@override String get activeAccount => 'Active Account';
	@override String get inactiveAccountsWillBeHidden => 'Inactive accounts will be hidden';
	@override String get noCategoriesAvailable => 'No categories available.';
	@override String get noAccountsFound1 => 'Akun tidak ditemukan';
	@override String subcategoriesCount({required Object count}) => '${count} subkategori';
	@override String pocketsCount({required Object count}) => '${count} kantong';
	@override String get totalActiveAccounts => 'Total Akun Aktif';
	@override String get noAccountsYet => 'Belum Ada Akun';
	@override String get tapTheButtonBelowToAddYourFirstAccount => 'Tekan tombol di bawah untuk menambahkan akun pertama Anda';
}

// Path: app
class _Translations$app$id extends Translations$app$en {
	_Translations$app$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get name => 'Poka';
	@override String get tagline => 'Teman keuangan pribadi Anda';
	@override late final _Translations$app$nav$id nav = _Translations$app$nav$id._(_root);
	@override String get termsOfService => 'Syarat Layanan';
	@override String get privacyPolicy => 'Kebijakan Privasi';
}

// Path: backup
class _Translations$backup$id extends Translations$backup$en {
	_Translations$backup$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cadangkan & Pulihkan';
	@override String get backupAction => 'Cadangkan';
	@override String get restoreAction => 'Pulihkan';
	@override String get password => 'Kata Sandi';
	@override String get confirmPassword => 'Konfirmasi Kata Sandi';
	@override String get passwordsDoNotMatch => 'Kata sandi tidak cocok';
	@override String get backupSuccess => 'Pencadangan berhasil';
	@override String get restoreSuccess => 'Pemulihan berhasil';
	@override String get incorrectPassword => 'Kata sandi salah atau file rusak';
	@override String get enterPasswordToEncrypt => 'Masukkan kata sandi untuk mengenkripsi cadangan';
	@override String get enterPasswordToDecrypt => 'Masukkan kata sandi untuk mendekripsi cadangan';
	@override String get pleaseRestart => 'Silakan mulai ulang aplikasi untuk menerapkan perubahan.';
	@override String get passwordRequired => 'Kata sandi wajib diisi';
}

// Path: budgets
class _Translations$budgets$id extends Translations$budgets$en {
	_Translations$budgets$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get budgetName => 'Nama anggaran';
	@override String get spendingLimit => 'Batas pengeluaran';
	@override String get period => 'Periode';
	@override String get resetDay => 'Hari reset (1-31)';
	@override String get createBudget => 'Buat Anggaran';
	@override String get endDate => 'Tanggal Berakhir';
	@override String get budgetDetails => 'Budget Details';
	@override String get deleteBudget => 'Delete Budget';
	@override String get areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone => 'Are you sure you want to delete this budget? All related tracking history will be permanently deleted. This action cannot be undone.';
	@override String get delete => 'Delete';
	@override String get transactions => 'Transactions';
	@override String get budgets => 'Budgets';
	@override String get allBudgets => 'All Budgets';
	@override String get egGroceriesEntertainment => 'e.g., Groceries, Entertainment';
	@override String get eg80 => 'e.g., 80';
	@override String get category => 'Category';
	@override String get account => 'Account';
	@override String get overLimit => 'Over limit';
	@override String get remaining => 'Remaining';
	@override String get totalSpent => 'Total spent';
	@override String get totalLimit => 'Total limit';
	@override String get selectEndDate => 'Pilih tanggal akhir';
	@override String get noTransactionsFoundForThisBudgetPeriod => 'No transactions found for this budget period.';
	@override String get addBudget => 'Add Budget';
	@override String get spent => 'Spent ';
	@override String get noBudgetsYet => 'No budgets yet';
	@override String get setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod => 'Set spending limits to track where your money goes each period.';
	@override String budgetAlert({required Object name}) => 'Peringatan Anggaran: ${name}';
	@override String percentOf({required Object percent}) => '${percent}% dari ';
	@override String budgetsCount({required Object count}) => '${count} anggaran';
}

// Path: categories
class _Translations$categories$id extends Translations$categories$en {
	_Translations$categories$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get expense => 'Pengeluaran';
	@override String get income => 'Pemasukan';
	@override String get categoryName => 'Nama Kategori';
	@override String get icon => 'Ikon';
	@override String get color => 'Warna';
	@override String get noCategoriesFound => 'Kategori tidak ditemukan.';
	@override String get subcategories => 'Subcategories';
	@override String get categories => 'Categories';
	@override String get egFoodDining => 'e.g., Food & Dining';
	@override String get deleteCategory => 'Delete Category';
	@override String get delete => 'Delete';
	@override String get selectIcon => 'Pilih Ikon';
	@override String get noSubcategoriesYet => 'No subcategories yet';
	@override String get noCategoriesFound1 => 'Kategori tidak ditemukan';
	@override String subcategoriesCount({required Object count}) => '${count} subkategori';
}

// Path: common
class _Translations$common$id extends Translations$common$en {
	_Translations$common$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get save => 'Simpan';
	@override String get cancel => 'Batal';
	@override String get delete => 'Hapus';
	@override String get edit => 'Edit';
	@override String get confirm => 'Konfirmasi';
	@override String get back => 'Kembali';
	@override String get loading => 'Memuat...';
	@override String get error => 'Terjadi kesalahan';
	@override String get retry => 'Coba lagi';
	@override String get empty => 'Belum ada data';
	@override String get cannotBeUndone => 'Tindakan ini tidak dapat dibatalkan.';
}

// Path: dashboard
class _Translations$dashboard$id extends Translations$dashboard$en {
	_Translations$dashboard$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get overview => 'Ringkasan';
	@override String get myFinances => 'Keuangan Saya';
	@override String get netWorth => 'Kekayaan Bersih';
	@override String accountsCount({required Object count}) => '${count} akun';
	@override String get assets => 'Aset';
	@override String get liabilities => 'Kewajiban';
	@override String get budgets => 'Anggaran';
	@override String get categories => 'Kategori';
	@override String get goals => 'Tujuan';
	@override String get debts => 'Utang';
	@override String get recurring => 'Berulang';
	@override String get cashFlow => 'Arus Kas';
	@override String get budget => 'Anggaran';
	@override String get needs => 'Kebutuhan (50%)';
	@override String get wants => 'Keinginan (30%)';
	@override String get savings => 'Tabungan (20%)';
	@override String get saved => 'tersimpan';
	@override String get onTrack => 'Aman';
	@override String get needsAttention => 'Perlu perhatian';
	@override String get income => 'Pemasukan';
	@override String get expense => 'Pengeluaran';
	@override String get other => 'Lainnya';
	@override String get noData => 'Tidak ada data';
	@override String get spendingActivity => 'Aktivitas Pengeluaran';
	@override String get total => 'Total';
	@override String get average => 'Rata-rata';
	@override String get budgetPerDay => 'Anggaran/Hari';
	@override String get todaysBudget => 'Anggaran Hari Ini';
	@override String get overbudget => 'Lebih batas!';
	@override String get setDailyBudget => 'Atur Anggaran Harian';
	@override String get amount => 'Jumlah';
	@override String get amountHint => 'Cth: 100000';
	@override String get recentTransactions => 'Transaksi Terakhir';
	@override String get thisMonth => 'Bulan ini';
	@override String get noRecentTransactions => 'Tidak ada transaksi baru';
	@override String get seeAll => 'Lihat Semua';
	@override String get notSet => 'Belum diatur';
	@override late final _Translations$dashboard$insight$id insight = _Translations$dashboard$insight$id._(_root);
	@override late final _Translations$dashboard$days$id days = _Translations$dashboard$days$id._(_root);
}

// Path: debts
class _Translations$debts$id extends Translations$debts$en {
	_Translations$debts$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get addRepayment => 'Tambah Pembayaran';
	@override String get iOwe => 'Saya Berhutang';
	@override String get theyOwe => 'Mereka Berhutang';
	@override String get personName => 'Nama orang';
	@override String get principalAmount => 'Jumlah pokok';
	@override String get transactionBinding => 'Keterikatan Transaksi';
	@override String get cancel => 'Batal';
	@override String get save => 'Simpan';
	@override String get ok => 'OK';
	@override String get addRecord => 'Tambah Catatan';
	@override String get debtDetails => 'Debt Details';
	@override String get repaymentHistory => 'Repayment History';
	@override String get debtsLoans => 'Debts & Loans';
	@override String get deleteDebt => 'Delete Debt';
	@override String get delete => 'Delete';
	@override String get writeoffDebt => 'Write-off Debt';
	@override String get areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances => 'Are you sure you want to write-off this debt? It will be marked as paid without affecting your wallet balances.';
	@override String get writeoff => 'Write-off';
	@override String get egJohnDoe => 'e.g., John Doe';
	@override String get category => 'Category';
	@override String get account => 'Account';
	@override String get egDinnerLastFriday => 'e.g., Dinner last Friday';
	@override String get selectDueDate => 'Pilih tanggal jatuh tempo';
	@override String get outstanding => 'Outstanding';
	@override String get paid => 'Paid';
	@override String get principal => 'Principal';
	@override String get actionDenied => 'Action Denied';
	@override String get jumlahPembayaranTidakBolehMelebihiSisaUtang => 'Jumlah pembayaran tidak boleh melebihi sisa utang.';
	@override String get addNote => 'Add note';
	@override String get payInFull => 'Pay in Full';
	@override String get remaining => 'remaining';
	@override String get paid1 => 'Paid ';
	@override String reminder({required Object type, required Object name}) => 'Pengingat ${type}: ${name}';
	@override String due({required Object type, required Object name}) => '${type} Jatuh Tempo: ${name}';
	@override String noHistoryFoundForThis({required Object type}) => 'Tidak ada riwayat untuk ${type} ini';
	@override String failedToLoadDebts({required Object error}) => 'Gagal memuat utang: ${error}';
	@override String percentOf({required Object percent}) => '${percent}% dari ';
	@override String settled({required Object count}) => '${count} lunas';
	@override String get payable => 'Utang';
	@override String get receivable => 'Piutang';
	@override String get noDebtsRecorded => 'Belum ada utang dicatat';
	@override String get noLoansRecorded => 'Belum ada piutang dicatat';
	@override String get trackMoneyYouOweToOthersAndLogRepayments => 'Lacak uang yang Anda pinjam dan catat pembayarannya.';
	@override String get trackMoneyOthersOweYouAndLogCollections => 'Lacak uang yang dipinjam orang lain dan catat penagihannya.';
}

// Path: goals
class _Translations$goals$id extends Translations$goals$en {
	_Translations$goals$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get fulfillGoal => 'Penuhi Tujuan (Gunakan)';
	@override String get goalName => 'Nama tujuan';
	@override String get targetAmount => 'Jumlah target';
	@override String get createGoal => 'Buat Tujuan';
	@override String errorPrefix({required Object error}) => 'Kesalahan: ${error}';
	@override String get goalDetails => 'Goal Details';
	@override String get transactions => 'Transactions';
	@override String get active => 'Active';
	@override String get past => 'Past';
	@override String get actionDenied => 'Action Denied';
	@override String get kosongkanSaldoTransferKeluarSebelumMenghapusGoalIni => 'Kosongkan saldo (transfer keluar) sebelum menghapus Goal ini.';
	@override String get ok => 'OK';
	@override String get deleteGoal => 'Delete Goal';
	@override String get areYouSureYouWantToDeleteThisGoalTheAssociatedPocketAccountAndItsHistoryWillAlsoBeRemovedThisActionCannotBeUndone => 'Are you sure you want to delete this goal? The associated pocket account and its history will also be removed. This action cannot be undone.';
	@override String get delete => 'Delete';
	@override String get egEmergencyFundNewLaptop => 'e.g., Emergency Fund, New Laptop';
	@override String get completed => 'Completed';
	@override String get fullyFunded => 'Tercapai';
	@override String get inProgress => 'In progress';
	@override String get totalSaved => 'Total Saved';
	@override String get stillNeeded => 'Still needed';
	@override String get totalTarget => 'Total target';
	@override String get selectTargetDate => 'Pilih tanggal target';
	@override String get noTransactionsFoundForThisGoal => 'No transactions found for this goal.';
	@override String get addGoal => 'Add Goal';
	@override String get aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal => 'A dedicated Pocket account will be created automatically to track this goal.';
	@override String get saved => 'saved';
	@override String get needs => 'Needs ';
	@override String get more => ' more';
	@override String get noGoalsYet => 'No goals yet';
	@override String get setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal => 'Set savings targets — a dedicated pocket is created automatically for each goal.';
	@override String percentOfTarget({required Object percent}) => '${percent}% dari target';
	@override String goalsCount({required Object count}) => '${count} goal';
	@override String fullyFundedCount({required Object count}) => '${count} tercapai';
	@override String get noCompletedGoalsYet => 'Belum ada tujuan selesai';
	@override String get completedGoalsWillAppearHere => 'Tujuan yang sudah tercapai akan muncul di sini.';
}

// Path: lock
class _Translations$lock$id extends Translations$lock$en {
	_Translations$lock$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get confirmPin => 'Konfirmasi PIN';
	@override String get createPin => 'Buat PIN';
	@override String get pinsDoNotMatch => 'PIN tidak cocok';
	@override String get reenterPin => 'Masukkan ulang PIN';
	@override String get enterPinAppLock => 'Masukkan PIN untuk Kunci Aplikasi';
	@override String get incorrectPin => 'PIN salah';
	@override String get verifyIdentity => 'Verifikasi Identitas';
	@override String retryInSeconds({required Object seconds}) => 'Coba lagi dalam ${seconds} detik';
	@override String get setupPinTitle => 'Atur PIN';
	@override String get setupPinBody => 'Buat PIN dulu sebelum mengaktifkan Kunci Aplikasi atau Biometrik.';
	@override String get unlocked => 'Terbuka';
	@override String get enter6DigitPin => 'Masukkan PIN 6 digit';
	@override String get enterPin => 'Masukkan PIN';
	@override String get invalidPin => 'PIN tidak valid';
	@override String get tooManyAttempts => 'Terlalu banyak percobaan';
	@override String get temporarilyLocked => 'Terkunci sementara';
}

// Path: onboarding
class _Translations$onboarding$id extends Translations$onboarding$en {
	_Translations$onboarding$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get continueWithCurrency => 'Lanjutkan dengan mata uang pilihan';
	@override String get chooseYourBaseCurrency => 'Pilih Mata Uang Utama Anda';
	@override String get thisCurrencyWillBeUsedForAllAccountsPocketsAndTransactionsYouCanChangeThisLaterInSettings => 'This currency will be used for all accounts, pockets, and transactions. You can change this later in settings.';
}

// Path: recurring
class _Translations$recurring$id extends Translations$recurring$en {
	_Translations$recurring$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get addSchedule => 'Tambah Jadwal';
	@override String get transactionDetails => 'Detail Transaksi';
	@override String get amount => 'Jumlah';
	@override String get frequency => 'Frekuensi';
	@override String get startDate => 'Tanggal Mulai';
	@override String get recurring => 'Recurring';
	@override String get schedules => 'Schedules';
	@override String get scheduleDetails => 'Schedule Details';
	@override String get deleteSchedule => 'Delete Schedule';
	@override String get areYouSureYouWantToDeleteThisRecurringScheduleExistingGeneratedTransactionsWillNotBeDeleted => 'Are you sure you want to delete this recurring schedule? Existing generated transactions will not be deleted.';
	@override String get delete => 'Delete';
	@override String get triggerHistory => 'Trigger History';
	@override String get destinationAccount => 'Destination Account';
	@override String get category => 'Category';
	@override String get egNetflixSubscription => 'e.g., Netflix subscription';
	@override String get selectFirstDueDate => 'Select first due date';
	@override String get estMonthlyNet => 'Est. Monthly Net';
	@override String get monthlyIn => 'Monthly In';
	@override String get monthlyOut => 'Monthly Out';
	@override String get noRecurringTransactions => 'No recurring transactions';
	@override String get automateBillsLikeSubscriptionsOrSalary => 'Automate bills like subscriptions or salary. The app will record them on schedule.';
	@override String get noHistoryFoundForThisSchedule => 'No history found for this schedule.';
	@override String get allocation => 'Allocation';
	@override String get active => 'Active';
	@override String get eachTimeTheAppOpensOverdueRecurringTransactionsAre => 'Each time the app opens, overdue recurring transactions are automatically recorded in your ledger.';
	@override String schedulesCount({required Object count}) => '${count} jadwal';
	@override String pausedCount({required Object count}) => '${count} dijeda';
}

// Path: reports
class _Translations$reports$id extends Translations$reports$en {
	_Translations$reports$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Laporan';
	@override String get overview => 'Ringkasan Keuangan';
	@override String get tabCashflow => 'Arus Kas';
	@override String get tabBudgets => 'Anggaran & Target';
	@override String get period => 'Periode';
	@override String get thisMonth => 'Bulan Ini';
	@override String get lastMonth => 'Bulan Lalu';
	@override String get last3Months => '3 Bulan';
	@override String get last6Months => '6 Bulan';
	@override String get custom => 'Kustom';
	@override String get income => 'Pemasukan';
	@override String get expense => 'Pengeluaran';
	@override String get netSavings => 'Tabungan Bersih';
	@override String get netCashflow => 'Arus Kas Bersih';
	@override String get cashflow => 'Arus Kas';
	@override String get savingsRate => 'Tingkat Tabungan';
	@override String get topCategories => 'Kategori Teratas';
	@override String get topExpenses => 'Pengeluaran Teratas';
	@override String get topIncome => 'Pemasukan Teratas';
	@override String get monthlyTrend => 'Tren Bulanan';
	@override String get cashflowTrend => 'Tren Pemasukan vs Pengeluaran';
	@override String get budgetBreakdown => 'Rincian Anggaran';
	@override String get budgetUtilization => 'Penggunaan Anggaran';
	@override String get spendingAllocation => 'Alokasi Pengeluaran';
	@override String get noData => 'Tidak ada data untuk periode ini';
	@override String get noBudgets => 'Belum ada anggaran';
	@override String get noBudgetsDesc => 'Tambahkan anggaran untuk memantau batas pengeluaran';
	@override String get onTrack => 'Aman';
	@override String get needsAttention => 'Perlu perhatian';
	@override String get overBudget => 'Melebihi anggaran';
	@override String get onBudget => 'Dalam batas';
	@override String get needs => 'Kebutuhan';
	@override String get wants => 'Keinginan';
	@override String get savings => 'Tabungan';
	@override String get other => 'Lainnya';
	@override String get total => 'Total';
	@override String get average => 'Rata-rata';
	@override String get remaining => 'Sisa';
	@override String get spent => 'Terpakai';
	@override String get limit => 'Batas';
	@override String txCount({required Object count}) => '${count} transaksi';
	@override String get selectDateRange => 'Pilih Rentang Tanggal';
	@override String get apply => 'Terapkan';
	@override String get from => 'Dari';
	@override String get to => 'Hingga';
	@override String comparedTo({required Object period}) => 'vs ${period}';
	@override String get higher => 'lebih tinggi';
	@override String get lower => 'lebih rendah';
	@override String get same => 'sama dengan';
	@override String get noChange => 'Tidak ada perubahan';
	@override String get percent50 => '50%';
	@override String get percent30 => '30%';
	@override String get percent20 => '20%';
	@override String get rule503020 => '50/30/20';
}

// Path: settings
class _Translations$settings$id extends Translations$settings$en {
	_Translations$settings$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pengaturan';
	@override String get preferences => 'Preferensi';
	@override String get baseCurrency => 'Mata Uang Utama';
	@override String get theme => 'Tema';
	@override String get language => 'Bahasa';
	@override String get numberFormat => 'Format Angka';
	@override String get selectNumberFormat => 'Pilih Format Angka';
	@override String get formatSystem => 'Default Aplikasi';
	@override String get formatId => '1.000.000,00';
	@override String get formatUs => '1,000,000.00';
	@override String get formatFr => '1 000 000,00';
	@override String get system => 'Sistem';
	@override String get english => 'English';
	@override String get indonesia => 'Indonesia';
	@override String get security => 'Keamanan';
	@override String get appLock => 'Kunci Aplikasi';
	@override String get appLockDesc => 'Lindungi aplikasi dengan PIN';
	@override String get biometrics => 'Biometrik';
	@override String get biometricsDesc => 'Gunakan sidik jari untuk membuka';
	@override String get dataManagement => 'Manajemen Data';
	@override String get backupRestore => 'Cadangkan & Pulihkan';
	@override String get backupRestoreDesc => 'Simpan atau pulihkan data Anda';
	@override String get clearOld => 'Hapus Transaksi Lama';
	@override String get clearOldDesc => 'Hapus transaksi lebih dari 1 tahun';
	@override String get resetData => 'Reset Data';
	@override String get resetDataDesc => 'Hapus semua data aplikasi lokal';
	@override String get support => 'Bantuan';
	@override String get faq => 'FAQ';
	@override String get faqDesc => 'Pertanyaan yang Sering Diajukan';
	@override String get about => 'Tentang Poka CE';
	@override String get aboutDesc => 'Versi dan informasi legal';
	@override String get selectTheme => 'Pilih Tema';
	@override String get themeLight => 'Terang';
	@override String get themeDark => 'Gelap';
	@override String get selectLanguage => 'Pilih Bahasa';
	@override String get oldTransactionsCleared => 'Transaksi lama berhasil dibersihkan';
	@override String get appDataReset => 'Data aplikasi berhasil direset';
	@override String get failedToExportLogs => 'Gagal mengekspor log';
	@override String easterEggRemaining({required Object remaining}) => '${remaining} ketukan lagi dari sebuah kejutan...';
	@override String get easterEggFound => '🎉 Anda menemukan easter egg!';
	@override String get selectCurrency => 'Pilih Mata Uang';
	@override String get openSourceLicenses => 'Lisensi Open Source';
	@override String get helpIssues => 'Bantuan & Masalah';
	@override String get reportBugsOrRequestFeatures => 'Laporkan bug atau minta fitur';
	@override String get legal => 'Legal';
	@override String get termsOfService => 'Syarat Layanan';
	@override String get readOurTermsAndConditions => 'Baca syarat dan ketentuan kami';
	@override String get privacyPolicy => 'Kebijakan Privasi';
	@override String get learnHowWeHandleYourData => 'Pelajari cara kami mengelola data Anda';
	@override String get viewThirdpartySoftwareLicenses => 'Lihat lisensi perangkat lunak pihak ketiga';
	@override String get advanced => 'Lanjutan';
	@override String get exportDebugLogs => 'Ekspor Log Debug';
	@override String get shareErrorLogsForTroubleshooting => 'Bagikan log kesalahan untuk pemecahan masalah';
	@override String get search => 'Cari...';
	@override String get errorLoadingContent => 'Gagal memuat konten';
	@override String get noLicensesFound => 'Lisensi tidak ditemukan';
	@override String get pokaCe => 'Poka CE';
	@override String get communityEdition => 'Edisi Komunitas';
	@override String get aboutDescription => 'Pengelola keuangan pribadi open-source gratis yang dirancang untuk membantu Anda mencatat pengeluaran, mengatur anggaran, dan memantau akun secara lokal.';
	@override String get copyright => '© 2026 POKA. All rights reserved.';
	@override String get noResultsFound => 'Tidak Ada Hasil';
	@override String get weCouldntFindAnyCurrencyMatching => 'Kami tidak menemukan mata uang yang cocok dengan "{search}".';
}

// Path: shared
class _Translations$shared$id extends Translations$shared$en {
	_Translations$shared$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get authRequired => 'Dibutuhkan Autentikasi';
	@override String get hexColorCode => 'Kode Warna Hex';
	@override String get apply => 'Terapkan';
	@override String get enterAmount => 'Enter Amount';
	@override String get selectCategory => 'Pilih Kategori';
	@override String get egFf5733 => 'e.g., FF5733';
	@override String get amount => 'Amount';
	@override String get noCategoriesAvailable => 'No categories available.';
	@override String get noWalletsFoundPleaseCreateOneFirst => 'No wallets found. Please create one first.';
	@override String get balance => 'Balance: ';
	@override String get optional => 'Optional';
	@override String get customColor => 'Custom Color';
}

// Path: transactions
class _Translations$transactions$id extends Translations$transactions$en {
	_Translations$transactions$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get searchTransactions => 'Cari transaksi...';
	@override String get failedToLoad => 'Gagal memuat transaksi';
	@override String get cancel => 'Batal';
	@override String get delete => 'Hapus';
	@override String get goToToday => 'Ke Hari Ini';
	@override String get addItem => 'Tambah Item';
	@override String get saveSplitTransaction => 'Simpan Transaksi Terpisah';
	@override String get transactionType => 'Tipe Transaksi';
	@override String get applyFilter => 'Terapkan Filter';
	@override String get noAccountsAvailable => 'Tidak ada akun tersedia';
	@override String get account => 'Akun';
	@override String get category => 'Kategori';
	@override String get done => 'Selesai';
	@override String get save => 'Simpan';
	@override String get transactions => 'Transactions';
	@override String get splitTransaction => 'Split Transaction';
	@override String get from => 'From';
	@override String get to => 'To';
	@override String get empty => '+/-';
	@override String get filtered => 'Filtered';
	@override String get netBalance => 'Net Balance';
	@override String get income => 'Income';
	@override String get expense => 'Expense';
	@override String get selectCategory => 'Pilih Kategori';
	@override String get filter => 'Filter';
	@override String get backToToday => 'Back to today';
	@override String get deleteTransaction => 'Delete Transaction';
	@override String get deleteTransactionWarning => 'Menghapus transaksi ini akan mengembalikan saldo akun dan budget Anda seperti semula.';
	@override String get out => 'Out ';
	@override String get noTransactions => 'No transactions';
	@override String get addNote => 'Add note';
	@override String get noItemsYet => 'No items yet';
	@override String get tapAddItemToBeginSplittingntheTransaction => 'Tap "Add Item" to begin splitting\nthe transaction.';
	@override String get addAtLeastOneMoreItemToSave => 'Add at least one more item to save.';
	@override String get noTransactions1 => 'No Transactions';
	@override String get reset => 'Reset';
	@override String get incoming => 'In ';
	@override String nothingRecordedFor({required Object period}) => 'Tidak ada catatan untuk ${period}.';
	@override String splitItems({required Object count}) => '${count} item split';
	@override String itemsCount({required Object count}) => '${count} item';
	@override String transactionsCount({required Object count}) => '${count} transaksi';
}

// Path: app.nav
class _Translations$app$nav$id extends Translations$app$nav$en {
	_Translations$app$nav$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get home => 'Beranda';
	@override String get transactions => 'Transaksi';
	@override String get reports => 'Laporan';
	@override String get accounts => 'Akun';
	@override String get settings => 'Pengaturan';
}

// Path: dashboard.insight
class _Translations$dashboard$insight$id extends Translations$dashboard$insight$en {
	_Translations$dashboard$insight$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get noData => 'Belum ada data bulan ini untuk dianalisa.';
	@override String get thisMonth => 'bulan ini';
	@override String get up => 'naik';
	@override String get down => 'turun';
	@override String get same => 'sama dengan';
	@override String get fromLastMonth => 'dari bulan lalu.';
}

// Path: dashboard.days
class _Translations$dashboard$days$id extends Translations$dashboard$days$en {
	_Translations$dashboard$days$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get mon => 'Sen';
	@override String get tue => 'Sel';
	@override String get wed => 'Rab';
	@override String get thu => 'Kam';
	@override String get fri => 'Jum';
	@override String get sat => 'Sab';
	@override String get sun => 'Min';
}

/// The flat map containing all translations for locale <id>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsId {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'accounts.accountName' => 'Nama Akun',
			'accounts.initialBalance' => 'Saldo Awal',
			'accounts.icon' => 'Ikon',
			'accounts.color' => 'Warna',
			'accounts.assets' => 'Aset',
			'accounts.liability' => 'Liabilitas',
			'accounts.income' => 'Pemasukan',
			'accounts.expense' => 'Pengeluaran',
			'accounts.balance' => 'Balance',
			'accounts.walletsPockets' => 'Wallets & Pockets',
			'accounts.accounts' => 'Accounts',
			'accounts.mainAccounts' => 'Akun Utama',
			'accounts.goalsAndSavings' => 'Target & Tabungan',
			'accounts.deleteAccount' => 'Delete Account',
			'accounts.areYouSureYouWantToDeleteThisAccountItWillBeHiddenFromTheApp' => 'Are you sure you want to delete this account? It will be hidden from the app.',
			'accounts.delete' => 'Delete',
			'accounts.account' => 'Account',
			'accounts.totalBalance' => 'Total Balance',
			'accounts.pockets' => 'Pockets',
			'accounts.deletePocket' => 'Delete Pocket',
			'accounts.areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp' => 'Are you sure you want to delete this pocket? It will be hidden from the app.',
			'accounts.nameCannotBeEmpty' => 'Name cannot be empty',
			'accounts.egMainWallet' => 'e.g., Main Wallet',
			'accounts.selectIcon' => 'Pilih Ikon',
			'accounts.allowedCategories' => 'Allowed Categories',
			'accounts.transactions' => 'Transactions',
			'accounts.editAccount' => 'Edit Account',
			'accounts.updateNameIconOrColor' => 'Update name, icon, or color',
			'accounts.permanentlyRemoveThisAccount' => 'Permanently remove this account',
			'accounts.seeAll' => 'See All',
			'accounts.noTransactionsYet' => 'No transactions yet',
			'accounts.addAccount' => 'Add Account',
			'accounts.noAccountsFound' => 'Akun tidak ditemukan.',
			'accounts.addPocket' => 'Add Pocket',
			'accounts.noPocketsYet' => 'No pockets yet',
			'accounts.pocketsHelpYouSplitYourWalletIntoCategories' => 'Pockets help you split your wallet into categories',
			'accounts.activeAccount' => 'Active Account',
			'accounts.inactiveAccountsWillBeHidden' => 'Inactive accounts will be hidden',
			'accounts.noCategoriesAvailable' => 'No categories available.',
			'accounts.noAccountsFound1' => 'Akun tidak ditemukan',
			'accounts.subcategoriesCount' => ({required Object count}) => '${count} subkategori',
			'accounts.pocketsCount' => ({required Object count}) => '${count} kantong',
			'accounts.totalActiveAccounts' => 'Total Akun Aktif',
			'accounts.noAccountsYet' => 'Belum Ada Akun',
			'accounts.tapTheButtonBelowToAddYourFirstAccount' => 'Tekan tombol di bawah untuk menambahkan akun pertama Anda',
			'app.name' => 'Poka',
			'app.tagline' => 'Teman keuangan pribadi Anda',
			'app.nav.home' => 'Beranda',
			'app.nav.transactions' => 'Transaksi',
			'app.nav.reports' => 'Laporan',
			'app.nav.accounts' => 'Akun',
			'app.nav.settings' => 'Pengaturan',
			'app.termsOfService' => 'Syarat Layanan',
			'app.privacyPolicy' => 'Kebijakan Privasi',
			'backup.title' => 'Cadangkan & Pulihkan',
			'backup.backupAction' => 'Cadangkan',
			'backup.restoreAction' => 'Pulihkan',
			'backup.password' => 'Kata Sandi',
			'backup.confirmPassword' => 'Konfirmasi Kata Sandi',
			'backup.passwordsDoNotMatch' => 'Kata sandi tidak cocok',
			'backup.backupSuccess' => 'Pencadangan berhasil',
			'backup.restoreSuccess' => 'Pemulihan berhasil',
			'backup.incorrectPassword' => 'Kata sandi salah atau file rusak',
			'backup.enterPasswordToEncrypt' => 'Masukkan kata sandi untuk mengenkripsi cadangan',
			'backup.enterPasswordToDecrypt' => 'Masukkan kata sandi untuk mendekripsi cadangan',
			'backup.pleaseRestart' => 'Silakan mulai ulang aplikasi untuk menerapkan perubahan.',
			'backup.passwordRequired' => 'Kata sandi wajib diisi',
			'budgets.budgetName' => 'Nama anggaran',
			'budgets.spendingLimit' => 'Batas pengeluaran',
			'budgets.period' => 'Periode',
			'budgets.resetDay' => 'Hari reset (1-31)',
			'budgets.createBudget' => 'Buat Anggaran',
			'budgets.endDate' => 'Tanggal Berakhir',
			'budgets.budgetDetails' => 'Budget Details',
			'budgets.deleteBudget' => 'Delete Budget',
			'budgets.areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone' => 'Are you sure you want to delete this budget? All related tracking history will be permanently deleted. This action cannot be undone.',
			'budgets.delete' => 'Delete',
			'budgets.transactions' => 'Transactions',
			'budgets.budgets' => 'Budgets',
			'budgets.allBudgets' => 'All Budgets',
			'budgets.egGroceriesEntertainment' => 'e.g., Groceries, Entertainment',
			'budgets.eg80' => 'e.g., 80',
			'budgets.category' => 'Category',
			'budgets.account' => 'Account',
			'budgets.overLimit' => 'Over limit',
			'budgets.remaining' => 'Remaining',
			'budgets.totalSpent' => 'Total spent',
			'budgets.totalLimit' => 'Total limit',
			'budgets.selectEndDate' => 'Pilih tanggal akhir',
			'budgets.noTransactionsFoundForThisBudgetPeriod' => 'No transactions found for this budget period.',
			'budgets.addBudget' => 'Add Budget',
			'budgets.spent' => 'Spent ',
			'budgets.noBudgetsYet' => 'No budgets yet',
			'budgets.setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod' => 'Set spending limits to track where your money goes each period.',
			'budgets.budgetAlert' => ({required Object name}) => 'Peringatan Anggaran: ${name}',
			'budgets.percentOf' => ({required Object percent}) => '${percent}% dari ',
			'budgets.budgetsCount' => ({required Object count}) => '${count} anggaran',
			'categories.expense' => 'Pengeluaran',
			'categories.income' => 'Pemasukan',
			'categories.categoryName' => 'Nama Kategori',
			'categories.icon' => 'Ikon',
			'categories.color' => 'Warna',
			'categories.noCategoriesFound' => 'Kategori tidak ditemukan.',
			'categories.subcategories' => 'Subcategories',
			'categories.categories' => 'Categories',
			'categories.egFoodDining' => 'e.g., Food & Dining',
			'categories.deleteCategory' => 'Delete Category',
			'categories.delete' => 'Delete',
			'categories.selectIcon' => 'Pilih Ikon',
			'categories.noSubcategoriesYet' => 'No subcategories yet',
			'categories.noCategoriesFound1' => 'Kategori tidak ditemukan',
			'categories.subcategoriesCount' => ({required Object count}) => '${count} subkategori',
			'common.save' => 'Simpan',
			'common.cancel' => 'Batal',
			'common.delete' => 'Hapus',
			'common.edit' => 'Edit',
			'common.confirm' => 'Konfirmasi',
			'common.back' => 'Kembali',
			'common.loading' => 'Memuat...',
			'common.error' => 'Terjadi kesalahan',
			'common.retry' => 'Coba lagi',
			'common.empty' => 'Belum ada data',
			'common.cannotBeUndone' => 'Tindakan ini tidak dapat dibatalkan.',
			'dashboard.overview' => 'Ringkasan',
			'dashboard.myFinances' => 'Keuangan Saya',
			'dashboard.netWorth' => 'Kekayaan Bersih',
			'dashboard.accountsCount' => ({required Object count}) => '${count} akun',
			'dashboard.assets' => 'Aset',
			'dashboard.liabilities' => 'Kewajiban',
			'dashboard.budgets' => 'Anggaran',
			'dashboard.categories' => 'Kategori',
			'dashboard.goals' => 'Tujuan',
			'dashboard.debts' => 'Utang',
			'dashboard.recurring' => 'Berulang',
			'dashboard.cashFlow' => 'Arus Kas',
			'dashboard.budget' => 'Anggaran',
			'dashboard.needs' => 'Kebutuhan (50%)',
			'dashboard.wants' => 'Keinginan (30%)',
			'dashboard.savings' => 'Tabungan (20%)',
			'dashboard.saved' => 'tersimpan',
			'dashboard.onTrack' => 'Aman',
			'dashboard.needsAttention' => 'Perlu perhatian',
			'dashboard.income' => 'Pemasukan',
			'dashboard.expense' => 'Pengeluaran',
			'dashboard.other' => 'Lainnya',
			'dashboard.noData' => 'Tidak ada data',
			'dashboard.spendingActivity' => 'Aktivitas Pengeluaran',
			'dashboard.total' => 'Total',
			'dashboard.average' => 'Rata-rata',
			'dashboard.budgetPerDay' => 'Anggaran/Hari',
			'dashboard.todaysBudget' => 'Anggaran Hari Ini',
			'dashboard.overbudget' => 'Lebih batas!',
			'dashboard.setDailyBudget' => 'Atur Anggaran Harian',
			'dashboard.amount' => 'Jumlah',
			'dashboard.amountHint' => 'Cth: 100000',
			'dashboard.recentTransactions' => 'Transaksi Terakhir',
			'dashboard.thisMonth' => 'Bulan ini',
			'dashboard.noRecentTransactions' => 'Tidak ada transaksi baru',
			'dashboard.seeAll' => 'Lihat Semua',
			'dashboard.notSet' => 'Belum diatur',
			'dashboard.insight.noData' => 'Belum ada data bulan ini untuk dianalisa.',
			'dashboard.insight.thisMonth' => 'bulan ini',
			'dashboard.insight.up' => 'naik',
			'dashboard.insight.down' => 'turun',
			'dashboard.insight.same' => 'sama dengan',
			'dashboard.insight.fromLastMonth' => 'dari bulan lalu.',
			'dashboard.days.mon' => 'Sen',
			'dashboard.days.tue' => 'Sel',
			'dashboard.days.wed' => 'Rab',
			'dashboard.days.thu' => 'Kam',
			'dashboard.days.fri' => 'Jum',
			'dashboard.days.sat' => 'Sab',
			'dashboard.days.sun' => 'Min',
			'debts.addRepayment' => 'Tambah Pembayaran',
			'debts.iOwe' => 'Saya Berhutang',
			'debts.theyOwe' => 'Mereka Berhutang',
			'debts.personName' => 'Nama orang',
			'debts.principalAmount' => 'Jumlah pokok',
			'debts.transactionBinding' => 'Keterikatan Transaksi',
			'debts.cancel' => 'Batal',
			'debts.save' => 'Simpan',
			'debts.ok' => 'OK',
			'debts.addRecord' => 'Tambah Catatan',
			'debts.debtDetails' => 'Debt Details',
			'debts.repaymentHistory' => 'Repayment History',
			'debts.debtsLoans' => 'Debts & Loans',
			'debts.deleteDebt' => 'Delete Debt',
			'debts.delete' => 'Delete',
			'debts.writeoffDebt' => 'Write-off Debt',
			'debts.areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances' => 'Are you sure you want to write-off this debt? It will be marked as paid without affecting your wallet balances.',
			'debts.writeoff' => 'Write-off',
			'debts.egJohnDoe' => 'e.g., John Doe',
			'debts.category' => 'Category',
			'debts.account' => 'Account',
			'debts.egDinnerLastFriday' => 'e.g., Dinner last Friday',
			'debts.selectDueDate' => 'Pilih tanggal jatuh tempo',
			'debts.outstanding' => 'Outstanding',
			'debts.paid' => 'Paid',
			'debts.principal' => 'Principal',
			'debts.actionDenied' => 'Action Denied',
			'debts.jumlahPembayaranTidakBolehMelebihiSisaUtang' => 'Jumlah pembayaran tidak boleh melebihi sisa utang.',
			'debts.addNote' => 'Add note',
			'debts.payInFull' => 'Pay in Full',
			'debts.remaining' => 'remaining',
			'debts.paid1' => 'Paid ',
			'debts.reminder' => ({required Object type, required Object name}) => 'Pengingat ${type}: ${name}',
			'debts.due' => ({required Object type, required Object name}) => '${type} Jatuh Tempo: ${name}',
			'debts.noHistoryFoundForThis' => ({required Object type}) => 'Tidak ada riwayat untuk ${type} ini',
			'debts.failedToLoadDebts' => ({required Object error}) => 'Gagal memuat utang: ${error}',
			'debts.percentOf' => ({required Object percent}) => '${percent}% dari ',
			'debts.settled' => ({required Object count}) => '${count} lunas',
			'debts.payable' => 'Utang',
			'debts.receivable' => 'Piutang',
			'debts.noDebtsRecorded' => 'Belum ada utang dicatat',
			'debts.noLoansRecorded' => 'Belum ada piutang dicatat',
			'debts.trackMoneyYouOweToOthersAndLogRepayments' => 'Lacak uang yang Anda pinjam dan catat pembayarannya.',
			'debts.trackMoneyOthersOweYouAndLogCollections' => 'Lacak uang yang dipinjam orang lain dan catat penagihannya.',
			'error.generic' => 'Terjadi kesalahan yang tidak terduga',
			'error.network' => 'Periksa koneksi Anda dan coba lagi',
			'error.database' => 'Gagal mengakses data lokal',
			'goals.fulfillGoal' => 'Penuhi Tujuan (Gunakan)',
			'goals.goalName' => 'Nama tujuan',
			'goals.targetAmount' => 'Jumlah target',
			'goals.createGoal' => 'Buat Tujuan',
			'goals.errorPrefix' => ({required Object error}) => 'Kesalahan: ${error}',
			'goals.goalDetails' => 'Goal Details',
			'goals.transactions' => 'Transactions',
			'goals.active' => 'Active',
			'goals.past' => 'Past',
			'goals.actionDenied' => 'Action Denied',
			'goals.kosongkanSaldoTransferKeluarSebelumMenghapusGoalIni' => 'Kosongkan saldo (transfer keluar) sebelum menghapus Goal ini.',
			'goals.ok' => 'OK',
			'goals.deleteGoal' => 'Delete Goal',
			'goals.areYouSureYouWantToDeleteThisGoalTheAssociatedPocketAccountAndItsHistoryWillAlsoBeRemovedThisActionCannotBeUndone' => 'Are you sure you want to delete this goal? The associated pocket account and its history will also be removed. This action cannot be undone.',
			'goals.delete' => 'Delete',
			'goals.egEmergencyFundNewLaptop' => 'e.g., Emergency Fund, New Laptop',
			'goals.completed' => 'Completed',
			'goals.fullyFunded' => 'Tercapai',
			'goals.inProgress' => 'In progress',
			'goals.totalSaved' => 'Total Saved',
			'goals.stillNeeded' => 'Still needed',
			'goals.totalTarget' => 'Total target',
			'goals.selectTargetDate' => 'Pilih tanggal target',
			'goals.noTransactionsFoundForThisGoal' => 'No transactions found for this goal.',
			'goals.addGoal' => 'Add Goal',
			'goals.aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal' => 'A dedicated Pocket account will be created automatically to track this goal.',
			'goals.saved' => 'saved',
			'goals.needs' => 'Needs ',
			'goals.more' => ' more',
			'goals.noGoalsYet' => 'No goals yet',
			'goals.setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal' => 'Set savings targets — a dedicated pocket is created automatically for each goal.',
			'goals.percentOfTarget' => ({required Object percent}) => '${percent}% dari target',
			'goals.goalsCount' => ({required Object count}) => '${count} goal',
			'goals.fullyFundedCount' => ({required Object count}) => '${count} tercapai',
			'goals.noCompletedGoalsYet' => 'Belum ada tujuan selesai',
			'goals.completedGoalsWillAppearHere' => 'Tujuan yang sudah tercapai akan muncul di sini.',
			'lock.confirmPin' => 'Konfirmasi PIN',
			'lock.createPin' => 'Buat PIN',
			'lock.pinsDoNotMatch' => 'PIN tidak cocok',
			'lock.reenterPin' => 'Masukkan ulang PIN',
			'lock.enterPinAppLock' => 'Masukkan PIN untuk Kunci Aplikasi',
			'lock.incorrectPin' => 'PIN salah',
			'lock.verifyIdentity' => 'Verifikasi Identitas',
			'lock.retryInSeconds' => ({required Object seconds}) => 'Coba lagi dalam ${seconds} detik',
			'lock.setupPinTitle' => 'Atur PIN',
			'lock.setupPinBody' => 'Buat PIN dulu sebelum mengaktifkan Kunci Aplikasi atau Biometrik.',
			'lock.unlocked' => 'Terbuka',
			'lock.enter6DigitPin' => 'Masukkan PIN 6 digit',
			'lock.enterPin' => 'Masukkan PIN',
			'lock.invalidPin' => 'PIN tidak valid',
			'lock.tooManyAttempts' => 'Terlalu banyak percobaan',
			'lock.temporarilyLocked' => 'Terkunci sementara',
			'onboarding.continueWithCurrency' => 'Lanjutkan dengan mata uang pilihan',
			'onboarding.chooseYourBaseCurrency' => 'Pilih Mata Uang Utama Anda',
			'onboarding.thisCurrencyWillBeUsedForAllAccountsPocketsAndTransactionsYouCanChangeThisLaterInSettings' => 'This currency will be used for all accounts, pockets, and transactions. You can change this later in settings.',
			'recurring.addSchedule' => 'Tambah Jadwal',
			'recurring.transactionDetails' => 'Detail Transaksi',
			'recurring.amount' => 'Jumlah',
			'recurring.frequency' => 'Frekuensi',
			'recurring.startDate' => 'Tanggal Mulai',
			'recurring.recurring' => 'Recurring',
			'recurring.schedules' => 'Schedules',
			'recurring.scheduleDetails' => 'Schedule Details',
			'recurring.deleteSchedule' => 'Delete Schedule',
			'recurring.areYouSureYouWantToDeleteThisRecurringScheduleExistingGeneratedTransactionsWillNotBeDeleted' => 'Are you sure you want to delete this recurring schedule? Existing generated transactions will not be deleted.',
			'recurring.delete' => 'Delete',
			'recurring.triggerHistory' => 'Trigger History',
			'recurring.destinationAccount' => 'Destination Account',
			'recurring.category' => 'Category',
			'recurring.egNetflixSubscription' => 'e.g., Netflix subscription',
			'recurring.selectFirstDueDate' => 'Select first due date',
			'recurring.estMonthlyNet' => 'Est. Monthly Net',
			'recurring.monthlyIn' => 'Monthly In',
			'recurring.monthlyOut' => 'Monthly Out',
			'recurring.noRecurringTransactions' => 'No recurring transactions',
			'recurring.automateBillsLikeSubscriptionsOrSalary' => 'Automate bills like subscriptions or salary. The app will record them on schedule.',
			'recurring.noHistoryFoundForThisSchedule' => 'No history found for this schedule.',
			'recurring.allocation' => 'Allocation',
			'recurring.active' => 'Active',
			'recurring.eachTimeTheAppOpensOverdueRecurringTransactionsAre' => 'Each time the app opens, overdue recurring transactions are automatically recorded in your ledger.',
			'recurring.schedulesCount' => ({required Object count}) => '${count} jadwal',
			'recurring.pausedCount' => ({required Object count}) => '${count} dijeda',
			'reports.title' => 'Laporan',
			'reports.overview' => 'Ringkasan Keuangan',
			'reports.tabCashflow' => 'Arus Kas',
			'reports.tabBudgets' => 'Anggaran & Target',
			'reports.period' => 'Periode',
			'reports.thisMonth' => 'Bulan Ini',
			'reports.lastMonth' => 'Bulan Lalu',
			'reports.last3Months' => '3 Bulan',
			'reports.last6Months' => '6 Bulan',
			'reports.custom' => 'Kustom',
			'reports.income' => 'Pemasukan',
			'reports.expense' => 'Pengeluaran',
			'reports.netSavings' => 'Tabungan Bersih',
			'reports.netCashflow' => 'Arus Kas Bersih',
			'reports.cashflow' => 'Arus Kas',
			'reports.savingsRate' => 'Tingkat Tabungan',
			'reports.topCategories' => 'Kategori Teratas',
			'reports.topExpenses' => 'Pengeluaran Teratas',
			'reports.topIncome' => 'Pemasukan Teratas',
			'reports.monthlyTrend' => 'Tren Bulanan',
			'reports.cashflowTrend' => 'Tren Pemasukan vs Pengeluaran',
			'reports.budgetBreakdown' => 'Rincian Anggaran',
			'reports.budgetUtilization' => 'Penggunaan Anggaran',
			'reports.spendingAllocation' => 'Alokasi Pengeluaran',
			'reports.noData' => 'Tidak ada data untuk periode ini',
			'reports.noBudgets' => 'Belum ada anggaran',
			'reports.noBudgetsDesc' => 'Tambahkan anggaran untuk memantau batas pengeluaran',
			'reports.onTrack' => 'Aman',
			'reports.needsAttention' => 'Perlu perhatian',
			'reports.overBudget' => 'Melebihi anggaran',
			'reports.onBudget' => 'Dalam batas',
			'reports.needs' => 'Kebutuhan',
			'reports.wants' => 'Keinginan',
			'reports.savings' => 'Tabungan',
			'reports.other' => 'Lainnya',
			'reports.total' => 'Total',
			'reports.average' => 'Rata-rata',
			'reports.remaining' => 'Sisa',
			'reports.spent' => 'Terpakai',
			'reports.limit' => 'Batas',
			'reports.txCount' => ({required Object count}) => '${count} transaksi',
			'reports.selectDateRange' => 'Pilih Rentang Tanggal',
			'reports.apply' => 'Terapkan',
			'reports.from' => 'Dari',
			'reports.to' => 'Hingga',
			'reports.comparedTo' => ({required Object period}) => 'vs ${period}',
			'reports.higher' => 'lebih tinggi',
			'reports.lower' => 'lebih rendah',
			'reports.same' => 'sama dengan',
			'reports.noChange' => 'Tidak ada perubahan',
			'reports.percent50' => '50%',
			'reports.percent30' => '30%',
			'reports.percent20' => '20%',
			'reports.rule503020' => '50/30/20',
			'settings.title' => 'Pengaturan',
			'settings.preferences' => 'Preferensi',
			'settings.baseCurrency' => 'Mata Uang Utama',
			'settings.theme' => 'Tema',
			'settings.language' => 'Bahasa',
			'settings.numberFormat' => 'Format Angka',
			'settings.selectNumberFormat' => 'Pilih Format Angka',
			'settings.formatSystem' => 'Default Aplikasi',
			'settings.formatId' => '1.000.000,00',
			'settings.formatUs' => '1,000,000.00',
			'settings.formatFr' => '1 000 000,00',
			'settings.system' => 'Sistem',
			'settings.english' => 'English',
			'settings.indonesia' => 'Indonesia',
			'settings.security' => 'Keamanan',
			'settings.appLock' => 'Kunci Aplikasi',
			'settings.appLockDesc' => 'Lindungi aplikasi dengan PIN',
			'settings.biometrics' => 'Biometrik',
			'settings.biometricsDesc' => 'Gunakan sidik jari untuk membuka',
			'settings.dataManagement' => 'Manajemen Data',
			'settings.backupRestore' => 'Cadangkan & Pulihkan',
			'settings.backupRestoreDesc' => 'Simpan atau pulihkan data Anda',
			'settings.clearOld' => 'Hapus Transaksi Lama',
			'settings.clearOldDesc' => 'Hapus transaksi lebih dari 1 tahun',
			'settings.resetData' => 'Reset Data',
			'settings.resetDataDesc' => 'Hapus semua data aplikasi lokal',
			'settings.support' => 'Bantuan',
			'settings.faq' => 'FAQ',
			'settings.faqDesc' => 'Pertanyaan yang Sering Diajukan',
			'settings.about' => 'Tentang Poka CE',
			'settings.aboutDesc' => 'Versi dan informasi legal',
			'settings.selectTheme' => 'Pilih Tema',
			'settings.themeLight' => 'Terang',
			'settings.themeDark' => 'Gelap',
			'settings.selectLanguage' => 'Pilih Bahasa',
			'settings.oldTransactionsCleared' => 'Transaksi lama berhasil dibersihkan',
			'settings.appDataReset' => 'Data aplikasi berhasil direset',
			'settings.failedToExportLogs' => 'Gagal mengekspor log',
			'settings.easterEggRemaining' => ({required Object remaining}) => '${remaining} ketukan lagi dari sebuah kejutan...',
			'settings.easterEggFound' => '🎉 Anda menemukan easter egg!',
			'settings.selectCurrency' => 'Pilih Mata Uang',
			'settings.openSourceLicenses' => 'Lisensi Open Source',
			'settings.helpIssues' => 'Bantuan & Masalah',
			'settings.reportBugsOrRequestFeatures' => 'Laporkan bug atau minta fitur',
			'settings.legal' => 'Legal',
			'settings.termsOfService' => 'Syarat Layanan',
			'settings.readOurTermsAndConditions' => 'Baca syarat dan ketentuan kami',
			'settings.privacyPolicy' => 'Kebijakan Privasi',
			'settings.learnHowWeHandleYourData' => 'Pelajari cara kami mengelola data Anda',
			'settings.viewThirdpartySoftwareLicenses' => 'Lihat lisensi perangkat lunak pihak ketiga',
			'settings.advanced' => 'Lanjutan',
			'settings.exportDebugLogs' => 'Ekspor Log Debug',
			'settings.shareErrorLogsForTroubleshooting' => 'Bagikan log kesalahan untuk pemecahan masalah',
			'settings.search' => 'Cari...',
			'settings.errorLoadingContent' => 'Gagal memuat konten',
			'settings.noLicensesFound' => 'Lisensi tidak ditemukan',
			'settings.pokaCe' => 'Poka CE',
			'settings.communityEdition' => 'Edisi Komunitas',
			'settings.aboutDescription' => 'Pengelola keuangan pribadi open-source gratis yang dirancang untuk membantu Anda mencatat pengeluaran, mengatur anggaran, dan memantau akun secara lokal.',
			'settings.copyright' => '© 2026 POKA. All rights reserved.',
			'settings.noResultsFound' => 'Tidak Ada Hasil',
			'settings.weCouldntFindAnyCurrencyMatching' => 'Kami tidak menemukan mata uang yang cocok dengan "{search}".',
			'shared.authRequired' => 'Dibutuhkan Autentikasi',
			'shared.hexColorCode' => 'Kode Warna Hex',
			'shared.apply' => 'Terapkan',
			'shared.enterAmount' => 'Enter Amount',
			'shared.selectCategory' => 'Pilih Kategori',
			'shared.egFf5733' => 'e.g., FF5733',
			'shared.amount' => 'Amount',
			'shared.noCategoriesAvailable' => 'No categories available.',
			'shared.noWalletsFoundPleaseCreateOneFirst' => 'No wallets found. Please create one first.',
			'shared.balance' => 'Balance: ',
			'shared.optional' => 'Optional',
			'shared.customColor' => 'Custom Color',
			'transactions.searchTransactions' => 'Cari transaksi...',
			'transactions.failedToLoad' => 'Gagal memuat transaksi',
			'transactions.cancel' => 'Batal',
			'transactions.delete' => 'Hapus',
			'transactions.goToToday' => 'Ke Hari Ini',
			'transactions.addItem' => 'Tambah Item',
			'transactions.saveSplitTransaction' => 'Simpan Transaksi Terpisah',
			'transactions.transactionType' => 'Tipe Transaksi',
			'transactions.applyFilter' => 'Terapkan Filter',
			'transactions.noAccountsAvailable' => 'Tidak ada akun tersedia',
			'transactions.account' => 'Akun',
			'transactions.category' => 'Kategori',
			'transactions.done' => 'Selesai',
			'transactions.save' => 'Simpan',
			'transactions.transactions' => 'Transactions',
			'transactions.splitTransaction' => 'Split Transaction',
			'transactions.from' => 'From',
			'transactions.to' => 'To',
			'transactions.empty' => '+/-',
			'transactions.filtered' => 'Filtered',
			'transactions.netBalance' => 'Net Balance',
			'transactions.income' => 'Income',
			'transactions.expense' => 'Expense',
			'transactions.selectCategory' => 'Pilih Kategori',
			'transactions.filter' => 'Filter',
			'transactions.backToToday' => 'Back to today',
			'transactions.deleteTransaction' => 'Delete Transaction',
			'transactions.deleteTransactionWarning' => 'Menghapus transaksi ini akan mengembalikan saldo akun dan budget Anda seperti semula.',
			'transactions.out' => 'Out ',
			'transactions.noTransactions' => 'No transactions',
			'transactions.addNote' => 'Add note',
			'transactions.noItemsYet' => 'No items yet',
			'transactions.tapAddItemToBeginSplittingntheTransaction' => 'Tap "Add Item" to begin splitting\nthe transaction.',
			'transactions.addAtLeastOneMoreItemToSave' => 'Add at least one more item to save.',
			'transactions.noTransactions1' => 'No Transactions',
			'transactions.reset' => 'Reset',
			'transactions.incoming' => 'In ',
			'transactions.nothingRecordedFor' => ({required Object period}) => 'Tidak ada catatan untuk ${period}.',
			'transactions.splitItems' => ({required Object count}) => '${count} item split',
			'transactions.itemsCount' => ({required Object count}) => '${count} item',
			'transactions.transactionsCount' => ({required Object count}) => '${count} transaksi',
			_ => null,
		};
	}
}
