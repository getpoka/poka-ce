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
class TranslationsMs extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsMs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ms,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ms>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsMs _root = this; // ignore: unused_field

	@override 
	TranslationsMs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsMs(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$accounts$ms accounts = _Translations$accounts$ms._(_root);
	@override late final _Translations$app$ms app = _Translations$app$ms._(_root);
	@override late final _Translations$backup$ms backup = _Translations$backup$ms._(_root);
	@override late final _Translations$budgets$ms budgets = _Translations$budgets$ms._(_root);
	@override late final _Translations$categories$ms categories = _Translations$categories$ms._(_root);
	@override late final _Translations$common$ms common = _Translations$common$ms._(_root);
	@override late final _Translations$dashboard$ms dashboard = _Translations$dashboard$ms._(_root);
	@override late final _Translations$debts$ms debts = _Translations$debts$ms._(_root);
	@override Map<String, String> get error => {
		'generic': 'Berlaku ralat yang tidak dijangka',
		'network': 'Sila semak sambungan anda dan cuba lagi',
		'database': 'Gagal mengakses data setempat',
	};
	@override late final _Translations$goals$ms goals = _Translations$goals$ms._(_root);
	@override late final _Translations$lock$ms lock = _Translations$lock$ms._(_root);
	@override late final _Translations$onboarding$ms onboarding = _Translations$onboarding$ms._(_root);
	@override late final _Translations$recurring$ms recurring = _Translations$recurring$ms._(_root);
	@override late final _Translations$reports$ms reports = _Translations$reports$ms._(_root);
	@override late final _Translations$settings$ms settings = _Translations$settings$ms._(_root);
	@override late final _Translations$shared$ms shared = _Translations$shared$ms._(_root);
	@override late final _Translations$transactions$ms transactions = _Translations$transactions$ms._(_root);
}

// Path: accounts
class _Translations$accounts$ms extends Translations$accounts$en {
	_Translations$accounts$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get accountName => 'Nama Akaun';
	@override String get pocketName => 'Nama Poket';
	@override String get initialBalance => 'Baki Awal';
	@override String get icon => 'Ikon';
	@override String get color => 'Warna';
	@override String get assets => 'Aset';
	@override String get liability => 'Liabiliti';
	@override String get income => 'Pendapatan';
	@override String get expense => 'Perbelanjaan';
	@override String get balance => 'Baki';
	@override String get walletsPockets => 'Dompet & Poket';
	@override String get accounts => 'Akaun';
	@override String get mainAccounts => 'Akaun Utama';
	@override String get deleteAccount => 'Padam Akaun';
	@override String get areYouSureYouWantToDeleteThisAccountItWillBeHiddenFromTheApp => 'Adakah anda pasti mahu memadam akaun ini? Akaun akan disembunyikan daripada aplikasi.';
	@override String get delete => 'Padam';
	@override String get account => 'Akaun';
	@override String get totalBalance => 'Jumlah Baki';
	@override String get pockets => 'Poket';
	@override String get deletePocket => 'Padam Poket';
	@override String get cannotDeleteMainPocket => 'Poket utama tidak boleh dipadam';
	@override String get mainPocket => 'Utama';
	@override String get areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp => 'Adakah anda pasti mahu memadam poket ini? Poket akan disembunyikan daripada aplikasi.';
	@override String get nameCannotBeEmpty => 'Nama tidak boleh kosong';
	@override String get egMainWallet => 'cth., Dompet Utama';
	@override String get egPocket => 'cth., Barangan Dapur, Percutian';
	@override String get selectIcon => 'Pilih Ikon';
	@override String get allowedCategories => 'Kategori yang Dibenarkan';
	@override String get transactions => 'Transaksi';
	@override String get editAccount => 'Edit Akaun';
	@override String get editPocket => 'Edit Poket';
	@override String get updateNameIconOrColor => 'Kemas kini nama, ikon atau warna';
	@override String get permanentlyRemoveThisAccount => 'Buang akaun ini secara kekal';
	@override String get seeAll => 'Lihat Semua';
	@override String get noTransactionsYet => 'Belum ada transaksi';
	@override String get accountTransactionsSubtitle => 'Transaksi yang direkodkan dalam akaun ini akan dipaparkan di sini.';
	@override String get pocketTransactionsSubtitle => 'Transaksi yang direkodkan dalam poket ini akan dipaparkan di sini.';
	@override String get addAccount => 'Tambah Akaun';
	@override String get noAccountsFound => 'Tiada akaun ditemui.';
	@override String get addPocket => 'Tambah Poket';
	@override String get noPocketsYet => 'Belum ada poket';
	@override String get pocketsHelpYouSplitYourWalletIntoCategories => 'Poket membantu anda membahagikan dompet kepada beberapa kategori. Baki anda akan dipindahkan secara automatik ke poket "Utama".';
	@override String get activeAccount => 'Akaun Aktif';
	@override String get inactiveAccountsWillBeHidden => 'Akaun tidak aktif akan disembunyikan';
	@override String get noCategoriesAvailable => 'Tiada kategori tersedia.';
	@override String get noAccountsFound1 => 'Tiada akaun ditemui';
	@override String subcategoriesCount({required Object count}) => '${count} subkategori';
	@override String pocketsCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ms'))(count,
		one: '1 poket',
		other: '${count} poket',
	);
	@override String get totalActiveAccounts => 'Jumlah Akaun Aktif';
	@override String get noAccountsYet => 'Belum Ada Akaun';
	@override String get tapTheButtonBelowToAddYourFirstAccount => 'Ketik butang di bawah untuk menambah akaun pertama anda';
	@override String get allCategoriesAllowed => 'Semua kategori dibenarkan';
	@override String categoriesSelected({required Object count}) => '${count} kategori dipilih';
	@override String ratioOfAccount({required Object percent}) => '${percent}% daripada akaun';
	@override String get noMainAccountsYet => 'Belum ada akaun utama.';
	@override String percentOfAssets({required Object percent}) => '${percent}% daripada aset';
	@override String get recentTransactions => 'Transaksi Terkini';
	@override String recentTransactionsCount({required Object count}) => 'Transaksi Terkini (${count})';
	@override String get reconcileBalance => 'Selaraskan Baki';
	@override String get reconcileBalanceSubtitle => 'Selaraskan baki aplikasi dengan baki sebenar akaun';
	@override String get currentBalanceInPoka => 'Baki dalam Poka';
	@override String get actualBalance => 'Baki Sebenar';
	@override String get difference => 'Perbezaan';
	@override String get adjustmentExpense => 'Pelarasan (Perbelanjaan)';
	@override String get adjustmentIncome => 'Pelarasan (Pendapatan)';
	@override String get balanceAdjustment => 'Pelarasan Baki';
	@override String get saveAdjustment => 'Simpan Pelarasan';
	@override String get balancesMatch => 'Baki sepadan, tiada pelarasan diperlukan';
	@override String get noteOptional => 'Catatan (Pilihan)';
	@override String get reconcileAccount => 'Selaraskan Baki Akaun';
}

// Path: app
class _Translations$app$ms extends Translations$app$en {
	_Translations$app$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Poka';
	@override String get tagline => 'Rakan kewangan peribadi anda';
	@override late final _Translations$app$nav$ms nav = _Translations$app$nav$ms._(_root);
	@override String get termsOfService => 'Terma Perkhidmatan';
	@override String get privacyPolicy => 'Dasar Privasi';
}

// Path: backup
class _Translations$backup$ms extends Translations$backup$en {
	_Translations$backup$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sandaran & Pemulihan';
	@override String get backupAction => 'Sandarkan';
	@override String get restoreAction => 'Pulihkan';
	@override String get password => 'Kata Laluan';
	@override String get confirmPassword => 'Sahkan Kata Laluan';
	@override String get passwordsDoNotMatch => 'Kata laluan tidak sepadan';
	@override String get backupSuccess => 'Sandaran berjaya';
	@override String get restoreSuccess => 'Pemulihan berjaya';
	@override String get incorrectPassword => 'Kata laluan salah atau fail rosak';
	@override String get enterPasswordToEncrypt => 'Masukkan kata laluan untuk menyulitkan sandaran';
	@override String get enterPasswordToDecrypt => 'Masukkan kata laluan untuk menyahsulit sandaran';
	@override String get pleaseRestart => 'Sila mulakan semula aplikasi untuk mengguna pakai perubahan.';
	@override String get passwordRequired => 'Kata laluan diperlukan';
	@override String get reminder => 'Peringatan Sandaran';
	@override String get reminderDesc => 'Ingatkan anda dari semasa ke semasa untuk menyandarkan data anda';
	@override String get reminderOff => 'Mati';
	@override String get reminderWeekly => 'Mingguan';
	@override String get reminderMonthly => 'Bulanan';
	@override String get reminderNotificationTitle => 'Masanya untuk Sandarkan Data Anda';
	@override String get reminderNotificationBody => 'Sudah lama sejak sandaran terakhir anda. Lindungi data kewangan anda dengan membuat sandaran sekarang.';
	@override String get reminderSaved => 'Peringatan sandaran dikemas kini';
	@override String get restoreWarningDesc => 'Memulihkan sandaran akan menggantikan semua data semasa dengan data daripada fail sandaran yang dipilih. Sebarang perubahan yang belum disandarkan akan hilang. Adakah anda mahu meneruskan?';
	@override String get sendTestNotification => 'Hantar Notifikasi Ujian';
	@override String get testNotificationSent => 'Notifikasi peringatan ujian dihantar';
	@override String get permissionRationaleTitle => 'Peringatan Sandaran Setempat';
	@override String get permissionRationaleDesc => 'Poka memerlukan kebenaran notifikasi untuk mengingatkan anda menyandarkan data dari semasa ke semasa. Peringatan berjalan sepenuhnya di luar talian pada peranti anda tanpa sebarang penjejakan atau analitik.';
	@override String get allowNotifications => 'Benarkan Notifikasi';
	@override String get permissionDenied => 'Kebenaran notifikasi telah ditolak. Peringatan kekal dimatikan.';
}

// Path: budgets
class _Translations$budgets$ms extends Translations$budgets$en {
	_Translations$budgets$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get budgetName => 'Nama belanjawan';
	@override String get spendingLimit => 'Had perbelanjaan';
	@override String get period => 'Tempoh';
	@override String get resetDay => 'Hari set semula (1–31)';
	@override String get createBudget => 'Cipta Belanjawan';
	@override String get endDate => 'Tarikh Tamat';
	@override String get budgetDetails => 'Butiran Belanjawan';
	@override String get deleteBudget => 'Padam Belanjawan';
	@override String get areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone => 'Adakah anda pasti mahu memadam belanjawan ini? Semua sejarah penjejakan yang berkaitan akan dipadam secara kekal. Tindakan ini tidak boleh diundurkan.';
	@override String get delete => 'Padam';
	@override String get transactions => 'Transaksi';
	@override String get budgets => 'Belanjawan';
	@override String get allBudgets => 'Semua Belanjawan';
	@override String get egGroceriesEntertainment => 'cth., Barangan Dapur, Hiburan';
	@override String get eg80 => 'cth., 80';
	@override String get category => 'Kategori';
	@override String get account => 'Akaun';
	@override String get overLimit => 'Melebihi had';
	@override String get remaining => 'Baki';
	@override String get totalSpent => 'Jumlah dibelanjakan';
	@override String get totalLimit => 'Jumlah had';
	@override String get selectEndDate => 'Pilih tarikh tamat';
	@override String get noTransactionsFoundForThisBudgetPeriod => 'Tiada transaksi ditemui untuk tempoh belanjawan ini.';
	@override String get budgetTransactionsSubtitle => 'Transaksi yang sepadan dengan belanjawan ini akan dipaparkan di sini.';
	@override String get addBudget => 'Tambah Belanjawan';
	@override String get spent => 'Dibelanjakan ';
	@override String get noBudgetsYet => 'Belum ada belanjawan';
	@override String get setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod => 'Tetapkan had perbelanjaan untuk menjejaki ke mana wang anda dibelanjakan setiap tempoh.';
	@override String budgetAlert({required Object name}) => 'Amaran Belanjawan: ${name}';
	@override String percentOf({required Object percent}) => '${percent}% daripada ';
	@override String budgetsCount({required Object count}) => '${count} belanjawan';
	@override String get editBudget => 'Edit Belanjawan';
	@override String get newBudget => 'Belanjawan Baharu';
	@override String get nameCannotBeEmpty => 'Nama tidak boleh kosong';
	@override String get amountGreaterThanZero => 'Jumlah mestilah melebihi 0';
	@override String get alertThresholdLabel => 'Ambang amaran (%)';
	@override String get scope => 'Skop';
	@override String get anyCategory => 'Sebarang kategori';
	@override String get anyAccount => 'Sebarang akaun';
	@override String get saveChanges => 'Simpan Perubahan';
	@override String get periodWeekly => 'Mingguan';
	@override String get periodMonthly => 'Bulanan';
	@override String get periodYearly => 'Tahunan';
	@override String get periodCustom => 'Tersuai';
	@override String budgetExceededAlert({required Object percentage, required Object name}) => 'Anda telah menggunakan ${percentage}% daripada belanjawan ${name} anda.';
}

// Path: categories
class _Translations$categories$ms extends Translations$categories$en {
	_Translations$categories$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get expense => 'Perbelanjaan';
	@override String get income => 'Pendapatan';
	@override String get categoryName => 'Nama Kategori';
	@override String get icon => 'Ikon';
	@override String get color => 'Warna';
	@override String get noCategoriesFound => 'Tiada kategori ditemui.';
	@override String get subcategories => 'Subkategori';
	@override String get categories => 'Kategori';
	@override String get egFoodDining => 'cth., Makanan & Minuman';
	@override String get deleteCategory => 'Padam Kategori';
	@override String get delete => 'Padam';
	@override String get selectIcon => 'Pilih Ikon';
	@override String get noSubcategoriesYet => 'Belum ada subkategori';
	@override String get noCategoriesFound1 => 'Tiada kategori ditemui';
	@override String subcategoriesCount({required Object count}) => '${count} subkategori';
	@override String get addSubcategory => 'Tambah Subkategori';
	@override String get addCategory => 'Tambah Kategori';
	@override String get emptyCategorySubtitle => 'Mula jejaki perbelanjaan anda dengan menambah kategori';
	@override String get emptySubcategorySubtitle => 'Pecahkan kategori anda kepada bahagian yang lebih kecil';
	@override String get saveSubCategory => 'Simpan Subkategori';
	@override String get saveCategory => 'Simpan Kategori';
	@override String get newSubCategory => 'Subkategori Baharu';
	@override String get newCategory => 'Kategori Baharu';
	@override String get editSubCategory => 'Edit Subkategori';
	@override String get editCategory => 'Edit Kategori';
	@override String deleteConfirmWithChildren({required Object count}) => 'Adakah anda pasti mahu memadam kategori ini? ${count} subkategorinya akan menjadi kategori utama, dan transaksinya sendiri akan menjadi tanpa kategori.';
	@override String get deleteConfirmNoChildren => 'Adakah anda pasti mahu memadam kategori ini? Semua transaksinya akan menjadi tanpa kategori.';
}

// Path: common
class _Translations$common$ms extends Translations$common$en {
	_Translations$common$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get save => 'Simpan';
	@override String get cancel => 'Batal';
	@override String get delete => 'Padam';
	@override String get edit => 'Edit';
	@override String get confirm => 'Sahkan';
	@override String get back => 'Kembali';
	@override String get loading => 'Memuatkan...';
	@override String get error => 'Berlaku ralat';
	@override String get retry => 'Cuba lagi';
	@override String get empty => 'Belum ada data';
	@override String get cannotBeUndone => 'Tindakan ini tidak boleh diundurkan.';
	@override String get pleaseWait => 'Sila tunggu';
	@override String get today => 'Hari ini';
	@override String get yesterday => 'Semalam';
	@override String get dueToday => 'Perlu hari ini';
	@override String get overdue => 'Tertunggak';
	@override String get uncategorized => 'Tanpa Kategori';
	@override String get unknown => 'Tidak diketahui';
	@override String get notSet => 'Belum Ditetapkan';
	@override String get undo => 'Buat Asal';
}

// Path: dashboard
class _Translations$dashboard$ms extends Translations$dashboard$en {
	_Translations$dashboard$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get overview => 'Gambaran Keseluruhan';
	@override String get myFinances => 'Kewangan Saya';
	@override String get netWorth => 'Nilai Bersih';
	@override String accountsCount({required Object count}) => '${count} akaun';
	@override String get assets => 'Aset';
	@override String get liabilities => 'Liabiliti';
	@override String get budgets => 'Belanjawan';
	@override String get categories => 'Kategori';
	@override String get goals => 'Matlamat';
	@override String get debts => 'Hutang';
	@override String get recurring => 'Berulang';
	@override String get cashFlow => 'Aliran Tunai';
	@override String get budget => 'Belanjawan';
	@override String get needs => 'Keperluan (50%)';
	@override String get wants => 'Kehendak (30%)';
	@override String get savings => 'Simpanan (20%)';
	@override String get saved => 'disimpan';
	@override String get onTrack => 'Baik';
	@override String get needsAttention => 'Perlu perhatian';
	@override String get income => 'Pendapatan';
	@override String get expense => 'Perbelanjaan';
	@override String get other => 'Lain-lain';
	@override String get noData => 'Tiada data';
	@override String get spendingActivity => 'Aktiviti Perbelanjaan';
	@override String get total => 'Jumlah';
	@override String get average => 'Purata';
	@override String get budgetPerDay => 'Belanjawan/Hari';
	@override String get todaysBudget => 'Belanjawan Hari Ini';
	@override String get overbudget => 'Melebihi belanjawan!';
	@override String get setDailyBudget => 'Tetapkan Belanjawan Harian';
	@override String get amount => 'Jumlah';
	@override String get amountHint => 'cth. 100000';
	@override String get recentTransactions => 'Transaksi Terkini';
	@override String get thisMonth => 'Bulan ini';
	@override String get noRecentTransactions => 'Tiada transaksi terkini';
	@override String get recentTransactionsSubtitle => 'Transaksi yang baru anda rekodkan akan dipaparkan di sini.';
	@override String get seeAll => 'Lihat Semua';
	@override String get notSet => 'Belum ditetapkan';
	@override late final _Translations$dashboard$insight$ms insight = _Translations$dashboard$insight$ms._(_root);
	@override late final _Translations$dashboard$days$ms days = _Translations$dashboard$days$ms._(_root);
}

// Path: debts
class _Translations$debts$ms extends Translations$debts$en {
	_Translations$debts$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get addRepayment => 'Tambah Bayaran Balik';
	@override String get iOwe => 'Saya Berhutang';
	@override String get theyOwe => 'Mereka Berhutang';
	@override String get personName => 'Nama orang';
	@override String get principalAmount => 'Jumlah pokok';
	@override String get transactionBinding => 'Pautan Transaksi';
	@override String get cancel => 'Batal';
	@override String get save => 'Simpan';
	@override String get ok => 'OK';
	@override String get addRecord => 'Tambah Rekod';
	@override String get createRecord => 'Cipta Rekod';
	@override String get debtDetails => 'Butiran Hutang';
	@override String get repaymentHistory => 'Sejarah Bayaran Balik';
	@override String get debtsLoans => 'Hutang & Pinjaman';
	@override String get deleteDebt => 'Padam Hutang';
	@override String get delete => 'Padam';
	@override String get writeoffDebt => 'Hapus Kira Hutang';
	@override String get areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances => 'Adakah anda pasti mahu menghapus kira hutang ini? Hutang akan ditandakan sebagai dijelaskan tanpa menjejaskan baki dompet anda.';
	@override String get writeoff => 'Hapus Kira';
	@override String get egJohnDoe => 'cth., John Doe';
	@override String get category => 'Kategori';
	@override String get account => 'Akaun';
	@override String get egDinnerLastFriday => 'cth., Makan malam Jumaat lepas';
	@override String get selectDueDate => 'Pilih tarikh akhir';
	@override String get outstanding => 'Belum Selesai';
	@override String get paid => 'Dibayar';
	@override String get principal => 'Pokok';
	@override String get actionDenied => 'Tindakan Ditolak';
	@override String get paymentCannotExceedRemaining => 'Jumlah bayaran tidak boleh melebihi baki hutang.';
	@override String get addNote => 'Tambah catatan';
	@override String get payInFull => 'Bayar Penuh';
	@override String get remaining => 'berbaki';
	@override String get paid1 => 'Dibayar ';
	@override String reminder({required Object type, required Object name}) => 'Peringatan ${type}: ${name}';
	@override String due({required Object type, required Object name}) => '${type} Tamat Tempoh: ${name}';
	@override String noHistoryFoundForThis({required Object type}) => 'Tiada sejarah ditemui untuk ${type} ini';
	@override String repaymentHistorySubtitle({required Object type}) => 'Rekod bayaran atau ansuran untuk ${type} ini akan dipaparkan di sini.';
	@override String failedToLoadDebts({required Object error}) => 'Gagal memuatkan hutang: ${error}';
	@override String percentOf({required Object percent}) => '${percent}% daripada ';
	@override String settled({required Object count}) => '${count} selesai';
	@override String get payable => 'Belum Bayar';
	@override String get receivable => 'Belum Terima';
	@override String get noDebtsRecorded => 'Tiada hutang direkodkan';
	@override String get noLoansRecorded => 'Tiada pinjaman direkodkan';
	@override String get trackMoneyYouOweToOthersAndLogRepayments => 'Jejaki wang yang anda hutang kepada orang lain dan rekodkan semua bayaran balik di sini.';
	@override String get trackMoneyOthersOweYouAndLogCollections => 'Jejaki wang yang orang lain hutang kepada anda dan rekodkan semua kutipan di sini.';
	@override String get editRecord => 'Edit Rekod';
	@override String get newRecord => 'Rekod Baharu';
	@override String get personNameCannotBeEmpty => 'Nama orang tidak boleh kosong';
	@override String get amountGreaterThanZero => 'Jumlah mestilah melebihi 0';
	@override String get selectCategoryAndAccount => 'Sila pilih kategori dan akaun';
	@override String get selectCategoryPrompt => 'Pilih kategori';
	@override String get selectAccountPrompt => 'Pilih akaun';
	@override String get debtBindingHelp => 'Merekod hutang ini menambah wang ke akaun (transaksi pendapatan).';
	@override String get loanBindingHelp => 'Merekod pinjaman ini mengeluarkan wang dari akaun (transaksi perbelanjaan).';
	@override String get noteLabel => 'Catatan';
	@override String get dueDateLabel => 'Tarikh Akhir';
	@override String get saveChanges => 'Simpan Perubahan';
	@override String deleteConfirm({required Object type}) => 'Adakah anda pasti mahu memadam ${type} ini? Rekod akan dipadam secara kekal. Tindakan ini tidak boleh diundurkan.';
	@override String debtDetailsTitle({required Object type}) => 'Butiran ${type}';
	@override String get debtTypeLoan => 'Pinjaman';
	@override String get debtTypeDebt => 'Hutang';
	@override String reminderAlert({required Object type, required Object amount, required Object action, required Object when}) => '${type} sebanyak ${amount} perlu ${action} ${when}.';
	@override String overdueAlert({required Object type, required Object amount, required Object action}) => '${type} sebanyak ${amount} telah tertunggak dan perlu ${action} dengan segera.';
	@override String get actionCollect => 'dikutip';
	@override String get actionPay => 'dibayar';
	@override String get today => 'hari ini';
	@override String inDays({required Object days}) => 'dalam masa ${days} hari';
	@override String owedCount({required Object count}) => '${count} perlu dibayar';
	@override String receivableCount({required Object count}) => '${count} perlu dikutip';
}

// Path: goals
class _Translations$goals$ms extends Translations$goals$en {
	_Translations$goals$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get goals => 'Matlamat';
	@override String get fulfillGoal => 'Capai Matlamat (Belanja)';
	@override String get goalName => 'Nama matlamat';
	@override String get targetAmount => 'Jumlah sasaran';
	@override String get createGoal => 'Cipta Matlamat';
	@override String errorPrefix({required Object error}) => 'Ralat: ${error}';
	@override String get goalDetails => 'Butiran Matlamat';
	@override String get transactions => 'Transaksi';
	@override String get active => 'Aktif';
	@override String get past => 'Lepas';
	@override String get actionDenied => 'Tindakan Ditolak';
	@override String get emptyBalanceBeforeDelete => 'Kosongkan baki (pindahkan keluar) sebelum memadam Matlamat ini.';
	@override String get ok => 'OK';
	@override String get deleteGoal => 'Padam Matlamat';
	@override String get areYouSureYouWantToDeleteThisGoalTheAssociatedPocketAccountAndItsHistoryWillAlsoBeRemovedThisActionCannotBeUndone => 'Adakah anda pasti mahu memadam matlamat ini? Akaun poket yang berkaitan dan sejarahnya juga akan dibuang. Tindakan ini tidak boleh diundurkan.';
	@override String get delete => 'Padam';
	@override String get egEmergencyFundNewLaptop => 'cth., Dana Kecemasan, Komputer Riba Baharu';
	@override String get completed => 'Selesai';
	@override String get fullyFunded => 'Cukup dibiayai';
	@override String get inProgress => 'Sedang berjalan';
	@override String get totalSaved => 'Jumlah Terkumpul';
	@override String get stillNeeded => 'Masih diperlukan';
	@override String get totalTarget => 'Jumlah sasaran';
	@override String get selectTargetDate => 'Pilih tarikh sasaran';
	@override String get noTransactionsFoundForThisGoal => 'Tiada transaksi ditemui untuk matlamat ini.';
	@override String get goalTransactionsSubtitle => 'Pindahan atau simpanan yang direkodkan untuk matlamat ini akan dipaparkan di sini.';
	@override String get addGoal => 'Tambah Matlamat';
	@override String get aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal => 'Akaun Poket khusus akan dicipta secara automatik untuk menjejaki matlamat ini.';
	@override String get saved => 'tersimpan';
	@override String get needs => 'Memerlukan ';
	@override String get more => ' lagi';
	@override String get noGoalsYet => 'Belum ada matlamat';
	@override String get setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal => 'Tetapkan sasaran simpanan — poket khusus dicipta secara automatik untuk setiap matlamat.';
	@override String percentOfTarget({required Object percent}) => '${percent}% daripada sasaran';
	@override String goalsCount({required Object count}) => '${count} matlamat';
	@override String fullyFundedCount({required Object count}) => '${count} cukup dibiayai';
	@override String get noCompletedGoalsYet => 'Belum ada matlamat yang selesai';
	@override String get completedGoalsWillAppearHere => 'Matlamat yang anda capai akan dipaparkan di sini.';
	@override String get editGoal => 'Edit Matlamat';
	@override String get newGoal => 'Matlamat Baharu';
	@override String get nameCannotBeEmpty => 'Nama tidak boleh kosong';
	@override String get targetAmountGreaterThanZero => 'Jumlah sasaran mestilah melebihi 0';
	@override String get saveChanges => 'Simpan Perubahan';
	@override String get targetDateLabel => 'Tarikh Sasaran';
	@override String get activeGoals => 'Matlamat Aktif';
	@override String get completedGoals => 'Matlamat Selesai';
	@override String get noActiveGoalsYet => 'Belum ada matlamat aktif';
	@override String get noActiveGoalsSubtitle => 'Cipta matlamat baharu untuk mula menyimpan bagi pencapaian anda yang seterusnya.';
	@override String get saveInAccount => 'Simpan dalam Akaun';
	@override String get selectAccount => 'Pilih Akaun';
	@override String get accountRequired => 'Sila pilih akaun';
	@override String storedIn({required Object account}) => 'Disimpan dalam ${account}';
}

// Path: lock
class _Translations$lock$ms extends Translations$lock$en {
	_Translations$lock$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get confirmPin => 'Sahkan PIN';
	@override String get createPin => 'Buat PIN';
	@override String get pinsDoNotMatch => 'PIN tidak sepadan';
	@override String get reenterPin => 'Masukkan semula PIN';
	@override String get enterPinAppLock => 'Masukkan PIN untuk Kunci Aplikasi';
	@override String get incorrectPin => 'PIN salah';
	@override String get verifyIdentity => 'Sahkan Identiti';
	@override String retryInSeconds({required Object seconds}) => 'Cuba lagi dalam ${seconds} saat';
	@override String get setupPinTitle => 'Tetapkan PIN';
	@override String get setupPinBody => 'Sila cipta PIN terlebih dahulu sebelum mendayakan Kunci Aplikasi atau Biometrik.';
	@override String get unlocked => 'Dibuka';
	@override String get enter6DigitPin => 'Masukkan PIN 6-digit';
	@override String get enterPin => 'Masukkan PIN';
	@override String get invalidPin => 'PIN tidak sah';
	@override String get tooManyAttempts => 'Terlalu banyak cubaan';
	@override String get temporarilyLocked => 'Disekat sementara';
	@override String get authenticateReason => 'Sahkan untuk mengakses Poka';
}

// Path: onboarding
class _Translations$onboarding$ms extends Translations$onboarding$en {
	_Translations$onboarding$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get continueWithCurrency => 'Teruskan dengan mata wang terpilih';
	@override String get chooseYourBaseCurrency => 'Pilih Mata Wang Asas Anda';
	@override String get thisCurrencyWillBeUsedForAllAccountsPocketsAndTransactionsYouCanChangeThisLaterInSettings => 'Mata wang ini akan digunakan untuk semua akaun, poket dan transaksi. Anda boleh menukarnya kemudian dalam tetapan.';
}

// Path: recurring
class _Translations$recurring$ms extends Translations$recurring$en {
	_Translations$recurring$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get addSchedule => 'Tambah Jadual';
	@override String get transactionDetails => 'Butiran Transaksi';
	@override String get amount => 'Jumlah';
	@override String get frequency => 'Kekerapan';
	@override String get startDate => 'Tarikh Mula';
	@override String get recurring => 'Berulang';
	@override String get schedules => 'Jadual';
	@override String get scheduleDetails => 'Butiran Jadual';
	@override String get deleteSchedule => 'Padam Jadual';
	@override String get areYouSureYouWantToDeleteThisRecurringScheduleExistingGeneratedTransactionsWillNotBeDeleted => 'Adakah anda pasti mahu memadam jadual berulang ini? Transaksi yang telah dijana tidak akan dipadam.';
	@override String get delete => 'Padam';
	@override String get triggerHistory => 'Sejarah Cetusan';
	@override String get destinationAccount => 'Akaun Destinasi';
	@override String get category => 'Kategori';
	@override String get egNetflixSubscription => 'cth., Langganan Netflix';
	@override String get selectFirstDueDate => 'Pilih tarikh akhir pertama';
	@override String get estMonthlyNet => 'Angg. Bersih Bulanan';
	@override String get monthlyIn => 'Masuk Bulanan';
	@override String get monthlyOut => 'Keluar Bulanan';
	@override String get noRecurringTransactions => 'Tiada transaksi berulang';
	@override String get automateBillsLikeSubscriptionsOrSalary => 'Automasi bil seperti langganan atau gaji. Aplikasi akan merekodkannya mengikut jadual.';
	@override String get noHistoryFoundForThisSchedule => 'Tiada sejarah ditemui untuk jadual ini.';
	@override String get scheduleHistorySubtitle => 'Transaksi yang dijana daripada jadual ini akan dipaparkan di sini.';
	@override String get allocation => 'Peruntukan';
	@override String get active => 'Aktif';
	@override String get eachTimeTheAppOpensOverdueRecurringTransactionsAre => 'Setiap kali aplikasi dibuka, transaksi berulang yang tertunggak akan direkodkan secara automatik dalam lejar anda.';
	@override String schedulesCount({required Object count}) => '${count} jadual';
	@override String pausedCount({required Object count}) => '${count} dijeda';
	@override String get editRecurring => 'Edit Berulang';
	@override String get newRecurring => 'Berulang Baharu';
	@override String get mustSelectAccount => 'Mesti memilih akaun';
	@override String get sourceAccount => 'Akaun Sumber';
	@override String get account => 'Akaun';
	@override String get selectAccountPrompt => 'Pilih akaun';
	@override String get selectDestinationPrompt => 'Pilih destinasi';
	@override String get selectCategoryOptional => 'Pilih kategori (pilihan)';
	@override String get noteLabel => 'Catatan';
	@override String get saveChanges => 'Simpan Perubahan';
	@override String get createRecurring => 'Cipta Berulang';
	@override String get amountGreaterThanZero => 'Jumlah mestilah melebihi 0';
	@override String get mustSelectStartDate => 'Mesti memilih tarikh mula';
	@override String get periodDaily => 'Harian';
	@override String get periodWeekly => 'Mingguan';
	@override String get periodMonthly => 'Bulanan';
	@override String get periodYearly => 'Tahunan';
	@override String get autoGenerateActive => 'Akan menjana transaksi secara automatik';
	@override String get autoGeneratePaused => 'Dijeda — tiada transaksi akan dijana';
	@override String get recurringIncome => 'Pendapatan Berulang';
	@override String get recurringExpense => 'Perbelanjaan Berulang';
	@override String get recurringTransfer => 'Pindahan Berulang';
	@override String nextDateLabel({required Object date}) => 'Seterusnya: ${date}';
}

// Path: reports
class _Translations$reports$ms extends Translations$reports$en {
	_Translations$reports$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Laporan';
	@override String get overview => 'Gambaran Kewangan';
	@override String get tabCashflow => 'Aliran Tunai';
	@override String get tabBudgets => 'Belanjawan & Matlamat';
	@override String get period => 'Tempoh';
	@override String get thisMonth => 'Bulan Ini';
	@override String get lastMonth => 'Bulan Lepas';
	@override String get last3Months => '3 Bulan';
	@override String get last6Months => '6 Bulan';
	@override String get custom => 'Tersuai';
	@override String get income => 'Pendapatan';
	@override String get expense => 'Perbelanjaan';
	@override String get netSavings => 'Simpanan Bersih';
	@override String get netCashflow => 'Aliran Tunai Bersih';
	@override String get cashflow => 'Aliran Tunai';
	@override String get savingsRate => 'Kadar Simpanan';
	@override String get topCategories => 'Kategori Teratas';
	@override String get topExpenses => 'Perbelanjaan Tertinggi';
	@override String get topIncome => 'Pendapatan Tertinggi';
	@override String get monthlyTrend => 'Aliran Bulanan';
	@override String get cashflowTrend => 'Aliran Pendapatan vs Perbelanjaan';
	@override String get budgetBreakdown => 'Pecahan Belanjawan';
	@override String get budgetUtilization => 'Penggunaan Belanjawan';
	@override String get spendingAllocation => 'Peruntukan Perbelanjaan';
	@override String get noData => 'Tiada data untuk tempoh ini';
	@override String get noExpenseDataDesc => 'Rekod transaksi perbelanjaan untuk melihat peruntukan perbelanjaan anda.';
	@override String get noBudgets => 'Belum ada belanjawan ditetapkan';
	@override String get noBudgetsDesc => 'Tambah belanjawan untuk menjejaki had perbelanjaan anda';
	@override String get onTrack => 'Mengikut landasan';
	@override String get needsAttention => 'Perlu perhatian';
	@override String get overBudget => 'Melebihi belanjawan';
	@override String get onBudget => 'Dalam had';
	@override String get needs => 'Keperluan';
	@override String get wants => 'Kehendak';
	@override String get savings => 'Simpanan';
	@override String get other => 'Lain-lain';
	@override String get total => 'Jumlah';
	@override String get average => 'Purata';
	@override String get remaining => 'Baki';
	@override String get spent => 'Dibelanjakan';
	@override String get limit => 'Had';
	@override String txCount({required Object count}) => '${count} transaksi';
	@override String get selectDateRange => 'Pilih Julat Tarikh';
	@override String get apply => 'Guna';
	@override String get from => 'Dari';
	@override String get to => 'Hingga';
	@override String comparedTo({required Object period}) => 'vs ${period}';
	@override String get higher => 'lebih tinggi';
	@override String get lower => 'lebih rendah';
	@override String get same => 'sama seperti';
	@override String get noChange => 'Tiada perubahan';
	@override String get percent50 => '50%';
	@override String get percent30 => '30%';
	@override String get percent20 => '20%';
	@override String get rule503020 => '50/30/20';
	@override String get prevLastMonth => 'bulan lepas';
	@override String get prevMonth => 'bulan sebelumnya';
	@override String get prev3Months => '3 bln lepas';
	@override String get prev6Months => '6 bln lepas';
	@override String get prevPeriod => 'tempoh lepas';
	@override String get exportExcel => 'Eksport ke Excel';
	@override String get exportExcelSuccess => 'Excel berjaya dieksport';
	@override String get exportExcelError => 'Gagal mengeksport fail Excel';
}

// Path: settings
class _Translations$settings$ms extends Translations$settings$en {
	_Translations$settings$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tetapan';
	@override String get preferences => 'Keutamaan';
	@override String get baseCurrency => 'Mata Wang Asas';
	@override String get theme => 'Tema';
	@override String get language => 'Bahasa';
	@override String get numberFormat => 'Format Nombor';
	@override String get selectNumberFormat => 'Pilih Format Nombor';
	@override String get formatSystem => 'Lalai Aplikasi';
	@override String get formatId => '1.000.000,00';
	@override String get formatUs => '1,000,000.00';
	@override String get formatFr => '1 000 000,00';
	@override String get system => 'Sistem';
	@override String get english => 'English';
	@override String get indonesia => 'Indonesia';
	@override String get malay => 'Bahasa Melayu';
	@override String get vietnam => 'Tiếng Việt';
	@override String get security => 'Keselamatan';
	@override String get appLock => 'Kunci Aplikasi';
	@override String get appLockDesc => 'Lindungi aplikasi dengan PIN';
	@override String get biometrics => 'Biometrik';
	@override String get biometricsDesc => 'Gunakan cap jari untuk membuka kunci';
	@override String get dataManagement => 'Pengurusan Data';
	@override String get backupRestore => 'Sandaran & Pemulihan';
	@override String get backupRestoreDesc => 'Simpan atau pulihkan data anda';
	@override String get clearOld => 'Padam Transaksi Lama';
	@override String get clearOldDesc => 'Buang transaksi yang lebih lama daripada 1 tahun';
	@override String get resetData => 'Tetapkan Semula Data';
	@override String get resetDataDesc => 'Padam semua data aplikasi setempat';
	@override String get support => 'Sokongan';
	@override String get faq => 'FAQ';
	@override String get faqDesc => 'Soalan Lazim';
	@override String get about => 'Tentang Poka CE';
	@override String get aboutDesc => 'Versi dan maklumat undang-undang';
	@override String get selectTheme => 'Pilih Tema';
	@override String get themeLight => 'Cerah';
	@override String get themeDark => 'Gelap';
	@override String get selectLanguage => 'Pilih Bahasa';
	@override String get oldTransactionsCleared => 'Transaksi lama berjaya dibersihkan';
	@override String get appDataReset => 'Data aplikasi berjaya ditetapkan semula';
	@override String get failedToExportLogs => 'Gagal mengeksport log';
	@override String easterEggRemaining({required Object remaining}) => '${remaining} ketikan lagi untuk kejutan...';
	@override String get easterEggFound => '🎉 Anda menemui easter egg!';
	@override String get selectCurrency => 'Pilih Mata Wang';
	@override String get openSourceLicenses => 'Lesen Sumber Terbuka';
	@override String get checkForUpdates => 'Semak Kemas Kini';
	@override String get viewLatestReleasesOnGithub => 'Lihat keluaran terkini di GitHub';
	@override String get helpIssues => 'Bantuan & Isu';
	@override String get reportBugsOrRequestFeatures => 'Laporkan pepijat atau cadangkan ciri';
	@override String get legal => 'Undang-undang';
	@override String get termsOfService => 'Terma Perkhidmatan';
	@override String get readOurTermsAndConditions => 'Baca terma dan syarat kami';
	@override String get privacyPolicy => 'Dasar Privasi';
	@override String get learnHowWeHandleYourData => 'Ketahui cara kami mengendalikan data anda';
	@override String get viewThirdpartySoftwareLicenses => 'Lihat lesen perisian pihak ketiga';
	@override String get advanced => 'Lanjutan';
	@override String get exportDebugLogs => 'Eksport Log Nyahpepijat';
	@override String get shareErrorLogsForTroubleshooting => 'Kongsi log ralat untuk penyelesaian masalah';
	@override String get search => 'Cari...';
	@override String get errorLoadingContent => 'Ralat memuatkan kandungan';
	@override String get noLicensesFound => 'Tiada lesen ditemui';
	@override String get pokaCe => 'Poka CE';
	@override String get communityEdition => 'Edisi Komuniti';
	@override String get aboutDescription => 'Pengurus kewangan peribadi sumber terbuka dan percuma yang direka untuk membantu anda menjejaki perbelanjaan, mengurus belanjawan dan memantau akaun anda secara setempat.';
	@override String get copyright => '© 2026 POKA. All rights reserved.';
	@override String get noResultsFound => 'Tiada Hasil Ditemui';
	@override String get weCouldntFindAnyCurrencyMatching => 'Kami tidak menemui mata wang yang sepadan dengan "{search}".';
	@override String get notSet => 'Belum Ditetapkan';
	@override String get exportExcel => 'Eksport ke Excel';
	@override String get exportExcelDesc => 'Eksport transaksi, akaun dan kategori ke .xlsx';
	@override String get exportExcelSuccess => 'Excel berjaya dieksport';
	@override String get exportExcelError => 'Gagal mengeksport fail Excel';
	@override String get currencyLockedToast => 'Mata wang tidak boleh ditukar selepas transaksi direkodkan. Sila tetapkan semula data jika anda mahu menukarnya.';
}

// Path: shared
class _Translations$shared$ms extends Translations$shared$en {
	_Translations$shared$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get authRequired => 'Pengesahan Diperlukan';
	@override String get hexColorCode => 'Kod Warna Hex';
	@override String get apply => 'Guna';
	@override String get enterAmount => 'Masukkan Jumlah';
	@override String get selectCategory => 'Pilih Kategori';
	@override String get egFf5733 => 'cth., FF5733';
	@override String get amount => 'Jumlah';
	@override String get noCategoriesAvailable => 'Tiada kategori tersedia.';
	@override String get noWalletsFoundPleaseCreateOneFirst => 'Tiada dompet ditemui. Sila cipta satu dahulu.';
	@override String get balance => 'Baki: ';
	@override String get optional => 'Pilihan';
	@override String get customColor => 'Warna Tersuai';
	@override String get selectWallet => 'Pilih Dompet';
}

// Path: transactions
class _Translations$transactions$ms extends Translations$transactions$en {
	_Translations$transactions$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get searchTransactions => 'Cari transaksi...';
	@override String get failedToLoad => 'Gagal memuatkan transaksi';
	@override String get cancel => 'Batal';
	@override String get delete => 'Padam';
	@override String get goToToday => 'Ke Hari Ini';
	@override String get addItem => 'Tambah Item';
	@override String get saveSplitTransaction => 'Simpan Transaksi Pecahan';
	@override String get transactionType => 'Jenis Transaksi';
	@override String get applyFilter => 'Guna Penapis';
	@override String get noAccountsAvailable => 'Tiada akaun tersedia';
	@override String get account => 'Akaun';
	@override String get category => 'Kategori';
	@override String get done => 'Siap';
	@override String get save => 'Simpan';
	@override String get transactions => 'Transaksi';
	@override String get splitTransaction => 'Pecah Transaksi';
	@override String get from => 'Dari';
	@override String get to => 'Ke';
	@override String get empty => '+/-';
	@override String get filtered => 'Ditapis';
	@override String get netBalance => 'Baki Bersih';
	@override String get income => 'Pendapatan';
	@override String get expense => 'Perbelanjaan';
	@override String get selectCategory => 'Pilih Kategori';
	@override String get filter => 'Tapis';
	@override String get backToToday => 'Kembali ke hari ini';
	@override String get deleteTransaction => 'Padam Transaksi';
	@override String get deleteTransactionWarning => 'Memadam transaksi ini akan mengembalikan baki akaun dan belanjawan anda kepada keadaan sebelumnya.';
	@override String get out => 'Keluar ';
	@override String get noTransactions => 'Tiada transaksi';
	@override String get addNote => 'Tambah catatan';
	@override String get noItemsYet => 'Belum ada item';
	@override String get tapAddItemToBeginSplittingntheTransaction => 'Ketik "Tambah Item" untuk mula memecahkan\ntransaksi.';
	@override String get addAtLeastOneMoreItemToSave => 'Tambah sekurang-kurangnya satu item lagi untuk menyimpan.';
	@override String get noTransactions1 => 'Tiada Transaksi';
	@override String get reset => 'Set Semula';
	@override String get incoming => 'Masuk ';
	@override String nothingRecordedFor({required Object period}) => 'Tiada rekod untuk ${period}.';
	@override String splitItems({required Object count}) => '${count} item pecahan';
	@override String itemsCount({required Object count}) => '${count} item';
	@override String transactionsCount({required Object count}) => '${count} transaksi';
	@override String get editTransaction => 'Edit Transaksi';
	@override String get newTransaction => 'Transaksi Baharu';
	@override String get fromAccount => 'Dari Akaun';
	@override String get toAccount => 'Ke Akaun';
	@override String get need => 'Keperluan';
	@override String get want => 'Kehendak';
	@override String get saving => 'Simpanan';
	@override String get addNoteEllipsis => 'Tambah catatan...';
	@override String get editItem => 'Edit Item';
	@override String get newItem => 'Item Baharu';
	@override String get viewModeDay => 'Hari';
	@override String get viewModeWeek => 'Minggu';
	@override String get viewModeMonth => 'Bulan';
	@override String get viewModeDaily => 'Harian';
	@override String get viewModeWeekly => 'Mingguan';
	@override String get viewModeMonthly => 'Bulanan';
	@override String get debt => 'Hutang';
	@override String get recurring => 'Berulang';
	@override String get transfer => 'Pindahan';
	@override String weekNumber({required Object weekNum, required Object date}) => 'Minggu ${weekNum} · ${date}';
	@override String get insufficientBalance => 'Baki Tidak Mencukupi';
	@override String insufficientBalanceWarning({required Object amount, required Object account, required Object balance}) => 'Jumlah (${amount}) melebihi baki semasa dalam ${account} (${balance}). Mungkin anda terlupa merekodkan pendapatan terlebih dahulu?';
	@override String get insufficientBalanceConsequence => 'Baki akaun anda akan menjadi negatif jika anda meneruskan.';
	@override String get continueAnyway => 'Teruskan Sahaja';
	@override String get checkAgain => 'Semak Semula';
	@override String get transactionDeleted => 'Transaksi dipadam';
	@override String get transactionRestored => 'Transaksi dipulihkan';
	@override String get allocation => 'Peruntukan';
}

// Path: app.nav
class _Translations$app$nav$ms extends Translations$app$nav$en {
	_Translations$app$nav$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get home => 'Laman Utama';
	@override String get transactions => 'Transaksi';
	@override String get reports => 'Laporan';
	@override String get accounts => 'Akaun';
	@override String get settings => 'Tetapan';
}

// Path: dashboard.insight
class _Translations$dashboard$insight$ms extends Translations$dashboard$insight$en {
	_Translations$dashboard$insight$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get noData => 'Tiada data bulan ini untuk dianalisis.';
	@override String get thisMonth => 'bulan ini ialah';
	@override String get up => 'meningkat';
	@override String get down => 'menurun';
	@override String get same => 'sama seperti';
	@override String get fromLastMonth => 'berbanding bulan lepas.';
}

// Path: dashboard.days
class _Translations$dashboard$days$ms extends Translations$dashboard$days$en {
	_Translations$dashboard$days$ms._(TranslationsMs root) : this._root = root, super.internal(root);

	final TranslationsMs _root; // ignore: unused_field

	// Translations
	@override String get mon => 'Isn';
	@override String get tue => 'Sel';
	@override String get wed => 'Rab';
	@override String get thu => 'Kha';
	@override String get fri => 'Jum';
	@override String get sat => 'Sab';
	@override String get sun => 'Aha';
}

/// The flat map containing all translations for locale <ms>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsMs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'accounts.accountName' => 'Nama Akaun',
			'accounts.pocketName' => 'Nama Poket',
			'accounts.initialBalance' => 'Baki Awal',
			'accounts.icon' => 'Ikon',
			'accounts.color' => 'Warna',
			'accounts.assets' => 'Aset',
			'accounts.liability' => 'Liabiliti',
			'accounts.income' => 'Pendapatan',
			'accounts.expense' => 'Perbelanjaan',
			'accounts.balance' => 'Baki',
			'accounts.walletsPockets' => 'Dompet & Poket',
			'accounts.accounts' => 'Akaun',
			'accounts.mainAccounts' => 'Akaun Utama',
			'accounts.deleteAccount' => 'Padam Akaun',
			'accounts.areYouSureYouWantToDeleteThisAccountItWillBeHiddenFromTheApp' => 'Adakah anda pasti mahu memadam akaun ini? Akaun akan disembunyikan daripada aplikasi.',
			'accounts.delete' => 'Padam',
			'accounts.account' => 'Akaun',
			'accounts.totalBalance' => 'Jumlah Baki',
			'accounts.pockets' => 'Poket',
			'accounts.deletePocket' => 'Padam Poket',
			'accounts.cannotDeleteMainPocket' => 'Poket utama tidak boleh dipadam',
			'accounts.mainPocket' => 'Utama',
			'accounts.areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp' => 'Adakah anda pasti mahu memadam poket ini? Poket akan disembunyikan daripada aplikasi.',
			'accounts.nameCannotBeEmpty' => 'Nama tidak boleh kosong',
			'accounts.egMainWallet' => 'cth., Dompet Utama',
			'accounts.egPocket' => 'cth., Barangan Dapur, Percutian',
			'accounts.selectIcon' => 'Pilih Ikon',
			'accounts.allowedCategories' => 'Kategori yang Dibenarkan',
			'accounts.transactions' => 'Transaksi',
			'accounts.editAccount' => 'Edit Akaun',
			'accounts.editPocket' => 'Edit Poket',
			'accounts.updateNameIconOrColor' => 'Kemas kini nama, ikon atau warna',
			'accounts.permanentlyRemoveThisAccount' => 'Buang akaun ini secara kekal',
			'accounts.seeAll' => 'Lihat Semua',
			'accounts.noTransactionsYet' => 'Belum ada transaksi',
			'accounts.accountTransactionsSubtitle' => 'Transaksi yang direkodkan dalam akaun ini akan dipaparkan di sini.',
			'accounts.pocketTransactionsSubtitle' => 'Transaksi yang direkodkan dalam poket ini akan dipaparkan di sini.',
			'accounts.addAccount' => 'Tambah Akaun',
			'accounts.noAccountsFound' => 'Tiada akaun ditemui.',
			'accounts.addPocket' => 'Tambah Poket',
			'accounts.noPocketsYet' => 'Belum ada poket',
			'accounts.pocketsHelpYouSplitYourWalletIntoCategories' => 'Poket membantu anda membahagikan dompet kepada beberapa kategori. Baki anda akan dipindahkan secara automatik ke poket "Utama".',
			'accounts.activeAccount' => 'Akaun Aktif',
			'accounts.inactiveAccountsWillBeHidden' => 'Akaun tidak aktif akan disembunyikan',
			'accounts.noCategoriesAvailable' => 'Tiada kategori tersedia.',
			'accounts.noAccountsFound1' => 'Tiada akaun ditemui',
			'accounts.subcategoriesCount' => ({required Object count}) => '${count} subkategori',
			'accounts.pocketsCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ms'))(count, one: '1 poket', other: '${count} poket', ), 
			'accounts.totalActiveAccounts' => 'Jumlah Akaun Aktif',
			'accounts.noAccountsYet' => 'Belum Ada Akaun',
			'accounts.tapTheButtonBelowToAddYourFirstAccount' => 'Ketik butang di bawah untuk menambah akaun pertama anda',
			'accounts.allCategoriesAllowed' => 'Semua kategori dibenarkan',
			'accounts.categoriesSelected' => ({required Object count}) => '${count} kategori dipilih',
			'accounts.ratioOfAccount' => ({required Object percent}) => '${percent}% daripada akaun',
			'accounts.noMainAccountsYet' => 'Belum ada akaun utama.',
			'accounts.percentOfAssets' => ({required Object percent}) => '${percent}% daripada aset',
			'accounts.recentTransactions' => 'Transaksi Terkini',
			'accounts.recentTransactionsCount' => ({required Object count}) => 'Transaksi Terkini (${count})',
			'accounts.reconcileBalance' => 'Selaraskan Baki',
			'accounts.reconcileBalanceSubtitle' => 'Selaraskan baki aplikasi dengan baki sebenar akaun',
			'accounts.currentBalanceInPoka' => 'Baki dalam Poka',
			'accounts.actualBalance' => 'Baki Sebenar',
			'accounts.difference' => 'Perbezaan',
			'accounts.adjustmentExpense' => 'Pelarasan (Perbelanjaan)',
			'accounts.adjustmentIncome' => 'Pelarasan (Pendapatan)',
			'accounts.balanceAdjustment' => 'Pelarasan Baki',
			'accounts.saveAdjustment' => 'Simpan Pelarasan',
			'accounts.balancesMatch' => 'Baki sepadan, tiada pelarasan diperlukan',
			'accounts.noteOptional' => 'Catatan (Pilihan)',
			'accounts.reconcileAccount' => 'Selaraskan Baki Akaun',
			'app.name' => 'Poka',
			'app.tagline' => 'Rakan kewangan peribadi anda',
			'app.nav.home' => 'Laman Utama',
			'app.nav.transactions' => 'Transaksi',
			'app.nav.reports' => 'Laporan',
			'app.nav.accounts' => 'Akaun',
			'app.nav.settings' => 'Tetapan',
			'app.termsOfService' => 'Terma Perkhidmatan',
			'app.privacyPolicy' => 'Dasar Privasi',
			'backup.title' => 'Sandaran & Pemulihan',
			'backup.backupAction' => 'Sandarkan',
			'backup.restoreAction' => 'Pulihkan',
			'backup.password' => 'Kata Laluan',
			'backup.confirmPassword' => 'Sahkan Kata Laluan',
			'backup.passwordsDoNotMatch' => 'Kata laluan tidak sepadan',
			'backup.backupSuccess' => 'Sandaran berjaya',
			'backup.restoreSuccess' => 'Pemulihan berjaya',
			'backup.incorrectPassword' => 'Kata laluan salah atau fail rosak',
			'backup.enterPasswordToEncrypt' => 'Masukkan kata laluan untuk menyulitkan sandaran',
			'backup.enterPasswordToDecrypt' => 'Masukkan kata laluan untuk menyahsulit sandaran',
			'backup.pleaseRestart' => 'Sila mulakan semula aplikasi untuk mengguna pakai perubahan.',
			'backup.passwordRequired' => 'Kata laluan diperlukan',
			'backup.reminder' => 'Peringatan Sandaran',
			'backup.reminderDesc' => 'Ingatkan anda dari semasa ke semasa untuk menyandarkan data anda',
			'backup.reminderOff' => 'Mati',
			'backup.reminderWeekly' => 'Mingguan',
			'backup.reminderMonthly' => 'Bulanan',
			'backup.reminderNotificationTitle' => 'Masanya untuk Sandarkan Data Anda',
			'backup.reminderNotificationBody' => 'Sudah lama sejak sandaran terakhir anda. Lindungi data kewangan anda dengan membuat sandaran sekarang.',
			'backup.reminderSaved' => 'Peringatan sandaran dikemas kini',
			'backup.restoreWarningDesc' => 'Memulihkan sandaran akan menggantikan semua data semasa dengan data daripada fail sandaran yang dipilih. Sebarang perubahan yang belum disandarkan akan hilang. Adakah anda mahu meneruskan?',
			'backup.sendTestNotification' => 'Hantar Notifikasi Ujian',
			'backup.testNotificationSent' => 'Notifikasi peringatan ujian dihantar',
			'backup.permissionRationaleTitle' => 'Peringatan Sandaran Setempat',
			'backup.permissionRationaleDesc' => 'Poka memerlukan kebenaran notifikasi untuk mengingatkan anda menyandarkan data dari semasa ke semasa. Peringatan berjalan sepenuhnya di luar talian pada peranti anda tanpa sebarang penjejakan atau analitik.',
			'backup.allowNotifications' => 'Benarkan Notifikasi',
			'backup.permissionDenied' => 'Kebenaran notifikasi telah ditolak. Peringatan kekal dimatikan.',
			'budgets.budgetName' => 'Nama belanjawan',
			'budgets.spendingLimit' => 'Had perbelanjaan',
			'budgets.period' => 'Tempoh',
			'budgets.resetDay' => 'Hari set semula (1–31)',
			'budgets.createBudget' => 'Cipta Belanjawan',
			'budgets.endDate' => 'Tarikh Tamat',
			'budgets.budgetDetails' => 'Butiran Belanjawan',
			'budgets.deleteBudget' => 'Padam Belanjawan',
			'budgets.areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone' => 'Adakah anda pasti mahu memadam belanjawan ini? Semua sejarah penjejakan yang berkaitan akan dipadam secara kekal. Tindakan ini tidak boleh diundurkan.',
			'budgets.delete' => 'Padam',
			'budgets.transactions' => 'Transaksi',
			'budgets.budgets' => 'Belanjawan',
			'budgets.allBudgets' => 'Semua Belanjawan',
			'budgets.egGroceriesEntertainment' => 'cth., Barangan Dapur, Hiburan',
			'budgets.eg80' => 'cth., 80',
			'budgets.category' => 'Kategori',
			'budgets.account' => 'Akaun',
			'budgets.overLimit' => 'Melebihi had',
			'budgets.remaining' => 'Baki',
			'budgets.totalSpent' => 'Jumlah dibelanjakan',
			'budgets.totalLimit' => 'Jumlah had',
			'budgets.selectEndDate' => 'Pilih tarikh tamat',
			'budgets.noTransactionsFoundForThisBudgetPeriod' => 'Tiada transaksi ditemui untuk tempoh belanjawan ini.',
			'budgets.budgetTransactionsSubtitle' => 'Transaksi yang sepadan dengan belanjawan ini akan dipaparkan di sini.',
			'budgets.addBudget' => 'Tambah Belanjawan',
			'budgets.spent' => 'Dibelanjakan ',
			'budgets.noBudgetsYet' => 'Belum ada belanjawan',
			'budgets.setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod' => 'Tetapkan had perbelanjaan untuk menjejaki ke mana wang anda dibelanjakan setiap tempoh.',
			'budgets.budgetAlert' => ({required Object name}) => 'Amaran Belanjawan: ${name}',
			'budgets.percentOf' => ({required Object percent}) => '${percent}% daripada ',
			'budgets.budgetsCount' => ({required Object count}) => '${count} belanjawan',
			'budgets.editBudget' => 'Edit Belanjawan',
			'budgets.newBudget' => 'Belanjawan Baharu',
			'budgets.nameCannotBeEmpty' => 'Nama tidak boleh kosong',
			'budgets.amountGreaterThanZero' => 'Jumlah mestilah melebihi 0',
			'budgets.alertThresholdLabel' => 'Ambang amaran (%)',
			'budgets.scope' => 'Skop',
			'budgets.anyCategory' => 'Sebarang kategori',
			'budgets.anyAccount' => 'Sebarang akaun',
			'budgets.saveChanges' => 'Simpan Perubahan',
			'budgets.periodWeekly' => 'Mingguan',
			'budgets.periodMonthly' => 'Bulanan',
			'budgets.periodYearly' => 'Tahunan',
			'budgets.periodCustom' => 'Tersuai',
			'budgets.budgetExceededAlert' => ({required Object percentage, required Object name}) => 'Anda telah menggunakan ${percentage}% daripada belanjawan ${name} anda.',
			'categories.expense' => 'Perbelanjaan',
			'categories.income' => 'Pendapatan',
			'categories.categoryName' => 'Nama Kategori',
			'categories.icon' => 'Ikon',
			'categories.color' => 'Warna',
			'categories.noCategoriesFound' => 'Tiada kategori ditemui.',
			'categories.subcategories' => 'Subkategori',
			'categories.categories' => 'Kategori',
			'categories.egFoodDining' => 'cth., Makanan & Minuman',
			'categories.deleteCategory' => 'Padam Kategori',
			'categories.delete' => 'Padam',
			'categories.selectIcon' => 'Pilih Ikon',
			'categories.noSubcategoriesYet' => 'Belum ada subkategori',
			'categories.noCategoriesFound1' => 'Tiada kategori ditemui',
			'categories.subcategoriesCount' => ({required Object count}) => '${count} subkategori',
			'categories.addSubcategory' => 'Tambah Subkategori',
			'categories.addCategory' => 'Tambah Kategori',
			'categories.emptyCategorySubtitle' => 'Mula jejaki perbelanjaan anda dengan menambah kategori',
			'categories.emptySubcategorySubtitle' => 'Pecahkan kategori anda kepada bahagian yang lebih kecil',
			'categories.saveSubCategory' => 'Simpan Subkategori',
			'categories.saveCategory' => 'Simpan Kategori',
			'categories.newSubCategory' => 'Subkategori Baharu',
			'categories.newCategory' => 'Kategori Baharu',
			'categories.editSubCategory' => 'Edit Subkategori',
			'categories.editCategory' => 'Edit Kategori',
			'categories.deleteConfirmWithChildren' => ({required Object count}) => 'Adakah anda pasti mahu memadam kategori ini? ${count} subkategorinya akan menjadi kategori utama, dan transaksinya sendiri akan menjadi tanpa kategori.',
			'categories.deleteConfirmNoChildren' => 'Adakah anda pasti mahu memadam kategori ini? Semua transaksinya akan menjadi tanpa kategori.',
			'common.save' => 'Simpan',
			'common.cancel' => 'Batal',
			'common.delete' => 'Padam',
			'common.edit' => 'Edit',
			'common.confirm' => 'Sahkan',
			'common.back' => 'Kembali',
			'common.loading' => 'Memuatkan...',
			'common.error' => 'Berlaku ralat',
			'common.retry' => 'Cuba lagi',
			'common.empty' => 'Belum ada data',
			'common.cannotBeUndone' => 'Tindakan ini tidak boleh diundurkan.',
			'common.pleaseWait' => 'Sila tunggu',
			'common.today' => 'Hari ini',
			'common.yesterday' => 'Semalam',
			'common.dueToday' => 'Perlu hari ini',
			'common.overdue' => 'Tertunggak',
			'common.uncategorized' => 'Tanpa Kategori',
			'common.unknown' => 'Tidak diketahui',
			'common.notSet' => 'Belum Ditetapkan',
			'common.undo' => 'Buat Asal',
			'dashboard.overview' => 'Gambaran Keseluruhan',
			'dashboard.myFinances' => 'Kewangan Saya',
			'dashboard.netWorth' => 'Nilai Bersih',
			'dashboard.accountsCount' => ({required Object count}) => '${count} akaun',
			'dashboard.assets' => 'Aset',
			'dashboard.liabilities' => 'Liabiliti',
			'dashboard.budgets' => 'Belanjawan',
			'dashboard.categories' => 'Kategori',
			'dashboard.goals' => 'Matlamat',
			'dashboard.debts' => 'Hutang',
			'dashboard.recurring' => 'Berulang',
			'dashboard.cashFlow' => 'Aliran Tunai',
			'dashboard.budget' => 'Belanjawan',
			'dashboard.needs' => 'Keperluan (50%)',
			'dashboard.wants' => 'Kehendak (30%)',
			'dashboard.savings' => 'Simpanan (20%)',
			'dashboard.saved' => 'disimpan',
			'dashboard.onTrack' => 'Baik',
			'dashboard.needsAttention' => 'Perlu perhatian',
			'dashboard.income' => 'Pendapatan',
			'dashboard.expense' => 'Perbelanjaan',
			'dashboard.other' => 'Lain-lain',
			'dashboard.noData' => 'Tiada data',
			'dashboard.spendingActivity' => 'Aktiviti Perbelanjaan',
			'dashboard.total' => 'Jumlah',
			'dashboard.average' => 'Purata',
			'dashboard.budgetPerDay' => 'Belanjawan/Hari',
			'dashboard.todaysBudget' => 'Belanjawan Hari Ini',
			'dashboard.overbudget' => 'Melebihi belanjawan!',
			'dashboard.setDailyBudget' => 'Tetapkan Belanjawan Harian',
			'dashboard.amount' => 'Jumlah',
			'dashboard.amountHint' => 'cth. 100000',
			'dashboard.recentTransactions' => 'Transaksi Terkini',
			'dashboard.thisMonth' => 'Bulan ini',
			'dashboard.noRecentTransactions' => 'Tiada transaksi terkini',
			'dashboard.recentTransactionsSubtitle' => 'Transaksi yang baru anda rekodkan akan dipaparkan di sini.',
			'dashboard.seeAll' => 'Lihat Semua',
			'dashboard.notSet' => 'Belum ditetapkan',
			'dashboard.insight.noData' => 'Tiada data bulan ini untuk dianalisis.',
			'dashboard.insight.thisMonth' => 'bulan ini ialah',
			'dashboard.insight.up' => 'meningkat',
			'dashboard.insight.down' => 'menurun',
			'dashboard.insight.same' => 'sama seperti',
			'dashboard.insight.fromLastMonth' => 'berbanding bulan lepas.',
			'dashboard.days.mon' => 'Isn',
			'dashboard.days.tue' => 'Sel',
			'dashboard.days.wed' => 'Rab',
			'dashboard.days.thu' => 'Kha',
			'dashboard.days.fri' => 'Jum',
			'dashboard.days.sat' => 'Sab',
			'dashboard.days.sun' => 'Aha',
			'debts.addRepayment' => 'Tambah Bayaran Balik',
			'debts.iOwe' => 'Saya Berhutang',
			'debts.theyOwe' => 'Mereka Berhutang',
			'debts.personName' => 'Nama orang',
			'debts.principalAmount' => 'Jumlah pokok',
			'debts.transactionBinding' => 'Pautan Transaksi',
			'debts.cancel' => 'Batal',
			'debts.save' => 'Simpan',
			'debts.ok' => 'OK',
			'debts.addRecord' => 'Tambah Rekod',
			'debts.createRecord' => 'Cipta Rekod',
			'debts.debtDetails' => 'Butiran Hutang',
			'debts.repaymentHistory' => 'Sejarah Bayaran Balik',
			'debts.debtsLoans' => 'Hutang & Pinjaman',
			'debts.deleteDebt' => 'Padam Hutang',
			'debts.delete' => 'Padam',
			'debts.writeoffDebt' => 'Hapus Kira Hutang',
			'debts.areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances' => 'Adakah anda pasti mahu menghapus kira hutang ini? Hutang akan ditandakan sebagai dijelaskan tanpa menjejaskan baki dompet anda.',
			'debts.writeoff' => 'Hapus Kira',
			'debts.egJohnDoe' => 'cth., John Doe',
			'debts.category' => 'Kategori',
			'debts.account' => 'Akaun',
			'debts.egDinnerLastFriday' => 'cth., Makan malam Jumaat lepas',
			'debts.selectDueDate' => 'Pilih tarikh akhir',
			'debts.outstanding' => 'Belum Selesai',
			'debts.paid' => 'Dibayar',
			'debts.principal' => 'Pokok',
			'debts.actionDenied' => 'Tindakan Ditolak',
			'debts.paymentCannotExceedRemaining' => 'Jumlah bayaran tidak boleh melebihi baki hutang.',
			'debts.addNote' => 'Tambah catatan',
			'debts.payInFull' => 'Bayar Penuh',
			'debts.remaining' => 'berbaki',
			'debts.paid1' => 'Dibayar ',
			'debts.reminder' => ({required Object type, required Object name}) => 'Peringatan ${type}: ${name}',
			'debts.due' => ({required Object type, required Object name}) => '${type} Tamat Tempoh: ${name}',
			'debts.noHistoryFoundForThis' => ({required Object type}) => 'Tiada sejarah ditemui untuk ${type} ini',
			'debts.repaymentHistorySubtitle' => ({required Object type}) => 'Rekod bayaran atau ansuran untuk ${type} ini akan dipaparkan di sini.',
			'debts.failedToLoadDebts' => ({required Object error}) => 'Gagal memuatkan hutang: ${error}',
			'debts.percentOf' => ({required Object percent}) => '${percent}% daripada ',
			'debts.settled' => ({required Object count}) => '${count} selesai',
			'debts.payable' => 'Belum Bayar',
			'debts.receivable' => 'Belum Terima',
			'debts.noDebtsRecorded' => 'Tiada hutang direkodkan',
			'debts.noLoansRecorded' => 'Tiada pinjaman direkodkan',
			'debts.trackMoneyYouOweToOthersAndLogRepayments' => 'Jejaki wang yang anda hutang kepada orang lain dan rekodkan semua bayaran balik di sini.',
			'debts.trackMoneyOthersOweYouAndLogCollections' => 'Jejaki wang yang orang lain hutang kepada anda dan rekodkan semua kutipan di sini.',
			'debts.editRecord' => 'Edit Rekod',
			'debts.newRecord' => 'Rekod Baharu',
			'debts.personNameCannotBeEmpty' => 'Nama orang tidak boleh kosong',
			'debts.amountGreaterThanZero' => 'Jumlah mestilah melebihi 0',
			'debts.selectCategoryAndAccount' => 'Sila pilih kategori dan akaun',
			'debts.selectCategoryPrompt' => 'Pilih kategori',
			'debts.selectAccountPrompt' => 'Pilih akaun',
			'debts.debtBindingHelp' => 'Merekod hutang ini menambah wang ke akaun (transaksi pendapatan).',
			'debts.loanBindingHelp' => 'Merekod pinjaman ini mengeluarkan wang dari akaun (transaksi perbelanjaan).',
			'debts.noteLabel' => 'Catatan',
			'debts.dueDateLabel' => 'Tarikh Akhir',
			'debts.saveChanges' => 'Simpan Perubahan',
			'debts.deleteConfirm' => ({required Object type}) => 'Adakah anda pasti mahu memadam ${type} ini? Rekod akan dipadam secara kekal. Tindakan ini tidak boleh diundurkan.',
			'debts.debtDetailsTitle' => ({required Object type}) => 'Butiran ${type}',
			'debts.debtTypeLoan' => 'Pinjaman',
			'debts.debtTypeDebt' => 'Hutang',
			'debts.reminderAlert' => ({required Object type, required Object amount, required Object action, required Object when}) => '${type} sebanyak ${amount} perlu ${action} ${when}.',
			'debts.overdueAlert' => ({required Object type, required Object amount, required Object action}) => '${type} sebanyak ${amount} telah tertunggak dan perlu ${action} dengan segera.',
			'debts.actionCollect' => 'dikutip',
			'debts.actionPay' => 'dibayar',
			'debts.today' => 'hari ini',
			'debts.inDays' => ({required Object days}) => 'dalam masa ${days} hari',
			'debts.owedCount' => ({required Object count}) => '${count} perlu dibayar',
			'debts.receivableCount' => ({required Object count}) => '${count} perlu dikutip',
			'error.generic' => 'Berlaku ralat yang tidak dijangka',
			'error.network' => 'Sila semak sambungan anda dan cuba lagi',
			'error.database' => 'Gagal mengakses data setempat',
			'goals.goals' => 'Matlamat',
			'goals.fulfillGoal' => 'Capai Matlamat (Belanja)',
			'goals.goalName' => 'Nama matlamat',
			'goals.targetAmount' => 'Jumlah sasaran',
			'goals.createGoal' => 'Cipta Matlamat',
			'goals.errorPrefix' => ({required Object error}) => 'Ralat: ${error}',
			'goals.goalDetails' => 'Butiran Matlamat',
			'goals.transactions' => 'Transaksi',
			'goals.active' => 'Aktif',
			'goals.past' => 'Lepas',
			'goals.actionDenied' => 'Tindakan Ditolak',
			'goals.emptyBalanceBeforeDelete' => 'Kosongkan baki (pindahkan keluar) sebelum memadam Matlamat ini.',
			'goals.ok' => 'OK',
			'goals.deleteGoal' => 'Padam Matlamat',
			'goals.areYouSureYouWantToDeleteThisGoalTheAssociatedPocketAccountAndItsHistoryWillAlsoBeRemovedThisActionCannotBeUndone' => 'Adakah anda pasti mahu memadam matlamat ini? Akaun poket yang berkaitan dan sejarahnya juga akan dibuang. Tindakan ini tidak boleh diundurkan.',
			'goals.delete' => 'Padam',
			'goals.egEmergencyFundNewLaptop' => 'cth., Dana Kecemasan, Komputer Riba Baharu',
			'goals.completed' => 'Selesai',
			'goals.fullyFunded' => 'Cukup dibiayai',
			'goals.inProgress' => 'Sedang berjalan',
			'goals.totalSaved' => 'Jumlah Terkumpul',
			'goals.stillNeeded' => 'Masih diperlukan',
			'goals.totalTarget' => 'Jumlah sasaran',
			'goals.selectTargetDate' => 'Pilih tarikh sasaran',
			'goals.noTransactionsFoundForThisGoal' => 'Tiada transaksi ditemui untuk matlamat ini.',
			'goals.goalTransactionsSubtitle' => 'Pindahan atau simpanan yang direkodkan untuk matlamat ini akan dipaparkan di sini.',
			'goals.addGoal' => 'Tambah Matlamat',
			'goals.aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal' => 'Akaun Poket khusus akan dicipta secara automatik untuk menjejaki matlamat ini.',
			'goals.saved' => 'tersimpan',
			'goals.needs' => 'Memerlukan ',
			'goals.more' => ' lagi',
			'goals.noGoalsYet' => 'Belum ada matlamat',
			'goals.setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal' => 'Tetapkan sasaran simpanan — poket khusus dicipta secara automatik untuk setiap matlamat.',
			'goals.percentOfTarget' => ({required Object percent}) => '${percent}% daripada sasaran',
			'goals.goalsCount' => ({required Object count}) => '${count} matlamat',
			'goals.fullyFundedCount' => ({required Object count}) => '${count} cukup dibiayai',
			'goals.noCompletedGoalsYet' => 'Belum ada matlamat yang selesai',
			'goals.completedGoalsWillAppearHere' => 'Matlamat yang anda capai akan dipaparkan di sini.',
			'goals.editGoal' => 'Edit Matlamat',
			'goals.newGoal' => 'Matlamat Baharu',
			'goals.nameCannotBeEmpty' => 'Nama tidak boleh kosong',
			'goals.targetAmountGreaterThanZero' => 'Jumlah sasaran mestilah melebihi 0',
			'goals.saveChanges' => 'Simpan Perubahan',
			'goals.targetDateLabel' => 'Tarikh Sasaran',
			'goals.activeGoals' => 'Matlamat Aktif',
			'goals.completedGoals' => 'Matlamat Selesai',
			'goals.noActiveGoalsYet' => 'Belum ada matlamat aktif',
			'goals.noActiveGoalsSubtitle' => 'Cipta matlamat baharu untuk mula menyimpan bagi pencapaian anda yang seterusnya.',
			'goals.saveInAccount' => 'Simpan dalam Akaun',
			'goals.selectAccount' => 'Pilih Akaun',
			'goals.accountRequired' => 'Sila pilih akaun',
			'goals.storedIn' => ({required Object account}) => 'Disimpan dalam ${account}',
			'lock.confirmPin' => 'Sahkan PIN',
			'lock.createPin' => 'Buat PIN',
			'lock.pinsDoNotMatch' => 'PIN tidak sepadan',
			'lock.reenterPin' => 'Masukkan semula PIN',
			'lock.enterPinAppLock' => 'Masukkan PIN untuk Kunci Aplikasi',
			'lock.incorrectPin' => 'PIN salah',
			'lock.verifyIdentity' => 'Sahkan Identiti',
			'lock.retryInSeconds' => ({required Object seconds}) => 'Cuba lagi dalam ${seconds} saat',
			'lock.setupPinTitle' => 'Tetapkan PIN',
			'lock.setupPinBody' => 'Sila cipta PIN terlebih dahulu sebelum mendayakan Kunci Aplikasi atau Biometrik.',
			'lock.unlocked' => 'Dibuka',
			'lock.enter6DigitPin' => 'Masukkan PIN 6-digit',
			'lock.enterPin' => 'Masukkan PIN',
			'lock.invalidPin' => 'PIN tidak sah',
			'lock.tooManyAttempts' => 'Terlalu banyak cubaan',
			'lock.temporarilyLocked' => 'Disekat sementara',
			'lock.authenticateReason' => 'Sahkan untuk mengakses Poka',
			'onboarding.continueWithCurrency' => 'Teruskan dengan mata wang terpilih',
			'onboarding.chooseYourBaseCurrency' => 'Pilih Mata Wang Asas Anda',
			'onboarding.thisCurrencyWillBeUsedForAllAccountsPocketsAndTransactionsYouCanChangeThisLaterInSettings' => 'Mata wang ini akan digunakan untuk semua akaun, poket dan transaksi. Anda boleh menukarnya kemudian dalam tetapan.',
			'recurring.addSchedule' => 'Tambah Jadual',
			'recurring.transactionDetails' => 'Butiran Transaksi',
			'recurring.amount' => 'Jumlah',
			'recurring.frequency' => 'Kekerapan',
			'recurring.startDate' => 'Tarikh Mula',
			'recurring.recurring' => 'Berulang',
			'recurring.schedules' => 'Jadual',
			'recurring.scheduleDetails' => 'Butiran Jadual',
			'recurring.deleteSchedule' => 'Padam Jadual',
			'recurring.areYouSureYouWantToDeleteThisRecurringScheduleExistingGeneratedTransactionsWillNotBeDeleted' => 'Adakah anda pasti mahu memadam jadual berulang ini? Transaksi yang telah dijana tidak akan dipadam.',
			'recurring.delete' => 'Padam',
			'recurring.triggerHistory' => 'Sejarah Cetusan',
			'recurring.destinationAccount' => 'Akaun Destinasi',
			'recurring.category' => 'Kategori',
			'recurring.egNetflixSubscription' => 'cth., Langganan Netflix',
			'recurring.selectFirstDueDate' => 'Pilih tarikh akhir pertama',
			'recurring.estMonthlyNet' => 'Angg. Bersih Bulanan',
			'recurring.monthlyIn' => 'Masuk Bulanan',
			'recurring.monthlyOut' => 'Keluar Bulanan',
			'recurring.noRecurringTransactions' => 'Tiada transaksi berulang',
			'recurring.automateBillsLikeSubscriptionsOrSalary' => 'Automasi bil seperti langganan atau gaji. Aplikasi akan merekodkannya mengikut jadual.',
			'recurring.noHistoryFoundForThisSchedule' => 'Tiada sejarah ditemui untuk jadual ini.',
			'recurring.scheduleHistorySubtitle' => 'Transaksi yang dijana daripada jadual ini akan dipaparkan di sini.',
			'recurring.allocation' => 'Peruntukan',
			'recurring.active' => 'Aktif',
			'recurring.eachTimeTheAppOpensOverdueRecurringTransactionsAre' => 'Setiap kali aplikasi dibuka, transaksi berulang yang tertunggak akan direkodkan secara automatik dalam lejar anda.',
			'recurring.schedulesCount' => ({required Object count}) => '${count} jadual',
			'recurring.pausedCount' => ({required Object count}) => '${count} dijeda',
			'recurring.editRecurring' => 'Edit Berulang',
			'recurring.newRecurring' => 'Berulang Baharu',
			'recurring.mustSelectAccount' => 'Mesti memilih akaun',
			'recurring.sourceAccount' => 'Akaun Sumber',
			'recurring.account' => 'Akaun',
			'recurring.selectAccountPrompt' => 'Pilih akaun',
			'recurring.selectDestinationPrompt' => 'Pilih destinasi',
			'recurring.selectCategoryOptional' => 'Pilih kategori (pilihan)',
			'recurring.noteLabel' => 'Catatan',
			'recurring.saveChanges' => 'Simpan Perubahan',
			'recurring.createRecurring' => 'Cipta Berulang',
			'recurring.amountGreaterThanZero' => 'Jumlah mestilah melebihi 0',
			'recurring.mustSelectStartDate' => 'Mesti memilih tarikh mula',
			'recurring.periodDaily' => 'Harian',
			'recurring.periodWeekly' => 'Mingguan',
			'recurring.periodMonthly' => 'Bulanan',
			'recurring.periodYearly' => 'Tahunan',
			'recurring.autoGenerateActive' => 'Akan menjana transaksi secara automatik',
			'recurring.autoGeneratePaused' => 'Dijeda — tiada transaksi akan dijana',
			'recurring.recurringIncome' => 'Pendapatan Berulang',
			'recurring.recurringExpense' => 'Perbelanjaan Berulang',
			'recurring.recurringTransfer' => 'Pindahan Berulang',
			'recurring.nextDateLabel' => ({required Object date}) => 'Seterusnya: ${date}',
			'reports.title' => 'Laporan',
			'reports.overview' => 'Gambaran Kewangan',
			'reports.tabCashflow' => 'Aliran Tunai',
			'reports.tabBudgets' => 'Belanjawan & Matlamat',
			'reports.period' => 'Tempoh',
			'reports.thisMonth' => 'Bulan Ini',
			'reports.lastMonth' => 'Bulan Lepas',
			'reports.last3Months' => '3 Bulan',
			'reports.last6Months' => '6 Bulan',
			'reports.custom' => 'Tersuai',
			'reports.income' => 'Pendapatan',
			'reports.expense' => 'Perbelanjaan',
			'reports.netSavings' => 'Simpanan Bersih',
			'reports.netCashflow' => 'Aliran Tunai Bersih',
			'reports.cashflow' => 'Aliran Tunai',
			'reports.savingsRate' => 'Kadar Simpanan',
			'reports.topCategories' => 'Kategori Teratas',
			'reports.topExpenses' => 'Perbelanjaan Tertinggi',
			'reports.topIncome' => 'Pendapatan Tertinggi',
			'reports.monthlyTrend' => 'Aliran Bulanan',
			'reports.cashflowTrend' => 'Aliran Pendapatan vs Perbelanjaan',
			'reports.budgetBreakdown' => 'Pecahan Belanjawan',
			'reports.budgetUtilization' => 'Penggunaan Belanjawan',
			'reports.spendingAllocation' => 'Peruntukan Perbelanjaan',
			'reports.noData' => 'Tiada data untuk tempoh ini',
			'reports.noExpenseDataDesc' => 'Rekod transaksi perbelanjaan untuk melihat peruntukan perbelanjaan anda.',
			'reports.noBudgets' => 'Belum ada belanjawan ditetapkan',
			'reports.noBudgetsDesc' => 'Tambah belanjawan untuk menjejaki had perbelanjaan anda',
			'reports.onTrack' => 'Mengikut landasan',
			'reports.needsAttention' => 'Perlu perhatian',
			'reports.overBudget' => 'Melebihi belanjawan',
			'reports.onBudget' => 'Dalam had',
			'reports.needs' => 'Keperluan',
			'reports.wants' => 'Kehendak',
			'reports.savings' => 'Simpanan',
			'reports.other' => 'Lain-lain',
			'reports.total' => 'Jumlah',
			'reports.average' => 'Purata',
			'reports.remaining' => 'Baki',
			'reports.spent' => 'Dibelanjakan',
			'reports.limit' => 'Had',
			'reports.txCount' => ({required Object count}) => '${count} transaksi',
			'reports.selectDateRange' => 'Pilih Julat Tarikh',
			'reports.apply' => 'Guna',
			'reports.from' => 'Dari',
			'reports.to' => 'Hingga',
			'reports.comparedTo' => ({required Object period}) => 'vs ${period}',
			'reports.higher' => 'lebih tinggi',
			'reports.lower' => 'lebih rendah',
			'reports.same' => 'sama seperti',
			'reports.noChange' => 'Tiada perubahan',
			'reports.percent50' => '50%',
			'reports.percent30' => '30%',
			'reports.percent20' => '20%',
			'reports.rule503020' => '50/30/20',
			'reports.prevLastMonth' => 'bulan lepas',
			'reports.prevMonth' => 'bulan sebelumnya',
			'reports.prev3Months' => '3 bln lepas',
			'reports.prev6Months' => '6 bln lepas',
			'reports.prevPeriod' => 'tempoh lepas',
			'reports.exportExcel' => 'Eksport ke Excel',
			'reports.exportExcelSuccess' => 'Excel berjaya dieksport',
			'reports.exportExcelError' => 'Gagal mengeksport fail Excel',
			'settings.title' => 'Tetapan',
			'settings.preferences' => 'Keutamaan',
			'settings.baseCurrency' => 'Mata Wang Asas',
			_ => null,
		} ?? switch (path) {
			'settings.theme' => 'Tema',
			'settings.language' => 'Bahasa',
			'settings.numberFormat' => 'Format Nombor',
			'settings.selectNumberFormat' => 'Pilih Format Nombor',
			'settings.formatSystem' => 'Lalai Aplikasi',
			'settings.formatId' => '1.000.000,00',
			'settings.formatUs' => '1,000,000.00',
			'settings.formatFr' => '1 000 000,00',
			'settings.system' => 'Sistem',
			'settings.english' => 'English',
			'settings.indonesia' => 'Indonesia',
			'settings.malay' => 'Bahasa Melayu',
			'settings.vietnam' => 'Tiếng Việt',
			'settings.security' => 'Keselamatan',
			'settings.appLock' => 'Kunci Aplikasi',
			'settings.appLockDesc' => 'Lindungi aplikasi dengan PIN',
			'settings.biometrics' => 'Biometrik',
			'settings.biometricsDesc' => 'Gunakan cap jari untuk membuka kunci',
			'settings.dataManagement' => 'Pengurusan Data',
			'settings.backupRestore' => 'Sandaran & Pemulihan',
			'settings.backupRestoreDesc' => 'Simpan atau pulihkan data anda',
			'settings.clearOld' => 'Padam Transaksi Lama',
			'settings.clearOldDesc' => 'Buang transaksi yang lebih lama daripada 1 tahun',
			'settings.resetData' => 'Tetapkan Semula Data',
			'settings.resetDataDesc' => 'Padam semua data aplikasi setempat',
			'settings.support' => 'Sokongan',
			'settings.faq' => 'FAQ',
			'settings.faqDesc' => 'Soalan Lazim',
			'settings.about' => 'Tentang Poka CE',
			'settings.aboutDesc' => 'Versi dan maklumat undang-undang',
			'settings.selectTheme' => 'Pilih Tema',
			'settings.themeLight' => 'Cerah',
			'settings.themeDark' => 'Gelap',
			'settings.selectLanguage' => 'Pilih Bahasa',
			'settings.oldTransactionsCleared' => 'Transaksi lama berjaya dibersihkan',
			'settings.appDataReset' => 'Data aplikasi berjaya ditetapkan semula',
			'settings.failedToExportLogs' => 'Gagal mengeksport log',
			'settings.easterEggRemaining' => ({required Object remaining}) => '${remaining} ketikan lagi untuk kejutan...',
			'settings.easterEggFound' => '🎉 Anda menemui easter egg!',
			'settings.selectCurrency' => 'Pilih Mata Wang',
			'settings.openSourceLicenses' => 'Lesen Sumber Terbuka',
			'settings.checkForUpdates' => 'Semak Kemas Kini',
			'settings.viewLatestReleasesOnGithub' => 'Lihat keluaran terkini di GitHub',
			'settings.helpIssues' => 'Bantuan & Isu',
			'settings.reportBugsOrRequestFeatures' => 'Laporkan pepijat atau cadangkan ciri',
			'settings.legal' => 'Undang-undang',
			'settings.termsOfService' => 'Terma Perkhidmatan',
			'settings.readOurTermsAndConditions' => 'Baca terma dan syarat kami',
			'settings.privacyPolicy' => 'Dasar Privasi',
			'settings.learnHowWeHandleYourData' => 'Ketahui cara kami mengendalikan data anda',
			'settings.viewThirdpartySoftwareLicenses' => 'Lihat lesen perisian pihak ketiga',
			'settings.advanced' => 'Lanjutan',
			'settings.exportDebugLogs' => 'Eksport Log Nyahpepijat',
			'settings.shareErrorLogsForTroubleshooting' => 'Kongsi log ralat untuk penyelesaian masalah',
			'settings.search' => 'Cari...',
			'settings.errorLoadingContent' => 'Ralat memuatkan kandungan',
			'settings.noLicensesFound' => 'Tiada lesen ditemui',
			'settings.pokaCe' => 'Poka CE',
			'settings.communityEdition' => 'Edisi Komuniti',
			'settings.aboutDescription' => 'Pengurus kewangan peribadi sumber terbuka dan percuma yang direka untuk membantu anda menjejaki perbelanjaan, mengurus belanjawan dan memantau akaun anda secara setempat.',
			'settings.copyright' => '© 2026 POKA. All rights reserved.',
			'settings.noResultsFound' => 'Tiada Hasil Ditemui',
			'settings.weCouldntFindAnyCurrencyMatching' => 'Kami tidak menemui mata wang yang sepadan dengan "{search}".',
			'settings.notSet' => 'Belum Ditetapkan',
			'settings.exportExcel' => 'Eksport ke Excel',
			'settings.exportExcelDesc' => 'Eksport transaksi, akaun dan kategori ke .xlsx',
			'settings.exportExcelSuccess' => 'Excel berjaya dieksport',
			'settings.exportExcelError' => 'Gagal mengeksport fail Excel',
			'settings.currencyLockedToast' => 'Mata wang tidak boleh ditukar selepas transaksi direkodkan. Sila tetapkan semula data jika anda mahu menukarnya.',
			'shared.authRequired' => 'Pengesahan Diperlukan',
			'shared.hexColorCode' => 'Kod Warna Hex',
			'shared.apply' => 'Guna',
			'shared.enterAmount' => 'Masukkan Jumlah',
			'shared.selectCategory' => 'Pilih Kategori',
			'shared.egFf5733' => 'cth., FF5733',
			'shared.amount' => 'Jumlah',
			'shared.noCategoriesAvailable' => 'Tiada kategori tersedia.',
			'shared.noWalletsFoundPleaseCreateOneFirst' => 'Tiada dompet ditemui. Sila cipta satu dahulu.',
			'shared.balance' => 'Baki: ',
			'shared.optional' => 'Pilihan',
			'shared.customColor' => 'Warna Tersuai',
			'shared.selectWallet' => 'Pilih Dompet',
			'transactions.searchTransactions' => 'Cari transaksi...',
			'transactions.failedToLoad' => 'Gagal memuatkan transaksi',
			'transactions.cancel' => 'Batal',
			'transactions.delete' => 'Padam',
			'transactions.goToToday' => 'Ke Hari Ini',
			'transactions.addItem' => 'Tambah Item',
			'transactions.saveSplitTransaction' => 'Simpan Transaksi Pecahan',
			'transactions.transactionType' => 'Jenis Transaksi',
			'transactions.applyFilter' => 'Guna Penapis',
			'transactions.noAccountsAvailable' => 'Tiada akaun tersedia',
			'transactions.account' => 'Akaun',
			'transactions.category' => 'Kategori',
			'transactions.done' => 'Siap',
			'transactions.save' => 'Simpan',
			'transactions.transactions' => 'Transaksi',
			'transactions.splitTransaction' => 'Pecah Transaksi',
			'transactions.from' => 'Dari',
			'transactions.to' => 'Ke',
			'transactions.empty' => '+/-',
			'transactions.filtered' => 'Ditapis',
			'transactions.netBalance' => 'Baki Bersih',
			'transactions.income' => 'Pendapatan',
			'transactions.expense' => 'Perbelanjaan',
			'transactions.selectCategory' => 'Pilih Kategori',
			'transactions.filter' => 'Tapis',
			'transactions.backToToday' => 'Kembali ke hari ini',
			'transactions.deleteTransaction' => 'Padam Transaksi',
			'transactions.deleteTransactionWarning' => 'Memadam transaksi ini akan mengembalikan baki akaun dan belanjawan anda kepada keadaan sebelumnya.',
			'transactions.out' => 'Keluar ',
			'transactions.noTransactions' => 'Tiada transaksi',
			'transactions.addNote' => 'Tambah catatan',
			'transactions.noItemsYet' => 'Belum ada item',
			'transactions.tapAddItemToBeginSplittingntheTransaction' => 'Ketik "Tambah Item" untuk mula memecahkan\ntransaksi.',
			'transactions.addAtLeastOneMoreItemToSave' => 'Tambah sekurang-kurangnya satu item lagi untuk menyimpan.',
			'transactions.noTransactions1' => 'Tiada Transaksi',
			'transactions.reset' => 'Set Semula',
			'transactions.incoming' => 'Masuk ',
			'transactions.nothingRecordedFor' => ({required Object period}) => 'Tiada rekod untuk ${period}.',
			'transactions.splitItems' => ({required Object count}) => '${count} item pecahan',
			'transactions.itemsCount' => ({required Object count}) => '${count} item',
			'transactions.transactionsCount' => ({required Object count}) => '${count} transaksi',
			'transactions.editTransaction' => 'Edit Transaksi',
			'transactions.newTransaction' => 'Transaksi Baharu',
			'transactions.fromAccount' => 'Dari Akaun',
			'transactions.toAccount' => 'Ke Akaun',
			'transactions.need' => 'Keperluan',
			'transactions.want' => 'Kehendak',
			'transactions.saving' => 'Simpanan',
			'transactions.addNoteEllipsis' => 'Tambah catatan...',
			'transactions.editItem' => 'Edit Item',
			'transactions.newItem' => 'Item Baharu',
			'transactions.viewModeDay' => 'Hari',
			'transactions.viewModeWeek' => 'Minggu',
			'transactions.viewModeMonth' => 'Bulan',
			'transactions.viewModeDaily' => 'Harian',
			'transactions.viewModeWeekly' => 'Mingguan',
			'transactions.viewModeMonthly' => 'Bulanan',
			'transactions.debt' => 'Hutang',
			'transactions.recurring' => 'Berulang',
			'transactions.transfer' => 'Pindahan',
			'transactions.weekNumber' => ({required Object weekNum, required Object date}) => 'Minggu ${weekNum} · ${date}',
			'transactions.insufficientBalance' => 'Baki Tidak Mencukupi',
			'transactions.insufficientBalanceWarning' => ({required Object amount, required Object account, required Object balance}) => 'Jumlah (${amount}) melebihi baki semasa dalam ${account} (${balance}). Mungkin anda terlupa merekodkan pendapatan terlebih dahulu?',
			'transactions.insufficientBalanceConsequence' => 'Baki akaun anda akan menjadi negatif jika anda meneruskan.',
			'transactions.continueAnyway' => 'Teruskan Sahaja',
			'transactions.checkAgain' => 'Semak Semula',
			'transactions.transactionDeleted' => 'Transaksi dipadam',
			'transactions.transactionRestored' => 'Transaksi dipulihkan',
			'transactions.allocation' => 'Peruntukan',
			_ => null,
		};
	}
}
