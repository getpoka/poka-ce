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
class TranslationsRu extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsRu({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsRu _root = this; // ignore: unused_field

	@override 
	TranslationsRu $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsRu(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$accounts$ru accounts = _Translations$accounts$ru._(_root);
	@override late final _Translations$app$ru app = _Translations$app$ru._(_root);
	@override late final _Translations$backup$ru backup = _Translations$backup$ru._(_root);
	@override late final _Translations$budgets$ru budgets = _Translations$budgets$ru._(_root);
	@override late final _Translations$categories$ru categories = _Translations$categories$ru._(_root);
	@override late final _Translations$common$ru common = _Translations$common$ru._(_root);
	@override late final _Translations$dashboard$ru dashboard = _Translations$dashboard$ru._(_root);
	@override late final _Translations$debts$ru debts = _Translations$debts$ru._(_root);
	@override Map<String, String> get error => {
		'generic': 'Произошла непредвиденная ошибка',
		'network': 'Проверьте соединение с интернетом и повторите попытку',
		'database': 'Не удалось получить доступ к локальным данным',
	};
	@override late final _Translations$goals$ru goals = _Translations$goals$ru._(_root);
	@override late final _Translations$icons$ru icons = _Translations$icons$ru._(_root);
	@override late final _Translations$lock$ru lock = _Translations$lock$ru._(_root);
	@override late final _Translations$onboarding$ru onboarding = _Translations$onboarding$ru._(_root);
	@override late final _Translations$recurring$ru recurring = _Translations$recurring$ru._(_root);
	@override late final _Translations$reports$ru reports = _Translations$reports$ru._(_root);
	@override late final _Translations$settings$ru settings = _Translations$settings$ru._(_root);
	@override late final _Translations$shared$ru shared = _Translations$shared$ru._(_root);
	@override late final _Translations$transactions$ru transactions = _Translations$transactions$ru._(_root);
}

// Path: accounts
class _Translations$accounts$ru extends Translations$accounts$en {
	_Translations$accounts$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get accountName => 'Название счета';
	@override String get pocketName => 'Название кармана';
	@override String get initialBalance => 'Начальный баланс';
	@override String get icon => 'Иконка';
	@override String get color => 'Цвет';
	@override String get assets => 'Активы';
	@override String get liability => 'Обязательства';
	@override String get income => 'Доход';
	@override String get expense => 'Расход';
	@override String get balance => 'Баланс';
	@override String get walletsPockets => 'Кошельки и карманы';
	@override String get accounts => 'Счета';
	@override String get mainAccounts => 'Основные счета';
	@override String get deleteAccount => 'Удалить счет';
	@override String get areYouSureYouWantToDeleteThisAccountItWillBeHiddenFromTheApp => 'Вы уверены, что хотите удалить этот счет? Он будет скрыт в приложении.';
	@override String get delete => 'Удалить';
	@override String get account => 'Счет';
	@override String get totalBalance => 'Общий баланс';
	@override String get pockets => 'Карманы';
	@override String get deletePocket => 'Удалить карман';
	@override String get cannotDeleteMainPocket => 'Основной карман нельзя удалить';
	@override String get mainPocket => 'Основной';
	@override String get areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp => 'Вы уверены, что хотите удалить этот карман? Он будет скрыт в приложении.';
	@override String get nameCannotBeEmpty => 'Название не может быть пустым';
	@override String get egMainWallet => 'напр., Основной кошелек';
	@override String get egPocket => 'напр., Продукты, Отпуск';
	@override String get selectIcon => 'Выбрать иконку';
	@override String get allowedCategories => 'Разрешенные категории';
	@override String get transactions => 'Транзакции';
	@override String get editAccount => 'Редактировать счет';
	@override String get editPocket => 'Редактировать карман';
	@override String get updateNameIconOrColor => 'Обновить имя, иконку или цвет';
	@override String get permanentlyRemoveThisAccount => 'Навсегда удалить этот счет';
	@override String get seeAll => 'Смотреть все';
	@override String get noTransactionsYet => 'Транзакций пока нет';
	@override String get accountTransactionsSubtitle => 'Транзакции этого счета будут отображаться здесь.';
	@override String get pocketTransactionsSubtitle => 'Транзакции этого кармана будут отображаться здесь.';
	@override String get addAccount => 'Добавить счет';
	@override String get noAccountsFound => 'Счета не найдены.';
	@override String get addPocket => 'Добавить карман';
	@override String get noPocketsYet => 'Карманов пока нет';
	@override String get pocketsHelpYouSplitYourWalletIntoCategories => 'Карманы помогают разделить ваш кошелек по категориям. Текущий баланс автоматически перейдет в «Основной» карман.';
	@override String get activeAccount => 'Активный счет';
	@override String get inactiveAccountsWillBeHidden => 'Неактивные счета будут скрыты';
	@override String get noCategoriesAvailable => 'Нет доступных категорий.';
	@override String get noAccountsFound1 => 'Счета не найдены';
	@override String subcategoriesCount({required Object count}) => '${count} подкатегорий';
	@override String pocketsCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(count,
		one: '1 карман',
		other: '${count} карманов',
	);
	@override String get totalActiveAccounts => 'Всего активных счетов';
	@override String get noAccountsYet => 'Счетов пока нет';
	@override String get tapTheButtonBelowToAddYourFirstAccount => 'Нажмите кнопку ниже, чтобы добавить первый счет';
	@override String get allCategoriesAllowed => 'Все категории разрешены';
	@override String categoriesSelected({required Object count}) => 'Выбрано категорий: ${count}';
	@override String ratioOfAccount({required Object percent}) => '${percent}% от счета';
	@override String get noMainAccountsYet => 'Основных счетов пока нет.';
	@override String percentOfAssets({required Object percent}) => '${percent}% от активов';
	@override String get recentTransactions => 'Недавние транзакции';
	@override String recentTransactionsCount({required Object count}) => 'Недавние транзакции (${count})';
	@override String get reconcileBalance => 'Сверить баланс';
	@override String get reconcileBalanceSubtitle => 'Сверить баланс приложения с реальным счетом';
	@override String get currentBalanceInPoka => 'Баланс в Poka';
	@override String get actualBalance => 'Фактический баланс';
	@override String get difference => 'Разница';
	@override String get adjustmentExpense => 'Корректировка (Расход)';
	@override String get adjustmentIncome => 'Корректировка (Доход)';
	@override String get balanceAdjustment => 'Корректировка баланса';
	@override String get saveAdjustment => 'Сохранить корректировку';
	@override String get balancesMatch => 'Балансы совпадают, корректировка не требуется';
	@override String get noteOptional => 'Заметка (необязательно)';
	@override String get reconcileAccount => 'Сверка баланса счета';
}

// Path: app
class _Translations$app$ru extends Translations$app$en {
	_Translations$app$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Poka';
	@override String get tagline => 'Ваш надежный помощник в личных финансах';
	@override late final _Translations$app$nav$ru nav = _Translations$app$nav$ru._(_root);
	@override String get termsOfService => 'Условия обслуживания';
	@override String get privacyPolicy => 'Политика конфиденциальности';
}

// Path: backup
class _Translations$backup$ru extends Translations$backup$en {
	_Translations$backup$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Резервное копирование и восстановление';
	@override String get backupAction => 'Создать копию';
	@override String get restoreAction => 'Восстановить';
	@override String get password => 'Пароль';
	@override String get confirmPassword => 'Подтвердите пароль';
	@override String get passwordsDoNotMatch => 'Пароли не совпадают';
	@override String get backupSuccess => 'Резервная копия успешно создана';
	@override String get restoreSuccess => 'Данные успешно восстановлены';
	@override String get incorrectPassword => 'Неверный пароль или поврежденный файл';
	@override String get enterPasswordToEncrypt => 'Введите пароль для шифрования копии';
	@override String get enterPasswordToDecrypt => 'Введите пароль для расшифровки';
	@override String get pleaseRestart => 'Пожалуйста, перезапустите приложение для применения изменений.';
	@override String get passwordRequired => 'Пароль обязателен';
	@override String get reminder => 'Напоминание о бэкапе';
	@override String get reminderDesc => 'Периодически напоминать о создании резервной копии';
	@override String get reminderOff => 'Выкл';
	@override String get reminderWeekly => 'Еженедельно';
	@override String get reminderMonthly => 'Ежемесячно';
	@override String get reminderNotificationTitle => 'Пора сделать резервную копию';
	@override String get reminderNotificationBody => 'С момента последней копии прошло много времени. Защитите свои финансовые данные, создав бэкап прямо сейчас.';
	@override String get reminderSaved => 'Напоминание сохранено';
	@override String get restoreWarningDesc => 'Восстановление заменит все текущие данные данными из выбранного файла бэкапа. Все несохраненные изменения будут потеряны. Продолжить?';
	@override String get sendTestNotification => 'Отправить тестовое уведомление';
	@override String get testNotificationSent => 'Тестовое уведомление отправлено';
	@override String get permissionRationaleTitle => 'Напоминания о резервных копиях';
	@override String get permissionRationaleDesc => 'Poka требуется разрешение на отправку уведомлений, чтобы периодически напоминать о сохранении данных. Напоминания работают полностью офлайн.';
	@override String get allowNotifications => 'Разрешить уведомления';
	@override String get permissionDenied => 'В разрешении отказано. Напоминания отключены.';
}

// Path: budgets
class _Translations$budgets$ru extends Translations$budgets$en {
	_Translations$budgets$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get budgetName => 'Название бюджета';
	@override String get spendingLimit => 'Лимит расходов';
	@override String get period => 'Период';
	@override String get resetDay => 'День сброса (1–31)';
	@override String get createBudget => 'Создать бюджет';
	@override String get endDate => 'Дата окончания';
	@override String get budgetDetails => 'Детали бюджета';
	@override String get deleteBudget => 'Удалить бюджет';
	@override String get areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone => 'Вы уверены, что хотите удалить этот бюджет? Вся связанная история будет безвозвратно удалена. Это действие нельзя отменить.';
	@override String get delete => 'Удалить';
	@override String get transactions => 'Транзакции';
	@override String get budgets => 'Бюджеты';
	@override String get allBudgets => 'Все бюджеты';
	@override String get egGroceriesEntertainment => 'например: Продукты, Развлечения';
	@override String get eg80 => 'например: 80';
	@override String get category => 'Категория';
	@override String get account => 'Счет';
	@override String get overLimit => 'Превышение';
	@override String get remaining => 'Осталось';
	@override String get totalSpent => 'Всего потрачено';
	@override String get totalLimit => 'Общий лимит';
	@override String get selectEndDate => 'Выберите дату окончания';
	@override String get noTransactionsFoundForThisBudgetPeriod => 'В этом периоде нет транзакций по бюджету.';
	@override String get budgetTransactionsSubtitle => 'Транзакции, относящиеся к этому бюджету, появятся здесь.';
	@override String get addBudget => 'Добавить бюджет';
	@override String get spent => 'Потрачено ';
	@override String get noBudgetsYet => 'Бюджетов пока нет';
	@override String get setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod => 'Установите лимиты расходов, чтобы контролировать траты за каждый период.';
	@override String budgetAlert({required Object name}) => 'Внимание, бюджет: ${name}';
	@override String percentOf({required Object percent}) => '${percent}% от ';
	@override String budgetsCount({required Object count}) => 'Бюджетов: ${count}';
	@override String get editBudget => 'Редактировать бюджет';
	@override String get newBudget => 'Новый бюджет';
	@override String get nameCannotBeEmpty => 'Название не может быть пустым';
	@override String get amountGreaterThanZero => 'Сумма должна быть больше 0';
	@override String get alertThresholdLabel => 'Порог предупреждения (%)';
	@override String get scope => 'Область действия';
	@override String get anyCategory => 'Любая категория';
	@override String get anyAccount => 'Любой счет';
	@override String get saveChanges => 'Сохранить изменения';
	@override String get periodWeekly => 'Еженедельный';
	@override String get periodMonthly => 'Ежемесячный';
	@override String get periodYearly => 'Ежегодный';
	@override String get periodCustom => 'Особый';
	@override String budgetExceededAlert({required Object percentage, required Object name}) => 'Вы израсходовали ${percentage}% от бюджета ${name}.';
}

// Path: categories
class _Translations$categories$ru extends Translations$categories$en {
	_Translations$categories$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get expense => 'Расход';
	@override String get income => 'Доход';
	@override String get categoryName => 'Название категории';
	@override String get icon => 'Иконка';
	@override String get color => 'Цвет';
	@override String get noCategoriesFound => 'Категории не найдены.';
	@override String get subcategories => 'Подкатегории';
	@override String get categories => 'Категории';
	@override String get egFoodDining => 'например: Еда и кафе';
	@override String get deleteCategory => 'Удалить категорию';
	@override String get delete => 'Удалить';
	@override String get selectIcon => 'Выбрать иконку';
	@override String get searchIcons => 'Поиск иконок...';
	@override String get noIconsFound => 'Иконки не найдены';
	@override String weCouldntFindAnyIconMatching({required Object search}) => 'Не найдено иконок по запросу "${search}".';
	@override String get noSubcategoriesYet => 'Подкатегорий пока нет';
	@override String get noCategoriesFound1 => 'Категории не найдены';
	@override String subcategoriesCount({required Object count}) => 'Подкатегорий: ${count}';
	@override String get addSubcategory => 'Добавить подкатегорию';
	@override String get addCategory => 'Добавить категорию';
	@override String get emptyCategorySubtitle => 'Начните учет расходов, добавив первую категорию';
	@override String get emptySubcategorySubtitle => 'Разделите категорию на более подробные части';
	@override String get saveSubCategory => 'Сохранить подкатегорию';
	@override String get saveCategory => 'Сохранить категорию';
	@override String get newSubCategory => 'Новая подкатегория';
	@override String get newCategory => 'Новая категория';
	@override String get editSubCategory => 'Редактировать подкатегорию';
	@override String get editCategory => 'Редактировать категорию';
	@override String deleteConfirmWithChildren({required Object count}) => 'Вы уверены, что хотите удалить эту категорию? Ее ${count} подкатегорий станут основными, а транзакции останутся без категории.';
	@override String get deleteConfirmNoChildren => 'Вы уверены, что хотите удалить категорию? Все ее транзакции останутся без категории.';
}

// Path: common
class _Translations$common$ru extends Translations$common$en {
	_Translations$common$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get save => 'Сохранить';
	@override String get cancel => 'Отмена';
	@override String get delete => 'Удалить';
	@override String get edit => 'Изменить';
	@override String get confirm => 'Подтвердить';
	@override String get back => 'Назад';
	@override String get loading => 'Загрузка...';
	@override String get error => 'Произошла ошибка';
	@override String get retry => 'Повторить';
	@override String get empty => 'Данных пока нет';
	@override String get cannotBeUndone => 'Это действие нельзя отменить.';
	@override String get pleaseWait => 'Пожалуйста, подождите';
	@override String get today => 'Сегодня';
	@override String get yesterday => 'Вчера';
	@override String get dueToday => 'Срок сегодня';
	@override String get overdue => 'Просрочено';
	@override String get uncategorized => 'Без категории';
	@override String get unknown => 'Неизвестно';
	@override String get notSet => 'Не задано';
	@override String get undo => 'Отменить';
}

// Path: dashboard
class _Translations$dashboard$ru extends Translations$dashboard$en {
	_Translations$dashboard$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get overview => 'Обзор';
	@override String get myFinances => 'Мои финансы';
	@override String get netWorth => 'Капитал';
	@override String accountsCount({required Object count}) => 'Счетов: ${count}';
	@override String get assets => 'Активы';
	@override String get liabilities => 'Обязательства';
	@override String get budgets => 'Бюджеты';
	@override String get categories => 'Категории';
	@override String get goals => 'Цели';
	@override String get debts => 'Долги';
	@override String get recurring => 'Регулярные';
	@override String get cashFlow => 'Денежный поток';
	@override String get budget => 'Бюджет';
	@override String get needs => 'Необходимое (50%)';
	@override String get wants => 'Желания (30%)';
	@override String get savings => 'Накопления (20%)';
	@override String get saved => 'накоплено';
	@override String get onTrack => 'По плану';
	@override String get needsAttention => 'Требует внимания';
	@override String get income => 'Доход';
	@override String get expense => 'Расход';
	@override String get other => 'Прочее';
	@override String get noData => 'Нет данных';
	@override String get spendingActivity => 'Активность расходов';
	@override String get total => 'Всего';
	@override String get average => 'В среднем';
	@override String get budgetPerDay => 'Бюджет/день';
	@override String get todaysBudget => 'Бюджет на сегодня';
	@override String get overbudget => 'Перерасход!';
	@override String get setDailyBudget => 'Задать дневной бюджет';
	@override String get amount => 'Сумма';
	@override String get amountHint => 'например: 1000';
	@override String get recentTransactions => 'Недавние транзакции';
	@override String get thisMonth => 'В этом месяце';
	@override String get noRecentTransactions => 'Нет недавних транзакций';
	@override String get recentTransactionsSubtitle => 'Недавно внесенные транзакции появятся здесь.';
	@override String get seeAll => 'Смотреть все';
	@override String get notSet => 'Не задано';
	@override late final _Translations$dashboard$insight$ru insight = _Translations$dashboard$insight$ru._(_root);
	@override late final _Translations$dashboard$days$ru days = _Translations$dashboard$days$ru._(_root);
}

// Path: debts
class _Translations$debts$ru extends Translations$debts$en {
	_Translations$debts$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get addRepayment => 'Внести платеж';
	@override String get iOwe => 'Я должен';
	@override String get theyOwe => 'Мне должны';
	@override String get personName => 'Имя контакта';
	@override String get principalAmount => 'Основная сумма';
	@override String get transactionBinding => 'Привязка транзакции';
	@override String get cancel => 'Отмена';
	@override String get save => 'Сохранить';
	@override String get ok => 'ОК';
	@override String get addRecord => 'Добавить запись';
	@override String get createRecord => 'Создать запись';
	@override String get debtDetails => 'Детали долга';
	@override String get repaymentHistory => 'История выплат';
	@override String get debtsLoans => 'Долги и займы';
	@override String get deleteDebt => 'Удалить долг';
	@override String get delete => 'Удалить';
	@override String get writeoffDebt => 'Списать долг';
	@override String get areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances => 'Вы уверены, что хотите списать этот долг? Он будет помечен как выплаченный без изменения баланса счетов.';
	@override String get writeoff => 'Списать';
	@override String get egJohnDoe => 'например: Иван Иванов';
	@override String get category => 'Категория';
	@override String get account => 'Счет';
	@override String get egDinnerLastFriday => 'например: Ужин в пятницу';
	@override String get selectDueDate => 'Выберите срок погашения';
	@override String get outstanding => 'Остаток';
	@override String get paid => 'Выплачено';
	@override String get principal => 'Сумма долга';
	@override String get actionDenied => 'Действие отклонено';
	@override String get paymentCannotExceedRemaining => 'Сумма платежа не может превышать остаток долга.';
	@override String get addNote => 'Добавить примечание';
	@override String get payInFull => 'Выплатить полностью';
	@override String get remaining => 'осталось';
	@override String get paid1 => 'Выплачено ';
	@override String reminder({required Object type, required Object name}) => 'Напоминание ${type}: ${name}';
	@override String due({required Object type, required Object name}) => 'Срок ${type}: ${name}';
	@override String noHistoryFoundForThis({required Object type}) => 'Нет истории выплат для ${type}';
	@override String repaymentHistorySubtitle({required Object type}) => 'История платежей по этому ${type} появится здесь.';
	@override String failedToLoadDebts({required Object error}) => 'Не удалось загрузить долги: ${error}';
	@override String percentOf({required Object percent}) => '${percent}% от ';
	@override String settled({required Object count}) => 'Погашено: ${count}';
	@override String get payable => 'К оплате';
	@override String get receivable => 'К получению';
	@override String get noDebtsRecorded => 'Нет записей о долгах';
	@override String get noLoansRecorded => 'Нет записей о займах';
	@override String get trackMoneyYouOweToOthersAndLogRepayments => 'Учитывайте долги перед другими людьми и отмечайте возвраты здесь.';
	@override String get trackMoneyOthersOweYouAndLogCollections => 'Ведите учет денег, взятых у вас в долг, и фиксируйте возвраты.';
	@override String get editRecord => 'Редактировать запись';
	@override String get newRecord => 'Новая запись';
	@override String get personNameCannotBeEmpty => 'Имя контакта не может быть пустым';
	@override String get amountGreaterThanZero => 'Сумма должна быть больше 0';
	@override String get selectCategoryAndAccount => 'Пожалуйста, выберите категорию и счет';
	@override String get selectCategoryPrompt => 'Выберите категорию';
	@override String get selectAccountPrompt => 'Выберите счет';
	@override String get debtBindingHelp => 'Создание этого долга добавит деньги на счет (доходная транзакция).';
	@override String get loanBindingHelp => 'Создание этого займа спишет деньги со счета (расходная транзакция).';
	@override String get noteLabel => 'Примечание';
	@override String get dueDateLabel => 'Срок погашения';
	@override String get saveChanges => 'Сохранить изменения';
	@override String deleteConfirm({required Object type}) => 'Вы уверены, что хотите удалить этот ${type}? Запись будет удалена безвозвратно. Это действие нельзя отменить.';
	@override String debtDetailsTitle({required Object type}) => 'Детали: ${type}';
	@override String get debtTypeLoan => 'Займ';
	@override String get debtTypeDebt => 'Долг';
	@override String reminderAlert({required Object type, required Object amount, required Object action, required Object when}) => '${type} на сумму ${amount} должен быть ${action} (срок: ${when}).';
	@override String overdueAlert({required Object type, required Object amount, required Object action}) => '${type} на сумму ${amount} просрочен и должен быть ${action} немедленно.';
	@override String get actionCollect => 'получен';
	@override String get actionPay => 'выплачен';
	@override String get today => 'сегодня';
	@override String inDays({required Object days}) => 'через ${days} дн.';
	@override String owedCount({required Object count}) => 'К выплате: ${count}';
	@override String receivableCount({required Object count}) => 'К получению: ${count}';
	@override String get disbursedAmount => 'Выданная/полученная сумма';
	@override String get lentAmount => 'Сумма займа';
	@override String get totalRepaymentAmount => 'Полная сумма к возврату';
	@override String get totalReceivableAmount => 'Полная сумма к получению';
	@override String get interestFee => 'Проценты / комиссия';
	@override String get disbursedAmountHelp => 'Фактическая сумма перевода в кошелек или из кошелька.';
	@override String get totalAmountMustBeGreaterOrEqual => 'Полная сумма не может быть меньше выданной';
	@override String disbursedAmountLabel({required Object type}) => '${type}:';
	@override String get interestLabel => 'Проценты:';
	@override String get received => 'Получено';
	@override String get lent => 'Выдано';
}

// Path: goals
class _Translations$goals$ru extends Translations$goals$en {
	_Translations$goals$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get goals => 'Цели';
	@override String get fulfillGoal => 'Исполнить цель (Потратить)';
	@override String get goalName => 'Название цели';
	@override String get targetAmount => 'Целевая сумма';
	@override String get createGoal => 'Создать цель';
	@override String errorPrefix({required Object error}) => 'Ошибка: ${error}';
	@override String get goalDetails => 'Детали цели';
	@override String get transactions => 'Транзакции';
	@override String get active => 'Активные';
	@override String get past => 'Завершенные';
	@override String get actionDenied => 'Действие отклонено';
	@override String get emptyBalanceBeforeDelete => 'Обнулите баланс (переведите средства) перед удалением цели.';
	@override String get ok => 'ОК';
	@override String get deleteGoal => 'Удалить цель';
	@override String get areYouSureYouWantToDeleteThisGoalTheAssociatedPocketAccountAndItsHistoryWillAlsoBeRemovedThisActionCannotBeUndone => 'Вы уверены, что хотите удалить эту цель? Связанный карман и его история также будут удалены. Это действие нельзя отменить.';
	@override String get delete => 'Удалить';
	@override String get egEmergencyFundNewLaptop => 'например: Подушка безопасности, Новый ноутбук';
	@override String get completed => 'Достигнута';
	@override String get fullyFunded => 'Полностью собрано';
	@override String get inProgress => 'В процессе';
	@override String get totalSaved => 'Всего накоплено';
	@override String get stillNeeded => 'Осталось собрать';
	@override String get totalTarget => 'Общая цель';
	@override String get selectTargetDate => 'Выберите дату цели';
	@override String get noTransactionsFoundForThisGoal => 'Нет транзакций по этой цели.';
	@override String get goalTransactionsSubtitle => 'Переводы и пополнения для этой цели появятся здесь.';
	@override String get addGoal => 'Добавить цель';
	@override String get aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal => 'Для отслеживания этой цели будет автоматически создан отдельный карман.';
	@override String get saved => 'накоплено';
	@override String get needs => 'Нужно еще ';
	@override String get more => '';
	@override String get noGoalsYet => 'Целей пока нет';
	@override String get setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal => 'Ставьте цели накоплений — для каждой автоматически создается отдельный карман.';
	@override String percentOfTarget({required Object percent}) => '${percent}% от цели';
	@override String goalsCount({required Object count}) => 'Целей: ${count}';
	@override String fullyFundedCount({required Object count}) => 'Достигнуто: ${count}';
	@override String get noCompletedGoalsYet => 'Нет завершенных целей';
	@override String get completedGoalsWillAppearHere => 'Достигнутые цели появятся здесь.';
	@override String get editGoal => 'Редактировать цель';
	@override String get newGoal => 'Новая цель';
	@override String get nameCannotBeEmpty => 'Название не может быть пустым';
	@override String get targetAmountGreaterThanZero => 'Сумма цели должна быть больше 0';
	@override String get saveChanges => 'Сохранить изменения';
	@override String get targetDateLabel => 'Целевая дата';
	@override String get activeGoals => 'Активные цели';
	@override String get completedGoals => 'Завершенные цели';
	@override String get noActiveGoalsYet => 'Нет активных целей';
	@override String get noActiveGoalsSubtitle => 'Создайте цель, чтобы начать копить на важную покупку.';
	@override String get saveInAccount => 'Хранить на счете';
	@override String get selectAccount => 'Выберите счет';
	@override String get accountRequired => 'Пожалуйста, выберите счет';
	@override String storedIn({required Object account}) => 'Хранится в ${account}';
}

// Path: icons
class _Translations$icons$ru extends Translations$icons$en {
	_Translations$icons$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

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
class _Translations$lock$ru extends Translations$lock$en {
	_Translations$lock$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get confirmPin => 'Подтвердите PIN';
	@override String get createPin => 'Создайте PIN';
	@override String get pinsDoNotMatch => 'PIN-коды не совпадают';
	@override String get reenterPin => 'Повторите PIN';
	@override String get enterPinAppLock => 'Введите PIN для входа';
	@override String get incorrectPin => 'Неверный PIN';
	@override String get verifyIdentity => 'Подтвердите личность';
	@override String retryInSeconds({required Object seconds}) => 'Повторите через ${seconds} сек.';
	@override String get setupPinTitle => 'Установка PIN-кода';
	@override String get setupPinBody => 'Создайте PIN перед включением блокировки или биометрии.';
	@override String get unlocked => 'Разблокировано';
	@override String get enter6DigitPin => 'Введите 6-значный PIN';
	@override String get enterPin => 'Введите PIN';
	@override String get invalidPin => 'Неверный PIN';
	@override String get tooManyAttempts => 'Слишком много попыток';
	@override String get temporarilyLocked => 'Временно заблокировано';
	@override String get authenticateReason => 'Подтвердите личность для входа в Poka';
}

// Path: onboarding
class _Translations$onboarding$ru extends Translations$onboarding$en {
	_Translations$onboarding$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get continueWithCurrency => 'Продолжить с выбранной валютой';
	@override String get chooseYourBaseCurrency => 'Выберите базовую валюту';
	@override String get thisCurrencyWillBeUsedForAllAccountsPocketsAndTransactionsYouCanChangeThisLaterInSettings => 'Эта валюта будет использоваться для всех счетов, карманов и транзакций. Вы можете изменить ее позже в настройках.';
}

// Path: recurring
class _Translations$recurring$ru extends Translations$recurring$en {
	_Translations$recurring$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get addSchedule => 'Добавить расписание';
	@override String get transactionDetails => 'Детали транзакции';
	@override String get amount => 'Сумма';
	@override String get frequency => 'Частота';
	@override String get startDate => 'Дата начала';
	@override String get recurring => 'Регулярные';
	@override String get schedules => 'Расписания';
	@override String get scheduleDetails => 'Детали расписания';
	@override String get deleteSchedule => 'Удалить расписание';
	@override String get areYouSureYouWantToDeleteThisRecurringScheduleExistingGeneratedTransactionsWillNotBeDeleted => 'Вы уверены, что хотите удалить это расписание? Ранее созданные транзакции удалены не будут.';
	@override String get delete => 'Удалить';
	@override String get triggerHistory => 'История выполнений';
	@override String get destinationAccount => 'Счет назначения';
	@override String get category => 'Категория';
	@override String get egNetflixSubscription => 'например: Подписка на кино';
	@override String get selectFirstDueDate => 'Выберите первую дату платежа';
	@override String get estMonthlyNet => 'Ожид. баланс/мес';
	@override String get monthlyIn => 'Доход/мес';
	@override String get monthlyOut => 'Расход/мес';
	@override String get noRecurringTransactions => 'Нет регулярных транзакций';
	@override String get automateBillsLikeSubscriptionsOrSalary => 'Автоматизируйте счета, подписки или зарплату. Приложение запишет их по графику.';
	@override String get noHistoryFoundForThisSchedule => 'Нет истории по этому расписанию.';
	@override String get scheduleHistorySubtitle => 'Транзакции, созданные этим расписанием, появятся здесь.';
	@override String get allocation => 'Распределение';
	@override String get active => 'Активно';
	@override String get eachTimeTheAppOpensOverdueRecurringTransactionsAre => 'При каждом открытии приложения наступившие регулярные платежи автоматически вносятся в журнал.';
	@override String schedulesCount({required Object count}) => 'Расписаний: ${count}';
	@override String pausedCount({required Object count}) => 'На паузе: ${count}';
	@override String get editRecurring => 'Редактировать расписание';
	@override String get newRecurring => 'Новое расписание';
	@override String get mustSelectAccount => 'Необходимо выбрать счет';
	@override String get sourceAccount => 'Счет списания';
	@override String get account => 'Счет';
	@override String get selectAccountPrompt => 'Выберите счет';
	@override String get selectDestinationPrompt => 'Выберите счет назначения';
	@override String get selectCategoryOptional => 'Выберите категорию (необязательно)';
	@override String get noteLabel => 'Примечание';
	@override String get saveChanges => 'Сохранить изменения';
	@override String get createRecurring => 'Создать расписание';
	@override String get amountGreaterThanZero => 'Сумма должна быть больше 0';
	@override String get mustSelectStartDate => 'Необходимо выбрать дату начала';
	@override String get periodDaily => 'Ежедневно';
	@override String get periodWeekly => 'Еженедельно';
	@override String get periodMonthly => 'Ежемесячно';
	@override String get periodYearly => 'Ежегодно';
	@override String get autoGenerateActive => 'Транзакции будут создаваться автоматически';
	@override String get autoGeneratePaused => 'На паузе — транзакции не будут создаваться';
	@override String get recurringIncome => 'Регулярный доход';
	@override String get recurringExpense => 'Регулярный расход';
	@override String get recurringTransfer => 'Регулярный перевод';
	@override String nextDateLabel({required Object date}) => 'Следующий: ${date}';
}

// Path: reports
class _Translations$reports$ru extends Translations$reports$en {
	_Translations$reports$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Отчеты';
	@override String get overview => 'Финансовый обзор';
	@override String get tabCashflow => 'Денежный поток';
	@override String get tabBudgets => 'Бюджеты и цели';
	@override String get period => 'Период';
	@override String get thisMonth => 'Этот месяц';
	@override String get lastMonth => 'Прошлый месяц';
	@override String get last3Months => '3 месяца';
	@override String get last6Months => '6 месяцев';
	@override String get custom => 'Особый';
	@override String get income => 'Доход';
	@override String get expense => 'Расход';
	@override String get netSavings => 'Чистые накопления';
	@override String get netCashflow => 'Чистый поток';
	@override String get cashflow => 'Денежный поток';
	@override String get savingsRate => 'Норма сбережений';
	@override String get topCategories => 'Топ категорий';
	@override String get topExpenses => 'Топ расходов';
	@override String get topIncome => 'Топ доходов';
	@override String get monthlyTrend => 'Месячный тренд';
	@override String get cashflowTrend => 'Тренд доходов и расходов';
	@override String get budgetBreakdown => 'Структура бюджета';
	@override String get budgetUtilization => 'Использование бюджета';
	@override String get spendingAllocation => 'Распределение трат';
	@override String get noData => 'Нет данных за выбранный период';
	@override String get noExpenseDataDesc => 'Вносите расходы, чтобы увидеть распределение трат.';
	@override String get noBudgets => 'Бюджеты не настроены';
	@override String get noBudgetsDesc => 'Добавьте бюджеты, чтобы следить за лимитами';
	@override String get onTrack => 'В пределах нормы';
	@override String get needsAttention => 'Требует внимания';
	@override String get overBudget => 'Сверх бюджета';
	@override String get onBudget => 'В лимите';
	@override String get needs => 'Необходимое';
	@override String get wants => 'Желания';
	@override String get savings => 'Накопления';
	@override String get other => 'Прочее';
	@override String get total => 'Всего';
	@override String get average => 'В среднем';
	@override String get remaining => 'Остаток';
	@override String get spent => 'Потрачено';
	@override String get limit => 'Лимит';
	@override String txCount({required Object count}) => 'Транзакций: ${count}';
	@override String get selectDateRange => 'Выберите диапазон дат';
	@override String get apply => 'Применить';
	@override String get from => 'С';
	@override String get to => 'По';
	@override String comparedTo({required Object period}) => 'к ${period}';
	@override String get higher => 'выше';
	@override String get lower => 'ниже';
	@override String get same => 'так же, как';
	@override String get noChange => 'Без изменений';
	@override String get percent50 => '50%';
	@override String get percent30 => '30%';
	@override String get percent20 => '20%';
	@override String get rule503020 => '50/30/20';
	@override String get prevLastMonth => 'прошлый месяц';
	@override String get prevMonth => 'пред. месяц';
	@override String get prev3Months => 'пред. 3 мес.';
	@override String get prev6Months => 'пред. 6 мес.';
	@override String get prevPeriod => 'пред. период';
	@override String get exportExcel => 'Экспорт в Excel';
	@override String get exportExcelSuccess => 'Файл Excel успешно экспортирован';
	@override String get exportExcelError => 'Не удалось экспортировать файл Excel';
}

// Path: settings
class _Translations$settings$ru extends Translations$settings$en {
	_Translations$settings$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Настройки';
	@override String get preferences => 'Предпочтения';
	@override String get baseCurrency => 'Основная валюта';
	@override String get theme => 'Тема';
	@override String get language => 'Язык';
	@override String get numberFormat => 'Формат чисел';
	@override String get selectNumberFormat => 'Выбрать формат чисел';
	@override String get formatSystem => 'По умолчанию';
	@override String get formatId => '1.000.000,00';
	@override String get formatUs => '1,000,000.00';
	@override String get formatFr => '1 000 000,00';
	@override String get system => 'Системный';
	@override String get english => 'English';
	@override String get indonesia => 'Indonesia';
	@override String get malay => 'Bahasa Melayu';
	@override String get vietnam => 'Tiếng Việt';
	@override String get russian => 'Русский';
	@override String get spanish => 'Español';
	@override String get portuguese => 'Português';
	@override String get german => 'Deutsch';
	@override String get security => 'Безопасность';
	@override String get appLock => 'Блокировка приложения';
	@override String get appLockDesc => 'Защита PIN-кодом';
	@override String get biometrics => 'Биометрия';
	@override String get biometricsDesc => 'Разблокировка отпечатком';
	@override String get dataManagement => 'Управление данными';
	@override String get backupRestore => 'Резервное копирование';
	@override String get backupRestoreDesc => 'Сохранить или восстановить данные';
	@override String get clearOld => 'Очистить старые транзакции';
	@override String get clearOldDesc => 'Удалить транзакции старше 1 года';
	@override String get resetData => 'Сброс данных';
	@override String get resetDataDesc => 'Стереть все локальные данные приложения';
	@override String get support => 'Поддержка';
	@override String get faq => 'ЧаВо';
	@override String get faqDesc => 'Часто задаваемые вопросы';
	@override String get about => 'О Poka CE';
	@override String get aboutDesc => 'Версия и юридическая информация';
	@override String get selectTheme => 'Выбрать тему';
	@override String get themeLight => 'Светлая';
	@override String get themeDark => 'Темная';
	@override String get selectLanguage => 'Выбрать язык';
	@override String get oldTransactionsCleared => 'Старые транзакции успешно очищены';
	@override String get appDataReset => 'Данные приложения успешно сброшены';
	@override String get failedToExportLogs => 'Не удалось экспортировать журналы';
	@override String easterEggRemaining({required Object remaining}) => 'Осталось ${remaining} нажатий до сюрприза...';
	@override String get easterEggFound => '🎉 Вы нашли пасхалку!';
	@override String get selectCurrency => 'Выбрать валюту';
	@override String get openSourceLicenses => 'Лицензии открытого ПО';
	@override String get checkForUpdates => 'Проверить обновления';
	@override String get viewLatestReleasesOnGithub => 'Посмотреть свежие релизы на GitHub';
	@override String get helpIssues => 'Помощь и проблемы';
	@override String get reportBugsOrRequestFeatures => 'Сообщить об ошибках или предложить идеи';
	@override String get legal => 'Правовая информация';
	@override String get termsOfService => 'Условия обслуживания';
	@override String get readOurTermsAndConditions => 'Ознакомьтесь с условиями и положениями';
	@override String get privacyPolicy => 'Политика конфиденциальности';
	@override String get learnHowWeHandleYourData => 'Узнайте, как мы обрабатываем ваши данные';
	@override String get viewThirdpartySoftwareLicenses => 'Посмотреть сторонние лицензии';
	@override String get advanced => 'Дополнительно';
	@override String get exportDebugLogs => 'Экспорт журналов отладки';
	@override String get shareErrorLogsForTroubleshooting => 'Поделиться журналами для решения проблем';
	@override String get search => 'Поиск...';
	@override String get errorLoadingContent => 'Ошибка загрузки данных';
	@override String get noLicensesFound => 'Лицензии не найдены';
	@override String get pokaCe => 'Poka CE';
	@override String get communityEdition => 'Community Edition';
	@override String get aboutDescription => 'Бесплатный менеджер личных финансов с открытым исходным кодом, который помогает отслеживать расходы, управлять бюджетами и контролировать счета локально.';
	@override String get copyright => '© 2026 POKA. Все права защищены.';
	@override String get noResultsFound => 'Ничего не найдено';
	@override String get weCouldntFindAnyCurrencyMatching => 'Валюта по запросу "{search}" не найдена.';
	@override String get notSet => 'Не задано';
	@override String get exportExcel => 'Экспорт в Excel';
	@override String get exportExcelDesc => 'Экспорт транзакций, счетов и категорий в .xlsx';
	@override String get exportExcelSuccess => 'Файл Excel успешно экспортирован';
	@override String get exportExcelError => 'Не удалось экспортировать файл Excel';
	@override String get currencyLockedToast => 'Валюту нельзя изменить после записи транзакций. Пожалуйста, сбросьте данные, если хотите ее изменить.';
}

// Path: shared
class _Translations$shared$ru extends Translations$shared$en {
	_Translations$shared$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get authRequired => 'Требуется аутентификация';
	@override String get hexColorCode => 'Код цвета Hex';
	@override String get apply => 'Применить';
	@override String get enterAmount => 'Введите сумму';
	@override String get selectCategory => 'Выберите категорию';
	@override String get egFf5733 => 'например: FF5733';
	@override String get amount => 'Сумма';
	@override String get noCategoriesAvailable => 'Нет доступных категорий.';
	@override String get noWalletsFoundPleaseCreateOneFirst => 'Кошельки не найдены. Сначала создайте кошелек.';
	@override String get balance => 'Баланс: ';
	@override String get optional => 'Необязательно';
	@override String get customColor => 'Свой цвет';
	@override String get selectWallet => 'Выбрать кошелек';
}

// Path: transactions
class _Translations$transactions$ru extends Translations$transactions$en {
	_Translations$transactions$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get searchTransactions => 'Поиск транзакций...';
	@override String get failedToLoad => 'Не удалось загрузить транзакции';
	@override String get cancel => 'Отмена';
	@override String get delete => 'Удалить';
	@override String get goToToday => 'Перейти к сегодняшнему дню';
	@override String get addItem => 'Добавить позицию';
	@override String get saveSplitTransaction => 'Сохранить чек с позициями';
	@override String get transactionType => 'Тип транзакции';
	@override String get applyFilter => 'Применить фильтр';
	@override String get noAccountsAvailable => 'Нет доступных счетов';
	@override String get account => 'Счет';
	@override String get category => 'Категория';
	@override String get done => 'Готово';
	@override String get save => 'Сохранить';
	@override String get transactions => 'Транзакции';
	@override String get splitTransaction => 'Чек с позициями';
	@override String get from => 'Из';
	@override String get to => 'В';
	@override String get empty => '+/-';
	@override String get filtered => 'Отфильтровано';
	@override String get netBalance => 'Чистый баланс';
	@override String get income => 'Доход';
	@override String get expense => 'Расход';
	@override String get selectCategory => 'Выбрать категорию';
	@override String get filter => 'Фильтр';
	@override String get backToToday => 'Вернуться к сегодняшнему дню';
	@override String get deleteTransaction => 'Удалить транзакцию';
	@override String get deleteTransactionWarning => 'Удаление этой транзакции вернет баланс счета и бюджет к их прежнему состоянию.';
	@override String get out => 'Расход ';
	@override String get noTransactions => 'Нет транзакций';
	@override String get addNote => 'Добавить заметку';
	@override String get noItemsYet => 'Позиций пока нет';
	@override String get tapAddItemToBeginSplittingntheTransaction => 'Нажмите «Добавить позицию», чтобы распределить этот чек по категориям.';
	@override String get addAtLeastOneMoreItemToSave => 'Добавьте хотя бы еще одну позицию для сохранения.';
	@override String get noTransactions1 => 'Нет транзакций';
	@override String get reset => 'Сбросить';
	@override String get incoming => 'Доход ';
	@override String nothingRecordedFor({required Object period}) => 'Ничего не записано за ${period}.';
	@override String splitItems({required Object count}) => '${count} позиций чека';
	@override String itemsCount({required Object count}) => '${count} позиций';
	@override String transactionsCount({required Object count}) => '${count} транзакций';
	@override String get editTransaction => 'Редактировать транзакцию';
	@override String get newTransaction => 'Новая транзакция';
	@override String get fromAccount => 'Со счета';
	@override String get toAccount => 'На счет';
	@override String get need => 'Необходимое';
	@override String get want => 'Желаемое';
	@override String get saving => 'Сбережения';
	@override String get addNoteEllipsis => 'Добавить заметку...';
	@override String get editItem => 'Редактировать позицию';
	@override String get newItem => 'Новая позиция';
	@override String get viewModeDay => 'День';
	@override String get viewModeWeek => 'Неделя';
	@override String get viewModeMonth => 'Месяц';
	@override String get viewModeDaily => 'По дням';
	@override String get viewModeWeekly => 'По неделям';
	@override String get viewModeMonthly => 'По месяцам';
	@override String get debt => 'Долг';
	@override String get recurring => 'Регулярные';
	@override String get transfer => 'Перевод';
	@override String weekNumber({required Object weekNum, required Object date}) => 'Неделя ${weekNum} · ${date}';
	@override String get insufficientBalance => 'Недостаточно средств';
	@override String insufficientBalanceWarning({required Object amount, required Object account, required Object balance}) => 'Сумма (${amount}) превышает текущий баланс счета ${account} (${balance}). Возможно, вы забыли сначала записать доход?';
	@override String get insufficientBalanceConsequence => 'Баланс вашего счета станет отрицательным, если вы продолжите.';
	@override String get continueAnyway => 'Все равно продолжить';
	@override String get checkAgain => 'Проверить снова';
	@override String get transactionDeleted => 'Транзакция удалена';
	@override String get transactionRestored => 'Транзакция восстановлена';
	@override String get allocation => 'Распределение';
}

// Path: app.nav
class _Translations$app$nav$ru extends Translations$app$nav$en {
	_Translations$app$nav$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get home => 'Главная';
	@override String get transactions => 'Транзакции';
	@override String get reports => 'Отчеты';
	@override String get accounts => 'Счета';
	@override String get settings => 'Настройки';
}

// Path: dashboard.insight
class _Translations$dashboard$insight$ru extends Translations$dashboard$insight$en {
	_Translations$dashboard$insight$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get noData => 'Нет данных за этот месяц для анализа.';
	@override String get thisMonth => 'в этом месяце';
	@override String get up => 'выше на';
	@override String get down => 'ниже на';
	@override String get same => 'так же, как';
	@override String get fromLastMonth => 'по сравнению с прошлым месяцем.';
}

// Path: dashboard.days
class _Translations$dashboard$days$ru extends Translations$dashboard$days$en {
	_Translations$dashboard$days$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get mon => 'Пн';
	@override String get tue => 'Вт';
	@override String get wed => 'Ср';
	@override String get thu => 'Чт';
	@override String get fri => 'Пт';
	@override String get sat => 'Сб';
	@override String get sun => 'Вс';
}

/// The flat map containing all translations for locale <ru>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsRu {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'accounts.accountName' => 'Название счета',
			'accounts.pocketName' => 'Название кармана',
			'accounts.initialBalance' => 'Начальный баланс',
			'accounts.icon' => 'Иконка',
			'accounts.color' => 'Цвет',
			'accounts.assets' => 'Активы',
			'accounts.liability' => 'Обязательства',
			'accounts.income' => 'Доход',
			'accounts.expense' => 'Расход',
			'accounts.balance' => 'Баланс',
			'accounts.walletsPockets' => 'Кошельки и карманы',
			'accounts.accounts' => 'Счета',
			'accounts.mainAccounts' => 'Основные счета',
			'accounts.deleteAccount' => 'Удалить счет',
			'accounts.areYouSureYouWantToDeleteThisAccountItWillBeHiddenFromTheApp' => 'Вы уверены, что хотите удалить этот счет? Он будет скрыт в приложении.',
			'accounts.delete' => 'Удалить',
			'accounts.account' => 'Счет',
			'accounts.totalBalance' => 'Общий баланс',
			'accounts.pockets' => 'Карманы',
			'accounts.deletePocket' => 'Удалить карман',
			'accounts.cannotDeleteMainPocket' => 'Основной карман нельзя удалить',
			'accounts.mainPocket' => 'Основной',
			'accounts.areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp' => 'Вы уверены, что хотите удалить этот карман? Он будет скрыт в приложении.',
			'accounts.nameCannotBeEmpty' => 'Название не может быть пустым',
			'accounts.egMainWallet' => 'напр., Основной кошелек',
			'accounts.egPocket' => 'напр., Продукты, Отпуск',
			'accounts.selectIcon' => 'Выбрать иконку',
			'accounts.allowedCategories' => 'Разрешенные категории',
			'accounts.transactions' => 'Транзакции',
			'accounts.editAccount' => 'Редактировать счет',
			'accounts.editPocket' => 'Редактировать карман',
			'accounts.updateNameIconOrColor' => 'Обновить имя, иконку или цвет',
			'accounts.permanentlyRemoveThisAccount' => 'Навсегда удалить этот счет',
			'accounts.seeAll' => 'Смотреть все',
			'accounts.noTransactionsYet' => 'Транзакций пока нет',
			'accounts.accountTransactionsSubtitle' => 'Транзакции этого счета будут отображаться здесь.',
			'accounts.pocketTransactionsSubtitle' => 'Транзакции этого кармана будут отображаться здесь.',
			'accounts.addAccount' => 'Добавить счет',
			'accounts.noAccountsFound' => 'Счета не найдены.',
			'accounts.addPocket' => 'Добавить карман',
			'accounts.noPocketsYet' => 'Карманов пока нет',
			'accounts.pocketsHelpYouSplitYourWalletIntoCategories' => 'Карманы помогают разделить ваш кошелек по категориям. Текущий баланс автоматически перейдет в «Основной» карман.',
			'accounts.activeAccount' => 'Активный счет',
			'accounts.inactiveAccountsWillBeHidden' => 'Неактивные счета будут скрыты',
			'accounts.noCategoriesAvailable' => 'Нет доступных категорий.',
			'accounts.noAccountsFound1' => 'Счета не найдены',
			'accounts.subcategoriesCount' => ({required Object count}) => '${count} подкатегорий',
			'accounts.pocketsCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(count, one: '1 карман', other: '${count} карманов', ), 
			'accounts.totalActiveAccounts' => 'Всего активных счетов',
			'accounts.noAccountsYet' => 'Счетов пока нет',
			'accounts.tapTheButtonBelowToAddYourFirstAccount' => 'Нажмите кнопку ниже, чтобы добавить первый счет',
			'accounts.allCategoriesAllowed' => 'Все категории разрешены',
			'accounts.categoriesSelected' => ({required Object count}) => 'Выбрано категорий: ${count}',
			'accounts.ratioOfAccount' => ({required Object percent}) => '${percent}% от счета',
			'accounts.noMainAccountsYet' => 'Основных счетов пока нет.',
			'accounts.percentOfAssets' => ({required Object percent}) => '${percent}% от активов',
			'accounts.recentTransactions' => 'Недавние транзакции',
			'accounts.recentTransactionsCount' => ({required Object count}) => 'Недавние транзакции (${count})',
			'accounts.reconcileBalance' => 'Сверить баланс',
			'accounts.reconcileBalanceSubtitle' => 'Сверить баланс приложения с реальным счетом',
			'accounts.currentBalanceInPoka' => 'Баланс в Poka',
			'accounts.actualBalance' => 'Фактический баланс',
			'accounts.difference' => 'Разница',
			'accounts.adjustmentExpense' => 'Корректировка (Расход)',
			'accounts.adjustmentIncome' => 'Корректировка (Доход)',
			'accounts.balanceAdjustment' => 'Корректировка баланса',
			'accounts.saveAdjustment' => 'Сохранить корректировку',
			'accounts.balancesMatch' => 'Балансы совпадают, корректировка не требуется',
			'accounts.noteOptional' => 'Заметка (необязательно)',
			'accounts.reconcileAccount' => 'Сверка баланса счета',
			'app.name' => 'Poka',
			'app.tagline' => 'Ваш надежный помощник в личных финансах',
			'app.nav.home' => 'Главная',
			'app.nav.transactions' => 'Транзакции',
			'app.nav.reports' => 'Отчеты',
			'app.nav.accounts' => 'Счета',
			'app.nav.settings' => 'Настройки',
			'app.termsOfService' => 'Условия обслуживания',
			'app.privacyPolicy' => 'Политика конфиденциальности',
			'backup.title' => 'Резервное копирование и восстановление',
			'backup.backupAction' => 'Создать копию',
			'backup.restoreAction' => 'Восстановить',
			'backup.password' => 'Пароль',
			'backup.confirmPassword' => 'Подтвердите пароль',
			'backup.passwordsDoNotMatch' => 'Пароли не совпадают',
			'backup.backupSuccess' => 'Резервная копия успешно создана',
			'backup.restoreSuccess' => 'Данные успешно восстановлены',
			'backup.incorrectPassword' => 'Неверный пароль или поврежденный файл',
			'backup.enterPasswordToEncrypt' => 'Введите пароль для шифрования копии',
			'backup.enterPasswordToDecrypt' => 'Введите пароль для расшифровки',
			'backup.pleaseRestart' => 'Пожалуйста, перезапустите приложение для применения изменений.',
			'backup.passwordRequired' => 'Пароль обязателен',
			'backup.reminder' => 'Напоминание о бэкапе',
			'backup.reminderDesc' => 'Периодически напоминать о создании резервной копии',
			'backup.reminderOff' => 'Выкл',
			'backup.reminderWeekly' => 'Еженедельно',
			'backup.reminderMonthly' => 'Ежемесячно',
			'backup.reminderNotificationTitle' => 'Пора сделать резервную копию',
			'backup.reminderNotificationBody' => 'С момента последней копии прошло много времени. Защитите свои финансовые данные, создав бэкап прямо сейчас.',
			'backup.reminderSaved' => 'Напоминание сохранено',
			'backup.restoreWarningDesc' => 'Восстановление заменит все текущие данные данными из выбранного файла бэкапа. Все несохраненные изменения будут потеряны. Продолжить?',
			'backup.sendTestNotification' => 'Отправить тестовое уведомление',
			'backup.testNotificationSent' => 'Тестовое уведомление отправлено',
			'backup.permissionRationaleTitle' => 'Напоминания о резервных копиях',
			'backup.permissionRationaleDesc' => 'Poka требуется разрешение на отправку уведомлений, чтобы периодически напоминать о сохранении данных. Напоминания работают полностью офлайн.',
			'backup.allowNotifications' => 'Разрешить уведомления',
			'backup.permissionDenied' => 'В разрешении отказано. Напоминания отключены.',
			'budgets.budgetName' => 'Название бюджета',
			'budgets.spendingLimit' => 'Лимит расходов',
			'budgets.period' => 'Период',
			'budgets.resetDay' => 'День сброса (1–31)',
			'budgets.createBudget' => 'Создать бюджет',
			'budgets.endDate' => 'Дата окончания',
			'budgets.budgetDetails' => 'Детали бюджета',
			'budgets.deleteBudget' => 'Удалить бюджет',
			'budgets.areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone' => 'Вы уверены, что хотите удалить этот бюджет? Вся связанная история будет безвозвратно удалена. Это действие нельзя отменить.',
			'budgets.delete' => 'Удалить',
			'budgets.transactions' => 'Транзакции',
			'budgets.budgets' => 'Бюджеты',
			'budgets.allBudgets' => 'Все бюджеты',
			'budgets.egGroceriesEntertainment' => 'например: Продукты, Развлечения',
			'budgets.eg80' => 'например: 80',
			'budgets.category' => 'Категория',
			'budgets.account' => 'Счет',
			'budgets.overLimit' => 'Превышение',
			'budgets.remaining' => 'Осталось',
			'budgets.totalSpent' => 'Всего потрачено',
			'budgets.totalLimit' => 'Общий лимит',
			'budgets.selectEndDate' => 'Выберите дату окончания',
			'budgets.noTransactionsFoundForThisBudgetPeriod' => 'В этом периоде нет транзакций по бюджету.',
			'budgets.budgetTransactionsSubtitle' => 'Транзакции, относящиеся к этому бюджету, появятся здесь.',
			'budgets.addBudget' => 'Добавить бюджет',
			'budgets.spent' => 'Потрачено ',
			'budgets.noBudgetsYet' => 'Бюджетов пока нет',
			'budgets.setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod' => 'Установите лимиты расходов, чтобы контролировать траты за каждый период.',
			'budgets.budgetAlert' => ({required Object name}) => 'Внимание, бюджет: ${name}',
			'budgets.percentOf' => ({required Object percent}) => '${percent}% от ',
			'budgets.budgetsCount' => ({required Object count}) => 'Бюджетов: ${count}',
			'budgets.editBudget' => 'Редактировать бюджет',
			'budgets.newBudget' => 'Новый бюджет',
			'budgets.nameCannotBeEmpty' => 'Название не может быть пустым',
			'budgets.amountGreaterThanZero' => 'Сумма должна быть больше 0',
			'budgets.alertThresholdLabel' => 'Порог предупреждения (%)',
			'budgets.scope' => 'Область действия',
			'budgets.anyCategory' => 'Любая категория',
			'budgets.anyAccount' => 'Любой счет',
			'budgets.saveChanges' => 'Сохранить изменения',
			'budgets.periodWeekly' => 'Еженедельный',
			'budgets.periodMonthly' => 'Ежемесячный',
			'budgets.periodYearly' => 'Ежегодный',
			'budgets.periodCustom' => 'Особый',
			'budgets.budgetExceededAlert' => ({required Object percentage, required Object name}) => 'Вы израсходовали ${percentage}% от бюджета ${name}.',
			'categories.expense' => 'Расход',
			'categories.income' => 'Доход',
			'categories.categoryName' => 'Название категории',
			'categories.icon' => 'Иконка',
			'categories.color' => 'Цвет',
			'categories.noCategoriesFound' => 'Категории не найдены.',
			'categories.subcategories' => 'Подкатегории',
			'categories.categories' => 'Категории',
			'categories.egFoodDining' => 'например: Еда и кафе',
			'categories.deleteCategory' => 'Удалить категорию',
			'categories.delete' => 'Удалить',
			'categories.selectIcon' => 'Выбрать иконку',
			'categories.searchIcons' => 'Поиск иконок...',
			'categories.noIconsFound' => 'Иконки не найдены',
			'categories.weCouldntFindAnyIconMatching' => ({required Object search}) => 'Не найдено иконок по запросу "${search}".',
			'categories.noSubcategoriesYet' => 'Подкатегорий пока нет',
			'categories.noCategoriesFound1' => 'Категории не найдены',
			'categories.subcategoriesCount' => ({required Object count}) => 'Подкатегорий: ${count}',
			'categories.addSubcategory' => 'Добавить подкатегорию',
			'categories.addCategory' => 'Добавить категорию',
			'categories.emptyCategorySubtitle' => 'Начните учет расходов, добавив первую категорию',
			'categories.emptySubcategorySubtitle' => 'Разделите категорию на более подробные части',
			'categories.saveSubCategory' => 'Сохранить подкатегорию',
			'categories.saveCategory' => 'Сохранить категорию',
			'categories.newSubCategory' => 'Новая подкатегория',
			'categories.newCategory' => 'Новая категория',
			'categories.editSubCategory' => 'Редактировать подкатегорию',
			'categories.editCategory' => 'Редактировать категорию',
			'categories.deleteConfirmWithChildren' => ({required Object count}) => 'Вы уверены, что хотите удалить эту категорию? Ее ${count} подкатегорий станут основными, а транзакции останутся без категории.',
			'categories.deleteConfirmNoChildren' => 'Вы уверены, что хотите удалить категорию? Все ее транзакции останутся без категории.',
			'common.save' => 'Сохранить',
			'common.cancel' => 'Отмена',
			'common.delete' => 'Удалить',
			'common.edit' => 'Изменить',
			'common.confirm' => 'Подтвердить',
			'common.back' => 'Назад',
			'common.loading' => 'Загрузка...',
			'common.error' => 'Произошла ошибка',
			'common.retry' => 'Повторить',
			'common.empty' => 'Данных пока нет',
			'common.cannotBeUndone' => 'Это действие нельзя отменить.',
			'common.pleaseWait' => 'Пожалуйста, подождите',
			'common.today' => 'Сегодня',
			'common.yesterday' => 'Вчера',
			'common.dueToday' => 'Срок сегодня',
			'common.overdue' => 'Просрочено',
			'common.uncategorized' => 'Без категории',
			'common.unknown' => 'Неизвестно',
			'common.notSet' => 'Не задано',
			'common.undo' => 'Отменить',
			'dashboard.overview' => 'Обзор',
			'dashboard.myFinances' => 'Мои финансы',
			'dashboard.netWorth' => 'Капитал',
			'dashboard.accountsCount' => ({required Object count}) => 'Счетов: ${count}',
			'dashboard.assets' => 'Активы',
			'dashboard.liabilities' => 'Обязательства',
			'dashboard.budgets' => 'Бюджеты',
			'dashboard.categories' => 'Категории',
			'dashboard.goals' => 'Цели',
			'dashboard.debts' => 'Долги',
			'dashboard.recurring' => 'Регулярные',
			'dashboard.cashFlow' => 'Денежный поток',
			'dashboard.budget' => 'Бюджет',
			'dashboard.needs' => 'Необходимое (50%)',
			'dashboard.wants' => 'Желания (30%)',
			'dashboard.savings' => 'Накопления (20%)',
			'dashboard.saved' => 'накоплено',
			'dashboard.onTrack' => 'По плану',
			'dashboard.needsAttention' => 'Требует внимания',
			'dashboard.income' => 'Доход',
			'dashboard.expense' => 'Расход',
			'dashboard.other' => 'Прочее',
			'dashboard.noData' => 'Нет данных',
			'dashboard.spendingActivity' => 'Активность расходов',
			'dashboard.total' => 'Всего',
			'dashboard.average' => 'В среднем',
			'dashboard.budgetPerDay' => 'Бюджет/день',
			'dashboard.todaysBudget' => 'Бюджет на сегодня',
			'dashboard.overbudget' => 'Перерасход!',
			'dashboard.setDailyBudget' => 'Задать дневной бюджет',
			'dashboard.amount' => 'Сумма',
			'dashboard.amountHint' => 'например: 1000',
			'dashboard.recentTransactions' => 'Недавние транзакции',
			'dashboard.thisMonth' => 'В этом месяце',
			'dashboard.noRecentTransactions' => 'Нет недавних транзакций',
			'dashboard.recentTransactionsSubtitle' => 'Недавно внесенные транзакции появятся здесь.',
			'dashboard.seeAll' => 'Смотреть все',
			'dashboard.notSet' => 'Не задано',
			'dashboard.insight.noData' => 'Нет данных за этот месяц для анализа.',
			'dashboard.insight.thisMonth' => 'в этом месяце',
			'dashboard.insight.up' => 'выше на',
			'dashboard.insight.down' => 'ниже на',
			'dashboard.insight.same' => 'так же, как',
			'dashboard.insight.fromLastMonth' => 'по сравнению с прошлым месяцем.',
			'dashboard.days.mon' => 'Пн',
			'dashboard.days.tue' => 'Вт',
			'dashboard.days.wed' => 'Ср',
			'dashboard.days.thu' => 'Чт',
			'dashboard.days.fri' => 'Пт',
			'dashboard.days.sat' => 'Сб',
			'dashboard.days.sun' => 'Вс',
			'debts.addRepayment' => 'Внести платеж',
			'debts.iOwe' => 'Я должен',
			'debts.theyOwe' => 'Мне должны',
			'debts.personName' => 'Имя контакта',
			'debts.principalAmount' => 'Основная сумма',
			'debts.transactionBinding' => 'Привязка транзакции',
			'debts.cancel' => 'Отмена',
			'debts.save' => 'Сохранить',
			'debts.ok' => 'ОК',
			'debts.addRecord' => 'Добавить запись',
			'debts.createRecord' => 'Создать запись',
			'debts.debtDetails' => 'Детали долга',
			'debts.repaymentHistory' => 'История выплат',
			'debts.debtsLoans' => 'Долги и займы',
			'debts.deleteDebt' => 'Удалить долг',
			'debts.delete' => 'Удалить',
			'debts.writeoffDebt' => 'Списать долг',
			'debts.areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances' => 'Вы уверены, что хотите списать этот долг? Он будет помечен как выплаченный без изменения баланса счетов.',
			'debts.writeoff' => 'Списать',
			'debts.egJohnDoe' => 'например: Иван Иванов',
			'debts.category' => 'Категория',
			'debts.account' => 'Счет',
			'debts.egDinnerLastFriday' => 'например: Ужин в пятницу',
			'debts.selectDueDate' => 'Выберите срок погашения',
			'debts.outstanding' => 'Остаток',
			'debts.paid' => 'Выплачено',
			'debts.principal' => 'Сумма долга',
			'debts.actionDenied' => 'Действие отклонено',
			'debts.paymentCannotExceedRemaining' => 'Сумма платежа не может превышать остаток долга.',
			'debts.addNote' => 'Добавить примечание',
			'debts.payInFull' => 'Выплатить полностью',
			'debts.remaining' => 'осталось',
			'debts.paid1' => 'Выплачено ',
			'debts.reminder' => ({required Object type, required Object name}) => 'Напоминание ${type}: ${name}',
			'debts.due' => ({required Object type, required Object name}) => 'Срок ${type}: ${name}',
			'debts.noHistoryFoundForThis' => ({required Object type}) => 'Нет истории выплат для ${type}',
			'debts.repaymentHistorySubtitle' => ({required Object type}) => 'История платежей по этому ${type} появится здесь.',
			'debts.failedToLoadDebts' => ({required Object error}) => 'Не удалось загрузить долги: ${error}',
			'debts.percentOf' => ({required Object percent}) => '${percent}% от ',
			'debts.settled' => ({required Object count}) => 'Погашено: ${count}',
			'debts.payable' => 'К оплате',
			'debts.receivable' => 'К получению',
			'debts.noDebtsRecorded' => 'Нет записей о долгах',
			'debts.noLoansRecorded' => 'Нет записей о займах',
			'debts.trackMoneyYouOweToOthersAndLogRepayments' => 'Учитывайте долги перед другими людьми и отмечайте возвраты здесь.',
			'debts.trackMoneyOthersOweYouAndLogCollections' => 'Ведите учет денег, взятых у вас в долг, и фиксируйте возвраты.',
			'debts.editRecord' => 'Редактировать запись',
			'debts.newRecord' => 'Новая запись',
			'debts.personNameCannotBeEmpty' => 'Имя контакта не может быть пустым',
			'debts.amountGreaterThanZero' => 'Сумма должна быть больше 0',
			'debts.selectCategoryAndAccount' => 'Пожалуйста, выберите категорию и счет',
			'debts.selectCategoryPrompt' => 'Выберите категорию',
			'debts.selectAccountPrompt' => 'Выберите счет',
			'debts.debtBindingHelp' => 'Создание этого долга добавит деньги на счет (доходная транзакция).',
			'debts.loanBindingHelp' => 'Создание этого займа спишет деньги со счета (расходная транзакция).',
			'debts.noteLabel' => 'Примечание',
			'debts.dueDateLabel' => 'Срок погашения',
			'debts.saveChanges' => 'Сохранить изменения',
			'debts.deleteConfirm' => ({required Object type}) => 'Вы уверены, что хотите удалить этот ${type}? Запись будет удалена безвозвратно. Это действие нельзя отменить.',
			'debts.debtDetailsTitle' => ({required Object type}) => 'Детали: ${type}',
			'debts.debtTypeLoan' => 'Займ',
			'debts.debtTypeDebt' => 'Долг',
			'debts.reminderAlert' => ({required Object type, required Object amount, required Object action, required Object when}) => '${type} на сумму ${amount} должен быть ${action} (срок: ${when}).',
			'debts.overdueAlert' => ({required Object type, required Object amount, required Object action}) => '${type} на сумму ${amount} просрочен и должен быть ${action} немедленно.',
			'debts.actionCollect' => 'получен',
			'debts.actionPay' => 'выплачен',
			'debts.today' => 'сегодня',
			'debts.inDays' => ({required Object days}) => 'через ${days} дн.',
			'debts.owedCount' => ({required Object count}) => 'К выплате: ${count}',
			'debts.receivableCount' => ({required Object count}) => 'К получению: ${count}',
			'debts.disbursedAmount' => 'Выданная/полученная сумма',
			'debts.lentAmount' => 'Сумма займа',
			'debts.totalRepaymentAmount' => 'Полная сумма к возврату',
			'debts.totalReceivableAmount' => 'Полная сумма к получению',
			'debts.interestFee' => 'Проценты / комиссия',
			'debts.disbursedAmountHelp' => 'Фактическая сумма перевода в кошелек или из кошелька.',
			'debts.totalAmountMustBeGreaterOrEqual' => 'Полная сумма не может быть меньше выданной',
			'debts.disbursedAmountLabel' => ({required Object type}) => '${type}:',
			'debts.interestLabel' => 'Проценты:',
			'debts.received' => 'Получено',
			'debts.lent' => 'Выдано',
			'error.generic' => 'Произошла непредвиденная ошибка',
			'error.network' => 'Проверьте соединение с интернетом и повторите попытку',
			'error.database' => 'Не удалось получить доступ к локальным данным',
			'goals.goals' => 'Цели',
			'goals.fulfillGoal' => 'Исполнить цель (Потратить)',
			'goals.goalName' => 'Название цели',
			'goals.targetAmount' => 'Целевая сумма',
			'goals.createGoal' => 'Создать цель',
			'goals.errorPrefix' => ({required Object error}) => 'Ошибка: ${error}',
			'goals.goalDetails' => 'Детали цели',
			'goals.transactions' => 'Транзакции',
			'goals.active' => 'Активные',
			'goals.past' => 'Завершенные',
			'goals.actionDenied' => 'Действие отклонено',
			'goals.emptyBalanceBeforeDelete' => 'Обнулите баланс (переведите средства) перед удалением цели.',
			'goals.ok' => 'ОК',
			'goals.deleteGoal' => 'Удалить цель',
			'goals.areYouSureYouWantToDeleteThisGoalTheAssociatedPocketAccountAndItsHistoryWillAlsoBeRemovedThisActionCannotBeUndone' => 'Вы уверены, что хотите удалить эту цель? Связанный карман и его история также будут удалены. Это действие нельзя отменить.',
			'goals.delete' => 'Удалить',
			'goals.egEmergencyFundNewLaptop' => 'например: Подушка безопасности, Новый ноутбук',
			'goals.completed' => 'Достигнута',
			'goals.fullyFunded' => 'Полностью собрано',
			'goals.inProgress' => 'В процессе',
			'goals.totalSaved' => 'Всего накоплено',
			'goals.stillNeeded' => 'Осталось собрать',
			'goals.totalTarget' => 'Общая цель',
			'goals.selectTargetDate' => 'Выберите дату цели',
			'goals.noTransactionsFoundForThisGoal' => 'Нет транзакций по этой цели.',
			'goals.goalTransactionsSubtitle' => 'Переводы и пополнения для этой цели появятся здесь.',
			'goals.addGoal' => 'Добавить цель',
			'goals.aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal' => 'Для отслеживания этой цели будет автоматически создан отдельный карман.',
			'goals.saved' => 'накоплено',
			'goals.needs' => 'Нужно еще ',
			'goals.more' => '',
			'goals.noGoalsYet' => 'Целей пока нет',
			'goals.setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal' => 'Ставьте цели накоплений — для каждой автоматически создается отдельный карман.',
			'goals.percentOfTarget' => ({required Object percent}) => '${percent}% от цели',
			'goals.goalsCount' => ({required Object count}) => 'Целей: ${count}',
			'goals.fullyFundedCount' => ({required Object count}) => 'Достигнуто: ${count}',
			'goals.noCompletedGoalsYet' => 'Нет завершенных целей',
			'goals.completedGoalsWillAppearHere' => 'Достигнутые цели появятся здесь.',
			'goals.editGoal' => 'Редактировать цель',
			'goals.newGoal' => 'Новая цель',
			'goals.nameCannotBeEmpty' => 'Название не может быть пустым',
			'goals.targetAmountGreaterThanZero' => 'Сумма цели должна быть больше 0',
			'goals.saveChanges' => 'Сохранить изменения',
			'goals.targetDateLabel' => 'Целевая дата',
			'goals.activeGoals' => 'Активные цели',
			'goals.completedGoals' => 'Завершенные цели',
			'goals.noActiveGoalsYet' => 'Нет активных целей',
			'goals.noActiveGoalsSubtitle' => 'Создайте цель, чтобы начать копить на важную покупку.',
			'goals.saveInAccount' => 'Хранить на счете',
			'goals.selectAccount' => 'Выберите счет',
			'goals.accountRequired' => 'Пожалуйста, выберите счет',
			'goals.storedIn' => ({required Object account}) => 'Хранится в ${account}',
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
			'lock.confirmPin' => 'Подтвердите PIN',
			'lock.createPin' => 'Создайте PIN',
			'lock.pinsDoNotMatch' => 'PIN-коды не совпадают',
			'lock.reenterPin' => 'Повторите PIN',
			'lock.enterPinAppLock' => 'Введите PIN для входа',
			'lock.incorrectPin' => 'Неверный PIN',
			'lock.verifyIdentity' => 'Подтвердите личность',
			'lock.retryInSeconds' => ({required Object seconds}) => 'Повторите через ${seconds} сек.',
			'lock.setupPinTitle' => 'Установка PIN-кода',
			'lock.setupPinBody' => 'Создайте PIN перед включением блокировки или биометрии.',
			'lock.unlocked' => 'Разблокировано',
			'lock.enter6DigitPin' => 'Введите 6-значный PIN',
			'lock.enterPin' => 'Введите PIN',
			'lock.invalidPin' => 'Неверный PIN',
			'lock.tooManyAttempts' => 'Слишком много попыток',
			'lock.temporarilyLocked' => 'Временно заблокировано',
			'lock.authenticateReason' => 'Подтвердите личность для входа в Poka',
			'onboarding.continueWithCurrency' => 'Продолжить с выбранной валютой',
			'onboarding.chooseYourBaseCurrency' => 'Выберите базовую валюту',
			'onboarding.thisCurrencyWillBeUsedForAllAccountsPocketsAndTransactionsYouCanChangeThisLaterInSettings' => 'Эта валюта будет использоваться для всех счетов, карманов и транзакций. Вы можете изменить ее позже в настройках.',
			'recurring.addSchedule' => 'Добавить расписание',
			'recurring.transactionDetails' => 'Детали транзакции',
			'recurring.amount' => 'Сумма',
			'recurring.frequency' => 'Частота',
			'recurring.startDate' => 'Дата начала',
			'recurring.recurring' => 'Регулярные',
			'recurring.schedules' => 'Расписания',
			'recurring.scheduleDetails' => 'Детали расписания',
			'recurring.deleteSchedule' => 'Удалить расписание',
			'recurring.areYouSureYouWantToDeleteThisRecurringScheduleExistingGeneratedTransactionsWillNotBeDeleted' => 'Вы уверены, что хотите удалить это расписание? Ранее созданные транзакции удалены не будут.',
			'recurring.delete' => 'Удалить',
			'recurring.triggerHistory' => 'История выполнений',
			'recurring.destinationAccount' => 'Счет назначения',
			'recurring.category' => 'Категория',
			'recurring.egNetflixSubscription' => 'например: Подписка на кино',
			'recurring.selectFirstDueDate' => 'Выберите первую дату платежа',
			'recurring.estMonthlyNet' => 'Ожид. баланс/мес',
			'recurring.monthlyIn' => 'Доход/мес',
			'recurring.monthlyOut' => 'Расход/мес',
			'recurring.noRecurringTransactions' => 'Нет регулярных транзакций',
			'recurring.automateBillsLikeSubscriptionsOrSalary' => 'Автоматизируйте счета, подписки или зарплату. Приложение запишет их по графику.',
			'recurring.noHistoryFoundForThisSchedule' => 'Нет истории по этому расписанию.',
			'recurring.scheduleHistorySubtitle' => 'Транзакции, созданные этим расписанием, появятся здесь.',
			'recurring.allocation' => 'Распределение',
			'recurring.active' => 'Активно',
			'recurring.eachTimeTheAppOpensOverdueRecurringTransactionsAre' => 'При каждом открытии приложения наступившие регулярные платежи автоматически вносятся в журнал.',
			'recurring.schedulesCount' => ({required Object count}) => 'Расписаний: ${count}',
			'recurring.pausedCount' => ({required Object count}) => 'На паузе: ${count}',
			'recurring.editRecurring' => 'Редактировать расписание',
			'recurring.newRecurring' => 'Новое расписание',
			'recurring.mustSelectAccount' => 'Необходимо выбрать счет',
			'recurring.sourceAccount' => 'Счет списания',
			'recurring.account' => 'Счет',
			'recurring.selectAccountPrompt' => 'Выберите счет',
			'recurring.selectDestinationPrompt' => 'Выберите счет назначения',
			'recurring.selectCategoryOptional' => 'Выберите категорию (необязательно)',
			'recurring.noteLabel' => 'Примечание',
			'recurring.saveChanges' => 'Сохранить изменения',
			'recurring.createRecurring' => 'Создать расписание',
			'recurring.amountGreaterThanZero' => 'Сумма должна быть больше 0',
			'recurring.mustSelectStartDate' => 'Необходимо выбрать дату начала',
			'recurring.periodDaily' => 'Ежедневно',
			'recurring.periodWeekly' => 'Еженедельно',
			'recurring.periodMonthly' => 'Ежемесячно',
			'recurring.periodYearly' => 'Ежегодно',
			'recurring.autoGenerateActive' => 'Транзакции будут создаваться автоматически',
			'recurring.autoGeneratePaused' => 'На паузе — транзакции не будут создаваться',
			'recurring.recurringIncome' => 'Регулярный доход',
			'recurring.recurringExpense' => 'Регулярный расход',
			'recurring.recurringTransfer' => 'Регулярный перевод',
			'recurring.nextDateLabel' => ({required Object date}) => 'Следующий: ${date}',
			'reports.title' => 'Отчеты',
			'reports.overview' => 'Финансовый обзор',
			'reports.tabCashflow' => 'Денежный поток',
			'reports.tabBudgets' => 'Бюджеты и цели',
			'reports.period' => 'Период',
			'reports.thisMonth' => 'Этот месяц',
			'reports.lastMonth' => 'Прошлый месяц',
			'reports.last3Months' => '3 месяца',
			'reports.last6Months' => '6 месяцев',
			'reports.custom' => 'Особый',
			'reports.income' => 'Доход',
			'reports.expense' => 'Расход',
			'reports.netSavings' => 'Чистые накопления',
			'reports.netCashflow' => 'Чистый поток',
			'reports.cashflow' => 'Денежный поток',
			'reports.savingsRate' => 'Норма сбережений',
			'reports.topCategories' => 'Топ категорий',
			'reports.topExpenses' => 'Топ расходов',
			'reports.topIncome' => 'Топ доходов',
			'reports.monthlyTrend' => 'Месячный тренд',
			'reports.cashflowTrend' => 'Тренд доходов и расходов',
			'reports.budgetBreakdown' => 'Структура бюджета',
			'reports.budgetUtilization' => 'Использование бюджета',
			'reports.spendingAllocation' => 'Распределение трат',
			'reports.noData' => 'Нет данных за выбранный период',
			'reports.noExpenseDataDesc' => 'Вносите расходы, чтобы увидеть распределение трат.',
			'reports.noBudgets' => 'Бюджеты не настроены',
			'reports.noBudgetsDesc' => 'Добавьте бюджеты, чтобы следить за лимитами',
			'reports.onTrack' => 'В пределах нормы',
			'reports.needsAttention' => 'Требует внимания',
			'reports.overBudget' => 'Сверх бюджета',
			'reports.onBudget' => 'В лимите',
			'reports.needs' => 'Необходимое',
			'reports.wants' => 'Желания',
			'reports.savings' => 'Накопления',
			'reports.other' => 'Прочее',
			'reports.total' => 'Всего',
			'reports.average' => 'В среднем',
			'reports.remaining' => 'Остаток',
			'reports.spent' => 'Потрачено',
			'reports.limit' => 'Лимит',
			'reports.txCount' => ({required Object count}) => 'Транзакций: ${count}',
			'reports.selectDateRange' => 'Выберите диапазон дат',
			'reports.apply' => 'Применить',
			'reports.from' => 'С',
			'reports.to' => 'По',
			'reports.comparedTo' => ({required Object period}) => 'к ${period}',
			'reports.higher' => 'выше',
			'reports.lower' => 'ниже',
			'reports.same' => 'так же, как',
			'reports.noChange' => 'Без изменений',
			'reports.percent50' => '50%',
			'reports.percent30' => '30%',
			'reports.percent20' => '20%',
			'reports.rule503020' => '50/30/20',
			'reports.prevLastMonth' => 'прошлый месяц',
			'reports.prevMonth' => 'пред. месяц',
			'reports.prev3Months' => 'пред. 3 мес.',
			'reports.prev6Months' => 'пред. 6 мес.',
			'reports.prevPeriod' => 'пред. период',
			'reports.exportExcel' => 'Экспорт в Excel',
			'reports.exportExcelSuccess' => 'Файл Excel успешно экспортирован',
			'reports.exportExcelError' => 'Не удалось экспортировать файл Excel',
			'settings.title' => 'Настройки',
			'settings.preferences' => 'Предпочтения',
			'settings.baseCurrency' => 'Основная валюта',
			'settings.theme' => 'Тема',
			'settings.language' => 'Язык',
			'settings.numberFormat' => 'Формат чисел',
			'settings.selectNumberFormat' => 'Выбрать формат чисел',
			'settings.formatSystem' => 'По умолчанию',
			'settings.formatId' => '1.000.000,00',
			'settings.formatUs' => '1,000,000.00',
			'settings.formatFr' => '1 000 000,00',
			'settings.system' => 'Системный',
			'settings.english' => 'English',
			'settings.indonesia' => 'Indonesia',
			'settings.malay' => 'Bahasa Melayu',
			'settings.vietnam' => 'Tiếng Việt',
			'settings.russian' => 'Русский',
			'settings.spanish' => 'Español',
			'settings.portuguese' => 'Português',
			'settings.german' => 'Deutsch',
			'settings.security' => 'Безопасность',
			'settings.appLock' => 'Блокировка приложения',
			'settings.appLockDesc' => 'Защита PIN-кодом',
			'settings.biometrics' => 'Биометрия',
			'settings.biometricsDesc' => 'Разблокировка отпечатком',
			'settings.dataManagement' => 'Управление данными',
			'settings.backupRestore' => 'Резервное копирование',
			'settings.backupRestoreDesc' => 'Сохранить или восстановить данные',
			'settings.clearOld' => 'Очистить старые транзакции',
			'settings.clearOldDesc' => 'Удалить транзакции старше 1 года',
			'settings.resetData' => 'Сброс данных',
			'settings.resetDataDesc' => 'Стереть все локальные данные приложения',
			'settings.support' => 'Поддержка',
			'settings.faq' => 'ЧаВо',
			'settings.faqDesc' => 'Часто задаваемые вопросы',
			'settings.about' => 'О Poka CE',
			'settings.aboutDesc' => 'Версия и юридическая информация',
			'settings.selectTheme' => 'Выбрать тему',
			'settings.themeLight' => 'Светлая',
			'settings.themeDark' => 'Темная',
			'settings.selectLanguage' => 'Выбрать язык',
			'settings.oldTransactionsCleared' => 'Старые транзакции успешно очищены',
			'settings.appDataReset' => 'Данные приложения успешно сброшены',
			'settings.failedToExportLogs' => 'Не удалось экспортировать журналы',
			'settings.easterEggRemaining' => ({required Object remaining}) => 'Осталось ${remaining} нажатий до сюрприза...',
			'settings.easterEggFound' => '🎉 Вы нашли пасхалку!',
			'settings.selectCurrency' => 'Выбрать валюту',
			'settings.openSourceLicenses' => 'Лицензии открытого ПО',
			'settings.checkForUpdates' => 'Проверить обновления',
			'settings.viewLatestReleasesOnGithub' => 'Посмотреть свежие релизы на GitHub',
			'settings.helpIssues' => 'Помощь и проблемы',
			'settings.reportBugsOrRequestFeatures' => 'Сообщить об ошибках или предложить идеи',
			'settings.legal' => 'Правовая информация',
			'settings.termsOfService' => 'Условия обслуживания',
			'settings.readOurTermsAndConditions' => 'Ознакомьтесь с условиями и положениями',
			'settings.privacyPolicy' => 'Политика конфиденциальности',
			'settings.learnHowWeHandleYourData' => 'Узнайте, как мы обрабатываем ваши данные',
			'settings.viewThirdpartySoftwareLicenses' => 'Посмотреть сторонние лицензии',
			'settings.advanced' => 'Дополнительно',
			'settings.exportDebugLogs' => 'Экспорт журналов отладки',
			'settings.shareErrorLogsForTroubleshooting' => 'Поделиться журналами для решения проблем',
			'settings.search' => 'Поиск...',
			'settings.errorLoadingContent' => 'Ошибка загрузки данных',
			'settings.noLicensesFound' => 'Лицензии не найдены',
			'settings.pokaCe' => 'Poka CE',
			'settings.communityEdition' => 'Community Edition',
			'settings.aboutDescription' => 'Бесплатный менеджер личных финансов с открытым исходным кодом, который помогает отслеживать расходы, управлять бюджетами и контролировать счета локально.',
			'settings.copyright' => '© 2026 POKA. Все права защищены.',
			'settings.noResultsFound' => 'Ничего не найдено',
			'settings.weCouldntFindAnyCurrencyMatching' => 'Валюта по запросу "{search}" не найдена.',
			'settings.notSet' => 'Не задано',
			'settings.exportExcel' => 'Экспорт в Excel',
			'settings.exportExcelDesc' => 'Экспорт транзакций, счетов и категорий в .xlsx',
			'settings.exportExcelSuccess' => 'Файл Excel успешно экспортирован',
			'settings.exportExcelError' => 'Не удалось экспортировать файл Excel',
			'settings.currencyLockedToast' => 'Валюту нельзя изменить после записи транзакций. Пожалуйста, сбросьте данные, если хотите ее изменить.',
			'shared.authRequired' => 'Требуется аутентификация',
			'shared.hexColorCode' => 'Код цвета Hex',
			'shared.apply' => 'Применить',
			'shared.enterAmount' => 'Введите сумму',
			'shared.selectCategory' => 'Выберите категорию',
			'shared.egFf5733' => 'например: FF5733',
			'shared.amount' => 'Сумма',
			'shared.noCategoriesAvailable' => 'Нет доступных категорий.',
			'shared.noWalletsFoundPleaseCreateOneFirst' => 'Кошельки не найдены. Сначала создайте кошелек.',
			'shared.balance' => 'Баланс: ',
			'shared.optional' => 'Необязательно',
			'shared.customColor' => 'Свой цвет',
			'shared.selectWallet' => 'Выбрать кошелек',
			'transactions.searchTransactions' => 'Поиск транзакций...',
			'transactions.failedToLoad' => 'Не удалось загрузить транзакции',
			'transactions.cancel' => 'Отмена',
			'transactions.delete' => 'Удалить',
			'transactions.goToToday' => 'Перейти к сегодняшнему дню',
			'transactions.addItem' => 'Добавить позицию',
			'transactions.saveSplitTransaction' => 'Сохранить чек с позициями',
			'transactions.transactionType' => 'Тип транзакции',
			'transactions.applyFilter' => 'Применить фильтр',
			'transactions.noAccountsAvailable' => 'Нет доступных счетов',
			'transactions.account' => 'Счет',
			'transactions.category' => 'Категория',
			'transactions.done' => 'Готово',
			'transactions.save' => 'Сохранить',
			'transactions.transactions' => 'Транзакции',
			'transactions.splitTransaction' => 'Чек с позициями',
			'transactions.from' => 'Из',
			'transactions.to' => 'В',
			'transactions.empty' => '+/-',
			'transactions.filtered' => 'Отфильтровано',
			'transactions.netBalance' => 'Чистый баланс',
			'transactions.income' => 'Доход',
			'transactions.expense' => 'Расход',
			'transactions.selectCategory' => 'Выбрать категорию',
			'transactions.filter' => 'Фильтр',
			'transactions.backToToday' => 'Вернуться к сегодняшнему дню',
			'transactions.deleteTransaction' => 'Удалить транзакцию',
			'transactions.deleteTransactionWarning' => 'Удаление этой транзакции вернет баланс счета и бюджет к их прежнему состоянию.',
			'transactions.out' => 'Расход ',
			'transactions.noTransactions' => 'Нет транзакций',
			'transactions.addNote' => 'Добавить заметку',
			'transactions.noItemsYet' => 'Позиций пока нет',
			'transactions.tapAddItemToBeginSplittingntheTransaction' => 'Нажмите «Добавить позицию», чтобы распределить этот чек по категориям.',
			'transactions.addAtLeastOneMoreItemToSave' => 'Добавьте хотя бы еще одну позицию для сохранения.',
			'transactions.noTransactions1' => 'Нет транзакций',
			'transactions.reset' => 'Сбросить',
			'transactions.incoming' => 'Доход ',
			'transactions.nothingRecordedFor' => ({required Object period}) => 'Ничего не записано за ${period}.',
			'transactions.splitItems' => ({required Object count}) => '${count} позиций чека',
			'transactions.itemsCount' => ({required Object count}) => '${count} позиций',
			'transactions.transactionsCount' => ({required Object count}) => '${count} транзакций',
			'transactions.editTransaction' => 'Редактировать транзакцию',
			'transactions.newTransaction' => 'Новая транзакция',
			'transactions.fromAccount' => 'Со счета',
			'transactions.toAccount' => 'На счет',
			'transactions.need' => 'Необходимое',
			'transactions.want' => 'Желаемое',
			'transactions.saving' => 'Сбережения',
			'transactions.addNoteEllipsis' => 'Добавить заметку...',
			'transactions.editItem' => 'Редактировать позицию',
			'transactions.newItem' => 'Новая позиция',
			'transactions.viewModeDay' => 'День',
			'transactions.viewModeWeek' => 'Неделя',
			'transactions.viewModeMonth' => 'Месяц',
			'transactions.viewModeDaily' => 'По дням',
			'transactions.viewModeWeekly' => 'По неделям',
			'transactions.viewModeMonthly' => 'По месяцам',
			'transactions.debt' => 'Долг',
			'transactions.recurring' => 'Регулярные',
			'transactions.transfer' => 'Перевод',
			'transactions.weekNumber' => ({required Object weekNum, required Object date}) => 'Неделя ${weekNum} · ${date}',
			'transactions.insufficientBalance' => 'Недостаточно средств',
			'transactions.insufficientBalanceWarning' => ({required Object amount, required Object account, required Object balance}) => 'Сумма (${amount}) превышает текущий баланс счета ${account} (${balance}). Возможно, вы забыли сначала записать доход?',
			'transactions.insufficientBalanceConsequence' => 'Баланс вашего счета станет отрицательным, если вы продолжите.',
			'transactions.continueAnyway' => 'Все равно продолжить',
			'transactions.checkAgain' => 'Проверить снова',
			'transactions.transactionDeleted' => 'Транзакция удалена',
			'transactions.transactionRestored' => 'Транзакция восстановлена',
			'transactions.allocation' => 'Распределение',
			_ => null,
		};
	}
}
