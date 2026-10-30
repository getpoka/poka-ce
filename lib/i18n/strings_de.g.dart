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
class TranslationsDe extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsDe _root = this; // ignore: unused_field

	@override 
	TranslationsDe $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsDe(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$accounts$de accounts = _Translations$accounts$de._(_root);
	@override late final _Translations$app$de app = _Translations$app$de._(_root);
	@override late final _Translations$backup$de backup = _Translations$backup$de._(_root);
	@override late final _Translations$budgets$de budgets = _Translations$budgets$de._(_root);
	@override late final _Translations$categories$de categories = _Translations$categories$de._(_root);
	@override late final _Translations$common$de common = _Translations$common$de._(_root);
	@override late final _Translations$dashboard$de dashboard = _Translations$dashboard$de._(_root);
	@override late final _Translations$debts$de debts = _Translations$debts$de._(_root);
	@override Map<String, String> get error => {
		'generic': 'Ein unerwarteter Fehler ist aufgetreten',
		'network': 'Bitte prüfe deine Internetverbindung und versuche es erneut',
		'database': 'Lokale Daten konnten nicht geladen werden',
	};
	@override late final _Translations$goals$de goals = _Translations$goals$de._(_root);
	@override late final _Translations$icons$de icons = _Translations$icons$de._(_root);
	@override late final _Translations$lock$de lock = _Translations$lock$de._(_root);
	@override late final _Translations$onboarding$de onboarding = _Translations$onboarding$de._(_root);
	@override late final _Translations$recurring$de recurring = _Translations$recurring$de._(_root);
	@override late final _Translations$reports$de reports = _Translations$reports$de._(_root);
	@override late final _Translations$settings$de settings = _Translations$settings$de._(_root);
	@override late final _Translations$shared$de shared = _Translations$shared$de._(_root);
	@override late final _Translations$transactions$de transactions = _Translations$transactions$de._(_root);
}

// Path: accounts
class _Translations$accounts$de extends Translations$accounts$en {
	_Translations$accounts$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get accountName => 'Kontoname';
	@override String get pocketName => 'Pocket-Name';
	@override String get initialBalance => 'Anfangssaldo';
	@override String get icon => 'Symbol';
	@override String get color => 'Farbe';
	@override String get assets => 'Vermögen';
	@override String get liability => 'Verbindlichkeiten';
	@override String get income => 'Einnahmen';
	@override String get expense => 'Ausgaben';
	@override String get balance => 'Saldo';
	@override String get walletsPockets => 'Wallets & Pockets';
	@override String get accounts => 'Konten';
	@override String get mainAccounts => 'Hauptkonten';
	@override String get deleteAccount => 'Konto löschen';
	@override String get areYouSureYouWantToDeleteThisAccountItWillBeHiddenFromTheApp => 'Möchtest du dieses Konto wirklich löschen? Es wird in der App ausgeblendet.';
	@override String get delete => 'Löschen';
	@override String get account => 'Konto';
	@override String get totalBalance => 'Gesamtsaldo';
	@override String get pockets => 'Pockets';
	@override String get deletePocket => 'Pocket löschen';
	@override String get cannotDeleteMainPocket => 'Haupt-Pocket kann nicht gelöscht werden';
	@override String get mainPocket => 'Haupt';
	@override String get areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp => 'Möchtest du dieses Pocket wirklich löschen? Es wird in der App ausgeblendet.';
	@override String get nameCannotBeEmpty => 'Name darf nicht leer sein';
	@override String get egMainWallet => 'z. B. Haupt-Wallet';
	@override String get egPocket => 'z. B. Einkäufe, Urlaub';
	@override String get selectIcon => 'Symbol wählen';
	@override String get allowedCategories => 'Erlaubte Kategorien';
	@override String get transactions => 'Buchungen';
	@override String get editAccount => 'Konto bearbeiten';
	@override String get editPocket => 'Pocket bearbeiten';
	@override String get updateNameIconOrColor => 'Name, Symbol oder Farbe ändern';
	@override String get permanentlyRemoveThisAccount => 'Dieses Konto dauerhaft entfernen';
	@override String get seeAll => 'Alle ansehen';
	@override String get noTransactionsYet => 'Noch keine Buchungen';
	@override String get accountTransactionsSubtitle => 'Buchungen auf diesem Konto werden hier angezeigt.';
	@override String get pocketTransactionsSubtitle => 'Buchungen in diesem Pocket werden hier angezeigt.';
	@override String get addAccount => 'Konto hinzufügen';
	@override String get noAccountsFound => 'Keine Konten gefunden.';
	@override String get addPocket => 'Pocket hinzufügen';
	@override String get noPocketsYet => 'Noch keine Pockets';
	@override String get pocketsHelpYouSplitYourWalletIntoCategories => 'Pockets helfen dir, dein Wallet in Kategorien zu unterteilen. Dein aktueller Saldo wird automatisch in ein „Haupt“-Pocket verschoben.';
	@override String get activeAccount => 'Aktives Konto';
	@override String get inactiveAccountsWillBeHidden => 'Inaktive Konten werden ausgeblendet';
	@override String get noCategoriesAvailable => 'Keine Kategorien verfügbar.';
	@override String get noAccountsFound1 => 'Keine Konten gefunden';
	@override String subcategoriesCount({required Object count}) => '${count} Unterkategorie(n)';
	@override String pocketsCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(count,
		one: '1 Pocket',
		other: '${count} Pockets',
	);
	@override String get totalActiveAccounts => 'Aktive Konten insgesamt';
	@override String get noAccountsYet => 'Noch keine Konten';
	@override String get tapTheButtonBelowToAddYourFirstAccount => 'Tippe auf die Schaltfläche unten, um dein erstes Konto hinzuzufügen';
	@override String get allCategoriesAllowed => 'Alle Kategorien erlaubt';
	@override String categoriesSelected({required Object count}) => '${count} Kategorien ausgewählt';
	@override String ratioOfAccount({required Object percent}) => '${percent}% des Kontos';
	@override String get noMainAccountsYet => 'Noch keine Hauptkonten vorhanden.';
	@override String percentOfAssets({required Object percent}) => '${percent}% des Vermögens';
	@override String get recentTransactions => 'Letzte Buchungen';
	@override String recentTransactionsCount({required Object count}) => 'Letzte Buchungen (${count})';
	@override String get reconcileBalance => 'Saldo abgleichen';
	@override String get reconcileBalanceSubtitle => 'App-Saldo mit tatsächlichem Kontostand abgleichen';
	@override String get currentBalanceInPoka => 'Saldo in Poka';
	@override String get actualBalance => 'Tatsächlicher Saldo';
	@override String get difference => 'Differenz';
	@override String get adjustmentExpense => 'Korrektur (Ausgabe)';
	@override String get adjustmentIncome => 'Korrektur (Einnahme)';
	@override String get balanceAdjustment => 'Saldokorrektur';
	@override String get saveAdjustment => 'Korrektur speichern';
	@override String get balancesMatch => 'Salden stimmen überein, keine Korrektur nötig';
	@override String get noteOptional => 'Notiz (optional)';
	@override String get reconcileAccount => 'Kontostand abgleichen';
}

// Path: app
class _Translations$app$de extends Translations$app$en {
	_Translations$app$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Poka';
	@override String get tagline => 'Dein persönlicher Finanzbegleiter';
	@override late final _Translations$app$nav$de nav = _Translations$app$nav$de._(_root);
	@override String get termsOfService => 'Nutzungsbedingungen';
	@override String get privacyPolicy => 'Datenschutzerklärung';
}

// Path: backup
class _Translations$backup$de extends Translations$backup$en {
	_Translations$backup$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Backup & Wiederherstellung';
	@override String get backupAction => 'Backup erstellen';
	@override String get restoreAction => 'Wiederherstellen';
	@override String get password => 'Passwort';
	@override String get confirmPassword => 'Passwort bestätigen';
	@override String get passwordsDoNotMatch => 'Passwörter stimmen nicht überein';
	@override String get backupSuccess => 'Backup erfolgreich erstellt';
	@override String get restoreSuccess => 'Wiederherstellung erfolgreich';
	@override String get incorrectPassword => 'Falsches Passwort oder beschädigte Datei';
	@override String get enterPasswordToEncrypt => 'Passwort zum Verschlüsseln eingeben';
	@override String get enterPasswordToDecrypt => 'Passwort zum Entschlüsseln eingeben';
	@override String get pleaseRestart => 'Bitte starte die App neu, um Änderungen anzuwenden.';
	@override String get passwordRequired => 'Passwort ist erforderlich';
	@override String get reminder => 'Backup-Erinnerung';
	@override String get reminderDesc => 'Regelmäßig daran erinnern, ein Backup zu erstellen';
	@override String get reminderOff => 'Aus';
	@override String get reminderWeekly => 'Wöchentlich';
	@override String get reminderMonthly => 'Monatlich';
	@override String get reminderNotificationTitle => 'Zeit für ein Daten-Backup';
	@override String get reminderNotificationBody => 'Dein letztes Backup liegt schon etwas zurück. Sichere deine Finanzdaten jetzt.';
	@override String get reminderSaved => 'Backup-Erinnerung aktualisiert';
	@override String get restoreWarningDesc => 'Das Wiederherstellen ersetzt alle aktuellen Daten durch die Daten der gewählten Sicherungsdatei. Ungesicherte Änderungen gehen verloren. Fortfahren?';
	@override String get sendTestNotification => 'Testbenachrichtigung senden';
	@override String get testNotificationSent => 'Testbenachrichtigung gesendet';
	@override String get permissionRationaleTitle => 'Lokale Backup-Erinnerung';
	@override String get permissionRationaleDesc => 'Poka benötigt Benachrichtigungsberechtigungen, um dich an regelmäßige Backups zu erinnern. Erinnerungen laufen vollständig lokal und offline.';
	@override String get allowNotifications => 'Benachrichtigungen erlauben';
	@override String get permissionDenied => 'Benachrichtigungsberechtigung abgelehnt. Erinnerungen bleiben deaktiviert.';
}

// Path: budgets
class _Translations$budgets$de extends Translations$budgets$en {
	_Translations$budgets$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get budgetName => 'Budgetname';
	@override String get spendingLimit => 'Ausgabenlimit';
	@override String get period => 'Zeitraum';
	@override String get resetDay => 'Reset-Tag (1–31)';
	@override String get createBudget => 'Budget erstellen';
	@override String get endDate => 'Enddatum';
	@override String get budgetDetails => 'Budgetdetails';
	@override String get deleteBudget => 'Budget löschen';
	@override String get areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone => 'Möchtest du dieses Budget wirklich löschen? Der gesamte Verlauf wird dauerhaft gelöscht. Dies kann nicht rückgängig gemacht werden.';
	@override String get delete => 'Löschen';
	@override String get transactions => 'Buchungen';
	@override String get budgets => 'Budgets';
	@override String get allBudgets => 'Alle Budgets';
	@override String get egGroceriesEntertainment => 'z.B. Lebensmittel, Freizeit';
	@override String get eg80 => 'z.B. 80';
	@override String get category => 'Kategorie';
	@override String get account => 'Konto';
	@override String get overLimit => 'Überschritten';
	@override String get remaining => 'Verbleibend';
	@override String get totalSpent => 'Insgesamt ausgegeben';
	@override String get totalLimit => 'Gesamtlimit';
	@override String get selectEndDate => 'Enddatum auswählen';
	@override String get noTransactionsFoundForThisBudgetPeriod => 'Keine Buchungen für diesen Budgetzeitraum gefunden.';
	@override String get budgetTransactionsSubtitle => 'Buchungen, die zu diesem Budget passen, erscheinen hier.';
	@override String get addBudget => 'Budget hinzufügen';
	@override String get spent => 'Ausgegeben ';
	@override String get noBudgetsYet => 'Noch keine Budgets';
	@override String get setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod => 'Lege Limits fest, um zu verfolgen, wohin dein Geld in jedem Zeitraum fließt.';
	@override String budgetAlert({required Object name}) => 'Budget-Warnung: ${name}';
	@override String percentOf({required Object percent}) => '${percent}% von ';
	@override String budgetsCount({required Object count}) => '${count} Budget(s)';
	@override String get editBudget => 'Budget bearbeiten';
	@override String get newBudget => 'Neues Budget';
	@override String get nameCannotBeEmpty => 'Name darf nicht leer sein';
	@override String get amountGreaterThanZero => 'Betrag muss größer als 0 sein';
	@override String get alertThresholdLabel => 'Warnschwelle (%)';
	@override String get scope => 'Geltungsbereich';
	@override String get anyCategory => 'Jede Kategorie';
	@override String get anyAccount => 'Jedes Konto';
	@override String get saveChanges => 'Änderungen speichern';
	@override String get periodWeekly => 'Wöchentlich';
	@override String get periodMonthly => 'Monatlich';
	@override String get periodYearly => 'Jährlich';
	@override String get periodCustom => 'Benutzerdefiniert';
	@override String budgetExceededAlert({required Object percentage, required Object name}) => 'Du hast ${percentage}% deines Budgets für ${name} aufgebraucht.';
}

// Path: categories
class _Translations$categories$de extends Translations$categories$en {
	_Translations$categories$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get expense => 'Ausgabe';
	@override String get income => 'Einnahme';
	@override String get categoryName => 'Kategoriename';
	@override String get icon => 'Symbol';
	@override String get color => 'Farbe';
	@override String get noCategoriesFound => 'Keine Kategorien gefunden.';
	@override String get subcategories => 'Unterkategorien';
	@override String get categories => 'Kategorien';
	@override String get egFoodDining => 'z.B. Essen & Trinken';
	@override String get deleteCategory => 'Kategorie löschen';
	@override String get delete => 'Löschen';
	@override String get selectIcon => 'Symbol auswählen';
	@override String get searchIcons => 'Symbole suchen...';
	@override String get noIconsFound => 'Keine Symbole gefunden';
	@override String weCouldntFindAnyIconMatching({required Object search}) => 'Kein Symbol passend zu "${search}" gefunden.';
	@override String get noSubcategoriesYet => 'Noch keine Unterkategorien';
	@override String get noCategoriesFound1 => 'Keine Kategorien gefunden';
	@override String subcategoriesCount({required Object count}) => '${count} Unterkategorien';
	@override String get addSubcategory => 'Unterkategorie hinzufügen';
	@override String get addCategory => 'Kategorie hinzufügen';
	@override String get emptyCategorySubtitle => 'Starte die Ausgabenerfassung mit deiner ersten Kategorie';
	@override String get emptySubcategorySubtitle => 'Unterteile deine Kategorie in kleinere Einheiten';
	@override String get saveSubCategory => 'Unterkategorie speichern';
	@override String get saveCategory => 'Kategorie speichern';
	@override String get newSubCategory => 'Neue Unterkategorie';
	@override String get newCategory => 'Neue Kategorie';
	@override String get editSubCategory => 'Unterkategorie bearbeiten';
	@override String get editCategory => 'Kategorie bearbeiten';
	@override String deleteConfirmWithChildren({required Object count}) => 'Möchtest du diese Kategorie wirklich löschen? Ihre ${count} Unterkategorie(n) werden zu Hauptkategorien und zugehörige Buchungen werden unkategorisiert.';
	@override String get deleteConfirmNoChildren => 'Möchtest du diese Kategorie wirklich löschen? Alle zugehörigen Buchungen werden unkategorisiert.';
}

// Path: common
class _Translations$common$de extends Translations$common$en {
	_Translations$common$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get save => 'Speichern';
	@override String get cancel => 'Abbrechen';
	@override String get delete => 'Löschen';
	@override String get edit => 'Bearbeiten';
	@override String get confirm => 'Bestätigen';
	@override String get back => 'Zurück';
	@override String get loading => 'Laden...';
	@override String get error => 'Ein Fehler ist aufgetreten';
	@override String get retry => 'Wiederholen';
	@override String get empty => 'Noch keine Daten';
	@override String get cannotBeUndone => 'Diese Aktion kann nicht rückgängig gemacht werden.';
	@override String get pleaseWait => 'Bitte warten';
	@override String get today => 'Heute';
	@override String get yesterday => 'Gestern';
	@override String get dueToday => 'Heute fällig';
	@override String get overdue => 'Überfällig';
	@override String get uncategorized => 'Unkategorisiert';
	@override String get unknown => 'Unbekannt';
	@override String get notSet => 'Nicht festgelegt';
	@override String get undo => 'Rückgängig';
}

// Path: dashboard
class _Translations$dashboard$de extends Translations$dashboard$en {
	_Translations$dashboard$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get overview => 'Übersicht';
	@override String get myFinances => 'Meine Finanzen';
	@override String get netWorth => 'Nettovermögen';
	@override String accountsCount({required Object count}) => '${count} Konten';
	@override String get assets => 'Vermögenswerte';
	@override String get liabilities => 'Verbindlichkeiten';
	@override String get budgets => 'Budgets';
	@override String get categories => 'Kategorien';
	@override String get goals => 'Sparziele';
	@override String get debts => 'Schulden';
	@override String get recurring => 'Wiederkehrend';
	@override String get cashFlow => 'Cashflow';
	@override String get budget => 'Budget';
	@override String get needs => 'Bedürfnisse (50%)';
	@override String get wants => 'Wünsche (30%)';
	@override String get savings => 'Sparen (20%)';
	@override String get saved => 'gespart';
	@override String get onTrack => 'Auf Kurs';
	@override String get needsAttention => 'Achtung';
	@override String get income => 'Einnahme';
	@override String get expense => 'Ausgabe';
	@override String get other => 'Sonstiges';
	@override String get noData => 'Keine Daten';
	@override String get spendingActivity => 'Ausgabenverlauf';
	@override String get total => 'Gesamt';
	@override String get average => 'Durchschnitt';
	@override String get budgetPerDay => 'Budget/Tag';
	@override String get todaysBudget => 'Heutiges Budget';
	@override String get overbudget => 'Über Budget!';
	@override String get setDailyBudget => 'Tagesbudget festlegen';
	@override String get amount => 'Betrag';
	@override String get amountHint => 'z.B. 50';
	@override String get recentTransactions => 'Letzte Buchungen';
	@override String get thisMonth => 'Diesen Monat';
	@override String get noRecentTransactions => 'Keine aktuellen Buchungen';
	@override String get recentTransactionsSubtitle => 'Kürzlich erfasste Buchungen erscheinen hier.';
	@override String get seeAll => 'Alle anzeigen';
	@override String get notSet => 'Nicht festgelegt';
	@override late final _Translations$dashboard$insight$de insight = _Translations$dashboard$insight$de._(_root);
	@override late final _Translations$dashboard$days$de days = _Translations$dashboard$days$de._(_root);
}

// Path: debts
class _Translations$debts$de extends Translations$debts$en {
	_Translations$debts$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get addRepayment => 'Zahlung hinzufügen';
	@override String get iOwe => 'Ich schulde';
	@override String get theyOwe => 'Schuldet mir';
	@override String get personName => 'Name der Person';
	@override String get principalAmount => 'Ursprünglicher Betrag';
	@override String get transactionBinding => 'Transaktionsbindung';
	@override String get cancel => 'Abbrechen';
	@override String get save => 'Speichern';
	@override String get ok => 'OK';
	@override String get addRecord => 'Eintrag hinzufügen';
	@override String get createRecord => 'Eintrag erstellen';
	@override String get debtDetails => 'Schulden-Details';
	@override String get repaymentHistory => 'Rückzahlungsverlauf';
	@override String get debtsLoans => 'Schulden & Kredite';
	@override String get deleteDebt => 'Schuld löschen';
	@override String get delete => 'Löschen';
	@override String get writeoffDebt => 'Schuld abschreiben';
	@override String get areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances => 'Möchtest du diese Schuld wirklich abschreiben? Sie wird als beglichen markiert, ohne deine Kontosalden zu verändern.';
	@override String get writeoff => 'Abschreiben';
	@override String get egJohnDoe => 'z.B. Max Mustermann';
	@override String get category => 'Kategorie';
	@override String get account => 'Konto';
	@override String get egDinnerLastFriday => 'z.B. Abendessen am Freitag';
	@override String get selectDueDate => 'Fälligkeitsdatum wählen';
	@override String get outstanding => 'Offen';
	@override String get paid => 'Bezahlt';
	@override String get principal => 'Kapital';
	@override String get actionDenied => 'Aktion verweigert';
	@override String get paymentCannotExceedRemaining => 'Zahlungsbetrag darf die verbleibende Schuld nicht übersteigen.';
	@override String get addNote => 'Notiz hinzufügen';
	@override String get payInFull => 'Vollständig begleichen';
	@override String get remaining => 'verbleibend';
	@override String get paid1 => 'Bezahlt ';
	@override String reminder({required Object type, required Object name}) => 'Erinnerung ${type}: ${name}';
	@override String due({required Object type, required Object name}) => 'Fälligkeit ${type}: ${name}';
	@override String noHistoryFoundForThis({required Object type}) => 'Kein Verlauf für diese(n) ${type}';
	@override String repaymentHistorySubtitle({required Object type}) => 'Zahlungen für diese(n) ${type} erscheinen hier.';
	@override String failedToLoadDebts({required Object error}) => 'Fehler beim Laden von Schulden: ${error}';
	@override String percentOf({required Object percent}) => '${percent}% von ';
	@override String settled({required Object count}) => '${count} beglichen';
	@override String get payable => 'Zu zahlen';
	@override String get receivable => 'Forderungen';
	@override String get noDebtsRecorded => 'Keine Schulden erfasst';
	@override String get noLoansRecorded => 'Keine Darlehen erfasst';
	@override String get trackMoneyYouOweToOthersAndLogRepayments => 'Behalte im Blick, was du anderen schuldest, und erfasse Rückzahlungen.';
	@override String get trackMoneyOthersOweYouAndLogCollections => 'Behalte im Blick, was dir andere schulden, und erfasse Geldeingänge.';
	@override String get editRecord => 'Eintrag bearbeiten';
	@override String get newRecord => 'Neuer Eintrag';
	@override String get personNameCannotBeEmpty => 'Name darf nicht leer sein';
	@override String get amountGreaterThanZero => 'Betrag muss größer als 0 sein';
	@override String get selectCategoryAndAccount => 'Bitte wähle eine Kategorie und ein Konto';
	@override String get selectCategoryPrompt => 'Kategorie wählen';
	@override String get selectAccountPrompt => 'Konto wählen';
	@override String get debtBindingHelp => 'Das Erfassen dieser Schuld bucht den Betrag auf das Konto (Einnahme).';
	@override String get loanBindingHelp => 'Das Erfassen dieses Darlehens bucht den Betrag vom Konto ab (Ausgabe).';
	@override String get noteLabel => 'Notiz';
	@override String get dueDateLabel => 'Fälligkeitsdatum';
	@override String get saveChanges => 'Änderungen speichern';
	@override String deleteConfirm({required Object type}) => 'Möchtest du diese(n) ${type} wirklich löschen? Der Eintrag wird dauerhaft gelöscht.';
	@override String debtDetailsTitle({required Object type}) => '${type}-Details';
	@override String get debtTypeLoan => 'Darlehen';
	@override String get debtTypeDebt => 'Schuld';
	@override String reminderAlert({required Object type, required Object amount, required Object when, required Object action}) => '${type} über ${amount} muss bis ${when} ${action} werden.';
	@override String overdueAlert({required Object type, required Object amount, required Object action}) => '${type} über ${amount} ist überfällig und muss sofort ${action} werden.';
	@override String get actionCollect => 'eingezogen';
	@override String get actionPay => 'bezahlt';
	@override String get today => 'heute';
	@override String inDays({required Object days}) => 'in ${days} Tagen';
	@override String owedCount({required Object count}) => '${count} Verbindlichkeiten';
	@override String receivableCount({required Object count}) => '${count} Forderungen';
	@override String get disbursedAmount => 'Ausgezahlter Betrag';
	@override String get lentAmount => 'Verliehener Betrag';
	@override String get totalRepaymentAmount => 'Gesamtrückzahlung';
	@override String get totalReceivableAmount => 'Gesamtforderung';
	@override String get interestFee => 'Zinsen / Gebühr';
	@override String get disbursedAmountHelp => 'Tatsächlicher Geldbetrag, der auf dein oder von deinem Konto gebucht wurde.';
	@override String get totalAmountMustBeGreaterOrEqual => 'Gesamtrückzahlung darf nicht geringer sein als der ausgezahlte Betrag';
	@override String disbursedAmountLabel({required Object type}) => '${type}:';
	@override String get interestLabel => 'Zinsen:';
	@override String get received => 'Erhalten';
	@override String get lent => 'Verliehen';
}

// Path: goals
class _Translations$goals$de extends Translations$goals$en {
	_Translations$goals$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get goals => 'Sparziele';
	@override String get fulfillGoal => 'Ziel erfüllen (Ausgeben)';
	@override String get goalName => 'Zielname';
	@override String get targetAmount => 'Zielbetrag';
	@override String get createGoal => 'Ziel erstellen';
	@override String errorPrefix({required Object error}) => 'Fehler: ${error}';
	@override String get goalDetails => 'Ziel-Details';
	@override String get transactions => 'Buchungen';
	@override String get active => 'Aktiv';
	@override String get past => 'Abgeschlossen';
	@override String get actionDenied => 'Aktion verweigert';
	@override String get emptyBalanceBeforeDelete => 'Überweise das Guthaben auf ein anderes Konto, bevor du dieses Sparziel löschst.';
	@override String get ok => 'OK';
	@override String get deleteGoal => 'Ziel löschen';
	@override String get areYouSureYouWantToDeleteThisGoalTheAssociatedPocketAccountAndItsHistoryWillAlsoBeRemovedThisActionCannotBeUndone => 'Möchtest du dieses Sparziel wirklich löschen? Das zugehörige Unterkonto und sein Verlauf werden gelöscht. Dies kann nicht rückgängig gemacht werden.';
	@override String get delete => 'Löschen';
	@override String get egEmergencyFundNewLaptop => 'z.B. Notgroschen, Neuer Laptop';
	@override String get completed => 'Erreicht';
	@override String get fullyFunded => 'Vollständig finanziert';
	@override String get inProgress => 'In Bearbeitung';
	@override String get totalSaved => 'Insgesamt gespart';
	@override String get stillNeeded => 'Fehlt noch';
	@override String get totalTarget => 'Gesamtziel';
	@override String get selectTargetDate => 'Zieldatum auswählen';
	@override String get noTransactionsFoundForThisGoal => 'Keine Buchungen für dieses Ziel gefunden.';
	@override String get goalTransactionsSubtitle => 'Überweisungen für dieses Sparziel erscheinen hier.';
	@override String get addGoal => 'Ziel hinzufügen';
	@override String get aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal => 'Ein eigenes Unterkonto wird automatisch erstellt, um dieses Ziel zu verfolgen.';
	@override String get saved => 'gespart';
	@override String get needs => 'Benötigt noch ';
	@override String get more => ' mehr';
	@override String get noGoalsYet => 'Noch keine Sparziele';
	@override String get setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal => 'Setze Sparziele — für jedes Ziel wird automatisch ein eigenes Unterkonto angelegt.';
	@override String percentOfTarget({required Object percent}) => '${percent}% des Ziels';
	@override String goalsCount({required Object count}) => '${count} Sparziel(e)';
	@override String fullyFundedCount({required Object count}) => '${count} vollständig erreicht';
	@override String get noCompletedGoalsYet => 'Noch keine erreichten Sparziele';
	@override String get completedGoalsWillAppearHere => 'Erreichte Ziele werden hier angezeigt.';
	@override String get editGoal => 'Ziel bearbeiten';
	@override String get newGoal => 'Neues Ziel';
	@override String get nameCannotBeEmpty => 'Name darf nicht leer sein';
	@override String get targetAmountGreaterThanZero => 'Zielbetrag muss größer als 0 sein';
	@override String get saveChanges => 'Änderungen speichern';
	@override String get targetDateLabel => 'Zieldatum';
	@override String get activeGoals => 'Aktive Ziele';
	@override String get completedGoals => 'Abgeschlossene Ziele';
	@override String get noActiveGoalsYet => 'Keine aktiven Ziele';
	@override String get noActiveGoalsSubtitle => 'Erstelle ein Sparziel, um für deine nächsten Meilensteine zu sparen.';
	@override String get saveInAccount => 'Auf Konto sparen';
	@override String get selectAccount => 'Konto auswählen';
	@override String get accountRequired => 'Bitte wähle ein Konto aus';
	@override String storedIn({required Object account}) => 'Gespeichert in ${account}';
}

// Path: icons
class _Translations$icons$de extends Translations$icons$en {
	_Translations$icons$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override Map<String, String> get aliases => {
		'wallet': 'wallet, money, cash, salary, pay, income, funds',
		'bank': 'bank, atm, account, checking, wire, branch',
		'credit_card': 'card, credit, debit, visa, mastercard, payment',
		'money': 'money, cash, salary, wage, dollar, income, earnings',
		'piggy_bank': 'savings, save, piggy bank, deposit, reserve',
		'coins': 'coins, change, cents, currency, cash',
		'currency_circle_dollar': 'dollar, currency, foreign exchange, forex',
		'vault': 'vault, safe, security, reserve, deposit',
		'chart_line_up': 'investment, stock, shares, trading, crypto, growth, profit',
		'chart_line_down': 'loss, decrease, decline, dip, expense',
		'chart_pie': 'budget, allocation, analytics, breakdown, pie chart',
		'chart_bar': 'report, stats, performance, analytics, bar chart',
		'receipt': 'receipt, bill, slip, voucher, proof',
		'invoice': 'invoice, billing, statement, payment request',
		'calculator': 'calculator, calculate, math, accounting, sum',
		'scales': 'tax, law, balance, justice, legal, compliance',
		'hand_coins': 'donation, charity, tip, alms, giving, offering',
		'trend_up': 'trend up, increase, profit, gain, rise',
		'trend_down': 'trend down, decrease, loss, drop, fall',
		'cardholder': 'cardholder, cards, pouch, wallet',
		'shopping_cart': 'cart, supermarket, grocery, shopping, mart',
		'hamburger': 'burger, fast food, meal, junk food, food',
		'coffee': 'coffee, cafe, starbucks, espresso, drink, beverage',
		'fork_knife': 'dining, restaurant, food, eat, meal, lunch, dinner',
		'pizza': 'pizza, fast food, food, snack, italian',
		'bowl_food': 'noodles, soup, ramen, rice, bowl, food, meal',
		'beer_bottle': 'beer, alcohol, beverage, drink, pub',
		'martini': 'cocktail, martini, bar, nightlife, drinks',
		'wine': 'wine, winery, alcohol, dinner, drink',
		'cooking_pot': 'cooking, cookware, kitchen, meal, stew',
		'carrot': 'vegetables, produce, market, fresh, vegan, healthy',
		'cake': 'cake, bakery, birthday, dessert, sweets, pastry',
		'ice_cream': 'ice cream, gelato, dessert, sweets, snack',
		'cookie': 'cookie, biscuit, snack, treats',
		'egg': 'egg, breakfast, grocery, cooking, farm',
		'fish_simple': 'fish, seafood, protein, market',
		'bag': 'shopping bag, store, retail, purchase, mall',
		'storefront': 'shop, store, market, boutique, retail, merchant',
		'basket': 'basket, grocery, shopping, market',
		'barcode': 'barcode, scan, price, item, product',
		'tag': 'discount, promo, sale, tag, deal, offer',
		'gift': 'gift, present, surprise, birthday, souvenir',
		'package': 'package, parcel, delivery, courier, shipment, order',
		't_shirt': 'clothing, clothes, t-shirt, shirt, fashion, apparel',
		'sneaker': 'shoes, sneakers, footwear, boots, fashion',
		'watch': 'watch, wristwatch, accessory, time, luxury',
		'sunglasses': 'sunglasses, glasses, shades, eyewear, accessory',
		'tote': 'tote bag, eco bag, shopping, purse',
		'handbag': 'handbag, purse, luxury bag, accessory',
		'crown': 'luxury, vip, premium, royalty, reward',
		'sparkle': 'beauty, clean, shine, sparkles, special',
		'car': 'car, automobile, vehicle, ride, drive',
		'car_profile': 'car, sedan, taxi, auto, vehicle',
		'airplane': 'airplane, flight, plane, airline, ticket, travel',
		'airplane_tilt': 'flight, travel, holiday, aviation',
		'airplane_takeoff': 'departure, takeoff, flight, travel, airport',
		'airplane_landing': 'arrival, landing, flight, return',
		'bicycle': 'bicycle, bike, cycling, ride',
		'bus': 'bus, public transport, transit, commute',
		'train': 'train, subway, railway, metro, transit',
		'taxi': 'taxi, cab, ride-hailing, uber, transport',
		'gas_pump': 'gas, fuel, petrol, oil, gasoline',
		'charging_station': 'electric vehicle, ev, charging, battery, electric',
		'map_pin': 'location, place, destination, gps, map',
		'globe': 'travel, worldwide, international, trip, foreign',
		'tent': 'camping, tent, outdoor, adventure, nature',
		'suitcase': 'luggage, baggage, vacation, trip, travel',
		'suitcase_rolling': 'suitcase, travel, suitcase with wheels, flight',
		'scooter': 'scooter, moped, ride, motor',
		'motorcycle': 'motorcycle, motorbike, bike, ride',
		'boat': 'boat, ferry, cruise, ship, sailing',
		'house': 'house, home, residence, property, housing',
		'house_line': 'neighborhood, residential, suburban, house',
		'building': 'building, office, commercial, city',
		'building_apartment': 'apartment, flat, condo, rent, lodging',
		'key': 'key, access, lock, security, home key',
		'lightning': 'electricity, power, utilities, electric bill, energy',
		'drop': 'water, utilities, water bill, aqua, liquid',
		'fire': 'gas, heating, lpg, energy, stove',
		'wifi_high': 'internet, wifi, broadband, network, connection',
		'plugs': 'appliances, electronics, power, plug',
		'television': 'tv, television, entertainment, screen, streaming',
		'armchair': 'furniture, sofa, chair, living room, decor',
		'bed': 'bed, mattress, hotel, bedroom, sleep',
		'wrench': 'tools, maintenance, repair, plumbing, service',
		'hammer': 'construction, renovation, DIY, tools, repair',
		'paint_roller': 'painting, renovation, decorating, home improvement',
		'toilet': 'toilet, bathroom, plumbing, restroom',
		'bathtub': 'bathtub, bath, spa, bathroom',
		'shower': 'shower, bathroom, water',
		'lightbulb': 'lighting, electricity, bulb, idea, utilities',
		'first_aid': 'first aid, emergency, medical, kit, clinic',
		'pill': 'medicine, medication, pharmacy, prescription, pills, drugs',
		'heart_beat': 'health, heartbeat, pulse, cardio, medical',
		'syringe': 'vaccine, injection, blood test, clinical, needle',
		'stethoscope': 'doctor, physician, consultation, hospital, checkup',
		'brain': 'mental health, psychology, therapy, neurology, brain',
		'baby': 'baby, child, toddler, infant, kids',
		'bandaids': 'bandage, wound, first aid, care',
		'thermometer': 'fever, temperature, sickness, medical',
		'wheelchair': 'disability, wheelchair, accessibility, care',
		'activity': 'activity, wellness, vitals, tracking, health',
		'tooth': 'dentist, dental, teeth, tooth, oral care',
		'shield_check': 'insurance, policy, security, guarantee, protection',
		'shield_plus': 'health insurance, medical protection, coverage',
		'barbell': 'gym, fitness, workout, weightlifting, exercise',
		'student': 'student, school, college, pupil, learner',
		'graduation_cap': 'graduation, degree, university, education, college',
		'book': 'book, reading, textbook, library',
		'book_open': 'study, learning, coursework, reading',
		'books': 'books, literature, library, bookstore, research',
		'exam': 'exam, test, quiz, grades, evaluation',
		'pencil': 'pencil, drawing, writing, sketch, stationary',
		'pen': 'pen, writing, signature, document, stationary',
		'chalkboard': 'classroom, board, teacher, lecture, school',
		'certificate': 'certificate, diploma, course, qualification, training',
		'backpack': 'backpack, school bag, bag, student',
		'ruler': 'ruler, measuring, stationary, architecture, scale',
		'game_controller': 'gaming, games, video games, playstation, xbox, steam',
		'film_strip': 'movie, cinema, film, theater, entertainment',
		'monitor_play': 'streaming, youtube, netflix, video, watch',
		'music_notes': 'music, song, audio, spotify, concert',
		'headphones': 'headphones, headset, audio, podcast, listening',
		'palette': 'art, painting, drawing, hobby, creativity',
		'heart': 'romance, love, partner, family, date',
		'smiley': 'fun, recreation, entertainment, happiness',
		'camera': 'photography, camera, photos, video, creative',
		'popcorn': 'cinema snack, popcorn, movies, theater',
		'ticket': 'ticket, admission, event, concert, show',
		'microphone': 'karaoke, singing, podcast, voice, mic',
		'radio': 'radio, broadcast, audio, news',
		'speaker_hifi': 'speaker, sound, audio system, hifi',
		'mask_happy': 'theater, drama, performing arts, culture',
		'volleyball': 'volleyball, sports, match, recreation',
		'basketball': 'basketball, nba, sports, court',
		'soccer_ball': 'soccer, football, sports, match',
		'laptop': 'laptop, computer, macbook, work, pc',
		'desktop': 'desktop, pc, computer, monitor, workstation',
		'device_mobile': 'phone, mobile, smartphone, cell, cellular',
		'devices': 'gadgets, electronics, hardware, devices',
		'briefcase': 'work, business, job, office, career, corporate',
		'pen_nib': 'design, graphic, vector, creative, art',
		'code': 'coding, software, programming, developer, tech',
		'folder': 'files, documents, folder, archive, records',
		'printer': 'printer, printing, copy, paper, documents',
		'mouse': 'mouse, computer accessories, pointer',
		'keyboard': 'keyboard, typing, input, computer',
		'hard_drives': 'storage, hard drive, backup, server, data',
		'cpu': 'processor, cpu, hardware, chip, computing',
		'headset': 'headset, customer service, calls, meeting, zoom',
		'handshake': 'deal, partnership, agreement, client, business',
		'users': 'family, team, people, group, community',
		'user': 'personal, profile, self, individual, account',
		'paw_print': 'pets, animals, veterinary, paw',
		'cat': 'cat, kitten, pet food, feline',
		'dog': 'dog, puppy, canine, pet food',
		'bird': 'bird, parrot, avian, pet',
		'fish': 'fish, aquarium, seafood, aquatic',
		'horse': 'horse, equestrian, riding',
		'shield_star': 'family protection, life insurance, guardian',
		'dots_three': 'more, options, other, miscellaneous, extra',
		'star': 'favorites, star, bookmark, special, rating',
		'asterisk': 'note, reference, asterisk, remark',
		'question': 'help, support, faq, question, inquiry',
		'info': 'information, details, about, notice',
		'bell': 'notification, alert, reminder, bell, chime',
		'calendar': 'calendar, date, schedule, event, deadline',
		'clock': 'time, clock, hour, timer, watch',
		'flag': 'goal, milestone, flag, priority, marker',
		'leaf': 'eco, nature, organic, plant, environment',
		'tree': 'trees, park, nature, landscape, outdoors',
		'umbrella': 'umbrella, rain, protection, monsoon, weather',
		'target': 'target, aim, goal, objective, target savings',
		'trophy': 'achievement, reward, win, success, trophy',
	};
}

// Path: lock
class _Translations$lock$de extends Translations$lock$en {
	_Translations$lock$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get confirmPin => 'PIN bestätigen';
	@override String get createPin => 'PIN erstellen';
	@override String get pinsDoNotMatch => 'PINs stimmen nicht überein';
	@override String get reenterPin => 'PIN erneut eingeben';
	@override String get enterPinAppLock => 'PIN zur Entsperrung eingeben';
	@override String get incorrectPin => 'Falsche PIN';
	@override String get verifyIdentity => 'Identität bestätigen';
	@override String retryInSeconds({required Object seconds}) => 'In ${seconds} Sekunden erneut versuchen';
	@override String get setupPinTitle => 'PIN einrichten';
	@override String get setupPinBody => 'Bitte erstelle eine PIN, bevor du App-Sperre oder Biometrie aktivierst.';
	@override String get unlocked => 'Entsperrt';
	@override String get enter6DigitPin => '6-stellige PIN eingeben';
	@override String get enterPin => 'PIN eingeben';
	@override String get invalidPin => 'Ungültige PIN';
	@override String get tooManyAttempts => 'Zu viele Versuche';
	@override String get temporarilyLocked => 'Vorübergehend gesperrt';
	@override String get authenticateReason => 'Bestätige deine Identität für Poka';
}

// Path: onboarding
class _Translations$onboarding$de extends Translations$onboarding$en {
	_Translations$onboarding$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get continueWithCurrency => 'Mit gewählter Währung fortfahren';
	@override String get chooseYourBaseCurrency => 'Wähle deine Basiswährung';
	@override String get thisCurrencyWillBeUsedForAllAccountsPocketsAndTransactionsYouCanChangeThisLaterInSettings => 'Diese Währung wird für alle Konten, Unterkonten und Buchungen verwendet. Du kannst dies später in den Einstellungen ändern.';
}

// Path: recurring
class _Translations$recurring$de extends Translations$recurring$en {
	_Translations$recurring$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get addSchedule => 'Wiederholung hinzufügen';
	@override String get transactionDetails => 'Buchungsdetails';
	@override String get amount => 'Betrag';
	@override String get frequency => 'Häufigkeit';
	@override String get startDate => 'Startdatum';
	@override String get recurring => 'Wiederkehrend';
	@override String get schedules => 'Daueraufträge';
	@override String get scheduleDetails => 'Details des Dauerauftrags';
	@override String get deleteSchedule => 'Dauerauftrag löschen';
	@override String get areYouSureYouWantToDeleteThisRecurringScheduleExistingGeneratedTransactionsWillNotBeDeleted => 'Möchtest du diesen Dauerauftrag wirklich löschen? Bereits generierte Buchungen bleiben erhalten.';
	@override String get delete => 'Löschen';
	@override String get triggerHistory => 'Ausführungsverlauf';
	@override String get destinationAccount => 'Zielkonto';
	@override String get category => 'Kategorie';
	@override String get egNetflixSubscription => 'z.B. Netflix-Abonnement';
	@override String get selectFirstDueDate => 'Erste Fälligkeit auswählen';
	@override String get estMonthlyNet => 'Geschätztes Monatssaldo';
	@override String get monthlyIn => 'Einnahmen/Monat';
	@override String get monthlyOut => 'Ausgaben/Monat';
	@override String get noRecurringTransactions => 'Keine Daueraufträge';
	@override String get automateBillsLikeSubscriptionsOrSalary => 'Automatisiere Fixkosten wie Abos oder Gehalt. Die App erfasst sie pünktlich.';
	@override String get noHistoryFoundForThisSchedule => 'Kein Verlauf für diesen Dauerauftrag.';
	@override String get scheduleHistorySubtitle => 'Generierte Buchungen erscheinen hier.';
	@override String get allocation => 'Aufteilung';
	@override String get active => 'Aktiv';
	@override String get eachTimeTheAppOpensOverdueRecurringTransactionsAre => 'Bei jedem Öffnen der App werden fällige Daueraufträge automatisch im Buchungsjournal erfasst.';
	@override String schedulesCount({required Object count}) => '${count} Daueraufträge';
	@override String pausedCount({required Object count}) => '${count} pausiert';
	@override String get editRecurring => 'Dauerauftrag bearbeiten';
	@override String get newRecurring => 'Neuer Dauerauftrag';
	@override String get mustSelectAccount => 'Ein Konto muss ausgewählt werden';
	@override String get sourceAccount => 'Quellkonto';
	@override String get account => 'Konto';
	@override String get selectAccountPrompt => 'Konto wählen';
	@override String get selectDestinationPrompt => 'Ziel wählen';
	@override String get selectCategoryOptional => 'Kategorie wählen (optional)';
	@override String get noteLabel => 'Notiz';
	@override String get saveChanges => 'Änderungen speichern';
	@override String get createRecurring => 'Dauerauftrag anlegen';
	@override String get amountGreaterThanZero => 'Betrag muss größer als 0 sein';
	@override String get mustSelectStartDate => 'Startdatum muss ausgewählt werden';
	@override String get periodDaily => 'Täglich';
	@override String get periodWeekly => 'Wöchentlich';
	@override String get periodMonthly => 'Monatlich';
	@override String get periodYearly => 'Jährlich';
	@override String get autoGenerateActive => 'Generiert Buchungen automatisch';
	@override String get autoGeneratePaused => 'Pausiert — es werden keine Buchungen generiert';
	@override String get recurringIncome => 'Wiederkehrende Einnahme';
	@override String get recurringExpense => 'Wiederkehrende Ausgabe';
	@override String get recurringTransfer => 'Wiederkehrende Umbuchung';
	@override String nextDateLabel({required Object date}) => 'Nächste: ${date}';
}

// Path: reports
class _Translations$reports$de extends Translations$reports$en {
	_Translations$reports$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Berichte';
	@override String get overview => 'Finanzübersicht';
	@override String get tabCashflow => 'Cashflow';
	@override String get tabBudgets => 'Budgets & Sparziele';
	@override String get period => 'Zeitraum';
	@override String get thisMonth => 'Diesen Monat';
	@override String get lastMonth => 'Letzten Monat';
	@override String get last3Months => '3 Monate';
	@override String get last6Months => '6 Monate';
	@override String get custom => 'Benutzerdefiniert';
	@override String get income => 'Einnahme';
	@override String get expense => 'Ausgabe';
	@override String get netSavings => 'Netto-Ersparnis';
	@override String get netCashflow => 'Netto-Cashflow';
	@override String get cashflow => 'Cashflow';
	@override String get savingsRate => 'Sparquote';
	@override String get topCategories => 'Top-Kategorien';
	@override String get topExpenses => 'Größte Ausgaben';
	@override String get topIncome => 'Größte Einnahmen';
	@override String get monthlyTrend => 'Monatstrend';
	@override String get cashflowTrend => 'Einnahmen vs. Ausgaben';
	@override String get budgetBreakdown => 'Budget-Aufschlüsselung';
	@override String get budgetUtilization => 'Budget-Ausschöpfung';
	@override String get spendingAllocation => 'Ausgabenverteilung';
	@override String get noData => 'Keine Daten in diesem Zeitraum';
	@override String get noExpenseDataDesc => 'Erfasse Ausgaben, um deine Ausgabenverteilung zu sehen.';
	@override String get noBudgets => 'Keine Budgets eingerichtet';
	@override String get noBudgetsDesc => 'Erstelle Budgets, um deine Ausgabenlimits zu kontrollieren';
	@override String get onTrack => 'Auf Kurs';
	@override String get needsAttention => 'Achtung erforderlich';
	@override String get overBudget => 'Über Budget';
	@override String get onBudget => 'Im Limit';
	@override String get needs => 'Bedürfnisse';
	@override String get wants => 'Wünsche';
	@override String get savings => 'Sparen';
	@override String get other => 'Sonstiges';
	@override String get total => 'Gesamt';
	@override String get average => 'Durchschnitt';
	@override String get remaining => 'Verbleibend';
	@override String get spent => 'Ausgegeben';
	@override String get limit => 'Limit';
	@override String txCount({required Object count}) => '${count} Buchungen';
	@override String get selectDateRange => 'Datumsbereich auswählen';
	@override String get apply => 'Anwenden';
	@override String get from => 'Von';
	@override String get to => 'Bis';
	@override String comparedTo({required Object period}) => 'ggü. ${period}';
	@override String get higher => 'höher';
	@override String get lower => 'niedriger';
	@override String get same => 'gleich wie';
	@override String get noChange => 'Keine Änderung';
	@override String get percent50 => '50%';
	@override String get percent30 => '30%';
	@override String get percent20 => '20%';
	@override String get rule503020 => '50/30/20';
	@override String get prevLastMonth => 'letzter Monat';
	@override String get prevMonth => 'Vormonat';
	@override String get prev3Months => 'letzte 3 Monate';
	@override String get prev6Months => 'letzte 6 Monate';
	@override String get prevPeriod => 'Vorperiode';
	@override String get exportExcel => 'Nach Excel exportieren';
	@override String get exportExcelSuccess => 'Excel-Datei erfolgreich exportiert';
	@override String get exportExcelError => 'Fehler beim Exportieren der Excel-Datei';
}

// Path: settings
class _Translations$settings$de extends Translations$settings$en {
	_Translations$settings$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Einstellungen';
	@override String get preferences => 'Einstellungen';
	@override String get baseCurrency => 'Basiswährung';
	@override String get theme => 'Design';
	@override String get language => 'Sprache';
	@override String get numberFormat => 'Zahlenformat';
	@override String get selectNumberFormat => 'Zahlenformat wählen';
	@override String get formatSystem => 'Standard';
	@override String get formatId => '1.000.000,00';
	@override String get formatUs => '1,000,000.00';
	@override String get formatFr => '1 000 000,00';
	@override String get system => 'System';
	@override String get english => 'English';
	@override String get indonesia => 'Indonesia';
	@override String get malay => 'Bahasa Melayu';
	@override String get vietnam => 'Tiếng Việt';
	@override String get russian => 'Русский';
	@override String get spanish => 'Español';
	@override String get portuguese => 'Português';
	@override String get german => 'Deutsch';
	@override String get security => 'Sicherheit';
	@override String get appLock => 'App-Sperre';
	@override String get appLockDesc => 'App mit PIN schützen';
	@override String get biometrics => 'Biometrie';
	@override String get biometricsDesc => 'Mit Fingerabdruck entsperren';
	@override String get dataManagement => 'Datenverwaltung';
	@override String get backupRestore => 'Sicherung & Wiederherstellung';
	@override String get backupRestoreDesc => 'Daten sichern oder wiederherstellen';
	@override String get clearOld => 'Alte Buchungen bereinigen';
	@override String get clearOldDesc => 'Buchungen älter als 1 Jahr entfernen';
	@override String get resetData => 'Daten zurücksetzen';
	@override String get resetDataDesc => 'Alle lokalen App-Daten löschen';
	@override String get support => 'Support';
	@override String get faq => 'FAQ';
	@override String get faqDesc => 'Oft gestellte Fragen';
	@override String get about => 'Über Poka CE';
	@override String get aboutDesc => 'Version und rechtliche Hinweise';
	@override String get selectTheme => 'Design wählen';
	@override String get themeLight => 'Hell';
	@override String get themeDark => 'Dunkel';
	@override String get selectLanguage => 'Sprache wählen';
	@override String get oldTransactionsCleared => 'Alte Buchungen erfolgreich bereinigt';
	@override String get appDataReset => 'App-Daten erfolgreich zurückgesetzt';
	@override String get failedToExportLogs => 'Exportieren der Protokolle fehlgeschlagen';
	@override String easterEggRemaining({required Object remaining}) => 'Noch ${remaining} Fingertipps bis zur Überraschung...';
	@override String get easterEggFound => '🎉 Du hast das Easter Egg gefunden!';
	@override String get selectCurrency => 'Währung wählen';
	@override String get openSourceLicenses => 'Open-Source-Lizenzen';
	@override String get checkForUpdates => 'Nach Updates suchen';
	@override String get viewLatestReleasesOnGithub => 'Neueste Releases auf GitHub ansehen';
	@override String get helpIssues => 'Hilfe & Fehlermeldungen';
	@override String get reportBugsOrRequestFeatures => 'Fehler melden oder Funktionen vorschlagen';
	@override String get legal => 'Rechtliches';
	@override String get termsOfService => 'Nutzungsbedingungen';
	@override String get readOurTermsAndConditions => 'Lies unsere Geschäftsbedingungen';
	@override String get privacyPolicy => 'Datenschutzerklärung';
	@override String get learnHowWeHandleYourData => 'Erfahre, wie wir deine Daten verarbeiten';
	@override String get viewThirdpartySoftwareLicenses => 'Drittanbieter-Softwarelizenzen ansehen';
	@override String get advanced => 'Erweitert';
	@override String get exportDebugLogs => 'Debug-Protokolle exportieren';
	@override String get shareErrorLogsForTroubleshooting => 'Fehlerprotokolle zur Fehlerbehebung teilen';
	@override String get search => 'Suchen...';
	@override String get errorLoadingContent => 'Fehler beim Laden des Inhalts';
	@override String get noLicensesFound => 'Keine Lizenzen gefunden';
	@override String get pokaCe => 'Poka CE';
	@override String get communityEdition => 'Community Edition';
	@override String get aboutDescription => 'Ein kostenloser und quelloffener persönlicher Finanzmanager, mit dem du Ausgaben erfassen, Budgets verwalten und deine Konten lokal überwachen kannst.';
	@override String get copyright => '© 2026 POKA. Alle Rechte vorbehalten.';
	@override String get noResultsFound => 'Keine Ergebnisse gefunden';
	@override String weCouldntFindAnyCurrencyMatching({required Object search}) => 'Keine Währung passend zu „${search}“ gefunden.';
	@override String get notSet => 'Nicht festgelegt';
	@override String get exportExcel => 'Nach Excel exportieren';
	@override String get exportExcelDesc => 'Buchungen, Konten und Kategorien als .xlsx exportieren';
	@override String get exportExcelSuccess => 'Excel-Datei erfolgreich exportiert';
	@override String get exportExcelError => 'Exportieren der Excel-Datei fehlgeschlagen';
	@override String get currencyLockedToast => 'Die Währung kann nach dem Erfassen von Buchungen nicht mehr geändert werden. Bitte Daten zurücksetzen, falls du sie ändern möchtest.';
}

// Path: shared
class _Translations$shared$de extends Translations$shared$en {
	_Translations$shared$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get authRequired => 'Authentifizierung erforderlich';
	@override String get hexColorCode => 'Hex-Farbcode';
	@override String get apply => 'Anwenden';
	@override String get enterAmount => 'Betrag eingeben';
	@override String get selectCategory => 'Kategorie wählen';
	@override String get egFf5733 => 'z.B. FF5733';
	@override String get amount => 'Betrag';
	@override String get noCategoriesAvailable => 'Keine Kategorien verfügbar.';
	@override String get noWalletsFoundPleaseCreateOneFirst => 'Keine Wallets gefunden. Bitte erstelle zuerst eine.';
	@override String get balance => 'Saldo: ';
	@override String get optional => 'Optional';
	@override String get customColor => 'Eigene Farbe';
	@override String get selectWallet => 'Wallet auswählen';
}

// Path: transactions
class _Translations$transactions$de extends Translations$transactions$en {
	_Translations$transactions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get searchTransactions => 'Buchungen suchen...';
	@override String get failedToLoad => 'Buchungen konnten nicht geladen werden';
	@override String get cancel => 'Abbrechen';
	@override String get delete => 'Löschen';
	@override String get goToToday => 'Zu Heute springen';
	@override String get addItem => 'Position hinzufügen';
	@override String get saveSplitTransaction => 'Aufgeteilten Beleg speichern';
	@override String get transactionType => 'Buchungsart';
	@override String get applyFilter => 'Filter anwenden';
	@override String get noAccountsAvailable => 'Keine Konten verfügbar';
	@override String get account => 'Konto';
	@override String get category => 'Kategorie';
	@override String get done => 'Fertig';
	@override String get save => 'Speichern';
	@override String get transactions => 'Buchungen';
	@override String get splitTransaction => 'Aufgeteilter Beleg';
	@override String get from => 'Von';
	@override String get to => 'Nach';
	@override String get empty => '+/-';
	@override String get filtered => 'Gefiltert';
	@override String get netBalance => 'Nettosaldo';
	@override String get income => 'Einnahmen';
	@override String get expense => 'Ausgaben';
	@override String get selectCategory => 'Kategorie wählen';
	@override String get filter => 'Filtern';
	@override String get backToToday => 'Zurück zu heute';
	@override String get deleteTransaction => 'Buchung löschen';
	@override String get deleteTransactionWarning => 'Das Löschen dieser Buchung setzt deinen Kontostand und dein Budget auf den vorherigen Stand zurück.';
	@override String get out => 'Aus ';
	@override String get noTransactions => 'Keine Buchungen';
	@override String get addNote => 'Notiz hinzufügen';
	@override String get noItemsYet => 'Noch keine Positionen';
	@override String get tapAddItemToBeginSplittingntheTransaction => 'Tippe auf „Position hinzufügen“, um diesen Beleg auf Kategorien aufzuteilen.';
	@override String get addAtLeastOneMoreItemToSave => 'Füge mindestens eine weitere Position hinzu, um zu speichern.';
	@override String get noTransactions1 => 'Keine Buchungen';
	@override String get reset => 'Zurücksetzen';
	@override String get incoming => 'Ein ';
	@override String nothingRecordedFor({required Object period}) => 'Nichts erfasst für ${period}.';
	@override String splitItems({required Object count}) => '${count} Belegpositionen';
	@override String itemsCount({required Object count}) => '${count} Position(en)';
	@override String transactionsCount({required Object count}) => '${count} Buchungen';
	@override String get editTransaction => 'Buchung bearbeiten';
	@override String get newTransaction => 'Neue Buchung';
	@override String get fromAccount => 'Von Konto';
	@override String get toAccount => 'Auf Konto';
	@override String get need => 'Bedarf';
	@override String get want => 'Wunsch';
	@override String get saving => 'Sparen';
	@override String get addNoteEllipsis => 'Notiz hinzufügen...';
	@override String get editItem => 'Position bearbeiten';
	@override String get newItem => 'Neue Position';
	@override String get viewModeDay => 'Tag';
	@override String get viewModeWeek => 'Woche';
	@override String get viewModeMonth => 'Monat';
	@override String get viewModeDaily => 'Täglich';
	@override String get viewModeWeekly => 'Wöchentlich';
	@override String get viewModeMonthly => 'Monatlich';
	@override String get debt => 'Schulden';
	@override String get recurring => 'Wiederkehrend';
	@override String get transfer => 'Umbuchung';
	@override String weekNumber({required Object weekNum, required Object date}) => 'Woche ${weekNum} · ${date}';
	@override String get insufficientBalance => 'Unzureichender Saldo';
	@override String insufficientBalanceWarning({required Object amount, required Object account, required Object balance}) => 'Der Betrag (${amount}) übersteigt den aktuellen Saldo auf ${account} (${balance}). Wurde eventuell vergessen, zuerst Einnahmen zu erfassen?';
	@override String get insufficientBalanceConsequence => 'Dein Kontostand wird negativ, wenn du fortfährst.';
	@override String get continueAnyway => 'Trotzdem fortfahren';
	@override String get checkAgain => 'Erneut prüfen';
	@override String get transactionDeleted => 'Buchung gelöscht';
	@override String get transactionRestored => 'Buchung wiederhergestellt';
	@override String get allocation => 'Zuteilung';
}

// Path: app.nav
class _Translations$app$nav$de extends Translations$app$nav$en {
	_Translations$app$nav$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get home => 'Start';
	@override String get transactions => 'Buchungen';
	@override String get reports => 'Berichte';
	@override String get accounts => 'Konten';
	@override String get settings => 'Einstellungen';
}

// Path: dashboard.insight
class _Translations$dashboard$insight$de extends Translations$dashboard$insight$en {
	_Translations$dashboard$insight$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get noData => 'Zu wenige Daten in diesem Monat für eine Auswertung.';
	@override String get thisMonth => 'diesen Monat ist';
	@override String get up => 'höher um';
	@override String get down => 'niedriger um';
	@override String get same => 'gleich wie';
	@override String get fromLastMonth => 'im Vergleich zum Vormonat.';
}

// Path: dashboard.days
class _Translations$dashboard$days$de extends Translations$dashboard$days$en {
	_Translations$dashboard$days$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get mon => 'Mo';
	@override String get tue => 'Di';
	@override String get wed => 'Mi';
	@override String get thu => 'Do';
	@override String get fri => 'Fr';
	@override String get sat => 'Sa';
	@override String get sun => 'So';
}

/// The flat map containing all translations for locale <de>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'accounts.accountName' => 'Kontoname',
			'accounts.pocketName' => 'Pocket-Name',
			'accounts.initialBalance' => 'Anfangssaldo',
			'accounts.icon' => 'Symbol',
			'accounts.color' => 'Farbe',
			'accounts.assets' => 'Vermögen',
			'accounts.liability' => 'Verbindlichkeiten',
			'accounts.income' => 'Einnahmen',
			'accounts.expense' => 'Ausgaben',
			'accounts.balance' => 'Saldo',
			'accounts.walletsPockets' => 'Wallets & Pockets',
			'accounts.accounts' => 'Konten',
			'accounts.mainAccounts' => 'Hauptkonten',
			'accounts.deleteAccount' => 'Konto löschen',
			'accounts.areYouSureYouWantToDeleteThisAccountItWillBeHiddenFromTheApp' => 'Möchtest du dieses Konto wirklich löschen? Es wird in der App ausgeblendet.',
			'accounts.delete' => 'Löschen',
			'accounts.account' => 'Konto',
			'accounts.totalBalance' => 'Gesamtsaldo',
			'accounts.pockets' => 'Pockets',
			'accounts.deletePocket' => 'Pocket löschen',
			'accounts.cannotDeleteMainPocket' => 'Haupt-Pocket kann nicht gelöscht werden',
			'accounts.mainPocket' => 'Haupt',
			'accounts.areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp' => 'Möchtest du dieses Pocket wirklich löschen? Es wird in der App ausgeblendet.',
			'accounts.nameCannotBeEmpty' => 'Name darf nicht leer sein',
			'accounts.egMainWallet' => 'z. B. Haupt-Wallet',
			'accounts.egPocket' => 'z. B. Einkäufe, Urlaub',
			'accounts.selectIcon' => 'Symbol wählen',
			'accounts.allowedCategories' => 'Erlaubte Kategorien',
			'accounts.transactions' => 'Buchungen',
			'accounts.editAccount' => 'Konto bearbeiten',
			'accounts.editPocket' => 'Pocket bearbeiten',
			'accounts.updateNameIconOrColor' => 'Name, Symbol oder Farbe ändern',
			'accounts.permanentlyRemoveThisAccount' => 'Dieses Konto dauerhaft entfernen',
			'accounts.seeAll' => 'Alle ansehen',
			'accounts.noTransactionsYet' => 'Noch keine Buchungen',
			'accounts.accountTransactionsSubtitle' => 'Buchungen auf diesem Konto werden hier angezeigt.',
			'accounts.pocketTransactionsSubtitle' => 'Buchungen in diesem Pocket werden hier angezeigt.',
			'accounts.addAccount' => 'Konto hinzufügen',
			'accounts.noAccountsFound' => 'Keine Konten gefunden.',
			'accounts.addPocket' => 'Pocket hinzufügen',
			'accounts.noPocketsYet' => 'Noch keine Pockets',
			'accounts.pocketsHelpYouSplitYourWalletIntoCategories' => 'Pockets helfen dir, dein Wallet in Kategorien zu unterteilen. Dein aktueller Saldo wird automatisch in ein „Haupt“-Pocket verschoben.',
			'accounts.activeAccount' => 'Aktives Konto',
			'accounts.inactiveAccountsWillBeHidden' => 'Inaktive Konten werden ausgeblendet',
			'accounts.noCategoriesAvailable' => 'Keine Kategorien verfügbar.',
			'accounts.noAccountsFound1' => 'Keine Konten gefunden',
			'accounts.subcategoriesCount' => ({required Object count}) => '${count} Unterkategorie(n)',
			'accounts.pocketsCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(count, one: '1 Pocket', other: '${count} Pockets', ), 
			'accounts.totalActiveAccounts' => 'Aktive Konten insgesamt',
			'accounts.noAccountsYet' => 'Noch keine Konten',
			'accounts.tapTheButtonBelowToAddYourFirstAccount' => 'Tippe auf die Schaltfläche unten, um dein erstes Konto hinzuzufügen',
			'accounts.allCategoriesAllowed' => 'Alle Kategorien erlaubt',
			'accounts.categoriesSelected' => ({required Object count}) => '${count} Kategorien ausgewählt',
			'accounts.ratioOfAccount' => ({required Object percent}) => '${percent}% des Kontos',
			'accounts.noMainAccountsYet' => 'Noch keine Hauptkonten vorhanden.',
			'accounts.percentOfAssets' => ({required Object percent}) => '${percent}% des Vermögens',
			'accounts.recentTransactions' => 'Letzte Buchungen',
			'accounts.recentTransactionsCount' => ({required Object count}) => 'Letzte Buchungen (${count})',
			'accounts.reconcileBalance' => 'Saldo abgleichen',
			'accounts.reconcileBalanceSubtitle' => 'App-Saldo mit tatsächlichem Kontostand abgleichen',
			'accounts.currentBalanceInPoka' => 'Saldo in Poka',
			'accounts.actualBalance' => 'Tatsächlicher Saldo',
			'accounts.difference' => 'Differenz',
			'accounts.adjustmentExpense' => 'Korrektur (Ausgabe)',
			'accounts.adjustmentIncome' => 'Korrektur (Einnahme)',
			'accounts.balanceAdjustment' => 'Saldokorrektur',
			'accounts.saveAdjustment' => 'Korrektur speichern',
			'accounts.balancesMatch' => 'Salden stimmen überein, keine Korrektur nötig',
			'accounts.noteOptional' => 'Notiz (optional)',
			'accounts.reconcileAccount' => 'Kontostand abgleichen',
			'app.name' => 'Poka',
			'app.tagline' => 'Dein persönlicher Finanzbegleiter',
			'app.nav.home' => 'Start',
			'app.nav.transactions' => 'Buchungen',
			'app.nav.reports' => 'Berichte',
			'app.nav.accounts' => 'Konten',
			'app.nav.settings' => 'Einstellungen',
			'app.termsOfService' => 'Nutzungsbedingungen',
			'app.privacyPolicy' => 'Datenschutzerklärung',
			'backup.title' => 'Backup & Wiederherstellung',
			'backup.backupAction' => 'Backup erstellen',
			'backup.restoreAction' => 'Wiederherstellen',
			'backup.password' => 'Passwort',
			'backup.confirmPassword' => 'Passwort bestätigen',
			'backup.passwordsDoNotMatch' => 'Passwörter stimmen nicht überein',
			'backup.backupSuccess' => 'Backup erfolgreich erstellt',
			'backup.restoreSuccess' => 'Wiederherstellung erfolgreich',
			'backup.incorrectPassword' => 'Falsches Passwort oder beschädigte Datei',
			'backup.enterPasswordToEncrypt' => 'Passwort zum Verschlüsseln eingeben',
			'backup.enterPasswordToDecrypt' => 'Passwort zum Entschlüsseln eingeben',
			'backup.pleaseRestart' => 'Bitte starte die App neu, um Änderungen anzuwenden.',
			'backup.passwordRequired' => 'Passwort ist erforderlich',
			'backup.reminder' => 'Backup-Erinnerung',
			'backup.reminderDesc' => 'Regelmäßig daran erinnern, ein Backup zu erstellen',
			'backup.reminderOff' => 'Aus',
			'backup.reminderWeekly' => 'Wöchentlich',
			'backup.reminderMonthly' => 'Monatlich',
			'backup.reminderNotificationTitle' => 'Zeit für ein Daten-Backup',
			'backup.reminderNotificationBody' => 'Dein letztes Backup liegt schon etwas zurück. Sichere deine Finanzdaten jetzt.',
			'backup.reminderSaved' => 'Backup-Erinnerung aktualisiert',
			'backup.restoreWarningDesc' => 'Das Wiederherstellen ersetzt alle aktuellen Daten durch die Daten der gewählten Sicherungsdatei. Ungesicherte Änderungen gehen verloren. Fortfahren?',
			'backup.sendTestNotification' => 'Testbenachrichtigung senden',
			'backup.testNotificationSent' => 'Testbenachrichtigung gesendet',
			'backup.permissionRationaleTitle' => 'Lokale Backup-Erinnerung',
			'backup.permissionRationaleDesc' => 'Poka benötigt Benachrichtigungsberechtigungen, um dich an regelmäßige Backups zu erinnern. Erinnerungen laufen vollständig lokal und offline.',
			'backup.allowNotifications' => 'Benachrichtigungen erlauben',
			'backup.permissionDenied' => 'Benachrichtigungsberechtigung abgelehnt. Erinnerungen bleiben deaktiviert.',
			'budgets.budgetName' => 'Budgetname',
			'budgets.spendingLimit' => 'Ausgabenlimit',
			'budgets.period' => 'Zeitraum',
			'budgets.resetDay' => 'Reset-Tag (1–31)',
			'budgets.createBudget' => 'Budget erstellen',
			'budgets.endDate' => 'Enddatum',
			'budgets.budgetDetails' => 'Budgetdetails',
			'budgets.deleteBudget' => 'Budget löschen',
			'budgets.areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone' => 'Möchtest du dieses Budget wirklich löschen? Der gesamte Verlauf wird dauerhaft gelöscht. Dies kann nicht rückgängig gemacht werden.',
			'budgets.delete' => 'Löschen',
			'budgets.transactions' => 'Buchungen',
			'budgets.budgets' => 'Budgets',
			'budgets.allBudgets' => 'Alle Budgets',
			'budgets.egGroceriesEntertainment' => 'z.B. Lebensmittel, Freizeit',
			'budgets.eg80' => 'z.B. 80',
			'budgets.category' => 'Kategorie',
			'budgets.account' => 'Konto',
			'budgets.overLimit' => 'Überschritten',
			'budgets.remaining' => 'Verbleibend',
			'budgets.totalSpent' => 'Insgesamt ausgegeben',
			'budgets.totalLimit' => 'Gesamtlimit',
			'budgets.selectEndDate' => 'Enddatum auswählen',
			'budgets.noTransactionsFoundForThisBudgetPeriod' => 'Keine Buchungen für diesen Budgetzeitraum gefunden.',
			'budgets.budgetTransactionsSubtitle' => 'Buchungen, die zu diesem Budget passen, erscheinen hier.',
			'budgets.addBudget' => 'Budget hinzufügen',
			'budgets.spent' => 'Ausgegeben ',
			'budgets.noBudgetsYet' => 'Noch keine Budgets',
			'budgets.setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod' => 'Lege Limits fest, um zu verfolgen, wohin dein Geld in jedem Zeitraum fließt.',
			'budgets.budgetAlert' => ({required Object name}) => 'Budget-Warnung: ${name}',
			'budgets.percentOf' => ({required Object percent}) => '${percent}% von ',
			'budgets.budgetsCount' => ({required Object count}) => '${count} Budget(s)',
			'budgets.editBudget' => 'Budget bearbeiten',
			'budgets.newBudget' => 'Neues Budget',
			'budgets.nameCannotBeEmpty' => 'Name darf nicht leer sein',
			'budgets.amountGreaterThanZero' => 'Betrag muss größer als 0 sein',
			'budgets.alertThresholdLabel' => 'Warnschwelle (%)',
			'budgets.scope' => 'Geltungsbereich',
			'budgets.anyCategory' => 'Jede Kategorie',
			'budgets.anyAccount' => 'Jedes Konto',
			'budgets.saveChanges' => 'Änderungen speichern',
			'budgets.periodWeekly' => 'Wöchentlich',
			'budgets.periodMonthly' => 'Monatlich',
			'budgets.periodYearly' => 'Jährlich',
			'budgets.periodCustom' => 'Benutzerdefiniert',
			'budgets.budgetExceededAlert' => ({required Object percentage, required Object name}) => 'Du hast ${percentage}% deines Budgets für ${name} aufgebraucht.',
			'categories.expense' => 'Ausgabe',
			'categories.income' => 'Einnahme',
			'categories.categoryName' => 'Kategoriename',
			'categories.icon' => 'Symbol',
			'categories.color' => 'Farbe',
			'categories.noCategoriesFound' => 'Keine Kategorien gefunden.',
			'categories.subcategories' => 'Unterkategorien',
			'categories.categories' => 'Kategorien',
			'categories.egFoodDining' => 'z.B. Essen & Trinken',
			'categories.deleteCategory' => 'Kategorie löschen',
			'categories.delete' => 'Löschen',
			'categories.selectIcon' => 'Symbol auswählen',
			'categories.searchIcons' => 'Symbole suchen...',
			'categories.noIconsFound' => 'Keine Symbole gefunden',
			'categories.weCouldntFindAnyIconMatching' => ({required Object search}) => 'Kein Symbol passend zu "${search}" gefunden.',
			'categories.noSubcategoriesYet' => 'Noch keine Unterkategorien',
			'categories.noCategoriesFound1' => 'Keine Kategorien gefunden',
			'categories.subcategoriesCount' => ({required Object count}) => '${count} Unterkategorien',
			'categories.addSubcategory' => 'Unterkategorie hinzufügen',
			'categories.addCategory' => 'Kategorie hinzufügen',
			'categories.emptyCategorySubtitle' => 'Starte die Ausgabenerfassung mit deiner ersten Kategorie',
			'categories.emptySubcategorySubtitle' => 'Unterteile deine Kategorie in kleinere Einheiten',
			'categories.saveSubCategory' => 'Unterkategorie speichern',
			'categories.saveCategory' => 'Kategorie speichern',
			'categories.newSubCategory' => 'Neue Unterkategorie',
			'categories.newCategory' => 'Neue Kategorie',
			'categories.editSubCategory' => 'Unterkategorie bearbeiten',
			'categories.editCategory' => 'Kategorie bearbeiten',
			'categories.deleteConfirmWithChildren' => ({required Object count}) => 'Möchtest du diese Kategorie wirklich löschen? Ihre ${count} Unterkategorie(n) werden zu Hauptkategorien und zugehörige Buchungen werden unkategorisiert.',
			'categories.deleteConfirmNoChildren' => 'Möchtest du diese Kategorie wirklich löschen? Alle zugehörigen Buchungen werden unkategorisiert.',
			'common.save' => 'Speichern',
			'common.cancel' => 'Abbrechen',
			'common.delete' => 'Löschen',
			'common.edit' => 'Bearbeiten',
			'common.confirm' => 'Bestätigen',
			'common.back' => 'Zurück',
			'common.loading' => 'Laden...',
			'common.error' => 'Ein Fehler ist aufgetreten',
			'common.retry' => 'Wiederholen',
			'common.empty' => 'Noch keine Daten',
			'common.cannotBeUndone' => 'Diese Aktion kann nicht rückgängig gemacht werden.',
			'common.pleaseWait' => 'Bitte warten',
			'common.today' => 'Heute',
			'common.yesterday' => 'Gestern',
			'common.dueToday' => 'Heute fällig',
			'common.overdue' => 'Überfällig',
			'common.uncategorized' => 'Unkategorisiert',
			'common.unknown' => 'Unbekannt',
			'common.notSet' => 'Nicht festgelegt',
			'common.undo' => 'Rückgängig',
			'dashboard.overview' => 'Übersicht',
			'dashboard.myFinances' => 'Meine Finanzen',
			'dashboard.netWorth' => 'Nettovermögen',
			'dashboard.accountsCount' => ({required Object count}) => '${count} Konten',
			'dashboard.assets' => 'Vermögenswerte',
			'dashboard.liabilities' => 'Verbindlichkeiten',
			'dashboard.budgets' => 'Budgets',
			'dashboard.categories' => 'Kategorien',
			'dashboard.goals' => 'Sparziele',
			'dashboard.debts' => 'Schulden',
			'dashboard.recurring' => 'Wiederkehrend',
			'dashboard.cashFlow' => 'Cashflow',
			'dashboard.budget' => 'Budget',
			'dashboard.needs' => 'Bedürfnisse (50%)',
			'dashboard.wants' => 'Wünsche (30%)',
			'dashboard.savings' => 'Sparen (20%)',
			'dashboard.saved' => 'gespart',
			'dashboard.onTrack' => 'Auf Kurs',
			'dashboard.needsAttention' => 'Achtung',
			'dashboard.income' => 'Einnahme',
			'dashboard.expense' => 'Ausgabe',
			'dashboard.other' => 'Sonstiges',
			'dashboard.noData' => 'Keine Daten',
			'dashboard.spendingActivity' => 'Ausgabenverlauf',
			'dashboard.total' => 'Gesamt',
			'dashboard.average' => 'Durchschnitt',
			'dashboard.budgetPerDay' => 'Budget/Tag',
			'dashboard.todaysBudget' => 'Heutiges Budget',
			'dashboard.overbudget' => 'Über Budget!',
			'dashboard.setDailyBudget' => 'Tagesbudget festlegen',
			'dashboard.amount' => 'Betrag',
			'dashboard.amountHint' => 'z.B. 50',
			'dashboard.recentTransactions' => 'Letzte Buchungen',
			'dashboard.thisMonth' => 'Diesen Monat',
			'dashboard.noRecentTransactions' => 'Keine aktuellen Buchungen',
			'dashboard.recentTransactionsSubtitle' => 'Kürzlich erfasste Buchungen erscheinen hier.',
			'dashboard.seeAll' => 'Alle anzeigen',
			'dashboard.notSet' => 'Nicht festgelegt',
			'dashboard.insight.noData' => 'Zu wenige Daten in diesem Monat für eine Auswertung.',
			'dashboard.insight.thisMonth' => 'diesen Monat ist',
			'dashboard.insight.up' => 'höher um',
			'dashboard.insight.down' => 'niedriger um',
			'dashboard.insight.same' => 'gleich wie',
			'dashboard.insight.fromLastMonth' => 'im Vergleich zum Vormonat.',
			'dashboard.days.mon' => 'Mo',
			'dashboard.days.tue' => 'Di',
			'dashboard.days.wed' => 'Mi',
			'dashboard.days.thu' => 'Do',
			'dashboard.days.fri' => 'Fr',
			'dashboard.days.sat' => 'Sa',
			'dashboard.days.sun' => 'So',
			'debts.addRepayment' => 'Zahlung hinzufügen',
			'debts.iOwe' => 'Ich schulde',
			'debts.theyOwe' => 'Schuldet mir',
			'debts.personName' => 'Name der Person',
			'debts.principalAmount' => 'Ursprünglicher Betrag',
			'debts.transactionBinding' => 'Transaktionsbindung',
			'debts.cancel' => 'Abbrechen',
			'debts.save' => 'Speichern',
			'debts.ok' => 'OK',
			'debts.addRecord' => 'Eintrag hinzufügen',
			'debts.createRecord' => 'Eintrag erstellen',
			'debts.debtDetails' => 'Schulden-Details',
			'debts.repaymentHistory' => 'Rückzahlungsverlauf',
			'debts.debtsLoans' => 'Schulden & Kredite',
			'debts.deleteDebt' => 'Schuld löschen',
			'debts.delete' => 'Löschen',
			'debts.writeoffDebt' => 'Schuld abschreiben',
			'debts.areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances' => 'Möchtest du diese Schuld wirklich abschreiben? Sie wird als beglichen markiert, ohne deine Kontosalden zu verändern.',
			'debts.writeoff' => 'Abschreiben',
			'debts.egJohnDoe' => 'z.B. Max Mustermann',
			'debts.category' => 'Kategorie',
			'debts.account' => 'Konto',
			'debts.egDinnerLastFriday' => 'z.B. Abendessen am Freitag',
			'debts.selectDueDate' => 'Fälligkeitsdatum wählen',
			'debts.outstanding' => 'Offen',
			'debts.paid' => 'Bezahlt',
			'debts.principal' => 'Kapital',
			'debts.actionDenied' => 'Aktion verweigert',
			'debts.paymentCannotExceedRemaining' => 'Zahlungsbetrag darf die verbleibende Schuld nicht übersteigen.',
			'debts.addNote' => 'Notiz hinzufügen',
			'debts.payInFull' => 'Vollständig begleichen',
			'debts.remaining' => 'verbleibend',
			'debts.paid1' => 'Bezahlt ',
			'debts.reminder' => ({required Object type, required Object name}) => 'Erinnerung ${type}: ${name}',
			'debts.due' => ({required Object type, required Object name}) => 'Fälligkeit ${type}: ${name}',
			'debts.noHistoryFoundForThis' => ({required Object type}) => 'Kein Verlauf für diese(n) ${type}',
			'debts.repaymentHistorySubtitle' => ({required Object type}) => 'Zahlungen für diese(n) ${type} erscheinen hier.',
			'debts.failedToLoadDebts' => ({required Object error}) => 'Fehler beim Laden von Schulden: ${error}',
			'debts.percentOf' => ({required Object percent}) => '${percent}% von ',
			'debts.settled' => ({required Object count}) => '${count} beglichen',
			'debts.payable' => 'Zu zahlen',
			'debts.receivable' => 'Forderungen',
			'debts.noDebtsRecorded' => 'Keine Schulden erfasst',
			'debts.noLoansRecorded' => 'Keine Darlehen erfasst',
			'debts.trackMoneyYouOweToOthersAndLogRepayments' => 'Behalte im Blick, was du anderen schuldest, und erfasse Rückzahlungen.',
			'debts.trackMoneyOthersOweYouAndLogCollections' => 'Behalte im Blick, was dir andere schulden, und erfasse Geldeingänge.',
			'debts.editRecord' => 'Eintrag bearbeiten',
			'debts.newRecord' => 'Neuer Eintrag',
			'debts.personNameCannotBeEmpty' => 'Name darf nicht leer sein',
			'debts.amountGreaterThanZero' => 'Betrag muss größer als 0 sein',
			'debts.selectCategoryAndAccount' => 'Bitte wähle eine Kategorie und ein Konto',
			'debts.selectCategoryPrompt' => 'Kategorie wählen',
			'debts.selectAccountPrompt' => 'Konto wählen',
			'debts.debtBindingHelp' => 'Das Erfassen dieser Schuld bucht den Betrag auf das Konto (Einnahme).',
			'debts.loanBindingHelp' => 'Das Erfassen dieses Darlehens bucht den Betrag vom Konto ab (Ausgabe).',
			'debts.noteLabel' => 'Notiz',
			'debts.dueDateLabel' => 'Fälligkeitsdatum',
			'debts.saveChanges' => 'Änderungen speichern',
			'debts.deleteConfirm' => ({required Object type}) => 'Möchtest du diese(n) ${type} wirklich löschen? Der Eintrag wird dauerhaft gelöscht.',
			'debts.debtDetailsTitle' => ({required Object type}) => '${type}-Details',
			'debts.debtTypeLoan' => 'Darlehen',
			'debts.debtTypeDebt' => 'Schuld',
			'debts.reminderAlert' => ({required Object type, required Object amount, required Object when, required Object action}) => '${type} über ${amount} muss bis ${when} ${action} werden.',
			'debts.overdueAlert' => ({required Object type, required Object amount, required Object action}) => '${type} über ${amount} ist überfällig und muss sofort ${action} werden.',
			'debts.actionCollect' => 'eingezogen',
			'debts.actionPay' => 'bezahlt',
			'debts.today' => 'heute',
			'debts.inDays' => ({required Object days}) => 'in ${days} Tagen',
			'debts.owedCount' => ({required Object count}) => '${count} Verbindlichkeiten',
			'debts.receivableCount' => ({required Object count}) => '${count} Forderungen',
			'debts.disbursedAmount' => 'Ausgezahlter Betrag',
			'debts.lentAmount' => 'Verliehener Betrag',
			'debts.totalRepaymentAmount' => 'Gesamtrückzahlung',
			'debts.totalReceivableAmount' => 'Gesamtforderung',
			'debts.interestFee' => 'Zinsen / Gebühr',
			'debts.disbursedAmountHelp' => 'Tatsächlicher Geldbetrag, der auf dein oder von deinem Konto gebucht wurde.',
			'debts.totalAmountMustBeGreaterOrEqual' => 'Gesamtrückzahlung darf nicht geringer sein als der ausgezahlte Betrag',
			'debts.disbursedAmountLabel' => ({required Object type}) => '${type}:',
			'debts.interestLabel' => 'Zinsen:',
			'debts.received' => 'Erhalten',
			'debts.lent' => 'Verliehen',
			'error.generic' => 'Ein unerwarteter Fehler ist aufgetreten',
			'error.network' => 'Bitte prüfe deine Internetverbindung und versuche es erneut',
			'error.database' => 'Lokale Daten konnten nicht geladen werden',
			'goals.goals' => 'Sparziele',
			'goals.fulfillGoal' => 'Ziel erfüllen (Ausgeben)',
			'goals.goalName' => 'Zielname',
			'goals.targetAmount' => 'Zielbetrag',
			'goals.createGoal' => 'Ziel erstellen',
			'goals.errorPrefix' => ({required Object error}) => 'Fehler: ${error}',
			'goals.goalDetails' => 'Ziel-Details',
			'goals.transactions' => 'Buchungen',
			'goals.active' => 'Aktiv',
			'goals.past' => 'Abgeschlossen',
			'goals.actionDenied' => 'Aktion verweigert',
			'goals.emptyBalanceBeforeDelete' => 'Überweise das Guthaben auf ein anderes Konto, bevor du dieses Sparziel löschst.',
			'goals.ok' => 'OK',
			'goals.deleteGoal' => 'Ziel löschen',
			'goals.areYouSureYouWantToDeleteThisGoalTheAssociatedPocketAccountAndItsHistoryWillAlsoBeRemovedThisActionCannotBeUndone' => 'Möchtest du dieses Sparziel wirklich löschen? Das zugehörige Unterkonto und sein Verlauf werden gelöscht. Dies kann nicht rückgängig gemacht werden.',
			'goals.delete' => 'Löschen',
			'goals.egEmergencyFundNewLaptop' => 'z.B. Notgroschen, Neuer Laptop',
			'goals.completed' => 'Erreicht',
			'goals.fullyFunded' => 'Vollständig finanziert',
			'goals.inProgress' => 'In Bearbeitung',
			'goals.totalSaved' => 'Insgesamt gespart',
			'goals.stillNeeded' => 'Fehlt noch',
			'goals.totalTarget' => 'Gesamtziel',
			'goals.selectTargetDate' => 'Zieldatum auswählen',
			'goals.noTransactionsFoundForThisGoal' => 'Keine Buchungen für dieses Ziel gefunden.',
			'goals.goalTransactionsSubtitle' => 'Überweisungen für dieses Sparziel erscheinen hier.',
			'goals.addGoal' => 'Ziel hinzufügen',
			'goals.aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal' => 'Ein eigenes Unterkonto wird automatisch erstellt, um dieses Ziel zu verfolgen.',
			'goals.saved' => 'gespart',
			'goals.needs' => 'Benötigt noch ',
			'goals.more' => ' mehr',
			'goals.noGoalsYet' => 'Noch keine Sparziele',
			'goals.setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal' => 'Setze Sparziele — für jedes Ziel wird automatisch ein eigenes Unterkonto angelegt.',
			'goals.percentOfTarget' => ({required Object percent}) => '${percent}% des Ziels',
			'goals.goalsCount' => ({required Object count}) => '${count} Sparziel(e)',
			'goals.fullyFundedCount' => ({required Object count}) => '${count} vollständig erreicht',
			'goals.noCompletedGoalsYet' => 'Noch keine erreichten Sparziele',
			'goals.completedGoalsWillAppearHere' => 'Erreichte Ziele werden hier angezeigt.',
			'goals.editGoal' => 'Ziel bearbeiten',
			'goals.newGoal' => 'Neues Ziel',
			'goals.nameCannotBeEmpty' => 'Name darf nicht leer sein',
			'goals.targetAmountGreaterThanZero' => 'Zielbetrag muss größer als 0 sein',
			'goals.saveChanges' => 'Änderungen speichern',
			'goals.targetDateLabel' => 'Zieldatum',
			'goals.activeGoals' => 'Aktive Ziele',
			'goals.completedGoals' => 'Abgeschlossene Ziele',
			'goals.noActiveGoalsYet' => 'Keine aktiven Ziele',
			'goals.noActiveGoalsSubtitle' => 'Erstelle ein Sparziel, um für deine nächsten Meilensteine zu sparen.',
			'goals.saveInAccount' => 'Auf Konto sparen',
			'goals.selectAccount' => 'Konto auswählen',
			'goals.accountRequired' => 'Bitte wähle ein Konto aus',
			'goals.storedIn' => ({required Object account}) => 'Gespeichert in ${account}',
			'icons.aliases.wallet' => 'wallet, money, cash, salary, pay, income, funds',
			'icons.aliases.bank' => 'bank, atm, account, checking, wire, branch',
			'icons.aliases.credit_card' => 'card, credit, debit, visa, mastercard, payment',
			'icons.aliases.money' => 'money, cash, salary, wage, dollar, income, earnings',
			'icons.aliases.piggy_bank' => 'savings, save, piggy bank, deposit, reserve',
			'icons.aliases.coins' => 'coins, change, cents, currency, cash',
			'icons.aliases.currency_circle_dollar' => 'dollar, currency, foreign exchange, forex',
			'icons.aliases.vault' => 'vault, safe, security, reserve, deposit',
			'icons.aliases.chart_line_up' => 'investment, stock, shares, trading, crypto, growth, profit',
			'icons.aliases.chart_line_down' => 'loss, decrease, decline, dip, expense',
			'icons.aliases.chart_pie' => 'budget, allocation, analytics, breakdown, pie chart',
			'icons.aliases.chart_bar' => 'report, stats, performance, analytics, bar chart',
			'icons.aliases.receipt' => 'receipt, bill, slip, voucher, proof',
			'icons.aliases.invoice' => 'invoice, billing, statement, payment request',
			'icons.aliases.calculator' => 'calculator, calculate, math, accounting, sum',
			'icons.aliases.scales' => 'tax, law, balance, justice, legal, compliance',
			'icons.aliases.hand_coins' => 'donation, charity, tip, alms, giving, offering',
			'icons.aliases.trend_up' => 'trend up, increase, profit, gain, rise',
			'icons.aliases.trend_down' => 'trend down, decrease, loss, drop, fall',
			'icons.aliases.cardholder' => 'cardholder, cards, pouch, wallet',
			'icons.aliases.shopping_cart' => 'cart, supermarket, grocery, shopping, mart',
			'icons.aliases.hamburger' => 'burger, fast food, meal, junk food, food',
			'icons.aliases.coffee' => 'coffee, cafe, starbucks, espresso, drink, beverage',
			'icons.aliases.fork_knife' => 'dining, restaurant, food, eat, meal, lunch, dinner',
			'icons.aliases.pizza' => 'pizza, fast food, food, snack, italian',
			'icons.aliases.bowl_food' => 'noodles, soup, ramen, rice, bowl, food, meal',
			'icons.aliases.beer_bottle' => 'beer, alcohol, beverage, drink, pub',
			'icons.aliases.martini' => 'cocktail, martini, bar, nightlife, drinks',
			'icons.aliases.wine' => 'wine, winery, alcohol, dinner, drink',
			'icons.aliases.cooking_pot' => 'cooking, cookware, kitchen, meal, stew',
			'icons.aliases.carrot' => 'vegetables, produce, market, fresh, vegan, healthy',
			'icons.aliases.cake' => 'cake, bakery, birthday, dessert, sweets, pastry',
			'icons.aliases.ice_cream' => 'ice cream, gelato, dessert, sweets, snack',
			'icons.aliases.cookie' => 'cookie, biscuit, snack, treats',
			'icons.aliases.egg' => 'egg, breakfast, grocery, cooking, farm',
			'icons.aliases.fish_simple' => 'fish, seafood, protein, market',
			'icons.aliases.bag' => 'shopping bag, store, retail, purchase, mall',
			'icons.aliases.storefront' => 'shop, store, market, boutique, retail, merchant',
			'icons.aliases.basket' => 'basket, grocery, shopping, market',
			'icons.aliases.barcode' => 'barcode, scan, price, item, product',
			'icons.aliases.tag' => 'discount, promo, sale, tag, deal, offer',
			'icons.aliases.gift' => 'gift, present, surprise, birthday, souvenir',
			'icons.aliases.package' => 'package, parcel, delivery, courier, shipment, order',
			'icons.aliases.t_shirt' => 'clothing, clothes, t-shirt, shirt, fashion, apparel',
			'icons.aliases.sneaker' => 'shoes, sneakers, footwear, boots, fashion',
			'icons.aliases.watch' => 'watch, wristwatch, accessory, time, luxury',
			'icons.aliases.sunglasses' => 'sunglasses, glasses, shades, eyewear, accessory',
			'icons.aliases.tote' => 'tote bag, eco bag, shopping, purse',
			'icons.aliases.handbag' => 'handbag, purse, luxury bag, accessory',
			'icons.aliases.crown' => 'luxury, vip, premium, royalty, reward',
			'icons.aliases.sparkle' => 'beauty, clean, shine, sparkles, special',
			'icons.aliases.car' => 'car, automobile, vehicle, ride, drive',
			'icons.aliases.car_profile' => 'car, sedan, taxi, auto, vehicle',
			'icons.aliases.airplane' => 'airplane, flight, plane, airline, ticket, travel',
			'icons.aliases.airplane_tilt' => 'flight, travel, holiday, aviation',
			'icons.aliases.airplane_takeoff' => 'departure, takeoff, flight, travel, airport',
			'icons.aliases.airplane_landing' => 'arrival, landing, flight, return',
			'icons.aliases.bicycle' => 'bicycle, bike, cycling, ride',
			'icons.aliases.bus' => 'bus, public transport, transit, commute',
			'icons.aliases.train' => 'train, subway, railway, metro, transit',
			'icons.aliases.taxi' => 'taxi, cab, ride-hailing, uber, transport',
			'icons.aliases.gas_pump' => 'gas, fuel, petrol, oil, gasoline',
			'icons.aliases.charging_station' => 'electric vehicle, ev, charging, battery, electric',
			'icons.aliases.map_pin' => 'location, place, destination, gps, map',
			'icons.aliases.globe' => 'travel, worldwide, international, trip, foreign',
			'icons.aliases.tent' => 'camping, tent, outdoor, adventure, nature',
			'icons.aliases.suitcase' => 'luggage, baggage, vacation, trip, travel',
			'icons.aliases.suitcase_rolling' => 'suitcase, travel, suitcase with wheels, flight',
			'icons.aliases.scooter' => 'scooter, moped, ride, motor',
			'icons.aliases.motorcycle' => 'motorcycle, motorbike, bike, ride',
			'icons.aliases.boat' => 'boat, ferry, cruise, ship, sailing',
			'icons.aliases.house' => 'house, home, residence, property, housing',
			'icons.aliases.house_line' => 'neighborhood, residential, suburban, house',
			'icons.aliases.building' => 'building, office, commercial, city',
			'icons.aliases.building_apartment' => 'apartment, flat, condo, rent, lodging',
			'icons.aliases.key' => 'key, access, lock, security, home key',
			'icons.aliases.lightning' => 'electricity, power, utilities, electric bill, energy',
			'icons.aliases.drop' => 'water, utilities, water bill, aqua, liquid',
			'icons.aliases.fire' => 'gas, heating, lpg, energy, stove',
			'icons.aliases.wifi_high' => 'internet, wifi, broadband, network, connection',
			'icons.aliases.plugs' => 'appliances, electronics, power, plug',
			'icons.aliases.television' => 'tv, television, entertainment, screen, streaming',
			'icons.aliases.armchair' => 'furniture, sofa, chair, living room, decor',
			'icons.aliases.bed' => 'bed, mattress, hotel, bedroom, sleep',
			'icons.aliases.wrench' => 'tools, maintenance, repair, plumbing, service',
			'icons.aliases.hammer' => 'construction, renovation, DIY, tools, repair',
			'icons.aliases.paint_roller' => 'painting, renovation, decorating, home improvement',
			'icons.aliases.toilet' => 'toilet, bathroom, plumbing, restroom',
			'icons.aliases.bathtub' => 'bathtub, bath, spa, bathroom',
			'icons.aliases.shower' => 'shower, bathroom, water',
			'icons.aliases.lightbulb' => 'lighting, electricity, bulb, idea, utilities',
			'icons.aliases.first_aid' => 'first aid, emergency, medical, kit, clinic',
			'icons.aliases.pill' => 'medicine, medication, pharmacy, prescription, pills, drugs',
			'icons.aliases.heart_beat' => 'health, heartbeat, pulse, cardio, medical',
			'icons.aliases.syringe' => 'vaccine, injection, blood test, clinical, needle',
			'icons.aliases.stethoscope' => 'doctor, physician, consultation, hospital, checkup',
			'icons.aliases.brain' => 'mental health, psychology, therapy, neurology, brain',
			'icons.aliases.baby' => 'baby, child, toddler, infant, kids',
			'icons.aliases.bandaids' => 'bandage, wound, first aid, care',
			'icons.aliases.thermometer' => 'fever, temperature, sickness, medical',
			'icons.aliases.wheelchair' => 'disability, wheelchair, accessibility, care',
			'icons.aliases.activity' => 'activity, wellness, vitals, tracking, health',
			'icons.aliases.tooth' => 'dentist, dental, teeth, tooth, oral care',
			'icons.aliases.shield_check' => 'insurance, policy, security, guarantee, protection',
			'icons.aliases.shield_plus' => 'health insurance, medical protection, coverage',
			'icons.aliases.barbell' => 'gym, fitness, workout, weightlifting, exercise',
			'icons.aliases.student' => 'student, school, college, pupil, learner',
			'icons.aliases.graduation_cap' => 'graduation, degree, university, education, college',
			'icons.aliases.book' => 'book, reading, textbook, library',
			'icons.aliases.book_open' => 'study, learning, coursework, reading',
			'icons.aliases.books' => 'books, literature, library, bookstore, research',
			'icons.aliases.exam' => 'exam, test, quiz, grades, evaluation',
			'icons.aliases.pencil' => 'pencil, drawing, writing, sketch, stationary',
			'icons.aliases.pen' => 'pen, writing, signature, document, stationary',
			'icons.aliases.chalkboard' => 'classroom, board, teacher, lecture, school',
			'icons.aliases.certificate' => 'certificate, diploma, course, qualification, training',
			'icons.aliases.backpack' => 'backpack, school bag, bag, student',
			'icons.aliases.ruler' => 'ruler, measuring, stationary, architecture, scale',
			'icons.aliases.game_controller' => 'gaming, games, video games, playstation, xbox, steam',
			'icons.aliases.film_strip' => 'movie, cinema, film, theater, entertainment',
			'icons.aliases.monitor_play' => 'streaming, youtube, netflix, video, watch',
			'icons.aliases.music_notes' => 'music, song, audio, spotify, concert',
			'icons.aliases.headphones' => 'headphones, headset, audio, podcast, listening',
			_ => null,
		} ?? switch (path) {
			'icons.aliases.palette' => 'art, painting, drawing, hobby, creativity',
			'icons.aliases.heart' => 'romance, love, partner, family, date',
			'icons.aliases.smiley' => 'fun, recreation, entertainment, happiness',
			'icons.aliases.camera' => 'photography, camera, photos, video, creative',
			'icons.aliases.popcorn' => 'cinema snack, popcorn, movies, theater',
			'icons.aliases.ticket' => 'ticket, admission, event, concert, show',
			'icons.aliases.microphone' => 'karaoke, singing, podcast, voice, mic',
			'icons.aliases.radio' => 'radio, broadcast, audio, news',
			'icons.aliases.speaker_hifi' => 'speaker, sound, audio system, hifi',
			'icons.aliases.mask_happy' => 'theater, drama, performing arts, culture',
			'icons.aliases.volleyball' => 'volleyball, sports, match, recreation',
			'icons.aliases.basketball' => 'basketball, nba, sports, court',
			'icons.aliases.soccer_ball' => 'soccer, football, sports, match',
			'icons.aliases.laptop' => 'laptop, computer, macbook, work, pc',
			'icons.aliases.desktop' => 'desktop, pc, computer, monitor, workstation',
			'icons.aliases.device_mobile' => 'phone, mobile, smartphone, cell, cellular',
			'icons.aliases.devices' => 'gadgets, electronics, hardware, devices',
			'icons.aliases.briefcase' => 'work, business, job, office, career, corporate',
			'icons.aliases.pen_nib' => 'design, graphic, vector, creative, art',
			'icons.aliases.code' => 'coding, software, programming, developer, tech',
			'icons.aliases.folder' => 'files, documents, folder, archive, records',
			'icons.aliases.printer' => 'printer, printing, copy, paper, documents',
			'icons.aliases.mouse' => 'mouse, computer accessories, pointer',
			'icons.aliases.keyboard' => 'keyboard, typing, input, computer',
			'icons.aliases.hard_drives' => 'storage, hard drive, backup, server, data',
			'icons.aliases.cpu' => 'processor, cpu, hardware, chip, computing',
			'icons.aliases.headset' => 'headset, customer service, calls, meeting, zoom',
			'icons.aliases.handshake' => 'deal, partnership, agreement, client, business',
			'icons.aliases.users' => 'family, team, people, group, community',
			'icons.aliases.user' => 'personal, profile, self, individual, account',
			'icons.aliases.paw_print' => 'pets, animals, veterinary, paw',
			'icons.aliases.cat' => 'cat, kitten, pet food, feline',
			'icons.aliases.dog' => 'dog, puppy, canine, pet food',
			'icons.aliases.bird' => 'bird, parrot, avian, pet',
			'icons.aliases.fish' => 'fish, aquarium, seafood, aquatic',
			'icons.aliases.horse' => 'horse, equestrian, riding',
			'icons.aliases.shield_star' => 'family protection, life insurance, guardian',
			'icons.aliases.dots_three' => 'more, options, other, miscellaneous, extra',
			'icons.aliases.star' => 'favorites, star, bookmark, special, rating',
			'icons.aliases.asterisk' => 'note, reference, asterisk, remark',
			'icons.aliases.question' => 'help, support, faq, question, inquiry',
			'icons.aliases.info' => 'information, details, about, notice',
			'icons.aliases.bell' => 'notification, alert, reminder, bell, chime',
			'icons.aliases.calendar' => 'calendar, date, schedule, event, deadline',
			'icons.aliases.clock' => 'time, clock, hour, timer, watch',
			'icons.aliases.flag' => 'goal, milestone, flag, priority, marker',
			'icons.aliases.leaf' => 'eco, nature, organic, plant, environment',
			'icons.aliases.tree' => 'trees, park, nature, landscape, outdoors',
			'icons.aliases.umbrella' => 'umbrella, rain, protection, monsoon, weather',
			'icons.aliases.target' => 'target, aim, goal, objective, target savings',
			'icons.aliases.trophy' => 'achievement, reward, win, success, trophy',
			'lock.confirmPin' => 'PIN bestätigen',
			'lock.createPin' => 'PIN erstellen',
			'lock.pinsDoNotMatch' => 'PINs stimmen nicht überein',
			'lock.reenterPin' => 'PIN erneut eingeben',
			'lock.enterPinAppLock' => 'PIN zur Entsperrung eingeben',
			'lock.incorrectPin' => 'Falsche PIN',
			'lock.verifyIdentity' => 'Identität bestätigen',
			'lock.retryInSeconds' => ({required Object seconds}) => 'In ${seconds} Sekunden erneut versuchen',
			'lock.setupPinTitle' => 'PIN einrichten',
			'lock.setupPinBody' => 'Bitte erstelle eine PIN, bevor du App-Sperre oder Biometrie aktivierst.',
			'lock.unlocked' => 'Entsperrt',
			'lock.enter6DigitPin' => '6-stellige PIN eingeben',
			'lock.enterPin' => 'PIN eingeben',
			'lock.invalidPin' => 'Ungültige PIN',
			'lock.tooManyAttempts' => 'Zu viele Versuche',
			'lock.temporarilyLocked' => 'Vorübergehend gesperrt',
			'lock.authenticateReason' => 'Bestätige deine Identität für Poka',
			'onboarding.continueWithCurrency' => 'Mit gewählter Währung fortfahren',
			'onboarding.chooseYourBaseCurrency' => 'Wähle deine Basiswährung',
			'onboarding.thisCurrencyWillBeUsedForAllAccountsPocketsAndTransactionsYouCanChangeThisLaterInSettings' => 'Diese Währung wird für alle Konten, Unterkonten und Buchungen verwendet. Du kannst dies später in den Einstellungen ändern.',
			'recurring.addSchedule' => 'Wiederholung hinzufügen',
			'recurring.transactionDetails' => 'Buchungsdetails',
			'recurring.amount' => 'Betrag',
			'recurring.frequency' => 'Häufigkeit',
			'recurring.startDate' => 'Startdatum',
			'recurring.recurring' => 'Wiederkehrend',
			'recurring.schedules' => 'Daueraufträge',
			'recurring.scheduleDetails' => 'Details des Dauerauftrags',
			'recurring.deleteSchedule' => 'Dauerauftrag löschen',
			'recurring.areYouSureYouWantToDeleteThisRecurringScheduleExistingGeneratedTransactionsWillNotBeDeleted' => 'Möchtest du diesen Dauerauftrag wirklich löschen? Bereits generierte Buchungen bleiben erhalten.',
			'recurring.delete' => 'Löschen',
			'recurring.triggerHistory' => 'Ausführungsverlauf',
			'recurring.destinationAccount' => 'Zielkonto',
			'recurring.category' => 'Kategorie',
			'recurring.egNetflixSubscription' => 'z.B. Netflix-Abonnement',
			'recurring.selectFirstDueDate' => 'Erste Fälligkeit auswählen',
			'recurring.estMonthlyNet' => 'Geschätztes Monatssaldo',
			'recurring.monthlyIn' => 'Einnahmen/Monat',
			'recurring.monthlyOut' => 'Ausgaben/Monat',
			'recurring.noRecurringTransactions' => 'Keine Daueraufträge',
			'recurring.automateBillsLikeSubscriptionsOrSalary' => 'Automatisiere Fixkosten wie Abos oder Gehalt. Die App erfasst sie pünktlich.',
			'recurring.noHistoryFoundForThisSchedule' => 'Kein Verlauf für diesen Dauerauftrag.',
			'recurring.scheduleHistorySubtitle' => 'Generierte Buchungen erscheinen hier.',
			'recurring.allocation' => 'Aufteilung',
			'recurring.active' => 'Aktiv',
			'recurring.eachTimeTheAppOpensOverdueRecurringTransactionsAre' => 'Bei jedem Öffnen der App werden fällige Daueraufträge automatisch im Buchungsjournal erfasst.',
			'recurring.schedulesCount' => ({required Object count}) => '${count} Daueraufträge',
			'recurring.pausedCount' => ({required Object count}) => '${count} pausiert',
			'recurring.editRecurring' => 'Dauerauftrag bearbeiten',
			'recurring.newRecurring' => 'Neuer Dauerauftrag',
			'recurring.mustSelectAccount' => 'Ein Konto muss ausgewählt werden',
			'recurring.sourceAccount' => 'Quellkonto',
			'recurring.account' => 'Konto',
			'recurring.selectAccountPrompt' => 'Konto wählen',
			'recurring.selectDestinationPrompt' => 'Ziel wählen',
			'recurring.selectCategoryOptional' => 'Kategorie wählen (optional)',
			'recurring.noteLabel' => 'Notiz',
			'recurring.saveChanges' => 'Änderungen speichern',
			'recurring.createRecurring' => 'Dauerauftrag anlegen',
			'recurring.amountGreaterThanZero' => 'Betrag muss größer als 0 sein',
			'recurring.mustSelectStartDate' => 'Startdatum muss ausgewählt werden',
			'recurring.periodDaily' => 'Täglich',
			'recurring.periodWeekly' => 'Wöchentlich',
			'recurring.periodMonthly' => 'Monatlich',
			'recurring.periodYearly' => 'Jährlich',
			'recurring.autoGenerateActive' => 'Generiert Buchungen automatisch',
			'recurring.autoGeneratePaused' => 'Pausiert — es werden keine Buchungen generiert',
			'recurring.recurringIncome' => 'Wiederkehrende Einnahme',
			'recurring.recurringExpense' => 'Wiederkehrende Ausgabe',
			'recurring.recurringTransfer' => 'Wiederkehrende Umbuchung',
			'recurring.nextDateLabel' => ({required Object date}) => 'Nächste: ${date}',
			'reports.title' => 'Berichte',
			'reports.overview' => 'Finanzübersicht',
			'reports.tabCashflow' => 'Cashflow',
			'reports.tabBudgets' => 'Budgets & Sparziele',
			'reports.period' => 'Zeitraum',
			'reports.thisMonth' => 'Diesen Monat',
			'reports.lastMonth' => 'Letzten Monat',
			'reports.last3Months' => '3 Monate',
			'reports.last6Months' => '6 Monate',
			'reports.custom' => 'Benutzerdefiniert',
			'reports.income' => 'Einnahme',
			'reports.expense' => 'Ausgabe',
			'reports.netSavings' => 'Netto-Ersparnis',
			'reports.netCashflow' => 'Netto-Cashflow',
			'reports.cashflow' => 'Cashflow',
			'reports.savingsRate' => 'Sparquote',
			'reports.topCategories' => 'Top-Kategorien',
			'reports.topExpenses' => 'Größte Ausgaben',
			'reports.topIncome' => 'Größte Einnahmen',
			'reports.monthlyTrend' => 'Monatstrend',
			'reports.cashflowTrend' => 'Einnahmen vs. Ausgaben',
			'reports.budgetBreakdown' => 'Budget-Aufschlüsselung',
			'reports.budgetUtilization' => 'Budget-Ausschöpfung',
			'reports.spendingAllocation' => 'Ausgabenverteilung',
			'reports.noData' => 'Keine Daten in diesem Zeitraum',
			'reports.noExpenseDataDesc' => 'Erfasse Ausgaben, um deine Ausgabenverteilung zu sehen.',
			'reports.noBudgets' => 'Keine Budgets eingerichtet',
			'reports.noBudgetsDesc' => 'Erstelle Budgets, um deine Ausgabenlimits zu kontrollieren',
			'reports.onTrack' => 'Auf Kurs',
			'reports.needsAttention' => 'Achtung erforderlich',
			'reports.overBudget' => 'Über Budget',
			'reports.onBudget' => 'Im Limit',
			'reports.needs' => 'Bedürfnisse',
			'reports.wants' => 'Wünsche',
			'reports.savings' => 'Sparen',
			'reports.other' => 'Sonstiges',
			'reports.total' => 'Gesamt',
			'reports.average' => 'Durchschnitt',
			'reports.remaining' => 'Verbleibend',
			'reports.spent' => 'Ausgegeben',
			'reports.limit' => 'Limit',
			'reports.txCount' => ({required Object count}) => '${count} Buchungen',
			'reports.selectDateRange' => 'Datumsbereich auswählen',
			'reports.apply' => 'Anwenden',
			'reports.from' => 'Von',
			'reports.to' => 'Bis',
			'reports.comparedTo' => ({required Object period}) => 'ggü. ${period}',
			'reports.higher' => 'höher',
			'reports.lower' => 'niedriger',
			'reports.same' => 'gleich wie',
			'reports.noChange' => 'Keine Änderung',
			'reports.percent50' => '50%',
			'reports.percent30' => '30%',
			'reports.percent20' => '20%',
			'reports.rule503020' => '50/30/20',
			'reports.prevLastMonth' => 'letzter Monat',
			'reports.prevMonth' => 'Vormonat',
			'reports.prev3Months' => 'letzte 3 Monate',
			'reports.prev6Months' => 'letzte 6 Monate',
			'reports.prevPeriod' => 'Vorperiode',
			'reports.exportExcel' => 'Nach Excel exportieren',
			'reports.exportExcelSuccess' => 'Excel-Datei erfolgreich exportiert',
			'reports.exportExcelError' => 'Fehler beim Exportieren der Excel-Datei',
			'settings.title' => 'Einstellungen',
			'settings.preferences' => 'Einstellungen',
			'settings.baseCurrency' => 'Basiswährung',
			'settings.theme' => 'Design',
			'settings.language' => 'Sprache',
			'settings.numberFormat' => 'Zahlenformat',
			'settings.selectNumberFormat' => 'Zahlenformat wählen',
			'settings.formatSystem' => 'Standard',
			'settings.formatId' => '1.000.000,00',
			'settings.formatUs' => '1,000,000.00',
			'settings.formatFr' => '1 000 000,00',
			'settings.system' => 'System',
			'settings.english' => 'English',
			'settings.indonesia' => 'Indonesia',
			'settings.malay' => 'Bahasa Melayu',
			'settings.vietnam' => 'Tiếng Việt',
			'settings.russian' => 'Русский',
			'settings.spanish' => 'Español',
			'settings.portuguese' => 'Português',
			'settings.german' => 'Deutsch',
			'settings.security' => 'Sicherheit',
			'settings.appLock' => 'App-Sperre',
			'settings.appLockDesc' => 'App mit PIN schützen',
			'settings.biometrics' => 'Biometrie',
			'settings.biometricsDesc' => 'Mit Fingerabdruck entsperren',
			'settings.dataManagement' => 'Datenverwaltung',
			'settings.backupRestore' => 'Sicherung & Wiederherstellung',
			'settings.backupRestoreDesc' => 'Daten sichern oder wiederherstellen',
			'settings.clearOld' => 'Alte Buchungen bereinigen',
			'settings.clearOldDesc' => 'Buchungen älter als 1 Jahr entfernen',
			'settings.resetData' => 'Daten zurücksetzen',
			'settings.resetDataDesc' => 'Alle lokalen App-Daten löschen',
			'settings.support' => 'Support',
			'settings.faq' => 'FAQ',
			'settings.faqDesc' => 'Oft gestellte Fragen',
			'settings.about' => 'Über Poka CE',
			'settings.aboutDesc' => 'Version und rechtliche Hinweise',
			'settings.selectTheme' => 'Design wählen',
			'settings.themeLight' => 'Hell',
			'settings.themeDark' => 'Dunkel',
			'settings.selectLanguage' => 'Sprache wählen',
			'settings.oldTransactionsCleared' => 'Alte Buchungen erfolgreich bereinigt',
			'settings.appDataReset' => 'App-Daten erfolgreich zurückgesetzt',
			'settings.failedToExportLogs' => 'Exportieren der Protokolle fehlgeschlagen',
			'settings.easterEggRemaining' => ({required Object remaining}) => 'Noch ${remaining} Fingertipps bis zur Überraschung...',
			'settings.easterEggFound' => '🎉 Du hast das Easter Egg gefunden!',
			'settings.selectCurrency' => 'Währung wählen',
			'settings.openSourceLicenses' => 'Open-Source-Lizenzen',
			'settings.checkForUpdates' => 'Nach Updates suchen',
			'settings.viewLatestReleasesOnGithub' => 'Neueste Releases auf GitHub ansehen',
			'settings.helpIssues' => 'Hilfe & Fehlermeldungen',
			'settings.reportBugsOrRequestFeatures' => 'Fehler melden oder Funktionen vorschlagen',
			'settings.legal' => 'Rechtliches',
			'settings.termsOfService' => 'Nutzungsbedingungen',
			'settings.readOurTermsAndConditions' => 'Lies unsere Geschäftsbedingungen',
			'settings.privacyPolicy' => 'Datenschutzerklärung',
			'settings.learnHowWeHandleYourData' => 'Erfahre, wie wir deine Daten verarbeiten',
			'settings.viewThirdpartySoftwareLicenses' => 'Drittanbieter-Softwarelizenzen ansehen',
			'settings.advanced' => 'Erweitert',
			'settings.exportDebugLogs' => 'Debug-Protokolle exportieren',
			'settings.shareErrorLogsForTroubleshooting' => 'Fehlerprotokolle zur Fehlerbehebung teilen',
			'settings.search' => 'Suchen...',
			'settings.errorLoadingContent' => 'Fehler beim Laden des Inhalts',
			'settings.noLicensesFound' => 'Keine Lizenzen gefunden',
			'settings.pokaCe' => 'Poka CE',
			'settings.communityEdition' => 'Community Edition',
			'settings.aboutDescription' => 'Ein kostenloser und quelloffener persönlicher Finanzmanager, mit dem du Ausgaben erfassen, Budgets verwalten und deine Konten lokal überwachen kannst.',
			'settings.copyright' => '© 2026 POKA. Alle Rechte vorbehalten.',
			'settings.noResultsFound' => 'Keine Ergebnisse gefunden',
			'settings.weCouldntFindAnyCurrencyMatching' => ({required Object search}) => 'Keine Währung passend zu „${search}“ gefunden.',
			'settings.notSet' => 'Nicht festgelegt',
			'settings.exportExcel' => 'Nach Excel exportieren',
			'settings.exportExcelDesc' => 'Buchungen, Konten und Kategorien als .xlsx exportieren',
			'settings.exportExcelSuccess' => 'Excel-Datei erfolgreich exportiert',
			'settings.exportExcelError' => 'Exportieren der Excel-Datei fehlgeschlagen',
			'settings.currencyLockedToast' => 'Die Währung kann nach dem Erfassen von Buchungen nicht mehr geändert werden. Bitte Daten zurücksetzen, falls du sie ändern möchtest.',
			'shared.authRequired' => 'Authentifizierung erforderlich',
			'shared.hexColorCode' => 'Hex-Farbcode',
			'shared.apply' => 'Anwenden',
			'shared.enterAmount' => 'Betrag eingeben',
			'shared.selectCategory' => 'Kategorie wählen',
			'shared.egFf5733' => 'z.B. FF5733',
			'shared.amount' => 'Betrag',
			'shared.noCategoriesAvailable' => 'Keine Kategorien verfügbar.',
			'shared.noWalletsFoundPleaseCreateOneFirst' => 'Keine Wallets gefunden. Bitte erstelle zuerst eine.',
			'shared.balance' => 'Saldo: ',
			'shared.optional' => 'Optional',
			'shared.customColor' => 'Eigene Farbe',
			'shared.selectWallet' => 'Wallet auswählen',
			'transactions.searchTransactions' => 'Buchungen suchen...',
			'transactions.failedToLoad' => 'Buchungen konnten nicht geladen werden',
			'transactions.cancel' => 'Abbrechen',
			'transactions.delete' => 'Löschen',
			'transactions.goToToday' => 'Zu Heute springen',
			'transactions.addItem' => 'Position hinzufügen',
			'transactions.saveSplitTransaction' => 'Aufgeteilten Beleg speichern',
			'transactions.transactionType' => 'Buchungsart',
			'transactions.applyFilter' => 'Filter anwenden',
			'transactions.noAccountsAvailable' => 'Keine Konten verfügbar',
			'transactions.account' => 'Konto',
			'transactions.category' => 'Kategorie',
			'transactions.done' => 'Fertig',
			'transactions.save' => 'Speichern',
			'transactions.transactions' => 'Buchungen',
			'transactions.splitTransaction' => 'Aufgeteilter Beleg',
			'transactions.from' => 'Von',
			'transactions.to' => 'Nach',
			'transactions.empty' => '+/-',
			'transactions.filtered' => 'Gefiltert',
			'transactions.netBalance' => 'Nettosaldo',
			'transactions.income' => 'Einnahmen',
			'transactions.expense' => 'Ausgaben',
			'transactions.selectCategory' => 'Kategorie wählen',
			'transactions.filter' => 'Filtern',
			'transactions.backToToday' => 'Zurück zu heute',
			'transactions.deleteTransaction' => 'Buchung löschen',
			'transactions.deleteTransactionWarning' => 'Das Löschen dieser Buchung setzt deinen Kontostand und dein Budget auf den vorherigen Stand zurück.',
			'transactions.out' => 'Aus ',
			'transactions.noTransactions' => 'Keine Buchungen',
			'transactions.addNote' => 'Notiz hinzufügen',
			'transactions.noItemsYet' => 'Noch keine Positionen',
			'transactions.tapAddItemToBeginSplittingntheTransaction' => 'Tippe auf „Position hinzufügen“, um diesen Beleg auf Kategorien aufzuteilen.',
			'transactions.addAtLeastOneMoreItemToSave' => 'Füge mindestens eine weitere Position hinzu, um zu speichern.',
			'transactions.noTransactions1' => 'Keine Buchungen',
			'transactions.reset' => 'Zurücksetzen',
			'transactions.incoming' => 'Ein ',
			'transactions.nothingRecordedFor' => ({required Object period}) => 'Nichts erfasst für ${period}.',
			'transactions.splitItems' => ({required Object count}) => '${count} Belegpositionen',
			'transactions.itemsCount' => ({required Object count}) => '${count} Position(en)',
			'transactions.transactionsCount' => ({required Object count}) => '${count} Buchungen',
			'transactions.editTransaction' => 'Buchung bearbeiten',
			'transactions.newTransaction' => 'Neue Buchung',
			'transactions.fromAccount' => 'Von Konto',
			'transactions.toAccount' => 'Auf Konto',
			'transactions.need' => 'Bedarf',
			'transactions.want' => 'Wunsch',
			'transactions.saving' => 'Sparen',
			'transactions.addNoteEllipsis' => 'Notiz hinzufügen...',
			'transactions.editItem' => 'Position bearbeiten',
			'transactions.newItem' => 'Neue Position',
			'transactions.viewModeDay' => 'Tag',
			'transactions.viewModeWeek' => 'Woche',
			'transactions.viewModeMonth' => 'Monat',
			'transactions.viewModeDaily' => 'Täglich',
			'transactions.viewModeWeekly' => 'Wöchentlich',
			'transactions.viewModeMonthly' => 'Monatlich',
			'transactions.debt' => 'Schulden',
			'transactions.recurring' => 'Wiederkehrend',
			'transactions.transfer' => 'Umbuchung',
			'transactions.weekNumber' => ({required Object weekNum, required Object date}) => 'Woche ${weekNum} · ${date}',
			'transactions.insufficientBalance' => 'Unzureichender Saldo',
			'transactions.insufficientBalanceWarning' => ({required Object amount, required Object account, required Object balance}) => 'Der Betrag (${amount}) übersteigt den aktuellen Saldo auf ${account} (${balance}). Wurde eventuell vergessen, zuerst Einnahmen zu erfassen?',
			'transactions.insufficientBalanceConsequence' => 'Dein Kontostand wird negativ, wenn du fortfährst.',
			'transactions.continueAnyway' => 'Trotzdem fortfahren',
			'transactions.checkAgain' => 'Erneut prüfen',
			'transactions.transactionDeleted' => 'Buchung gelöscht',
			'transactions.transactionRestored' => 'Buchung wiederhergestellt',
			'transactions.allocation' => 'Zuteilung',
			_ => null,
		};
	}
}
