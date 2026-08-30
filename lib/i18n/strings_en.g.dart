///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$accounts$en accounts = Translations$accounts$en.internal(_root);
	late final Translations$app$en app = Translations$app$en.internal(_root);
	late final Translations$backup$en backup = Translations$backup$en.internal(_root);
	late final Translations$budgets$en budgets = Translations$budgets$en.internal(_root);
	late final Translations$categories$en categories = Translations$categories$en.internal(_root);
	late final Translations$common$en common = Translations$common$en.internal(_root);
	late final Translations$dashboard$en dashboard = Translations$dashboard$en.internal(_root);
	late final Translations$debts$en debts = Translations$debts$en.internal(_root);
	Map<String, String> get error => {
		'generic': 'An unexpected error occurred',
		'network': 'Please check your connection and try again',
		'database': 'Failed to access local data',
	};
	late final Translations$goals$en goals = Translations$goals$en.internal(_root);
	late final Translations$lock$en lock = Translations$lock$en.internal(_root);
	late final Translations$onboarding$en onboarding = Translations$onboarding$en.internal(_root);
	late final Translations$recurring$en recurring = Translations$recurring$en.internal(_root);
	late final Translations$reports$en reports = Translations$reports$en.internal(_root);
	late final Translations$settings$en settings = Translations$settings$en.internal(_root);
	late final Translations$shared$en shared = Translations$shared$en.internal(_root);
	late final Translations$transactions$en transactions = Translations$transactions$en.internal(_root);
}

// Path: accounts
class Translations$accounts$en {
	Translations$accounts$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Account Name'
	String get accountName => 'Account Name';

	/// en: 'Initial Balance'
	String get initialBalance => 'Initial Balance';

	/// en: 'Icon'
	String get icon => 'Icon';

	/// en: 'Color'
	String get color => 'Color';

	/// en: 'Assets'
	String get assets => 'Assets';

	/// en: 'Liability'
	String get liability => 'Liability';

	/// en: 'Income'
	String get income => 'Income';

	/// en: 'Expense'
	String get expense => 'Expense';

	/// en: 'Balance'
	String get balance => 'Balance';

	/// en: 'Wallets & Pockets'
	String get walletsPockets => 'Wallets & Pockets';

	/// en: 'Accounts'
	String get accounts => 'Accounts';

	/// en: 'Main Accounts'
	String get mainAccounts => 'Main Accounts';

	/// en: 'Goals & Savings'
	String get goalsAndSavings => 'Goals & Savings';

	/// en: 'Delete Account'
	String get deleteAccount => 'Delete Account';

	/// en: 'Are you sure you want to delete this account? It will be hidden from the app.'
	String get areYouSureYouWantToDeleteThisAccountItWillBeHiddenFromTheApp => 'Are you sure you want to delete this account? It will be hidden from the app.';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'Total Balance'
	String get totalBalance => 'Total Balance';

	/// en: 'Pockets'
	String get pockets => 'Pockets';

	/// en: 'Delete Pocket'
	String get deletePocket => 'Delete Pocket';

	/// en: 'Are you sure you want to delete this pocket? It will be hidden from the app.'
	String get areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp => 'Are you sure you want to delete this pocket? It will be hidden from the app.';

	/// en: 'Name cannot be empty'
	String get nameCannotBeEmpty => 'Name cannot be empty';

	/// en: 'e.g., Main Wallet'
	String get egMainWallet => 'e.g., Main Wallet';

	/// en: 'Select Icon'
	String get selectIcon => 'Select Icon';

	/// en: 'Allowed Categories'
	String get allowedCategories => 'Allowed Categories';

	/// en: 'Transactions'
	String get transactions => 'Transactions';

	/// en: 'Edit Account'
	String get editAccount => 'Edit Account';

	/// en: 'Update name, icon, or color'
	String get updateNameIconOrColor => 'Update name, icon, or color';

	/// en: 'Permanently remove this account'
	String get permanentlyRemoveThisAccount => 'Permanently remove this account';

	/// en: 'See All'
	String get seeAll => 'See All';

	/// en: 'No transactions yet'
	String get noTransactionsYet => 'No transactions yet';

	/// en: 'Add Account'
	String get addAccount => 'Add Account';

	/// en: 'No accounts found.'
	String get noAccountsFound => 'No accounts found.';

	/// en: 'Add Pocket'
	String get addPocket => 'Add Pocket';

	/// en: 'No pockets yet'
	String get noPocketsYet => 'No pockets yet';

	/// en: 'Pockets help you split your wallet into categories'
	String get pocketsHelpYouSplitYourWalletIntoCategories => 'Pockets help you split your wallet into categories';

	/// en: 'Active Account'
	String get activeAccount => 'Active Account';

	/// en: 'Inactive accounts will be hidden'
	String get inactiveAccountsWillBeHidden => 'Inactive accounts will be hidden';

	/// en: 'No categories available.'
	String get noCategoriesAvailable => 'No categories available.';

	/// en: 'No accounts found'
	String get noAccountsFound1 => 'No accounts found';

	/// en: '{{count}} subcategor(ies)'
	String subcategoriesCount({required Object count}) => '${count} subcategor(ies)';

	/// en: '{{count}} pocket(s)'
	String pocketsCount({required Object count}) => '${count} pocket(s)';

	/// en: 'Total Active Accounts'
	String get totalActiveAccounts => 'Total Active Accounts';

	/// en: 'No Accounts Yet'
	String get noAccountsYet => 'No Accounts Yet';

	/// en: 'Tap the button below to add your first account'
	String get tapTheButtonBelowToAddYourFirstAccount => 'Tap the button below to add your first account';
}

// Path: app
class Translations$app$en {
	Translations$app$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Poka'
	String get name => 'Poka';

	/// en: 'Your personal finance companion'
	String get tagline => 'Your personal finance companion';

	late final Translations$app$nav$en nav = Translations$app$nav$en.internal(_root);

	/// en: 'Terms of Service'
	String get termsOfService => 'Terms of Service';

	/// en: 'Privacy Policy'
	String get privacyPolicy => 'Privacy Policy';
}

// Path: backup
class Translations$backup$en {
	Translations$backup$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Backup & Restore'
	String get title => 'Backup & Restore';

	/// en: 'Backup'
	String get backupAction => 'Backup';

	/// en: 'Restore'
	String get restoreAction => 'Restore';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Confirm Password'
	String get confirmPassword => 'Confirm Password';

	/// en: 'Passwords do not match'
	String get passwordsDoNotMatch => 'Passwords do not match';

	/// en: 'Backup successful'
	String get backupSuccess => 'Backup successful';

	/// en: 'Restore successful'
	String get restoreSuccess => 'Restore successful';

	/// en: 'Incorrect password or corrupted file'
	String get incorrectPassword => 'Incorrect password or corrupted file';

	/// en: 'Enter password to encrypt backup'
	String get enterPasswordToEncrypt => 'Enter password to encrypt backup';

	/// en: 'Enter password to decrypt backup'
	String get enterPasswordToDecrypt => 'Enter password to decrypt backup';

	/// en: 'Please restart the app to apply changes.'
	String get pleaseRestart => 'Please restart the app to apply changes.';

	/// en: 'Password is required'
	String get passwordRequired => 'Password is required';
}

// Path: budgets
class Translations$budgets$en {
	Translations$budgets$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Budget name'
	String get budgetName => 'Budget name';

	/// en: 'Spending limit'
	String get spendingLimit => 'Spending limit';

	/// en: 'Period'
	String get period => 'Period';

	/// en: 'Reset day (1–31)'
	String get resetDay => 'Reset day (1–31)';

	/// en: 'Create Budget'
	String get createBudget => 'Create Budget';

	/// en: 'End Date'
	String get endDate => 'End Date';

	/// en: 'Budget Details'
	String get budgetDetails => 'Budget Details';

	/// en: 'Delete Budget'
	String get deleteBudget => 'Delete Budget';

	/// en: 'Are you sure you want to delete this budget? All related tracking history will be permanently deleted. This action cannot be undone.'
	String get areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone => 'Are you sure you want to delete this budget? All related tracking history will be permanently deleted. This action cannot be undone.';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Transactions'
	String get transactions => 'Transactions';

	/// en: 'Budgets'
	String get budgets => 'Budgets';

	/// en: 'All Budgets'
	String get allBudgets => 'All Budgets';

	/// en: 'e.g., Groceries, Entertainment'
	String get egGroceriesEntertainment => 'e.g., Groceries, Entertainment';

	/// en: 'e.g., 80'
	String get eg80 => 'e.g., 80';

	/// en: 'Category'
	String get category => 'Category';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'Over limit'
	String get overLimit => 'Over limit';

	/// en: 'Remaining'
	String get remaining => 'Remaining';

	/// en: 'Total spent'
	String get totalSpent => 'Total spent';

	/// en: 'Total limit'
	String get totalLimit => 'Total limit';

	/// en: 'Select end date'
	String get selectEndDate => 'Select end date';

	/// en: 'No transactions found for this budget period.'
	String get noTransactionsFoundForThisBudgetPeriod => 'No transactions found for this budget period.';

	/// en: 'Add Budget'
	String get addBudget => 'Add Budget';

	/// en: 'Spent '
	String get spent => 'Spent ';

	/// en: 'No budgets yet'
	String get noBudgetsYet => 'No budgets yet';

	/// en: 'Set spending limits to track where your money goes each period.'
	String get setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod => 'Set spending limits to track where your money goes each period.';

	/// en: 'Budget Alert: {{name}}'
	String budgetAlert({required Object name}) => 'Budget Alert: ${name}';

	/// en: '{{percent}}% of '
	String percentOf({required Object percent}) => '${percent}% of ';

	/// en: '{{count}} budget(s)'
	String budgetsCount({required Object count}) => '${count} budget(s)';
}

// Path: categories
class Translations$categories$en {
	Translations$categories$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Expense'
	String get expense => 'Expense';

	/// en: 'Income'
	String get income => 'Income';

	/// en: 'Category Name'
	String get categoryName => 'Category Name';

	/// en: 'Icon'
	String get icon => 'Icon';

	/// en: 'Color'
	String get color => 'Color';

	/// en: 'No categories found.'
	String get noCategoriesFound => 'No categories found.';

	/// en: 'Subcategories'
	String get subcategories => 'Subcategories';

	/// en: 'Categories'
	String get categories => 'Categories';

	/// en: 'e.g., Food & Dining'
	String get egFoodDining => 'e.g., Food & Dining';

	/// en: 'Delete Category'
	String get deleteCategory => 'Delete Category';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Select Icon'
	String get selectIcon => 'Select Icon';

	/// en: 'No subcategories yet'
	String get noSubcategoriesYet => 'No subcategories yet';

	/// en: 'No categories found'
	String get noCategoriesFound1 => 'No categories found';

	/// en: '{{count}} subcategories'
	String subcategoriesCount({required Object count}) => '${count} subcategories';
}

// Path: common
class Translations$common$en {
	Translations$common$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'An error occurred'
	String get error => 'An error occurred';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'No data yet'
	String get empty => 'No data yet';

	/// en: 'This action cannot be undone.'
	String get cannotBeUndone => 'This action cannot be undone.';
}

// Path: dashboard
class Translations$dashboard$en {
	Translations$dashboard$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Overview'
	String get overview => 'Overview';

	/// en: 'My Finances'
	String get myFinances => 'My Finances';

	/// en: 'Net Worth'
	String get netWorth => 'Net Worth';

	/// en: '{{count}} accounts'
	String accountsCount({required Object count}) => '${count} accounts';

	/// en: 'Assets'
	String get assets => 'Assets';

	/// en: 'Liabilities'
	String get liabilities => 'Liabilities';

	/// en: 'Budgets'
	String get budgets => 'Budgets';

	/// en: 'Categories'
	String get categories => 'Categories';

	/// en: 'Goals'
	String get goals => 'Goals';

	/// en: 'Debts'
	String get debts => 'Debts';

	/// en: 'Recurring'
	String get recurring => 'Recurring';

	/// en: 'Cash Flow'
	String get cashFlow => 'Cash Flow';

	/// en: 'Budget'
	String get budget => 'Budget';

	/// en: 'Needs (50%)'
	String get needs => 'Needs (50%)';

	/// en: 'Wants (30%)'
	String get wants => 'Wants (30%)';

	/// en: 'Savings (20%)'
	String get savings => 'Savings (20%)';

	/// en: 'saved'
	String get saved => 'saved';

	/// en: 'On track'
	String get onTrack => 'On track';

	/// en: 'Needs attention'
	String get needsAttention => 'Needs attention';

	/// en: 'Income'
	String get income => 'Income';

	/// en: 'Expense'
	String get expense => 'Expense';

	/// en: 'Other'
	String get other => 'Other';

	/// en: 'No data'
	String get noData => 'No data';

	/// en: 'Spending Activity'
	String get spendingActivity => 'Spending Activity';

	/// en: 'Total'
	String get total => 'Total';

	/// en: 'Average'
	String get average => 'Average';

	/// en: 'Budget/Day'
	String get budgetPerDay => 'Budget/Day';

	/// en: 'Today's Budget'
	String get todaysBudget => 'Today\'s Budget';

	/// en: 'Overbudget!'
	String get overbudget => 'Overbudget!';

	/// en: 'Set Daily Budget'
	String get setDailyBudget => 'Set Daily Budget';

	/// en: 'Amount'
	String get amount => 'Amount';

	/// en: 'e.g. 100000'
	String get amountHint => 'e.g. 100000';

	/// en: 'Recent Transactions'
	String get recentTransactions => 'Recent Transactions';

	/// en: 'This month'
	String get thisMonth => 'This month';

	/// en: 'No recent transactions'
	String get noRecentTransactions => 'No recent transactions';

	/// en: 'See All'
	String get seeAll => 'See All';

	/// en: 'Not set'
	String get notSet => 'Not set';

	late final Translations$dashboard$insight$en insight = Translations$dashboard$insight$en.internal(_root);
	late final Translations$dashboard$days$en days = Translations$dashboard$days$en.internal(_root);
}

// Path: debts
class Translations$debts$en {
	Translations$debts$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add Repayment'
	String get addRepayment => 'Add Repayment';

	/// en: 'I Owe'
	String get iOwe => 'I Owe';

	/// en: 'They Owe'
	String get theyOwe => 'They Owe';

	/// en: 'Person name'
	String get personName => 'Person name';

	/// en: 'Principal amount'
	String get principalAmount => 'Principal amount';

	/// en: 'Transaction Binding'
	String get transactionBinding => 'Transaction Binding';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'OK'
	String get ok => 'OK';

	/// en: 'Add Record'
	String get addRecord => 'Add Record';

	/// en: 'Debt Details'
	String get debtDetails => 'Debt Details';

	/// en: 'Repayment History'
	String get repaymentHistory => 'Repayment History';

	/// en: 'Debts & Loans'
	String get debtsLoans => 'Debts & Loans';

	/// en: 'Delete Debt'
	String get deleteDebt => 'Delete Debt';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Write-off Debt'
	String get writeoffDebt => 'Write-off Debt';

	/// en: 'Are you sure you want to write-off this debt? It will be marked as paid without affecting your wallet balances.'
	String get areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances => 'Are you sure you want to write-off this debt? It will be marked as paid without affecting your wallet balances.';

	/// en: 'Write-off'
	String get writeoff => 'Write-off';

	/// en: 'e.g., John Doe'
	String get egJohnDoe => 'e.g., John Doe';

	/// en: 'Category'
	String get category => 'Category';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'e.g., Dinner last Friday'
	String get egDinnerLastFriday => 'e.g., Dinner last Friday';

	/// en: 'Select due date'
	String get selectDueDate => 'Select due date';

	/// en: 'Outstanding'
	String get outstanding => 'Outstanding';

	/// en: 'Paid'
	String get paid => 'Paid';

	/// en: 'Principal'
	String get principal => 'Principal';

	/// en: 'Action Denied'
	String get actionDenied => 'Action Denied';

	/// en: 'Jumlah pembayaran tidak boleh melebihi sisa utang.'
	String get jumlahPembayaranTidakBolehMelebihiSisaUtang => 'Jumlah pembayaran tidak boleh melebihi sisa utang.';

	/// en: 'Add note'
	String get addNote => 'Add note';

	/// en: 'Pay in Full'
	String get payInFull => 'Pay in Full';

	/// en: 'remaining'
	String get remaining => 'remaining';

	/// en: 'Paid '
	String get paid1 => 'Paid ';

	/// en: 'Reminder {{type}}: {{name}}'
	String reminder({required Object type, required Object name}) => 'Reminder ${type}: ${name}';

	/// en: '{{type}} Due: {{name}}'
	String due({required Object type, required Object name}) => '${type} Due: ${name}';

	/// en: 'No history found for this {{type}}'
	String noHistoryFoundForThis({required Object type}) => 'No history found for this ${type}';

	/// en: 'Failed to load debts: {{error}}'
	String failedToLoadDebts({required Object error}) => 'Failed to load debts: ${error}';

	/// en: '{{percent}}% of '
	String percentOf({required Object percent}) => '${percent}% of ';

	/// en: '{{count}} settled'
	String settled({required Object count}) => '${count} settled';

	/// en: 'Payable'
	String get payable => 'Payable';

	/// en: 'Receivable'
	String get receivable => 'Receivable';

	/// en: 'No debts recorded'
	String get noDebtsRecorded => 'No debts recorded';

	/// en: 'No loans recorded'
	String get noLoansRecorded => 'No loans recorded';

	/// en: 'Track money you owe to others and log repayments.'
	String get trackMoneyYouOweToOthersAndLogRepayments => 'Track money you owe to others and log repayments.';

	/// en: 'Track money others owe you and log collections.'
	String get trackMoneyOthersOweYouAndLogCollections => 'Track money others owe you and log collections.';
}

// Path: goals
class Translations$goals$en {
	Translations$goals$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Fulfill Goal (Spend)'
	String get fulfillGoal => 'Fulfill Goal (Spend)';

	/// en: 'Goal name'
	String get goalName => 'Goal name';

	/// en: 'Target amount'
	String get targetAmount => 'Target amount';

	/// en: 'Create Goal'
	String get createGoal => 'Create Goal';

	/// en: 'Error: {{error}}'
	String errorPrefix({required Object error}) => 'Error: ${error}';

	/// en: 'Goal Details'
	String get goalDetails => 'Goal Details';

	/// en: 'Transactions'
	String get transactions => 'Transactions';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Past'
	String get past => 'Past';

	/// en: 'Action Denied'
	String get actionDenied => 'Action Denied';

	/// en: 'Kosongkan saldo (transfer keluar) sebelum menghapus Goal ini.'
	String get kosongkanSaldoTransferKeluarSebelumMenghapusGoalIni => 'Kosongkan saldo (transfer keluar) sebelum menghapus Goal ini.';

	/// en: 'OK'
	String get ok => 'OK';

	/// en: 'Delete Goal'
	String get deleteGoal => 'Delete Goal';

	/// en: 'Are you sure you want to delete this goal? The associated pocket account and its history will also be removed. This action cannot be undone.'
	String get areYouSureYouWantToDeleteThisGoalTheAssociatedPocketAccountAndItsHistoryWillAlsoBeRemovedThisActionCannotBeUndone => 'Are you sure you want to delete this goal? The associated pocket account and its history will also be removed. This action cannot be undone.';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'e.g., Emergency Fund, New Laptop'
	String get egEmergencyFundNewLaptop => 'e.g., Emergency Fund, New Laptop';

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'Fully funded'
	String get fullyFunded => 'Fully funded';

	/// en: 'In progress'
	String get inProgress => 'In progress';

	/// en: 'Total Saved'
	String get totalSaved => 'Total Saved';

	/// en: 'Still needed'
	String get stillNeeded => 'Still needed';

	/// en: 'Total target'
	String get totalTarget => 'Total target';

	/// en: 'Select target date'
	String get selectTargetDate => 'Select target date';

	/// en: 'No transactions found for this goal.'
	String get noTransactionsFoundForThisGoal => 'No transactions found for this goal.';

	/// en: 'Add Goal'
	String get addGoal => 'Add Goal';

	/// en: 'A dedicated Pocket account will be created automatically to track this goal.'
	String get aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal => 'A dedicated Pocket account will be created automatically to track this goal.';

	/// en: 'saved'
	String get saved => 'saved';

	/// en: 'Needs '
	String get needs => 'Needs ';

	/// en: ' more'
	String get more => ' more';

	/// en: 'No goals yet'
	String get noGoalsYet => 'No goals yet';

	/// en: 'Set savings targets — a dedicated pocket is created automatically for each goal.'
	String get setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal => 'Set savings targets — a dedicated pocket is created automatically for each goal.';

	/// en: '{{percent}}% of target'
	String percentOfTarget({required Object percent}) => '${percent}% of target';

	/// en: '{{count}} goal(s)'
	String goalsCount({required Object count}) => '${count} goal(s)';

	/// en: '{{count}} fully funded'
	String fullyFundedCount({required Object count}) => '${count} fully funded';

	/// en: 'No completed goals yet'
	String get noCompletedGoalsYet => 'No completed goals yet';

	/// en: 'Goals you complete will appear here.'
	String get completedGoalsWillAppearHere => 'Goals you complete will appear here.';
}

// Path: lock
class Translations$lock$en {
	Translations$lock$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Confirm PIN'
	String get confirmPin => 'Confirm PIN';

	/// en: 'Create PIN'
	String get createPin => 'Create PIN';

	/// en: 'PINs do not match'
	String get pinsDoNotMatch => 'PINs do not match';

	/// en: 'Re-enter PIN'
	String get reenterPin => 'Re-enter PIN';

	/// en: 'Enter PIN for App Lock'
	String get enterPinAppLock => 'Enter PIN for App Lock';

	/// en: 'Incorrect PIN'
	String get incorrectPin => 'Incorrect PIN';

	/// en: 'Verify Identity'
	String get verifyIdentity => 'Verify Identity';

	/// en: 'Try again in {{seconds}} seconds'
	String retryInSeconds({required Object seconds}) => 'Try again in ${seconds} seconds';

	/// en: 'Setup PIN'
	String get setupPinTitle => 'Setup PIN';

	/// en: 'Please create a PIN first before enabling App Lock or Biometrics.'
	String get setupPinBody => 'Please create a PIN first before enabling App Lock or Biometrics.';

	/// en: 'Unlocked'
	String get unlocked => 'Unlocked';

	/// en: 'Enter 6-digit PIN'
	String get enter6DigitPin => 'Enter 6-digit PIN';

	/// en: 'Enter PIN'
	String get enterPin => 'Enter PIN';

	/// en: 'Invalid PIN'
	String get invalidPin => 'Invalid PIN';

	/// en: 'Too many attempts'
	String get tooManyAttempts => 'Too many attempts';

	/// en: 'Temporarily locked'
	String get temporarilyLocked => 'Temporarily locked';
}

// Path: onboarding
class Translations$onboarding$en {
	Translations$onboarding$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Continue with selected currency'
	String get continueWithCurrency => 'Continue with selected currency';

	/// en: 'Choose Your Base Currency'
	String get chooseYourBaseCurrency => 'Choose Your Base Currency';

	/// en: 'This currency will be used for all accounts, pockets, and transactions. You can change this later in settings.'
	String get thisCurrencyWillBeUsedForAllAccountsPocketsAndTransactionsYouCanChangeThisLaterInSettings => 'This currency will be used for all accounts, pockets, and transactions. You can change this later in settings.';
}

// Path: recurring
class Translations$recurring$en {
	Translations$recurring$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add Schedule'
	String get addSchedule => 'Add Schedule';

	/// en: 'Transaction Details'
	String get transactionDetails => 'Transaction Details';

	/// en: 'Amount'
	String get amount => 'Amount';

	/// en: 'Frequency'
	String get frequency => 'Frequency';

	/// en: 'Start Date'
	String get startDate => 'Start Date';

	/// en: 'Recurring'
	String get recurring => 'Recurring';

	/// en: 'Schedules'
	String get schedules => 'Schedules';

	/// en: 'Schedule Details'
	String get scheduleDetails => 'Schedule Details';

	/// en: 'Delete Schedule'
	String get deleteSchedule => 'Delete Schedule';

	/// en: 'Are you sure you want to delete this recurring schedule? Existing generated transactions will not be deleted.'
	String get areYouSureYouWantToDeleteThisRecurringScheduleExistingGeneratedTransactionsWillNotBeDeleted => 'Are you sure you want to delete this recurring schedule? Existing generated transactions will not be deleted.';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Trigger History'
	String get triggerHistory => 'Trigger History';

	/// en: 'Destination Account'
	String get destinationAccount => 'Destination Account';

	/// en: 'Category'
	String get category => 'Category';

	/// en: 'e.g., Netflix subscription'
	String get egNetflixSubscription => 'e.g., Netflix subscription';

	/// en: 'Select first due date'
	String get selectFirstDueDate => 'Select first due date';

	/// en: 'Est. Monthly Net'
	String get estMonthlyNet => 'Est. Monthly Net';

	/// en: 'Monthly In'
	String get monthlyIn => 'Monthly In';

	/// en: 'Monthly Out'
	String get monthlyOut => 'Monthly Out';

	/// en: 'No recurring transactions'
	String get noRecurringTransactions => 'No recurring transactions';

	/// en: 'Automate bills like subscriptions or salary. The app will record them on schedule.'
	String get automateBillsLikeSubscriptionsOrSalary => 'Automate bills like subscriptions or salary. The app will record them on schedule.';

	/// en: 'No history found for this schedule.'
	String get noHistoryFoundForThisSchedule => 'No history found for this schedule.';

	/// en: 'Allocation'
	String get allocation => 'Allocation';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Each time the app opens, overdue recurring transactions are automatically recorded in your ledger.'
	String get eachTimeTheAppOpensOverdueRecurringTransactionsAre => 'Each time the app opens, overdue recurring transactions are automatically recorded in your ledger.';

	/// en: '{{count}} schedules'
	String schedulesCount({required Object count}) => '${count} schedules';

	/// en: '{{count}} paused'
	String pausedCount({required Object count}) => '${count} paused';
}

// Path: reports
class Translations$reports$en {
	Translations$reports$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reports'
	String get title => 'Reports';

	/// en: 'Financial Overview'
	String get overview => 'Financial Overview';

	/// en: 'Cashflow'
	String get tabCashflow => 'Cashflow';

	/// en: 'Budgets & Goals'
	String get tabBudgets => 'Budgets & Goals';

	/// en: 'Period'
	String get period => 'Period';

	/// en: 'This Month'
	String get thisMonth => 'This Month';

	/// en: 'Last Month'
	String get lastMonth => 'Last Month';

	/// en: '3 Months'
	String get last3Months => '3 Months';

	/// en: '6 Months'
	String get last6Months => '6 Months';

	/// en: 'Custom'
	String get custom => 'Custom';

	/// en: 'Income'
	String get income => 'Income';

	/// en: 'Expense'
	String get expense => 'Expense';

	/// en: 'Net Savings'
	String get netSavings => 'Net Savings';

	/// en: 'Net Cash Flow'
	String get netCashflow => 'Net Cash Flow';

	/// en: 'Cash Flow'
	String get cashflow => 'Cash Flow';

	/// en: 'Savings Rate'
	String get savingsRate => 'Savings Rate';

	/// en: 'Top Categories'
	String get topCategories => 'Top Categories';

	/// en: 'Top Expenses'
	String get topExpenses => 'Top Expenses';

	/// en: 'Top Income'
	String get topIncome => 'Top Income';

	/// en: 'Monthly Trend'
	String get monthlyTrend => 'Monthly Trend';

	/// en: 'Income vs Expense Trend'
	String get cashflowTrend => 'Income vs Expense Trend';

	/// en: 'Budget Breakdown'
	String get budgetBreakdown => 'Budget Breakdown';

	/// en: 'Budget Utilization'
	String get budgetUtilization => 'Budget Utilization';

	/// en: 'Spending Allocation'
	String get spendingAllocation => 'Spending Allocation';

	/// en: 'No data for this period'
	String get noData => 'No data for this period';

	/// en: 'No budgets configured'
	String get noBudgets => 'No budgets configured';

	/// en: 'Add budgets to track your spending limits'
	String get noBudgetsDesc => 'Add budgets to track your spending limits';

	/// en: 'On track'
	String get onTrack => 'On track';

	/// en: 'Needs attention'
	String get needsAttention => 'Needs attention';

	/// en: 'Over budget'
	String get overBudget => 'Over budget';

	/// en: 'Within limit'
	String get onBudget => 'Within limit';

	/// en: 'Needs'
	String get needs => 'Needs';

	/// en: 'Wants'
	String get wants => 'Wants';

	/// en: 'Savings'
	String get savings => 'Savings';

	/// en: 'Other'
	String get other => 'Other';

	/// en: 'Total'
	String get total => 'Total';

	/// en: 'Average'
	String get average => 'Average';

	/// en: 'Remaining'
	String get remaining => 'Remaining';

	/// en: 'Spent'
	String get spent => 'Spent';

	/// en: 'Limit'
	String get limit => 'Limit';

	/// en: '{{count}} transactions'
	String txCount({required Object count}) => '${count} transactions';

	/// en: 'Select Date Range'
	String get selectDateRange => 'Select Date Range';

	/// en: 'Apply'
	String get apply => 'Apply';

	/// en: 'From'
	String get from => 'From';

	/// en: 'To'
	String get to => 'To';

	/// en: 'vs {{period}}'
	String comparedTo({required Object period}) => 'vs ${period}';

	/// en: 'higher'
	String get higher => 'higher';

	/// en: 'lower'
	String get lower => 'lower';

	/// en: 'same as'
	String get same => 'same as';

	/// en: 'No change'
	String get noChange => 'No change';

	/// en: '50%'
	String get percent50 => '50%';

	/// en: '30%'
	String get percent30 => '30%';

	/// en: '20%'
	String get percent20 => '20%';

	/// en: '50/30/20'
	String get rule503020 => '50/30/20';
}

// Path: settings
class Translations$settings$en {
	Translations$settings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	/// en: 'Preferences'
	String get preferences => 'Preferences';

	/// en: 'Base Currency'
	String get baseCurrency => 'Base Currency';

	/// en: 'Theme'
	String get theme => 'Theme';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Number Format'
	String get numberFormat => 'Number Format';

	/// en: 'Select Number Format'
	String get selectNumberFormat => 'Select Number Format';

	/// en: 'App Default'
	String get formatSystem => 'App Default';

	/// en: '1.000.000,00'
	String get formatId => '1.000.000,00';

	/// en: '1,000,000.00'
	String get formatUs => '1,000,000.00';

	/// en: '1 000 000,00'
	String get formatFr => '1 000 000,00';

	/// en: 'System'
	String get system => 'System';

	/// en: 'English'
	String get english => 'English';

	/// en: 'Indonesia'
	String get indonesia => 'Indonesia';

	/// en: 'Security'
	String get security => 'Security';

	/// en: 'App Lock'
	String get appLock => 'App Lock';

	/// en: 'Protect app with PIN'
	String get appLockDesc => 'Protect app with PIN';

	/// en: 'Biometrics'
	String get biometrics => 'Biometrics';

	/// en: 'Use fingerprint to unlock'
	String get biometricsDesc => 'Use fingerprint to unlock';

	/// en: 'Data Management'
	String get dataManagement => 'Data Management';

	/// en: 'Backup & Restore'
	String get backupRestore => 'Backup & Restore';

	/// en: 'Save or restore your data'
	String get backupRestoreDesc => 'Save or restore your data';

	/// en: 'Clear Old Transactions'
	String get clearOld => 'Clear Old Transactions';

	/// en: 'Remove transactions older than 1 year'
	String get clearOldDesc => 'Remove transactions older than 1 year';

	/// en: 'Reset Data'
	String get resetData => 'Reset Data';

	/// en: 'Erase all app data locally'
	String get resetDataDesc => 'Erase all app data locally';

	/// en: 'Support'
	String get support => 'Support';

	/// en: 'FAQ'
	String get faq => 'FAQ';

	/// en: 'Frequently Asked Questions'
	String get faqDesc => 'Frequently Asked Questions';

	/// en: 'About Poka CE'
	String get about => 'About Poka CE';

	/// en: 'Version and legal information'
	String get aboutDesc => 'Version and legal information';

	/// en: 'Select Theme'
	String get selectTheme => 'Select Theme';

	/// en: 'Light'
	String get themeLight => 'Light';

	/// en: 'Dark'
	String get themeDark => 'Dark';

	/// en: 'Select Language'
	String get selectLanguage => 'Select Language';

	/// en: 'Old transactions cleared successfully'
	String get oldTransactionsCleared => 'Old transactions cleared successfully';

	/// en: 'App data reset successfully'
	String get appDataReset => 'App data reset successfully';

	/// en: 'Failed to export logs'
	String get failedToExportLogs => 'Failed to export logs';

	/// en: '{{remaining}} taps away from a surprise...'
	String easterEggRemaining({required Object remaining}) => '${remaining} taps away from a surprise...';

	/// en: '🎉 You found the easter egg!'
	String get easterEggFound => '🎉 You found the easter egg!';

	/// en: 'Select Currency'
	String get selectCurrency => 'Select Currency';

	/// en: 'Open Source Licenses'
	String get openSourceLicenses => 'Open Source Licenses';

	/// en: 'Help & Issues'
	String get helpIssues => 'Help & Issues';

	/// en: 'Report bugs or request features'
	String get reportBugsOrRequestFeatures => 'Report bugs or request features';

	/// en: 'Legal'
	String get legal => 'Legal';

	/// en: 'Terms of Service'
	String get termsOfService => 'Terms of Service';

	/// en: 'Read our terms and conditions'
	String get readOurTermsAndConditions => 'Read our terms and conditions';

	/// en: 'Privacy Policy'
	String get privacyPolicy => 'Privacy Policy';

	/// en: 'Learn how we handle your data'
	String get learnHowWeHandleYourData => 'Learn how we handle your data';

	/// en: 'View third-party software licenses'
	String get viewThirdpartySoftwareLicenses => 'View third-party software licenses';

	/// en: 'Advanced'
	String get advanced => 'Advanced';

	/// en: 'Export Debug Logs'
	String get exportDebugLogs => 'Export Debug Logs';

	/// en: 'Share error logs for troubleshooting'
	String get shareErrorLogsForTroubleshooting => 'Share error logs for troubleshooting';

	/// en: 'Search...'
	String get search => 'Search...';

	/// en: 'Error loading content'
	String get errorLoadingContent => 'Error loading content';

	/// en: 'No licenses found'
	String get noLicensesFound => 'No licenses found';

	/// en: 'Poka CE'
	String get pokaCe => 'Poka CE';

	/// en: 'Community Edition'
	String get communityEdition => 'Community Edition';

	/// en: 'A free and open-source personal finance manager designed to help you track expenses, manage budgets, and monitor your accounts locally.'
	String get aboutDescription => 'A free and open-source personal finance manager designed to help you track expenses, manage budgets, and monitor your accounts locally.';

	/// en: '© 2026 POKA. All rights reserved.'
	String get copyright => '© 2026 POKA. All rights reserved.';

	/// en: 'No Results Found'
	String get noResultsFound => 'No Results Found';

	/// en: 'We couldn't find any currency matching "{search}".'
	String get weCouldntFindAnyCurrencyMatching => 'We couldn\'t find any currency matching "{search}".';
}

// Path: shared
class Translations$shared$en {
	Translations$shared$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Authentication Required'
	String get authRequired => 'Authentication Required';

	/// en: 'Hex Color Code'
	String get hexColorCode => 'Hex Color Code';

	/// en: 'Apply'
	String get apply => 'Apply';

	/// en: 'Enter Amount'
	String get enterAmount => 'Enter Amount';

	/// en: 'Select Category'
	String get selectCategory => 'Select Category';

	/// en: 'e.g., FF5733'
	String get egFf5733 => 'e.g., FF5733';

	/// en: 'Amount'
	String get amount => 'Amount';

	/// en: 'No categories available.'
	String get noCategoriesAvailable => 'No categories available.';

	/// en: 'No wallets found. Please create one first.'
	String get noWalletsFoundPleaseCreateOneFirst => 'No wallets found. Please create one first.';

	/// en: 'Balance: '
	String get balance => 'Balance: ';

	/// en: 'Optional'
	String get optional => 'Optional';

	/// en: 'Custom Color'
	String get customColor => 'Custom Color';
}

// Path: transactions
class Translations$transactions$en {
	Translations$transactions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Search transactions...'
	String get searchTransactions => 'Search transactions...';

	/// en: 'Failed to load transactions'
	String get failedToLoad => 'Failed to load transactions';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Go to Today'
	String get goToToday => 'Go to Today';

	/// en: 'Add Item'
	String get addItem => 'Add Item';

	/// en: 'Save Split Transaction'
	String get saveSplitTransaction => 'Save Split Transaction';

	/// en: 'Transaction Type'
	String get transactionType => 'Transaction Type';

	/// en: 'Apply Filter'
	String get applyFilter => 'Apply Filter';

	/// en: 'No accounts available'
	String get noAccountsAvailable => 'No accounts available';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'Category'
	String get category => 'Category';

	/// en: 'Done'
	String get done => 'Done';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Transactions'
	String get transactions => 'Transactions';

	/// en: 'Split Transaction'
	String get splitTransaction => 'Split Transaction';

	/// en: 'From'
	String get from => 'From';

	/// en: 'To'
	String get to => 'To';

	/// en: '+/-'
	String get empty => '+/-';

	/// en: 'Filtered'
	String get filtered => 'Filtered';

	/// en: 'Net Balance'
	String get netBalance => 'Net Balance';

	/// en: 'Income'
	String get income => 'Income';

	/// en: 'Expense'
	String get expense => 'Expense';

	/// en: 'Select Category'
	String get selectCategory => 'Select Category';

	/// en: 'Filter'
	String get filter => 'Filter';

	/// en: 'Back to today'
	String get backToToday => 'Back to today';

	/// en: 'Delete Transaction'
	String get deleteTransaction => 'Delete Transaction';

	/// en: 'Deleting this transaction will revert your account balance and budget to their previous state.'
	String get deleteTransactionWarning => 'Deleting this transaction will revert your account balance and budget to their previous state.';

	/// en: 'Out '
	String get out => 'Out ';

	/// en: 'No transactions'
	String get noTransactions => 'No transactions';

	/// en: 'Add note'
	String get addNote => 'Add note';

	/// en: 'No items yet'
	String get noItemsYet => 'No items yet';

	/// en: 'Tap "Add Item" to begin splitting\nthe transaction.'
	String get tapAddItemToBeginSplittingntheTransaction => 'Tap "Add Item" to begin splitting\nthe transaction.';

	/// en: 'Add at least one more item to save.'
	String get addAtLeastOneMoreItemToSave => 'Add at least one more item to save.';

	/// en: 'No Transactions'
	String get noTransactions1 => 'No Transactions';

	/// en: 'Reset'
	String get reset => 'Reset';

	/// en: 'In '
	String get incoming => 'In ';

	/// en: 'Nothing recorded for {{period}}.'
	String nothingRecordedFor({required Object period}) => 'Nothing recorded for ${period}.';

	/// en: '{{count}} split items'
	String splitItems({required Object count}) => '${count} split items';

	/// en: '{{count}} item(s)'
	String itemsCount({required Object count}) => '${count} item(s)';

	/// en: '{{count}} transactions'
	String transactionsCount({required Object count}) => '${count} transactions';
}

// Path: app.nav
class Translations$app$nav$en {
	Translations$app$nav$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Transactions'
	String get transactions => 'Transactions';

	/// en: 'Reports'
	String get reports => 'Reports';

	/// en: 'Accounts'
	String get accounts => 'Accounts';

	/// en: 'Settings'
	String get settings => 'Settings';
}

// Path: dashboard.insight
class Translations$dashboard$insight$en {
	Translations$dashboard$insight$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No data this month to analyze.'
	String get noData => 'No data this month to analyze.';

	/// en: 'this month is'
	String get thisMonth => 'this month is';

	/// en: 'up'
	String get up => 'up';

	/// en: 'down'
	String get down => 'down';

	/// en: 'same as'
	String get same => 'same as';

	/// en: 'from last month.'
	String get fromLastMonth => 'from last month.';
}

// Path: dashboard.days
class Translations$dashboard$days$en {
	Translations$dashboard$days$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Mon'
	String get mon => 'Mon';

	/// en: 'Tue'
	String get tue => 'Tue';

	/// en: 'Wed'
	String get wed => 'Wed';

	/// en: 'Thu'
	String get thu => 'Thu';

	/// en: 'Fri'
	String get fri => 'Fri';

	/// en: 'Sat'
	String get sat => 'Sat';

	/// en: 'Sun'
	String get sun => 'Sun';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'accounts.accountName' => 'Account Name',
			'accounts.initialBalance' => 'Initial Balance',
			'accounts.icon' => 'Icon',
			'accounts.color' => 'Color',
			'accounts.assets' => 'Assets',
			'accounts.liability' => 'Liability',
			'accounts.income' => 'Income',
			'accounts.expense' => 'Expense',
			'accounts.balance' => 'Balance',
			'accounts.walletsPockets' => 'Wallets & Pockets',
			'accounts.accounts' => 'Accounts',
			'accounts.mainAccounts' => 'Main Accounts',
			'accounts.goalsAndSavings' => 'Goals & Savings',
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
			'accounts.selectIcon' => 'Select Icon',
			'accounts.allowedCategories' => 'Allowed Categories',
			'accounts.transactions' => 'Transactions',
			'accounts.editAccount' => 'Edit Account',
			'accounts.updateNameIconOrColor' => 'Update name, icon, or color',
			'accounts.permanentlyRemoveThisAccount' => 'Permanently remove this account',
			'accounts.seeAll' => 'See All',
			'accounts.noTransactionsYet' => 'No transactions yet',
			'accounts.addAccount' => 'Add Account',
			'accounts.noAccountsFound' => 'No accounts found.',
			'accounts.addPocket' => 'Add Pocket',
			'accounts.noPocketsYet' => 'No pockets yet',
			'accounts.pocketsHelpYouSplitYourWalletIntoCategories' => 'Pockets help you split your wallet into categories',
			'accounts.activeAccount' => 'Active Account',
			'accounts.inactiveAccountsWillBeHidden' => 'Inactive accounts will be hidden',
			'accounts.noCategoriesAvailable' => 'No categories available.',
			'accounts.noAccountsFound1' => 'No accounts found',
			'accounts.subcategoriesCount' => ({required Object count}) => '${count} subcategor(ies)',
			'accounts.pocketsCount' => ({required Object count}) => '${count} pocket(s)',
			'accounts.totalActiveAccounts' => 'Total Active Accounts',
			'accounts.noAccountsYet' => 'No Accounts Yet',
			'accounts.tapTheButtonBelowToAddYourFirstAccount' => 'Tap the button below to add your first account',
			'app.name' => 'Poka',
			'app.tagline' => 'Your personal finance companion',
			'app.nav.home' => 'Home',
			'app.nav.transactions' => 'Transactions',
			'app.nav.reports' => 'Reports',
			'app.nav.accounts' => 'Accounts',
			'app.nav.settings' => 'Settings',
			'app.termsOfService' => 'Terms of Service',
			'app.privacyPolicy' => 'Privacy Policy',
			'backup.title' => 'Backup & Restore',
			'backup.backupAction' => 'Backup',
			'backup.restoreAction' => 'Restore',
			'backup.password' => 'Password',
			'backup.confirmPassword' => 'Confirm Password',
			'backup.passwordsDoNotMatch' => 'Passwords do not match',
			'backup.backupSuccess' => 'Backup successful',
			'backup.restoreSuccess' => 'Restore successful',
			'backup.incorrectPassword' => 'Incorrect password or corrupted file',
			'backup.enterPasswordToEncrypt' => 'Enter password to encrypt backup',
			'backup.enterPasswordToDecrypt' => 'Enter password to decrypt backup',
			'backup.pleaseRestart' => 'Please restart the app to apply changes.',
			'backup.passwordRequired' => 'Password is required',
			'budgets.budgetName' => 'Budget name',
			'budgets.spendingLimit' => 'Spending limit',
			'budgets.period' => 'Period',
			'budgets.resetDay' => 'Reset day (1–31)',
			'budgets.createBudget' => 'Create Budget',
			'budgets.endDate' => 'End Date',
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
			'budgets.selectEndDate' => 'Select end date',
			'budgets.noTransactionsFoundForThisBudgetPeriod' => 'No transactions found for this budget period.',
			'budgets.addBudget' => 'Add Budget',
			'budgets.spent' => 'Spent ',
			'budgets.noBudgetsYet' => 'No budgets yet',
			'budgets.setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod' => 'Set spending limits to track where your money goes each period.',
			'budgets.budgetAlert' => ({required Object name}) => 'Budget Alert: ${name}',
			'budgets.percentOf' => ({required Object percent}) => '${percent}% of ',
			'budgets.budgetsCount' => ({required Object count}) => '${count} budget(s)',
			'categories.expense' => 'Expense',
			'categories.income' => 'Income',
			'categories.categoryName' => 'Category Name',
			'categories.icon' => 'Icon',
			'categories.color' => 'Color',
			'categories.noCategoriesFound' => 'No categories found.',
			'categories.subcategories' => 'Subcategories',
			'categories.categories' => 'Categories',
			'categories.egFoodDining' => 'e.g., Food & Dining',
			'categories.deleteCategory' => 'Delete Category',
			'categories.delete' => 'Delete',
			'categories.selectIcon' => 'Select Icon',
			'categories.noSubcategoriesYet' => 'No subcategories yet',
			'categories.noCategoriesFound1' => 'No categories found',
			'categories.subcategoriesCount' => ({required Object count}) => '${count} subcategories',
			'common.save' => 'Save',
			'common.cancel' => 'Cancel',
			'common.delete' => 'Delete',
			'common.edit' => 'Edit',
			'common.confirm' => 'Confirm',
			'common.back' => 'Back',
			'common.loading' => 'Loading...',
			'common.error' => 'An error occurred',
			'common.retry' => 'Retry',
			'common.empty' => 'No data yet',
			'common.cannotBeUndone' => 'This action cannot be undone.',
			'dashboard.overview' => 'Overview',
			'dashboard.myFinances' => 'My Finances',
			'dashboard.netWorth' => 'Net Worth',
			'dashboard.accountsCount' => ({required Object count}) => '${count} accounts',
			'dashboard.assets' => 'Assets',
			'dashboard.liabilities' => 'Liabilities',
			'dashboard.budgets' => 'Budgets',
			'dashboard.categories' => 'Categories',
			'dashboard.goals' => 'Goals',
			'dashboard.debts' => 'Debts',
			'dashboard.recurring' => 'Recurring',
			'dashboard.cashFlow' => 'Cash Flow',
			'dashboard.budget' => 'Budget',
			'dashboard.needs' => 'Needs (50%)',
			'dashboard.wants' => 'Wants (30%)',
			'dashboard.savings' => 'Savings (20%)',
			'dashboard.saved' => 'saved',
			'dashboard.onTrack' => 'On track',
			'dashboard.needsAttention' => 'Needs attention',
			'dashboard.income' => 'Income',
			'dashboard.expense' => 'Expense',
			'dashboard.other' => 'Other',
			'dashboard.noData' => 'No data',
			'dashboard.spendingActivity' => 'Spending Activity',
			'dashboard.total' => 'Total',
			'dashboard.average' => 'Average',
			'dashboard.budgetPerDay' => 'Budget/Day',
			'dashboard.todaysBudget' => 'Today\'s Budget',
			'dashboard.overbudget' => 'Overbudget!',
			'dashboard.setDailyBudget' => 'Set Daily Budget',
			'dashboard.amount' => 'Amount',
			'dashboard.amountHint' => 'e.g. 100000',
			'dashboard.recentTransactions' => 'Recent Transactions',
			'dashboard.thisMonth' => 'This month',
			'dashboard.noRecentTransactions' => 'No recent transactions',
			'dashboard.seeAll' => 'See All',
			'dashboard.notSet' => 'Not set',
			'dashboard.insight.noData' => 'No data this month to analyze.',
			'dashboard.insight.thisMonth' => 'this month is',
			'dashboard.insight.up' => 'up',
			'dashboard.insight.down' => 'down',
			'dashboard.insight.same' => 'same as',
			'dashboard.insight.fromLastMonth' => 'from last month.',
			'dashboard.days.mon' => 'Mon',
			'dashboard.days.tue' => 'Tue',
			'dashboard.days.wed' => 'Wed',
			'dashboard.days.thu' => 'Thu',
			'dashboard.days.fri' => 'Fri',
			'dashboard.days.sat' => 'Sat',
			'dashboard.days.sun' => 'Sun',
			'debts.addRepayment' => 'Add Repayment',
			'debts.iOwe' => 'I Owe',
			'debts.theyOwe' => 'They Owe',
			'debts.personName' => 'Person name',
			'debts.principalAmount' => 'Principal amount',
			'debts.transactionBinding' => 'Transaction Binding',
			'debts.cancel' => 'Cancel',
			'debts.save' => 'Save',
			'debts.ok' => 'OK',
			'debts.addRecord' => 'Add Record',
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
			'debts.selectDueDate' => 'Select due date',
			'debts.outstanding' => 'Outstanding',
			'debts.paid' => 'Paid',
			'debts.principal' => 'Principal',
			'debts.actionDenied' => 'Action Denied',
			'debts.jumlahPembayaranTidakBolehMelebihiSisaUtang' => 'Jumlah pembayaran tidak boleh melebihi sisa utang.',
			'debts.addNote' => 'Add note',
			'debts.payInFull' => 'Pay in Full',
			'debts.remaining' => 'remaining',
			'debts.paid1' => 'Paid ',
			'debts.reminder' => ({required Object type, required Object name}) => 'Reminder ${type}: ${name}',
			'debts.due' => ({required Object type, required Object name}) => '${type} Due: ${name}',
			'debts.noHistoryFoundForThis' => ({required Object type}) => 'No history found for this ${type}',
			'debts.failedToLoadDebts' => ({required Object error}) => 'Failed to load debts: ${error}',
			'debts.percentOf' => ({required Object percent}) => '${percent}% of ',
			'debts.settled' => ({required Object count}) => '${count} settled',
			'debts.payable' => 'Payable',
			'debts.receivable' => 'Receivable',
			'debts.noDebtsRecorded' => 'No debts recorded',
			'debts.noLoansRecorded' => 'No loans recorded',
			'debts.trackMoneyYouOweToOthersAndLogRepayments' => 'Track money you owe to others and log repayments.',
			'debts.trackMoneyOthersOweYouAndLogCollections' => 'Track money others owe you and log collections.',
			'error.generic' => 'An unexpected error occurred',
			'error.network' => 'Please check your connection and try again',
			'error.database' => 'Failed to access local data',
			'goals.fulfillGoal' => 'Fulfill Goal (Spend)',
			'goals.goalName' => 'Goal name',
			'goals.targetAmount' => 'Target amount',
			'goals.createGoal' => 'Create Goal',
			'goals.errorPrefix' => ({required Object error}) => 'Error: ${error}',
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
			'goals.fullyFunded' => 'Fully funded',
			'goals.inProgress' => 'In progress',
			'goals.totalSaved' => 'Total Saved',
			'goals.stillNeeded' => 'Still needed',
			'goals.totalTarget' => 'Total target',
			'goals.selectTargetDate' => 'Select target date',
			'goals.noTransactionsFoundForThisGoal' => 'No transactions found for this goal.',
			'goals.addGoal' => 'Add Goal',
			'goals.aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal' => 'A dedicated Pocket account will be created automatically to track this goal.',
			'goals.saved' => 'saved',
			'goals.needs' => 'Needs ',
			'goals.more' => ' more',
			'goals.noGoalsYet' => 'No goals yet',
			'goals.setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal' => 'Set savings targets — a dedicated pocket is created automatically for each goal.',
			'goals.percentOfTarget' => ({required Object percent}) => '${percent}% of target',
			'goals.goalsCount' => ({required Object count}) => '${count} goal(s)',
			'goals.fullyFundedCount' => ({required Object count}) => '${count} fully funded',
			'goals.noCompletedGoalsYet' => 'No completed goals yet',
			'goals.completedGoalsWillAppearHere' => 'Goals you complete will appear here.',
			'lock.confirmPin' => 'Confirm PIN',
			'lock.createPin' => 'Create PIN',
			'lock.pinsDoNotMatch' => 'PINs do not match',
			'lock.reenterPin' => 'Re-enter PIN',
			'lock.enterPinAppLock' => 'Enter PIN for App Lock',
			'lock.incorrectPin' => 'Incorrect PIN',
			'lock.verifyIdentity' => 'Verify Identity',
			'lock.retryInSeconds' => ({required Object seconds}) => 'Try again in ${seconds} seconds',
			'lock.setupPinTitle' => 'Setup PIN',
			'lock.setupPinBody' => 'Please create a PIN first before enabling App Lock or Biometrics.',
			'lock.unlocked' => 'Unlocked',
			'lock.enter6DigitPin' => 'Enter 6-digit PIN',
			'lock.enterPin' => 'Enter PIN',
			'lock.invalidPin' => 'Invalid PIN',
			'lock.tooManyAttempts' => 'Too many attempts',
			'lock.temporarilyLocked' => 'Temporarily locked',
			'onboarding.continueWithCurrency' => 'Continue with selected currency',
			'onboarding.chooseYourBaseCurrency' => 'Choose Your Base Currency',
			'onboarding.thisCurrencyWillBeUsedForAllAccountsPocketsAndTransactionsYouCanChangeThisLaterInSettings' => 'This currency will be used for all accounts, pockets, and transactions. You can change this later in settings.',
			'recurring.addSchedule' => 'Add Schedule',
			'recurring.transactionDetails' => 'Transaction Details',
			'recurring.amount' => 'Amount',
			'recurring.frequency' => 'Frequency',
			'recurring.startDate' => 'Start Date',
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
			'recurring.schedulesCount' => ({required Object count}) => '${count} schedules',
			'recurring.pausedCount' => ({required Object count}) => '${count} paused',
			'reports.title' => 'Reports',
			'reports.overview' => 'Financial Overview',
			'reports.tabCashflow' => 'Cashflow',
			'reports.tabBudgets' => 'Budgets & Goals',
			'reports.period' => 'Period',
			'reports.thisMonth' => 'This Month',
			'reports.lastMonth' => 'Last Month',
			'reports.last3Months' => '3 Months',
			'reports.last6Months' => '6 Months',
			'reports.custom' => 'Custom',
			'reports.income' => 'Income',
			'reports.expense' => 'Expense',
			'reports.netSavings' => 'Net Savings',
			'reports.netCashflow' => 'Net Cash Flow',
			'reports.cashflow' => 'Cash Flow',
			'reports.savingsRate' => 'Savings Rate',
			'reports.topCategories' => 'Top Categories',
			'reports.topExpenses' => 'Top Expenses',
			'reports.topIncome' => 'Top Income',
			'reports.monthlyTrend' => 'Monthly Trend',
			'reports.cashflowTrend' => 'Income vs Expense Trend',
			'reports.budgetBreakdown' => 'Budget Breakdown',
			'reports.budgetUtilization' => 'Budget Utilization',
			'reports.spendingAllocation' => 'Spending Allocation',
			'reports.noData' => 'No data for this period',
			'reports.noBudgets' => 'No budgets configured',
			'reports.noBudgetsDesc' => 'Add budgets to track your spending limits',
			'reports.onTrack' => 'On track',
			'reports.needsAttention' => 'Needs attention',
			'reports.overBudget' => 'Over budget',
			'reports.onBudget' => 'Within limit',
			'reports.needs' => 'Needs',
			'reports.wants' => 'Wants',
			'reports.savings' => 'Savings',
			'reports.other' => 'Other',
			'reports.total' => 'Total',
			'reports.average' => 'Average',
			'reports.remaining' => 'Remaining',
			'reports.spent' => 'Spent',
			'reports.limit' => 'Limit',
			'reports.txCount' => ({required Object count}) => '${count} transactions',
			'reports.selectDateRange' => 'Select Date Range',
			'reports.apply' => 'Apply',
			'reports.from' => 'From',
			'reports.to' => 'To',
			'reports.comparedTo' => ({required Object period}) => 'vs ${period}',
			'reports.higher' => 'higher',
			'reports.lower' => 'lower',
			'reports.same' => 'same as',
			'reports.noChange' => 'No change',
			'reports.percent50' => '50%',
			'reports.percent30' => '30%',
			'reports.percent20' => '20%',
			'reports.rule503020' => '50/30/20',
			'settings.title' => 'Settings',
			'settings.preferences' => 'Preferences',
			'settings.baseCurrency' => 'Base Currency',
			'settings.theme' => 'Theme',
			'settings.language' => 'Language',
			'settings.numberFormat' => 'Number Format',
			'settings.selectNumberFormat' => 'Select Number Format',
			'settings.formatSystem' => 'App Default',
			'settings.formatId' => '1.000.000,00',
			'settings.formatUs' => '1,000,000.00',
			'settings.formatFr' => '1 000 000,00',
			'settings.system' => 'System',
			'settings.english' => 'English',
			'settings.indonesia' => 'Indonesia',
			'settings.security' => 'Security',
			'settings.appLock' => 'App Lock',
			'settings.appLockDesc' => 'Protect app with PIN',
			'settings.biometrics' => 'Biometrics',
			'settings.biometricsDesc' => 'Use fingerprint to unlock',
			'settings.dataManagement' => 'Data Management',
			'settings.backupRestore' => 'Backup & Restore',
			'settings.backupRestoreDesc' => 'Save or restore your data',
			'settings.clearOld' => 'Clear Old Transactions',
			'settings.clearOldDesc' => 'Remove transactions older than 1 year',
			'settings.resetData' => 'Reset Data',
			'settings.resetDataDesc' => 'Erase all app data locally',
			'settings.support' => 'Support',
			'settings.faq' => 'FAQ',
			'settings.faqDesc' => 'Frequently Asked Questions',
			'settings.about' => 'About Poka CE',
			'settings.aboutDesc' => 'Version and legal information',
			'settings.selectTheme' => 'Select Theme',
			'settings.themeLight' => 'Light',
			'settings.themeDark' => 'Dark',
			'settings.selectLanguage' => 'Select Language',
			'settings.oldTransactionsCleared' => 'Old transactions cleared successfully',
			'settings.appDataReset' => 'App data reset successfully',
			'settings.failedToExportLogs' => 'Failed to export logs',
			'settings.easterEggRemaining' => ({required Object remaining}) => '${remaining} taps away from a surprise...',
			'settings.easterEggFound' => '🎉 You found the easter egg!',
			'settings.selectCurrency' => 'Select Currency',
			'settings.openSourceLicenses' => 'Open Source Licenses',
			'settings.helpIssues' => 'Help & Issues',
			'settings.reportBugsOrRequestFeatures' => 'Report bugs or request features',
			'settings.legal' => 'Legal',
			'settings.termsOfService' => 'Terms of Service',
			'settings.readOurTermsAndConditions' => 'Read our terms and conditions',
			'settings.privacyPolicy' => 'Privacy Policy',
			'settings.learnHowWeHandleYourData' => 'Learn how we handle your data',
			'settings.viewThirdpartySoftwareLicenses' => 'View third-party software licenses',
			'settings.advanced' => 'Advanced',
			'settings.exportDebugLogs' => 'Export Debug Logs',
			'settings.shareErrorLogsForTroubleshooting' => 'Share error logs for troubleshooting',
			'settings.search' => 'Search...',
			'settings.errorLoadingContent' => 'Error loading content',
			'settings.noLicensesFound' => 'No licenses found',
			'settings.pokaCe' => 'Poka CE',
			'settings.communityEdition' => 'Community Edition',
			'settings.aboutDescription' => 'A free and open-source personal finance manager designed to help you track expenses, manage budgets, and monitor your accounts locally.',
			'settings.copyright' => '© 2026 POKA. All rights reserved.',
			'settings.noResultsFound' => 'No Results Found',
			'settings.weCouldntFindAnyCurrencyMatching' => 'We couldn\'t find any currency matching "{search}".',
			'shared.authRequired' => 'Authentication Required',
			'shared.hexColorCode' => 'Hex Color Code',
			'shared.apply' => 'Apply',
			'shared.enterAmount' => 'Enter Amount',
			'shared.selectCategory' => 'Select Category',
			'shared.egFf5733' => 'e.g., FF5733',
			'shared.amount' => 'Amount',
			'shared.noCategoriesAvailable' => 'No categories available.',
			'shared.noWalletsFoundPleaseCreateOneFirst' => 'No wallets found. Please create one first.',
			'shared.balance' => 'Balance: ',
			'shared.optional' => 'Optional',
			'shared.customColor' => 'Custom Color',
			'transactions.searchTransactions' => 'Search transactions...',
			'transactions.failedToLoad' => 'Failed to load transactions',
			'transactions.cancel' => 'Cancel',
			'transactions.delete' => 'Delete',
			'transactions.goToToday' => 'Go to Today',
			'transactions.addItem' => 'Add Item',
			'transactions.saveSplitTransaction' => 'Save Split Transaction',
			'transactions.transactionType' => 'Transaction Type',
			'transactions.applyFilter' => 'Apply Filter',
			'transactions.noAccountsAvailable' => 'No accounts available',
			'transactions.account' => 'Account',
			'transactions.category' => 'Category',
			'transactions.done' => 'Done',
			'transactions.save' => 'Save',
			'transactions.transactions' => 'Transactions',
			'transactions.splitTransaction' => 'Split Transaction',
			'transactions.from' => 'From',
			'transactions.to' => 'To',
			'transactions.empty' => '+/-',
			'transactions.filtered' => 'Filtered',
			'transactions.netBalance' => 'Net Balance',
			'transactions.income' => 'Income',
			'transactions.expense' => 'Expense',
			'transactions.selectCategory' => 'Select Category',
			'transactions.filter' => 'Filter',
			'transactions.backToToday' => 'Back to today',
			'transactions.deleteTransaction' => 'Delete Transaction',
			'transactions.deleteTransactionWarning' => 'Deleting this transaction will revert your account balance and budget to their previous state.',
			'transactions.out' => 'Out ',
			'transactions.noTransactions' => 'No transactions',
			'transactions.addNote' => 'Add note',
			'transactions.noItemsYet' => 'No items yet',
			'transactions.tapAddItemToBeginSplittingntheTransaction' => 'Tap "Add Item" to begin splitting\nthe transaction.',
			'transactions.addAtLeastOneMoreItemToSave' => 'Add at least one more item to save.',
			'transactions.noTransactions1' => 'No Transactions',
			'transactions.reset' => 'Reset',
			'transactions.incoming' => 'In ',
			'transactions.nothingRecordedFor' => ({required Object period}) => 'Nothing recorded for ${period}.',
			'transactions.splitItems' => ({required Object count}) => '${count} split items',
			'transactions.itemsCount' => ({required Object count}) => '${count} item(s)',
			'transactions.transactionsCount' => ({required Object count}) => '${count} transactions',
			_ => null,
		};
	}
}
