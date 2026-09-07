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
	@override String get balance => 'Saldo';
	@override String get walletsPockets => 'Dompet & Kantong';
	@override String get accounts => 'Akun';
	@override String get mainAccounts => 'Akun Utama';
	@override String get goalsAndSavings => 'Target & Tabungan';
	@override String get deleteAccount => 'Hapus Akun';
	@override String get areYouSureYouWantToDeleteThisAccountItWillBeHiddenFromTheApp => 'Apakah Anda yakin ingin menghapus akun ini? Akun akan disembunyikan dari aplikasi.';
	@override String get delete => 'Hapus';
	@override String get account => 'Akun';
	@override String get totalBalance => 'Total Saldo';
	@override String get pockets => 'Kantong';
	@override String get deletePocket => 'Hapus Kantong';
	@override String get areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp => 'Apakah Anda yakin ingin menghapus kantong ini? Kantong akan disembunyikan dari aplikasi.';
	@override String get nameCannotBeEmpty => 'Nama tidak boleh kosong';
	@override String get egMainWallet => 'misal, Dompet Utama';
	@override String get selectIcon => 'Pilih Ikon';
	@override String get allowedCategories => 'Kategori yang Diizinkan';
	@override String get transactions => 'Transaksi';
	@override String get editAccount => 'Edit Akun';
	@override String get updateNameIconOrColor => 'Perbarui nama, ikon, atau warna';
	@override String get permanentlyRemoveThisAccount => 'Hapus permanen akun ini';
	@override String get seeAll => 'Lihat Semua';
	@override String get noTransactionsYet => 'Belum ada transaksi';
	@override String get addAccount => 'Tambah Akun';
	@override String get noAccountsFound => 'Akun tidak ditemukan.';
	@override String get addPocket => 'Tambah Kantong';
	@override String get noPocketsYet => 'Belum ada kantong';
	@override String get pocketsHelpYouSplitYourWalletIntoCategories => 'Kantong membantu Anda membagi dompet ke dalam beberapa kategori';
	@override String get activeAccount => 'Akun Aktif';
	@override String get inactiveAccountsWillBeHidden => 'Akun tidak aktif akan disembunyikan';
	@override String get noCategoriesAvailable => 'Tidak ada kategori yang tersedia.';
	@override String get noAccountsFound1 => 'Akun tidak ditemukan';
	@override String subcategoriesCount({required Object count}) => '${count} subkategori';
	@override String pocketsCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('id'))(count,
		other: '${count} kantong',
	);
	@override String get totalActiveAccounts => 'Total Akun Aktif';
	@override String get noAccountsYet => 'Belum Ada Akun';
	@override String get tapTheButtonBelowToAddYourFirstAccount => 'Tekan tombol di bawah untuk menambahkan akun pertama Anda';
	@override String get allCategoriesAllowed => 'Semua kategori diizinkan';
	@override String categoriesSelected({required Object count}) => '${count} kategori dipilih';
	@override String ratioOfAccount({required Object percent}) => '${percent}% dari akun';
	@override String get noMainAccountsYet => 'Belum ada akun utama.';
	@override String percentOfAssets({required Object percent}) => '${percent}% dari aset';
	@override String get recentTransactions => 'Transaksi Terakhir';
	@override String recentTransactionsCount({required Object count}) => 'Transaksi Terakhir (${count})';
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
	@override String get resetDay => 'Hari reset (1–31)';
	@override String get createBudget => 'Buat Anggaran';
	@override String get endDate => 'Tanggal Berakhir';
	@override String get budgetDetails => 'Detail Anggaran';
	@override String get deleteBudget => 'Hapus Anggaran';
	@override String get areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone => 'Apakah Anda yakin ingin menghapus anggaran ini? Semua riwayat pelacakan terkait akan dihapus secara permanen. Tindakan ini tidak dapat dibatalkan.';
	@override String get delete => 'Hapus';
	@override String get transactions => 'Transaksi';
	@override String get budgets => 'Anggaran';
	@override String get allBudgets => 'Semua Anggaran';
	@override String get egGroceriesEntertainment => 'misal, Belanja, Hiburan';
	@override String get eg80 => 'misal, 80';
	@override String get category => 'Kategori';
	@override String get account => 'Akun';
	@override String get overLimit => 'Melebihi batas';
	@override String get remaining => 'Tersisa';
	@override String get totalSpent => 'Total terpakai';
	@override String get totalLimit => 'Total batas';
	@override String get selectEndDate => 'Pilih tanggal berakhir';
	@override String get noTransactionsFoundForThisBudgetPeriod => 'Tidak ada transaksi yang ditemukan untuk periode anggaran ini.';
	@override String get addBudget => 'Tambah Anggaran';
	@override String get spent => 'Terpakai ';
	@override String get noBudgetsYet => 'Belum ada anggaran';
	@override String get setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod => 'Tetapkan batas pengeluaran untuk melacak pengeluaran Anda setiap periode.';
	@override String budgetAlert({required Object name}) => 'Peringatan Anggaran: ${name}';
	@override String percentOf({required Object percent}) => '${percent}% dari ';
	@override String budgetsCount({required Object count}) => '${count} anggaran';
	@override String get editBudget => 'Edit Anggaran';
	@override String get newBudget => 'Anggaran Baru';
	@override String get nameCannotBeEmpty => 'Nama tidak boleh kosong';
	@override String get amountGreaterThanZero => 'Jumlah harus lebih besar dari 0';
	@override String get alertThresholdLabel => 'Ambang batas peringatan (%)';
	@override String get scope => 'Cakupan';
	@override String get anyCategory => 'Semua kategori';
	@override String get anyAccount => 'Semua akun';
	@override String get saveChanges => 'Simpan Perubahan';
	@override String get periodWeekly => 'Mingguan';
	@override String get periodMonthly => 'Bulanan';
	@override String get periodYearly => 'Tahunan';
	@override String get periodCustom => 'Kustom';
	@override String budgetExceededAlert({required Object percentage, required Object name}) => 'Anda telah menggunakan ${percentage}% dari anggaran ${name} Anda.';
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
	@override String get subcategories => 'Subkategori';
	@override String get categories => 'Kategori';
	@override String get egFoodDining => 'misal, Makanan & Minuman';
	@override String get deleteCategory => 'Hapus Kategori';
	@override String get delete => 'Hapus';
	@override String get selectIcon => 'Pilih Ikon';
	@override String get noSubcategoriesYet => 'Belum ada subkategori';
	@override String get noCategoriesFound1 => 'Kategori tidak ditemukan';
	@override String subcategoriesCount({required Object count}) => '${count} subkategori';
	@override String get addSubcategory => 'Tambah Subkategori';
	@override String get addCategory => 'Tambah Kategori';
	@override String get emptyCategorySubtitle => 'Mulai lacak pengeluaran Anda dengan menambahkan kategori';
	@override String get emptySubcategorySubtitle => 'Bagi kategori Anda menjadi bagian-bagian yang lebih kecil';
	@override String get saveSubCategory => 'Simpan Subkategori';
	@override String get saveCategory => 'Simpan Kategori';
	@override String get newSubCategory => 'Subkategori Baru';
	@override String get newCategory => 'Kategori Baru';
	@override String get editSubCategory => 'Edit Subkategori';
	@override String get editCategory => 'Edit Kategori';
	@override String deleteConfirmWithChildren({required Object count}) => 'Apakah Anda yakin ingin menghapus kategori ini? ${count} subkategorinya akan menjadi kategori utama, dan transaksinya sendiri akan menjadi tanpa kategori.';
	@override String get deleteConfirmNoChildren => 'Apakah Anda yakin ingin menghapus kategori ini? Semua transaksinya akan menjadi tanpa kategori.';
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
	@override String get pleaseWait => 'Harap tunggu';
	@override String get today => 'Hari ini';
	@override String get yesterday => 'Kemarin';
	@override String get dueToday => 'Jatuh tempo hari ini';
	@override String get overdue => 'Lewat jatuh tempo';
	@override String get uncategorized => 'Tanpa Kategori';
	@override String get unknown => 'Tidak diketahui';
	@override String get notSet => 'Belum Diatur';
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
	@override String get iOwe => 'Saya Berutang';
	@override String get theyOwe => 'Mereka Berutang';
	@override String get personName => 'Nama orang';
	@override String get principalAmount => 'Jumlah pokok';
	@override String get transactionBinding => 'Pengikatan Transaksi';
	@override String get cancel => 'Batal';
	@override String get save => 'Simpan';
	@override String get ok => 'OK';
	@override String get addRecord => 'Tambah Catatan';
	@override String get createRecord => 'Buat Catatan';
	@override String get debtDetails => 'Detail Utang';
	@override String get repaymentHistory => 'Riwayat Pembayaran';
	@override String get debtsLoans => 'Utang & Piutang';
	@override String get deleteDebt => 'Hapus Utang';
	@override String get delete => 'Hapus';
	@override String get writeoffDebt => 'Penghapusan Utang';
	@override String get areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances => 'Apakah Anda yakin ingin menghapus utang ini? Utang akan ditandai lunas tanpa memengaruhi saldo dompet Anda.';
	@override String get writeoff => 'Hapus Utang';
	@override String get egJohnDoe => 'misal, John Doe';
	@override String get category => 'Kategori';
	@override String get account => 'Akun';
	@override String get egDinnerLastFriday => 'misal, Makan malam jumat lalu';
	@override String get selectDueDate => 'Pilih tanggal jatuh tempo';
	@override String get outstanding => 'Belum Lunas';
	@override String get paid => 'Lunas';
	@override String get principal => 'Pokok';
	@override String get actionDenied => 'Aksi Ditolak';
	@override String get paymentCannotExceedRemaining => 'Jumlah pembayaran tidak boleh melebihi sisa utang.';
	@override String get addNote => 'Tambah catatan';
	@override String get payInFull => 'Bayar Lunas';
	@override String get remaining => 'tersisa';
	@override String get paid1 => 'Terbayar ';
	@override String reminder({required Object type, required Object name}) => 'Pengingat ${type}: ${name}';
	@override String due({required Object type, required Object name}) => '${type} Jatuh Tempo: ${name}';
	@override String noHistoryFoundForThis({required Object type}) => 'Tidak ada riwayat untuk ${type} ini';
	@override String failedToLoadDebts({required Object error}) => 'Gagal memuat utang: ${error}';
	@override String percentOf({required Object percent}) => '${percent}% dari ';
	@override String settled({required Object count}) => '${count} diselesaikan';
	@override String get payable => 'Utang';
	@override String get receivable => 'Piutang';
	@override String get noDebtsRecorded => 'Tidak ada utang tercatat';
	@override String get noLoansRecorded => 'Tidak ada piutang tercatat';
	@override String get trackMoneyYouOweToOthersAndLogRepayments => 'Lacak uang yang Anda pinjam dari orang lain dan catat pembayarannya di sini.';
	@override String get trackMoneyOthersOweYouAndLogCollections => 'Lacak uang yang dipinjam orang lain dari Anda dan catat penagihannya di sini.';
	@override String get editRecord => 'Edit Catatan';
	@override String get newRecord => 'Catatan Baru';
	@override String get personNameCannotBeEmpty => 'Nama orang tidak boleh kosong';
	@override String get amountGreaterThanZero => 'Jumlah harus lebih besar dari 0';
	@override String get selectCategoryAndAccount => 'Silakan pilih kategori dan akun';
	@override String get selectCategoryPrompt => 'Pilih kategori';
	@override String get selectAccountPrompt => 'Pilih akun';
	@override String get debtBindingHelp => 'Mencatat utang ini menambah uang ke akun (transaksi pemasukan).';
	@override String get loanBindingHelp => 'Mencatat pinjaman ini mengurangi uang dari akun (transaksi pengeluaran).';
	@override String get noteLabel => 'Catatan';
	@override String get dueDateLabel => 'Jatuh Tempo';
	@override String get saveChanges => 'Simpan Perubahan';
	@override String deleteConfirm({required Object type}) => 'Apakah Anda yakin ingin menghapus ${type} ini? Catatan akan dihapus permanen. Tindakan ini tidak dapat dibatalkan.';
	@override String debtDetailsTitle({required Object type}) => 'Detail ${type}';
	@override String get debtTypeLoan => 'Piutang';
	@override String get debtTypeDebt => 'Utang';
	@override String reminderAlert({required Object type, required Object amount, required Object action, required Object when}) => '${type} sejumlah ${amount} harus ${action} ${when}.';
	@override String overdueAlert({required Object type, required Object amount, required Object action}) => '${type} sejumlah ${amount} telah lewat jatuh tempo dan harus segera ${action}.';
	@override String get actionCollect => 'ditagih';
	@override String get actionPay => 'dibayar';
	@override String get today => 'hari ini';
	@override String inDays({required Object days}) => 'dalam ${days} hari';
	@override String owedCount({required Object count}) => '${count} harus dibayar';
	@override String receivableCount({required Object count}) => '${count} harus ditagih';
}

// Path: goals
class _Translations$goals$id extends Translations$goals$en {
	_Translations$goals$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get fulfillGoal => 'Capai Target (Gunakan)';
	@override String get goalName => 'Nama target';
	@override String get targetAmount => 'Jumlah target';
	@override String get createGoal => 'Buat Target';
	@override String errorPrefix({required Object error}) => 'Kesalahan: ${error}';
	@override String get goalDetails => 'Detail Target';
	@override String get transactions => 'Transaksi';
	@override String get active => 'Aktif';
	@override String get past => 'Selesai';
	@override String get actionDenied => 'Aksi Ditolak';
	@override String get emptyBalanceBeforeDelete => 'Kosongkan saldo (transfer keluar) sebelum menghapus Goal ini.';
	@override String get ok => 'OK';
	@override String get deleteGoal => 'Hapus Target';
	@override String get areYouSureYouWantToDeleteThisGoalTheAssociatedPocketAccountAndItsHistoryWillAlsoBeRemovedThisActionCannotBeUndone => 'Apakah Anda yakin ingin menghapus target ini? Akun kantong terkait dan riwayatnya juga akan dihapus. Tindakan ini tidak dapat dibatalkan.';
	@override String get delete => 'Hapus';
	@override String get egEmergencyFundNewLaptop => 'misal, Dana Darurat, Laptop Baru';
	@override String get completed => 'Selesai';
	@override String get fullyFunded => 'Tercapai penuh';
	@override String get inProgress => 'Sedang berjalan';
	@override String get totalSaved => 'Total Terkumpul';
	@override String get stillNeeded => 'Masih dibutuhkan';
	@override String get totalTarget => 'Total target';
	@override String get selectTargetDate => 'Pilih tanggal target';
	@override String get noTransactionsFoundForThisGoal => 'Tidak ada transaksi yang ditemukan untuk target ini.';
	@override String get addGoal => 'Tambah Target';
	@override String get aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal => 'Akun Kantong khusus akan dibuat secara otomatis untuk melacak target ini.';
	@override String get saved => 'terkumpul';
	@override String get needs => 'Butuh ';
	@override String get more => ' lagi';
	@override String get noGoalsYet => 'Belum ada target';
	@override String get setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal => 'Tetapkan target tabungan — kantong khusus akan dibuat secara otomatis untuk setiap target.';
	@override String percentOfTarget({required Object percent}) => '${percent}% dari target';
	@override String goalsCount({required Object count}) => '${count} target';
	@override String fullyFundedCount({required Object count}) => '${count} tercapai penuh';
	@override String get noCompletedGoalsYet => 'Belum ada target yang selesai';
	@override String get completedGoalsWillAppearHere => 'Target yang Anda selesaikan akan muncul di sini.';
	@override String get editGoal => 'Edit Target';
	@override String get newGoal => 'Target Baru';
	@override String get nameCannotBeEmpty => 'Nama tidak boleh kosong';
	@override String get targetAmountGreaterThanZero => 'Jumlah target harus lebih besar dari 0';
	@override String get saveChanges => 'Simpan Perubahan';
	@override String get targetDateLabel => 'Tanggal Target';
}

// Path: lock
class _Translations$lock$id extends Translations$lock$en {
	_Translations$lock$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get confirmPin => 'Konfirmasi PIN';
	@override String get createPin => 'Buat PIN';
	@override String get pinsDoNotMatch => 'PIN tidak cocok';
	@override String get reenterPin => 'Masukkan kembali PIN';
	@override String get enterPinAppLock => 'Masukkan PIN untuk Kunci Aplikasi';
	@override String get incorrectPin => 'PIN salah';
	@override String get verifyIdentity => 'Verifikasi Identitas';
	@override String retryInSeconds({required Object seconds}) => 'Coba lagi dalam ${seconds} detik';
	@override String get setupPinTitle => 'Atur PIN';
	@override String get setupPinBody => 'Harap buat PIN terlebih dahulu sebelum mengaktifkan Kunci Aplikasi atau Biometrik.';
	@override String get unlocked => 'Terbuka';
	@override String get enter6DigitPin => 'Masukkan 6-digit PIN';
	@override String get enterPin => 'Masukkan PIN';
	@override String get invalidPin => 'PIN tidak valid';
	@override String get tooManyAttempts => 'Terlalu banyak percobaan';
	@override String get temporarilyLocked => 'Terkunci sementara';
	@override String get authenticateReason => 'Autentikasi untuk mengakses Poka';
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
	@override String get recurring => 'Berulang';
	@override String get schedules => 'Jadwal';
	@override String get scheduleDetails => 'Detail Jadwal';
	@override String get deleteSchedule => 'Hapus Jadwal';
	@override String get areYouSureYouWantToDeleteThisRecurringScheduleExistingGeneratedTransactionsWillNotBeDeleted => 'Apakah Anda yakin ingin menghapus jadwal berulang ini? Transaksi yang sudah terbuat sebelumnya tidak akan dihapus.';
	@override String get delete => 'Hapus';
	@override String get triggerHistory => 'Riwayat Pemicu';
	@override String get destinationAccount => 'Akun Tujuan';
	@override String get category => 'Kategori';
	@override String get egNetflixSubscription => 'misal, Langganan Netflix';
	@override String get selectFirstDueDate => 'Pilih tanggal jatuh tempo pertama';
	@override String get estMonthlyNet => 'Estimasi Bersih Bulanan';
	@override String get monthlyIn => 'Pemasukan Bulanan';
	@override String get monthlyOut => 'Pengeluaran Bulanan';
	@override String get noRecurringTransactions => 'Tidak ada transaksi berulang';
	@override String get automateBillsLikeSubscriptionsOrSalary => 'Otomatiskan tagihan seperti langganan atau gaji. Aplikasi akan mencatatnya sesuai jadwal.';
	@override String get noHistoryFoundForThisSchedule => 'Tidak ada riwayat untuk jadwal ini.';
	@override String get allocation => 'Alokasi';
	@override String get active => 'Aktif';
	@override String get eachTimeTheAppOpensOverdueRecurringTransactionsAre => 'Setiap kali aplikasi dibuka, transaksi berulang yang telah lewat jatuh tempo akan otomatis dicatat dalam buku kas Anda.';
	@override String schedulesCount({required Object count}) => '${count} jadwal';
	@override String pausedCount({required Object count}) => '${count} dijeda';
	@override String get editRecurring => 'Edit Transaksi Berulang';
	@override String get newRecurring => 'Transaksi Berulang Baru';
	@override String get mustSelectAccount => 'Harus memilih akun';
	@override String get sourceAccount => 'Akun Sumber';
	@override String get account => 'Akun';
	@override String get selectAccountPrompt => 'Pilih akun';
	@override String get selectDestinationPrompt => 'Pilih tujuan';
	@override String get selectCategoryOptional => 'Pilih kategori (opsional)';
	@override String get noteLabel => 'Catatan';
	@override String get saveChanges => 'Simpan Perubahan';
	@override String get createRecurring => 'Buat Transaksi Berulang';
	@override String get amountGreaterThanZero => 'Jumlah harus lebih besar dari 0';
	@override String get mustSelectStartDate => 'Harus memilih tanggal mulai';
	@override String get periodDaily => 'Harian';
	@override String get periodWeekly => 'Mingguan';
	@override String get periodMonthly => 'Bulanan';
	@override String get periodYearly => 'Tahunan';
	@override String get autoGenerateActive => 'Akan otomatis membuat transaksi';
	@override String get autoGeneratePaused => 'Dijeda — tidak ada transaksi yang dibuat';
	@override String get recurringIncome => 'Pemasukan Berulang';
	@override String get recurringExpense => 'Pengeluaran Berulang';
	@override String get recurringTransfer => 'Transfer Berulang';
	@override String nextDateLabel({required Object date}) => 'Berikutnya: ${date}';
}

// Path: reports
class _Translations$reports$id extends Translations$reports$en {
	_Translations$reports$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Laporan';
	@override String get overview => 'Ikhtisar Keuangan';
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
	@override String get budgetUtilization => 'Pemanfaatan Anggaran';
	@override String get spendingAllocation => 'Alokasi Pengeluaran';
	@override String get noData => 'Tidak ada data untuk periode ini';
	@override String get noBudgets => 'Belum ada anggaran yang dikonfigurasi';
	@override String get noBudgetsDesc => 'Tambahkan anggaran untuk melacak batas pengeluaran Anda';
	@override String get onTrack => 'Sesuai rencana';
	@override String get needsAttention => 'Perlu perhatian';
	@override String get overBudget => 'Melebihi anggaran';
	@override String get onBudget => 'Dalam batas';
	@override String get needs => 'Kebutuhan';
	@override String get wants => 'Keinginan';
	@override String get savings => 'Tabungan';
	@override String get other => 'Lainnya';
	@override String get total => 'Total';
	@override String get average => 'Rata-rata';
	@override String get remaining => 'Tersisa';
	@override String get spent => 'Terpakai';
	@override String get limit => 'Batas';
	@override String txCount({required Object count}) => '${count} transaksi';
	@override String get selectDateRange => 'Pilih Rentang Tanggal';
	@override String get apply => 'Terapkan';
	@override String get from => 'Dari';
	@override String get to => 'Sampai';
	@override String comparedTo({required Object period}) => 'vs ${period}';
	@override String get higher => 'lebih tinggi';
	@override String get lower => 'lebih rendah';
	@override String get same => 'sama dengan';
	@override String get noChange => 'Tidak ada perubahan';
	@override String get percent50 => '50%';
	@override String get percent30 => '30%';
	@override String get percent20 => '20%';
	@override String get rule503020 => '50/30/20';
	@override String get prevLastMonth => 'bulan lalu';
	@override String get prevMonth => 'bulan sebelumnya';
	@override String get prev3Months => '3 bln lalu';
	@override String get prev6Months => '6 bln lalu';
	@override String get prevPeriod => 'periode lalu';
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
	@override String get notSet => 'Belum Diatur';
}

// Path: shared
class _Translations$shared$id extends Translations$shared$en {
	_Translations$shared$id._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get authRequired => 'Dibutuhkan Autentikasi';
	@override String get hexColorCode => 'Kode Warna Hex';
	@override String get apply => 'Terapkan';
	@override String get enterAmount => 'Masukkan Jumlah';
	@override String get selectCategory => 'Pilih Kategori';
	@override String get egFf5733 => 'misal, FF5733';
	@override String get amount => 'Jumlah';
	@override String get noCategoriesAvailable => 'Tidak ada kategori yang tersedia.';
	@override String get noWalletsFoundPleaseCreateOneFirst => 'Dompet tidak ditemukan. Silakan buat dompet terlebih dahulu.';
	@override String get balance => 'Saldo: ';
	@override String get optional => 'Opsional';
	@override String get customColor => 'Warna Kustom';
	@override String get selectWallet => 'Pilih Dompet';
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
	@override String get noAccountsAvailable => 'Tidak ada akun yang tersedia';
	@override String get account => 'Akun';
	@override String get category => 'Kategori';
	@override String get done => 'Selesai';
	@override String get save => 'Simpan';
	@override String get transactions => 'Transaksi';
	@override String get splitTransaction => 'Pisah Transaksi';
	@override String get from => 'Dari';
	@override String get to => 'Ke';
	@override String get empty => '+/-';
	@override String get filtered => 'Difilter';
	@override String get netBalance => 'Saldo Bersih';
	@override String get income => 'Pemasukan';
	@override String get expense => 'Pengeluaran';
	@override String get selectCategory => 'Pilih Kategori';
	@override String get filter => 'Filter';
	@override String get backToToday => 'Kembali ke hari ini';
	@override String get deleteTransaction => 'Hapus Transaksi';
	@override String get deleteTransactionWarning => 'Menghapus transaksi ini akan mengembalikan saldo akun dan anggaran Anda ke keadaan sebelumnya.';
	@override String get out => 'Keluar ';
	@override String get noTransactions => 'Tidak ada transaksi';
	@override String get addNote => 'Tambah catatan';
	@override String get noItemsYet => 'Belum ada item';
	@override String get tapAddItemToBeginSplittingntheTransaction => 'Ketuk "Tambah Item" untuk mulai memisahkan\ntransaksi.';
	@override String get addAtLeastOneMoreItemToSave => 'Tambahkan setidaknya satu item lagi untuk menyimpan.';
	@override String get noTransactions1 => 'Tidak Ada Transaksi';
	@override String get reset => 'Reset';
	@override String get incoming => 'Masuk ';
	@override String nothingRecordedFor({required Object period}) => 'Belum ada catatan untuk ${period}.';
	@override String splitItems({required Object count}) => '${count} item terpisah';
	@override String itemsCount({required Object count}) => '${count} item';
	@override String transactionsCount({required Object count}) => '${count} transaksi';
	@override String get editTransaction => 'Edit Transaksi';
	@override String get newTransaction => 'Transaksi Baru';
	@override String get fromAccount => 'Dari Akun';
	@override String get toAccount => 'Ke Akun';
	@override String get need => 'Kebutuhan';
	@override String get want => 'Keinginan';
	@override String get saving => 'Tabungan';
	@override String get addNoteEllipsis => 'Tambah catatan...';
	@override String get editItem => 'Edit Item';
	@override String get newItem => 'Item Baru';
	@override String get viewModeDay => 'Hari';
	@override String get viewModeWeek => 'Minggu';
	@override String get viewModeMonth => 'Bulan';
	@override String get viewModeDaily => 'Harian';
	@override String get viewModeWeekly => 'Mingguan';
	@override String get viewModeMonthly => 'Bulanan';
	@override String get debt => 'Utang';
	@override String get recurring => 'Berulang';
	@override String get transfer => 'Transfer';
	@override String weekNumber({required Object weekNum, required Object date}) => 'Minggu ${weekNum} · ${date}';
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
			'accounts.balance' => 'Saldo',
			'accounts.walletsPockets' => 'Dompet & Kantong',
			'accounts.accounts' => 'Akun',
			'accounts.mainAccounts' => 'Akun Utama',
			'accounts.goalsAndSavings' => 'Target & Tabungan',
			'accounts.deleteAccount' => 'Hapus Akun',
			'accounts.areYouSureYouWantToDeleteThisAccountItWillBeHiddenFromTheApp' => 'Apakah Anda yakin ingin menghapus akun ini? Akun akan disembunyikan dari aplikasi.',
			'accounts.delete' => 'Hapus',
			'accounts.account' => 'Akun',
			'accounts.totalBalance' => 'Total Saldo',
			'accounts.pockets' => 'Kantong',
			'accounts.deletePocket' => 'Hapus Kantong',
			'accounts.areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp' => 'Apakah Anda yakin ingin menghapus kantong ini? Kantong akan disembunyikan dari aplikasi.',
			'accounts.nameCannotBeEmpty' => 'Nama tidak boleh kosong',
			'accounts.egMainWallet' => 'misal, Dompet Utama',
			'accounts.selectIcon' => 'Pilih Ikon',
			'accounts.allowedCategories' => 'Kategori yang Diizinkan',
			'accounts.transactions' => 'Transaksi',
			'accounts.editAccount' => 'Edit Akun',
			'accounts.updateNameIconOrColor' => 'Perbarui nama, ikon, atau warna',
			'accounts.permanentlyRemoveThisAccount' => 'Hapus permanen akun ini',
			'accounts.seeAll' => 'Lihat Semua',
			'accounts.noTransactionsYet' => 'Belum ada transaksi',
			'accounts.addAccount' => 'Tambah Akun',
			'accounts.noAccountsFound' => 'Akun tidak ditemukan.',
			'accounts.addPocket' => 'Tambah Kantong',
			'accounts.noPocketsYet' => 'Belum ada kantong',
			'accounts.pocketsHelpYouSplitYourWalletIntoCategories' => 'Kantong membantu Anda membagi dompet ke dalam beberapa kategori',
			'accounts.activeAccount' => 'Akun Aktif',
			'accounts.inactiveAccountsWillBeHidden' => 'Akun tidak aktif akan disembunyikan',
			'accounts.noCategoriesAvailable' => 'Tidak ada kategori yang tersedia.',
			'accounts.noAccountsFound1' => 'Akun tidak ditemukan',
			'accounts.subcategoriesCount' => ({required Object count}) => '${count} subkategori',
			'accounts.pocketsCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('id'))(count, other: '${count} kantong', ), 
			'accounts.totalActiveAccounts' => 'Total Akun Aktif',
			'accounts.noAccountsYet' => 'Belum Ada Akun',
			'accounts.tapTheButtonBelowToAddYourFirstAccount' => 'Tekan tombol di bawah untuk menambahkan akun pertama Anda',
			'accounts.allCategoriesAllowed' => 'Semua kategori diizinkan',
			'accounts.categoriesSelected' => ({required Object count}) => '${count} kategori dipilih',
			'accounts.ratioOfAccount' => ({required Object percent}) => '${percent}% dari akun',
			'accounts.noMainAccountsYet' => 'Belum ada akun utama.',
			'accounts.percentOfAssets' => ({required Object percent}) => '${percent}% dari aset',
			'accounts.recentTransactions' => 'Transaksi Terakhir',
			'accounts.recentTransactionsCount' => ({required Object count}) => 'Transaksi Terakhir (${count})',
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
			'budgets.resetDay' => 'Hari reset (1–31)',
			'budgets.createBudget' => 'Buat Anggaran',
			'budgets.endDate' => 'Tanggal Berakhir',
			'budgets.budgetDetails' => 'Detail Anggaran',
			'budgets.deleteBudget' => 'Hapus Anggaran',
			'budgets.areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone' => 'Apakah Anda yakin ingin menghapus anggaran ini? Semua riwayat pelacakan terkait akan dihapus secara permanen. Tindakan ini tidak dapat dibatalkan.',
			'budgets.delete' => 'Hapus',
			'budgets.transactions' => 'Transaksi',
			'budgets.budgets' => 'Anggaran',
			'budgets.allBudgets' => 'Semua Anggaran',
			'budgets.egGroceriesEntertainment' => 'misal, Belanja, Hiburan',
			'budgets.eg80' => 'misal, 80',
			'budgets.category' => 'Kategori',
			'budgets.account' => 'Akun',
			'budgets.overLimit' => 'Melebihi batas',
			'budgets.remaining' => 'Tersisa',
			'budgets.totalSpent' => 'Total terpakai',
			'budgets.totalLimit' => 'Total batas',
			'budgets.selectEndDate' => 'Pilih tanggal berakhir',
			'budgets.noTransactionsFoundForThisBudgetPeriod' => 'Tidak ada transaksi yang ditemukan untuk periode anggaran ini.',
			'budgets.addBudget' => 'Tambah Anggaran',
			'budgets.spent' => 'Terpakai ',
			'budgets.noBudgetsYet' => 'Belum ada anggaran',
			'budgets.setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod' => 'Tetapkan batas pengeluaran untuk melacak pengeluaran Anda setiap periode.',
			'budgets.budgetAlert' => ({required Object name}) => 'Peringatan Anggaran: ${name}',
			'budgets.percentOf' => ({required Object percent}) => '${percent}% dari ',
			'budgets.budgetsCount' => ({required Object count}) => '${count} anggaran',
			'budgets.editBudget' => 'Edit Anggaran',
			'budgets.newBudget' => 'Anggaran Baru',
			'budgets.nameCannotBeEmpty' => 'Nama tidak boleh kosong',
			'budgets.amountGreaterThanZero' => 'Jumlah harus lebih besar dari 0',
			'budgets.alertThresholdLabel' => 'Ambang batas peringatan (%)',
			'budgets.scope' => 'Cakupan',
			'budgets.anyCategory' => 'Semua kategori',
			'budgets.anyAccount' => 'Semua akun',
			'budgets.saveChanges' => 'Simpan Perubahan',
			'budgets.periodWeekly' => 'Mingguan',
			'budgets.periodMonthly' => 'Bulanan',
			'budgets.periodYearly' => 'Tahunan',
			'budgets.periodCustom' => 'Kustom',
			'budgets.budgetExceededAlert' => ({required Object percentage, required Object name}) => 'Anda telah menggunakan ${percentage}% dari anggaran ${name} Anda.',
			'categories.expense' => 'Pengeluaran',
			'categories.income' => 'Pemasukan',
			'categories.categoryName' => 'Nama Kategori',
			'categories.icon' => 'Ikon',
			'categories.color' => 'Warna',
			'categories.noCategoriesFound' => 'Kategori tidak ditemukan.',
			'categories.subcategories' => 'Subkategori',
			'categories.categories' => 'Kategori',
			'categories.egFoodDining' => 'misal, Makanan & Minuman',
			'categories.deleteCategory' => 'Hapus Kategori',
			'categories.delete' => 'Hapus',
			'categories.selectIcon' => 'Pilih Ikon',
			'categories.noSubcategoriesYet' => 'Belum ada subkategori',
			'categories.noCategoriesFound1' => 'Kategori tidak ditemukan',
			'categories.subcategoriesCount' => ({required Object count}) => '${count} subkategori',
			'categories.addSubcategory' => 'Tambah Subkategori',
			'categories.addCategory' => 'Tambah Kategori',
			'categories.emptyCategorySubtitle' => 'Mulai lacak pengeluaran Anda dengan menambahkan kategori',
			'categories.emptySubcategorySubtitle' => 'Bagi kategori Anda menjadi bagian-bagian yang lebih kecil',
			'categories.saveSubCategory' => 'Simpan Subkategori',
			'categories.saveCategory' => 'Simpan Kategori',
			'categories.newSubCategory' => 'Subkategori Baru',
			'categories.newCategory' => 'Kategori Baru',
			'categories.editSubCategory' => 'Edit Subkategori',
			'categories.editCategory' => 'Edit Kategori',
			'categories.deleteConfirmWithChildren' => ({required Object count}) => 'Apakah Anda yakin ingin menghapus kategori ini? ${count} subkategorinya akan menjadi kategori utama, dan transaksinya sendiri akan menjadi tanpa kategori.',
			'categories.deleteConfirmNoChildren' => 'Apakah Anda yakin ingin menghapus kategori ini? Semua transaksinya akan menjadi tanpa kategori.',
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
			'common.pleaseWait' => 'Harap tunggu',
			'common.today' => 'Hari ini',
			'common.yesterday' => 'Kemarin',
			'common.dueToday' => 'Jatuh tempo hari ini',
			'common.overdue' => 'Lewat jatuh tempo',
			'common.uncategorized' => 'Tanpa Kategori',
			'common.unknown' => 'Tidak diketahui',
			'common.notSet' => 'Belum Diatur',
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
			'debts.iOwe' => 'Saya Berutang',
			'debts.theyOwe' => 'Mereka Berutang',
			'debts.personName' => 'Nama orang',
			'debts.principalAmount' => 'Jumlah pokok',
			'debts.transactionBinding' => 'Pengikatan Transaksi',
			'debts.cancel' => 'Batal',
			'debts.save' => 'Simpan',
			'debts.ok' => 'OK',
			'debts.addRecord' => 'Tambah Catatan',
			'debts.createRecord' => 'Buat Catatan',
			'debts.debtDetails' => 'Detail Utang',
			'debts.repaymentHistory' => 'Riwayat Pembayaran',
			'debts.debtsLoans' => 'Utang & Piutang',
			'debts.deleteDebt' => 'Hapus Utang',
			'debts.delete' => 'Hapus',
			'debts.writeoffDebt' => 'Penghapusan Utang',
			'debts.areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances' => 'Apakah Anda yakin ingin menghapus utang ini? Utang akan ditandai lunas tanpa memengaruhi saldo dompet Anda.',
			'debts.writeoff' => 'Hapus Utang',
			'debts.egJohnDoe' => 'misal, John Doe',
			'debts.category' => 'Kategori',
			'debts.account' => 'Akun',
			'debts.egDinnerLastFriday' => 'misal, Makan malam jumat lalu',
			'debts.selectDueDate' => 'Pilih tanggal jatuh tempo',
			'debts.outstanding' => 'Belum Lunas',
			'debts.paid' => 'Lunas',
			'debts.principal' => 'Pokok',
			'debts.actionDenied' => 'Aksi Ditolak',
			'debts.paymentCannotExceedRemaining' => 'Jumlah pembayaran tidak boleh melebihi sisa utang.',
			'debts.addNote' => 'Tambah catatan',
			'debts.payInFull' => 'Bayar Lunas',
			'debts.remaining' => 'tersisa',
			'debts.paid1' => 'Terbayar ',
			'debts.reminder' => ({required Object type, required Object name}) => 'Pengingat ${type}: ${name}',
			'debts.due' => ({required Object type, required Object name}) => '${type} Jatuh Tempo: ${name}',
			'debts.noHistoryFoundForThis' => ({required Object type}) => 'Tidak ada riwayat untuk ${type} ini',
			'debts.failedToLoadDebts' => ({required Object error}) => 'Gagal memuat utang: ${error}',
			'debts.percentOf' => ({required Object percent}) => '${percent}% dari ',
			'debts.settled' => ({required Object count}) => '${count} diselesaikan',
			'debts.payable' => 'Utang',
			'debts.receivable' => 'Piutang',
			'debts.noDebtsRecorded' => 'Tidak ada utang tercatat',
			'debts.noLoansRecorded' => 'Tidak ada piutang tercatat',
			'debts.trackMoneyYouOweToOthersAndLogRepayments' => 'Lacak uang yang Anda pinjam dari orang lain dan catat pembayarannya di sini.',
			'debts.trackMoneyOthersOweYouAndLogCollections' => 'Lacak uang yang dipinjam orang lain dari Anda dan catat penagihannya di sini.',
			'debts.editRecord' => 'Edit Catatan',
			'debts.newRecord' => 'Catatan Baru',
			'debts.personNameCannotBeEmpty' => 'Nama orang tidak boleh kosong',
			'debts.amountGreaterThanZero' => 'Jumlah harus lebih besar dari 0',
			'debts.selectCategoryAndAccount' => 'Silakan pilih kategori dan akun',
			'debts.selectCategoryPrompt' => 'Pilih kategori',
			'debts.selectAccountPrompt' => 'Pilih akun',
			'debts.debtBindingHelp' => 'Mencatat utang ini menambah uang ke akun (transaksi pemasukan).',
			'debts.loanBindingHelp' => 'Mencatat pinjaman ini mengurangi uang dari akun (transaksi pengeluaran).',
			'debts.noteLabel' => 'Catatan',
			'debts.dueDateLabel' => 'Jatuh Tempo',
			'debts.saveChanges' => 'Simpan Perubahan',
			'debts.deleteConfirm' => ({required Object type}) => 'Apakah Anda yakin ingin menghapus ${type} ini? Catatan akan dihapus permanen. Tindakan ini tidak dapat dibatalkan.',
			'debts.debtDetailsTitle' => ({required Object type}) => 'Detail ${type}',
			'debts.debtTypeLoan' => 'Piutang',
			'debts.debtTypeDebt' => 'Utang',
			'debts.reminderAlert' => ({required Object type, required Object amount, required Object action, required Object when}) => '${type} sejumlah ${amount} harus ${action} ${when}.',
			'debts.overdueAlert' => ({required Object type, required Object amount, required Object action}) => '${type} sejumlah ${amount} telah lewat jatuh tempo dan harus segera ${action}.',
			'debts.actionCollect' => 'ditagih',
			'debts.actionPay' => 'dibayar',
			'debts.today' => 'hari ini',
			'debts.inDays' => ({required Object days}) => 'dalam ${days} hari',
			'debts.owedCount' => ({required Object count}) => '${count} harus dibayar',
			'debts.receivableCount' => ({required Object count}) => '${count} harus ditagih',
			'error.generic' => 'Terjadi kesalahan yang tidak terduga',
			'error.network' => 'Periksa koneksi Anda dan coba lagi',
			'error.database' => 'Gagal mengakses data lokal',
			'goals.fulfillGoal' => 'Capai Target (Gunakan)',
			'goals.goalName' => 'Nama target',
			'goals.targetAmount' => 'Jumlah target',
			'goals.createGoal' => 'Buat Target',
			'goals.errorPrefix' => ({required Object error}) => 'Kesalahan: ${error}',
			'goals.goalDetails' => 'Detail Target',
			'goals.transactions' => 'Transaksi',
			'goals.active' => 'Aktif',
			'goals.past' => 'Selesai',
			'goals.actionDenied' => 'Aksi Ditolak',
			'goals.emptyBalanceBeforeDelete' => 'Kosongkan saldo (transfer keluar) sebelum menghapus Goal ini.',
			'goals.ok' => 'OK',
			'goals.deleteGoal' => 'Hapus Target',
			'goals.areYouSureYouWantToDeleteThisGoalTheAssociatedPocketAccountAndItsHistoryWillAlsoBeRemovedThisActionCannotBeUndone' => 'Apakah Anda yakin ingin menghapus target ini? Akun kantong terkait dan riwayatnya juga akan dihapus. Tindakan ini tidak dapat dibatalkan.',
			'goals.delete' => 'Hapus',
			'goals.egEmergencyFundNewLaptop' => 'misal, Dana Darurat, Laptop Baru',
			'goals.completed' => 'Selesai',
			'goals.fullyFunded' => 'Tercapai penuh',
			'goals.inProgress' => 'Sedang berjalan',
			'goals.totalSaved' => 'Total Terkumpul',
			'goals.stillNeeded' => 'Masih dibutuhkan',
			'goals.totalTarget' => 'Total target',
			'goals.selectTargetDate' => 'Pilih tanggal target',
			'goals.noTransactionsFoundForThisGoal' => 'Tidak ada transaksi yang ditemukan untuk target ini.',
			'goals.addGoal' => 'Tambah Target',
			'goals.aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal' => 'Akun Kantong khusus akan dibuat secara otomatis untuk melacak target ini.',
			'goals.saved' => 'terkumpul',
			'goals.needs' => 'Butuh ',
			'goals.more' => ' lagi',
			'goals.noGoalsYet' => 'Belum ada target',
			'goals.setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal' => 'Tetapkan target tabungan — kantong khusus akan dibuat secara otomatis untuk setiap target.',
			'goals.percentOfTarget' => ({required Object percent}) => '${percent}% dari target',
			'goals.goalsCount' => ({required Object count}) => '${count} target',
			'goals.fullyFundedCount' => ({required Object count}) => '${count} tercapai penuh',
			'goals.noCompletedGoalsYet' => 'Belum ada target yang selesai',
			'goals.completedGoalsWillAppearHere' => 'Target yang Anda selesaikan akan muncul di sini.',
			'goals.editGoal' => 'Edit Target',
			'goals.newGoal' => 'Target Baru',
			'goals.nameCannotBeEmpty' => 'Nama tidak boleh kosong',
			'goals.targetAmountGreaterThanZero' => 'Jumlah target harus lebih besar dari 0',
			'goals.saveChanges' => 'Simpan Perubahan',
			'goals.targetDateLabel' => 'Tanggal Target',
			'lock.confirmPin' => 'Konfirmasi PIN',
			'lock.createPin' => 'Buat PIN',
			'lock.pinsDoNotMatch' => 'PIN tidak cocok',
			'lock.reenterPin' => 'Masukkan kembali PIN',
			'lock.enterPinAppLock' => 'Masukkan PIN untuk Kunci Aplikasi',
			'lock.incorrectPin' => 'PIN salah',
			'lock.verifyIdentity' => 'Verifikasi Identitas',
			'lock.retryInSeconds' => ({required Object seconds}) => 'Coba lagi dalam ${seconds} detik',
			'lock.setupPinTitle' => 'Atur PIN',
			'lock.setupPinBody' => 'Harap buat PIN terlebih dahulu sebelum mengaktifkan Kunci Aplikasi atau Biometrik.',
			'lock.unlocked' => 'Terbuka',
			'lock.enter6DigitPin' => 'Masukkan 6-digit PIN',
			'lock.enterPin' => 'Masukkan PIN',
			'lock.invalidPin' => 'PIN tidak valid',
			'lock.tooManyAttempts' => 'Terlalu banyak percobaan',
			'lock.temporarilyLocked' => 'Terkunci sementara',
			'lock.authenticateReason' => 'Autentikasi untuk mengakses Poka',
			'onboarding.continueWithCurrency' => 'Lanjutkan dengan mata uang pilihan',
			'onboarding.chooseYourBaseCurrency' => 'Pilih Mata Uang Utama Anda',
			'onboarding.thisCurrencyWillBeUsedForAllAccountsPocketsAndTransactionsYouCanChangeThisLaterInSettings' => 'This currency will be used for all accounts, pockets, and transactions. You can change this later in settings.',
			'recurring.addSchedule' => 'Tambah Jadwal',
			'recurring.transactionDetails' => 'Detail Transaksi',
			'recurring.amount' => 'Jumlah',
			'recurring.frequency' => 'Frekuensi',
			'recurring.startDate' => 'Tanggal Mulai',
			'recurring.recurring' => 'Berulang',
			'recurring.schedules' => 'Jadwal',
			'recurring.scheduleDetails' => 'Detail Jadwal',
			'recurring.deleteSchedule' => 'Hapus Jadwal',
			'recurring.areYouSureYouWantToDeleteThisRecurringScheduleExistingGeneratedTransactionsWillNotBeDeleted' => 'Apakah Anda yakin ingin menghapus jadwal berulang ini? Transaksi yang sudah terbuat sebelumnya tidak akan dihapus.',
			'recurring.delete' => 'Hapus',
			'recurring.triggerHistory' => 'Riwayat Pemicu',
			'recurring.destinationAccount' => 'Akun Tujuan',
			'recurring.category' => 'Kategori',
			'recurring.egNetflixSubscription' => 'misal, Langganan Netflix',
			'recurring.selectFirstDueDate' => 'Pilih tanggal jatuh tempo pertama',
			'recurring.estMonthlyNet' => 'Estimasi Bersih Bulanan',
			'recurring.monthlyIn' => 'Pemasukan Bulanan',
			'recurring.monthlyOut' => 'Pengeluaran Bulanan',
			'recurring.noRecurringTransactions' => 'Tidak ada transaksi berulang',
			'recurring.automateBillsLikeSubscriptionsOrSalary' => 'Otomatiskan tagihan seperti langganan atau gaji. Aplikasi akan mencatatnya sesuai jadwal.',
			'recurring.noHistoryFoundForThisSchedule' => 'Tidak ada riwayat untuk jadwal ini.',
			'recurring.allocation' => 'Alokasi',
			'recurring.active' => 'Aktif',
			'recurring.eachTimeTheAppOpensOverdueRecurringTransactionsAre' => 'Setiap kali aplikasi dibuka, transaksi berulang yang telah lewat jatuh tempo akan otomatis dicatat dalam buku kas Anda.',
			'recurring.schedulesCount' => ({required Object count}) => '${count} jadwal',
			'recurring.pausedCount' => ({required Object count}) => '${count} dijeda',
			'recurring.editRecurring' => 'Edit Transaksi Berulang',
			'recurring.newRecurring' => 'Transaksi Berulang Baru',
			'recurring.mustSelectAccount' => 'Harus memilih akun',
			'recurring.sourceAccount' => 'Akun Sumber',
			'recurring.account' => 'Akun',
			'recurring.selectAccountPrompt' => 'Pilih akun',
			'recurring.selectDestinationPrompt' => 'Pilih tujuan',
			'recurring.selectCategoryOptional' => 'Pilih kategori (opsional)',
			'recurring.noteLabel' => 'Catatan',
			'recurring.saveChanges' => 'Simpan Perubahan',
			'recurring.createRecurring' => 'Buat Transaksi Berulang',
			'recurring.amountGreaterThanZero' => 'Jumlah harus lebih besar dari 0',
			'recurring.mustSelectStartDate' => 'Harus memilih tanggal mulai',
			'recurring.periodDaily' => 'Harian',
			'recurring.periodWeekly' => 'Mingguan',
			'recurring.periodMonthly' => 'Bulanan',
			'recurring.periodYearly' => 'Tahunan',
			'recurring.autoGenerateActive' => 'Akan otomatis membuat transaksi',
			'recurring.autoGeneratePaused' => 'Dijeda — tidak ada transaksi yang dibuat',
			'recurring.recurringIncome' => 'Pemasukan Berulang',
			'recurring.recurringExpense' => 'Pengeluaran Berulang',
			'recurring.recurringTransfer' => 'Transfer Berulang',
			'recurring.nextDateLabel' => ({required Object date}) => 'Berikutnya: ${date}',
			'reports.title' => 'Laporan',
			'reports.overview' => 'Ikhtisar Keuangan',
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
			'reports.budgetUtilization' => 'Pemanfaatan Anggaran',
			'reports.spendingAllocation' => 'Alokasi Pengeluaran',
			'reports.noData' => 'Tidak ada data untuk periode ini',
			'reports.noBudgets' => 'Belum ada anggaran yang dikonfigurasi',
			'reports.noBudgetsDesc' => 'Tambahkan anggaran untuk melacak batas pengeluaran Anda',
			'reports.onTrack' => 'Sesuai rencana',
			'reports.needsAttention' => 'Perlu perhatian',
			'reports.overBudget' => 'Melebihi anggaran',
			'reports.onBudget' => 'Dalam batas',
			'reports.needs' => 'Kebutuhan',
			'reports.wants' => 'Keinginan',
			'reports.savings' => 'Tabungan',
			'reports.other' => 'Lainnya',
			'reports.total' => 'Total',
			'reports.average' => 'Rata-rata',
			'reports.remaining' => 'Tersisa',
			'reports.spent' => 'Terpakai',
			'reports.limit' => 'Batas',
			'reports.txCount' => ({required Object count}) => '${count} transaksi',
			'reports.selectDateRange' => 'Pilih Rentang Tanggal',
			'reports.apply' => 'Terapkan',
			'reports.from' => 'Dari',
			'reports.to' => 'Sampai',
			'reports.comparedTo' => ({required Object period}) => 'vs ${period}',
			'reports.higher' => 'lebih tinggi',
			'reports.lower' => 'lebih rendah',
			'reports.same' => 'sama dengan',
			'reports.noChange' => 'Tidak ada perubahan',
			'reports.percent50' => '50%',
			'reports.percent30' => '30%',
			'reports.percent20' => '20%',
			'reports.rule503020' => '50/30/20',
			'reports.prevLastMonth' => 'bulan lalu',
			'reports.prevMonth' => 'bulan sebelumnya',
			'reports.prev3Months' => '3 bln lalu',
			'reports.prev6Months' => '6 bln lalu',
			'reports.prevPeriod' => 'periode lalu',
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
			_ => null,
		} ?? switch (path) {
			'settings.noLicensesFound' => 'Lisensi tidak ditemukan',
			'settings.pokaCe' => 'Poka CE',
			'settings.communityEdition' => 'Edisi Komunitas',
			'settings.aboutDescription' => 'Pengelola keuangan pribadi open-source gratis yang dirancang untuk membantu Anda mencatat pengeluaran, mengatur anggaran, dan memantau akun secara lokal.',
			'settings.copyright' => '© 2026 POKA. All rights reserved.',
			'settings.noResultsFound' => 'Tidak Ada Hasil',
			'settings.weCouldntFindAnyCurrencyMatching' => 'Kami tidak menemukan mata uang yang cocok dengan "{search}".',
			'settings.notSet' => 'Belum Diatur',
			'shared.authRequired' => 'Dibutuhkan Autentikasi',
			'shared.hexColorCode' => 'Kode Warna Hex',
			'shared.apply' => 'Terapkan',
			'shared.enterAmount' => 'Masukkan Jumlah',
			'shared.selectCategory' => 'Pilih Kategori',
			'shared.egFf5733' => 'misal, FF5733',
			'shared.amount' => 'Jumlah',
			'shared.noCategoriesAvailable' => 'Tidak ada kategori yang tersedia.',
			'shared.noWalletsFoundPleaseCreateOneFirst' => 'Dompet tidak ditemukan. Silakan buat dompet terlebih dahulu.',
			'shared.balance' => 'Saldo: ',
			'shared.optional' => 'Opsional',
			'shared.customColor' => 'Warna Kustom',
			'shared.selectWallet' => 'Pilih Dompet',
			'transactions.searchTransactions' => 'Cari transaksi...',
			'transactions.failedToLoad' => 'Gagal memuat transaksi',
			'transactions.cancel' => 'Batal',
			'transactions.delete' => 'Hapus',
			'transactions.goToToday' => 'Ke Hari Ini',
			'transactions.addItem' => 'Tambah Item',
			'transactions.saveSplitTransaction' => 'Simpan Transaksi Terpisah',
			'transactions.transactionType' => 'Tipe Transaksi',
			'transactions.applyFilter' => 'Terapkan Filter',
			'transactions.noAccountsAvailable' => 'Tidak ada akun yang tersedia',
			'transactions.account' => 'Akun',
			'transactions.category' => 'Kategori',
			'transactions.done' => 'Selesai',
			'transactions.save' => 'Simpan',
			'transactions.transactions' => 'Transaksi',
			'transactions.splitTransaction' => 'Pisah Transaksi',
			'transactions.from' => 'Dari',
			'transactions.to' => 'Ke',
			'transactions.empty' => '+/-',
			'transactions.filtered' => 'Difilter',
			'transactions.netBalance' => 'Saldo Bersih',
			'transactions.income' => 'Pemasukan',
			'transactions.expense' => 'Pengeluaran',
			'transactions.selectCategory' => 'Pilih Kategori',
			'transactions.filter' => 'Filter',
			'transactions.backToToday' => 'Kembali ke hari ini',
			'transactions.deleteTransaction' => 'Hapus Transaksi',
			'transactions.deleteTransactionWarning' => 'Menghapus transaksi ini akan mengembalikan saldo akun dan anggaran Anda ke keadaan sebelumnya.',
			'transactions.out' => 'Keluar ',
			'transactions.noTransactions' => 'Tidak ada transaksi',
			'transactions.addNote' => 'Tambah catatan',
			'transactions.noItemsYet' => 'Belum ada item',
			'transactions.tapAddItemToBeginSplittingntheTransaction' => 'Ketuk "Tambah Item" untuk mulai memisahkan\ntransaksi.',
			'transactions.addAtLeastOneMoreItemToSave' => 'Tambahkan setidaknya satu item lagi untuk menyimpan.',
			'transactions.noTransactions1' => 'Tidak Ada Transaksi',
			'transactions.reset' => 'Reset',
			'transactions.incoming' => 'Masuk ',
			'transactions.nothingRecordedFor' => ({required Object period}) => 'Belum ada catatan untuk ${period}.',
			'transactions.splitItems' => ({required Object count}) => '${count} item terpisah',
			'transactions.itemsCount' => ({required Object count}) => '${count} item',
			'transactions.transactionsCount' => ({required Object count}) => '${count} transaksi',
			'transactions.editTransaction' => 'Edit Transaksi',
			'transactions.newTransaction' => 'Transaksi Baru',
			'transactions.fromAccount' => 'Dari Akun',
			'transactions.toAccount' => 'Ke Akun',
			'transactions.need' => 'Kebutuhan',
			'transactions.want' => 'Keinginan',
			'transactions.saving' => 'Tabungan',
			'transactions.addNoteEllipsis' => 'Tambah catatan...',
			'transactions.editItem' => 'Edit Item',
			'transactions.newItem' => 'Item Baru',
			'transactions.viewModeDay' => 'Hari',
			'transactions.viewModeWeek' => 'Minggu',
			'transactions.viewModeMonth' => 'Bulan',
			'transactions.viewModeDaily' => 'Harian',
			'transactions.viewModeWeekly' => 'Mingguan',
			'transactions.viewModeMonthly' => 'Bulanan',
			'transactions.debt' => 'Utang',
			'transactions.recurring' => 'Berulang',
			'transactions.transfer' => 'Transfer',
			'transactions.weekNumber' => ({required Object weekNum, required Object date}) => 'Minggu ${weekNum} · ${date}',
			_ => null,
		};
	}
}
