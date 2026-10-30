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
class TranslationsEs extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$accounts$es accounts = _Translations$accounts$es._(_root);
	@override late final _Translations$app$es app = _Translations$app$es._(_root);
	@override late final _Translations$backup$es backup = _Translations$backup$es._(_root);
	@override late final _Translations$budgets$es budgets = _Translations$budgets$es._(_root);
	@override late final _Translations$categories$es categories = _Translations$categories$es._(_root);
	@override late final _Translations$common$es common = _Translations$common$es._(_root);
	@override late final _Translations$dashboard$es dashboard = _Translations$dashboard$es._(_root);
	@override late final _Translations$debts$es debts = _Translations$debts$es._(_root);
	@override Map<String, String> get error => {
		'generic': 'Ha ocurrido un error inesperado',
		'network': 'Comprueba tu conexión a internet e inténtalo de nuevo',
		'database': 'No se pudo acceder a los datos locales',
	};
	@override late final _Translations$goals$es goals = _Translations$goals$es._(_root);
	@override late final _Translations$icons$es icons = _Translations$icons$es._(_root);
	@override late final _Translations$lock$es lock = _Translations$lock$es._(_root);
	@override late final _Translations$onboarding$es onboarding = _Translations$onboarding$es._(_root);
	@override late final _Translations$recurring$es recurring = _Translations$recurring$es._(_root);
	@override late final _Translations$reports$es reports = _Translations$reports$es._(_root);
	@override late final _Translations$settings$es settings = _Translations$settings$es._(_root);
	@override late final _Translations$shared$es shared = _Translations$shared$es._(_root);
	@override late final _Translations$transactions$es transactions = _Translations$transactions$es._(_root);
}

// Path: accounts
class _Translations$accounts$es extends Translations$accounts$en {
	_Translations$accounts$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get accountName => 'Nombre de la cuenta';
	@override String get pocketName => 'Nombre del bolsillo';
	@override String get initialBalance => 'Saldo inicial';
	@override String get icon => 'Icono';
	@override String get color => 'Color';
	@override String get assets => 'Activos';
	@override String get liability => 'Pasivo';
	@override String get income => 'Ingresos';
	@override String get expense => 'Gastos';
	@override String get balance => 'Saldo';
	@override String get walletsPockets => 'Billeteras y bolsillos';
	@override String get accounts => 'Cuentas';
	@override String get mainAccounts => 'Cuentas principales';
	@override String get deleteAccount => 'Eliminar cuenta';
	@override String get areYouSureYouWantToDeleteThisAccountItWillBeHiddenFromTheApp => '¿Seguro que deseas eliminar esta cuenta? Se ocultará de la aplicación.';
	@override String get delete => 'Eliminar';
	@override String get account => 'Cuenta';
	@override String get totalBalance => 'Saldo total';
	@override String get pockets => 'Bolsillos';
	@override String get deletePocket => 'Eliminar bolsillo';
	@override String get cannotDeleteMainPocket => 'El bolsillo principal no se puede eliminar';
	@override String get mainPocket => 'Principal';
	@override String get areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp => '¿Seguro que deseas eliminar este bolsillo? Se ocultará de la aplicación.';
	@override String get nameCannotBeEmpty => 'El nombre no puede estar vacío';
	@override String get egMainWallet => 'p. ej., Billetera principal';
	@override String get egPocket => 'p. ej., Comestibles, Vacaciones';
	@override String get selectIcon => 'Seleccionar icono';
	@override String get allowedCategories => 'Categorías permitidas';
	@override String get transactions => 'Transacciones';
	@override String get editAccount => 'Editar cuenta';
	@override String get editPocket => 'Editar bolsillo';
	@override String get updateNameIconOrColor => 'Actualizar nombre, icono o color';
	@override String get permanentlyRemoveThisAccount => 'Eliminar permanentemente esta cuenta';
	@override String get seeAll => 'Ver todo';
	@override String get noTransactionsYet => 'Aún no hay transacciones';
	@override String get accountTransactionsSubtitle => 'Las transacciones registradas en esta cuenta aparecerán aquí.';
	@override String get pocketTransactionsSubtitle => 'Las transacciones registradas en este bolsillo aparecerán aquí.';
	@override String get addAccount => 'Añadir cuenta';
	@override String get noAccountsFound => 'No se encontraron cuentas.';
	@override String get addPocket => 'Añadir bolsillo';
	@override String get noPocketsYet => 'Aún no hay bolsillos';
	@override String get pocketsHelpYouSplitYourWalletIntoCategories => 'Los bolsillos te ayudan a dividir tu billetera en categorías. Tu saldo actual se moverá a un bolsillo "Principal" automáticamente.';
	@override String get activeAccount => 'Cuenta activa';
	@override String get inactiveAccountsWillBeHidden => 'Las cuentas inactivas se ocultarán';
	@override String get noCategoriesAvailable => 'No hay categorías disponibles.';
	@override String get noAccountsFound1 => 'No se encontraron cuentas';
	@override String subcategoriesCount({required Object count}) => '${count} subcategoría(s)';
	@override String pocketsCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(count,
		one: '1 bolsillo',
		other: '${count} bolsillos',
	);
	@override String get totalActiveAccounts => 'Total de cuentas activas';
	@override String get noAccountsYet => 'Aún no hay cuentas';
	@override String get tapTheButtonBelowToAddYourFirstAccount => 'Toca el botón de abajo para añadir tu primera cuenta';
	@override String get allCategoriesAllowed => 'Todas las categorías permitidas';
	@override String categoriesSelected({required Object count}) => '${count} categorías seleccionadas';
	@override String ratioOfAccount({required Object percent}) => '${percent}% de la cuenta';
	@override String get noMainAccountsYet => 'Aún no hay cuentas principales.';
	@override String percentOfAssets({required Object percent}) => '${percent}% de los activos';
	@override String get recentTransactions => 'Transacciones recientes';
	@override String recentTransactionsCount({required Object count}) => 'Transacciones recientes (${count})';
	@override String get reconcileBalance => 'Conciliar saldo';
	@override String get reconcileBalanceSubtitle => 'Alinear el saldo de la app con el saldo real de la cuenta';
	@override String get currentBalanceInPoka => 'Saldo en Poka';
	@override String get actualBalance => 'Saldo real';
	@override String get difference => 'Diferencia';
	@override String get adjustmentExpense => 'Ajuste (Gasto)';
	@override String get adjustmentIncome => 'Ajuste (Ingreso)';
	@override String get balanceAdjustment => 'Ajuste de saldo';
	@override String get saveAdjustment => 'Guardar ajuste';
	@override String get balancesMatch => 'Los saldos coinciden, no se necesita ajuste';
	@override String get noteOptional => 'Nota (opcional)';
	@override String get reconcileAccount => 'Conciliar saldo de cuenta';
}

// Path: app
class _Translations$app$es extends Translations$app$en {
	_Translations$app$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Poka';
	@override String get tagline => 'Tu compañero de finanzas personales';
	@override late final _Translations$app$nav$es nav = _Translations$app$nav$es._(_root);
	@override String get termsOfService => 'Términos del servicio';
	@override String get privacyPolicy => 'Política de privacidad';
}

// Path: backup
class _Translations$backup$es extends Translations$backup$en {
	_Translations$backup$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Copia de seguridad y restauración';
	@override String get backupAction => 'Crear copia';
	@override String get restoreAction => 'Restaurar';
	@override String get password => 'Contraseña';
	@override String get confirmPassword => 'Confirmar contraseña';
	@override String get passwordsDoNotMatch => 'Las contraseñas no coinciden';
	@override String get backupSuccess => 'Copia de seguridad completada con éxito';
	@override String get restoreSuccess => 'Restauración completada con éxito';
	@override String get incorrectPassword => 'Contraseña incorrecta o archivo dañado';
	@override String get enterPasswordToEncrypt => 'Introduce contraseña para cifrar la copia';
	@override String get enterPasswordToDecrypt => 'Introduce contraseña para descifrar la copia';
	@override String get pleaseRestart => 'Por favor, reinicia la app para aplicar los cambios.';
	@override String get passwordRequired => 'La contraseña es obligatoria';
	@override String get reminder => 'Recordatorio de copia de seguridad';
	@override String get reminderDesc => 'Te recuerda periódicamente que hagas una copia de seguridad';
	@override String get reminderOff => 'Desactivado';
	@override String get reminderWeekly => 'Semanal';
	@override String get reminderMonthly => 'Mensual';
	@override String get reminderNotificationTitle => 'Hora de hacer una copia de seguridad';
	@override String get reminderNotificationBody => 'Ha pasado tiempo desde tu última copia. Mantén tus finanzas a salvo creando un respaldo ahora.';
	@override String get reminderSaved => 'Recordatorio actualizado';
	@override String get restoreWarningDesc => 'Al restaurar se sustituirán todos los datos actuales por los del archivo seleccionado. Se perderán los cambios no guardados. ¿Deseas continuar?';
	@override String get sendTestNotification => 'Enviar notificación de prueba';
	@override String get testNotificationSent => 'Notificación de prueba enviada';
	@override String get permissionRationaleTitle => 'Recordatorio de copia local';
	@override String get permissionRationaleDesc => 'Poka necesita permiso de notificaciones para recordarte que respaldes tus datos. Los recordatorios se ejecutan de forma local y privada.';
	@override String get allowNotifications => 'Permitir notificaciones';
	@override String get permissionDenied => 'Permiso de notificaciones denegado. Los recordatorios quedan desactivados.';
}

// Path: budgets
class _Translations$budgets$es extends Translations$budgets$en {
	_Translations$budgets$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get budgetName => 'Nombre del presupuesto';
	@override String get spendingLimit => 'Límite de gasto';
	@override String get period => 'Periodo';
	@override String get resetDay => 'Día de reinicio (1–31)';
	@override String get createBudget => 'Crear presupuesto';
	@override String get endDate => 'Fecha de fin';
	@override String get budgetDetails => 'Detalles del presupuesto';
	@override String get deleteBudget => 'Eliminar presupuesto';
	@override String get areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone => '¿Seguro que deseas eliminar este presupuesto? Se borrará todo el historial relacionado de forma permanente. Esta acción no se puede deshacer.';
	@override String get delete => 'Eliminar';
	@override String get transactions => 'Transacciones';
	@override String get budgets => 'Presupuestos';
	@override String get allBudgets => 'Todos los presupuestos';
	@override String get egGroceriesEntertainment => 'ej. Comestibles, Ocio';
	@override String get eg80 => 'ej. 80';
	@override String get category => 'Categoría';
	@override String get account => 'Cuenta';
	@override String get overLimit => 'Excedido';
	@override String get remaining => 'Restante';
	@override String get totalSpent => 'Total gastado';
	@override String get totalLimit => 'Límite total';
	@override String get selectEndDate => 'Seleccionar fecha final';
	@override String get noTransactionsFoundForThisBudgetPeriod => 'No se encontraron transacciones para este periodo de presupuesto.';
	@override String get budgetTransactionsSubtitle => 'Las transacciones que coincidan con este presupuesto aparecerán aquí.';
	@override String get addBudget => 'Añadir presupuesto';
	@override String get spent => 'Gastado ';
	@override String get noBudgetsYet => 'Sin presupuestos todavía';
	@override String get setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod => 'Fija límites de gasto para controlar a dónde va tu dinero en cada periodo.';
	@override String budgetAlert({required Object name}) => 'Alerta de presupuesto: ${name}';
	@override String percentOf({required Object percent}) => '${percent}% de ';
	@override String budgetsCount({required Object count}) => '${count} presupuesto(s)';
	@override String get editBudget => 'Editar presupuesto';
	@override String get newBudget => 'Nuevo presupuesto';
	@override String get nameCannotBeEmpty => 'El nombre no puede estar vacío';
	@override String get amountGreaterThanZero => 'El importe debe ser mayor que 0';
	@override String get alertThresholdLabel => 'Umbral de alerta (%)';
	@override String get scope => 'Ámbito';
	@override String get anyCategory => 'Cualquier categoría';
	@override String get anyAccount => 'Cualquier cuenta';
	@override String get saveChanges => 'Guardar cambios';
	@override String get periodWeekly => 'Semanal';
	@override String get periodMonthly => 'Mensual';
	@override String get periodYearly => 'Anual';
	@override String get periodCustom => 'Personalizado';
	@override String budgetExceededAlert({required Object percentage, required Object name}) => 'Has consumido el ${percentage}% de tu presupuesto de ${name}.';
}

// Path: categories
class _Translations$categories$es extends Translations$categories$en {
	_Translations$categories$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get expense => 'Gasto';
	@override String get income => 'Ingreso';
	@override String get categoryName => 'Nombre de la categoría';
	@override String get icon => 'Icono';
	@override String get color => 'Color';
	@override String get noCategoriesFound => 'No se encontraron categorías.';
	@override String get subcategories => 'Subcategorías';
	@override String get categories => 'Categorías';
	@override String get egFoodDining => 'ej. Restaurantes y Comida';
	@override String get deleteCategory => 'Eliminar categoría';
	@override String get delete => 'Eliminar';
	@override String get selectIcon => 'Seleccionar icono';
	@override String get searchIcons => 'Buscar iconos...';
	@override String get noIconsFound => 'No se encontraron iconos';
	@override String weCouldntFindAnyIconMatching({required Object search}) => 'No encontramos ningún icono que coincida con "${search}".';
	@override String get noSubcategoriesYet => 'Sin subcategorías todavía';
	@override String get noCategoriesFound1 => 'No se encontraron categorías';
	@override String subcategoriesCount({required Object count}) => '${count} subcategorías';
	@override String get addSubcategory => 'Añadir subcategoría';
	@override String get addCategory => 'Añadir categoría';
	@override String get emptyCategorySubtitle => 'Comienza a organizar tus gastos añadiendo una categoría';
	@override String get emptySubcategorySubtitle => 'Divide tu categoría en partes más detalladas';
	@override String get saveSubCategory => 'Guardar subcategoría';
	@override String get saveCategory => 'Guardar categoría';
	@override String get newSubCategory => 'Nueva subcategoría';
	@override String get newCategory => 'Nueva categoría';
	@override String get editSubCategory => 'Editar subcategoría';
	@override String get editCategory => 'Editar categoría';
	@override String deleteConfirmWithChildren({required Object count}) => '¿Seguro que deseas eliminar esta categoría? Sus ${count} subcategoría(s) pasarán a ser principales y sus transacciones quedarán sin categoría.';
	@override String get deleteConfirmNoChildren => '¿Seguro que deseas eliminar esta categoría? Todas sus transacciones quedarán sin categoría.';
}

// Path: common
class _Translations$common$es extends Translations$common$en {
	_Translations$common$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get save => 'Guardar';
	@override String get cancel => 'Cancelar';
	@override String get delete => 'Eliminar';
	@override String get edit => 'Editar';
	@override String get confirm => 'Confirmar';
	@override String get back => 'Atrás';
	@override String get loading => 'Cargando...';
	@override String get error => 'Ocurrió un error';
	@override String get retry => 'Reintentar';
	@override String get empty => 'Sin datos todavía';
	@override String get cannotBeUndone => 'Esta acción no se puede deshacer.';
	@override String get pleaseWait => 'Por favor, espera';
	@override String get today => 'Hoy';
	@override String get yesterday => 'Ayer';
	@override String get dueToday => 'Vence hoy';
	@override String get overdue => 'Vencido';
	@override String get uncategorized => 'Sin categoría';
	@override String get unknown => 'Desconocido';
	@override String get notSet => 'No definido';
	@override String get undo => 'Deshacer';
}

// Path: dashboard
class _Translations$dashboard$es extends Translations$dashboard$en {
	_Translations$dashboard$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get overview => 'Resumen';
	@override String get myFinances => 'Mis Finanzas';
	@override String get netWorth => 'Patrimonio neto';
	@override String accountsCount({required Object count}) => '${count} cuentas';
	@override String get assets => 'Activos';
	@override String get liabilities => 'Pasivos';
	@override String get budgets => 'Presupuestos';
	@override String get categories => 'Categorías';
	@override String get goals => 'Metas';
	@override String get debts => 'Deudas';
	@override String get recurring => 'Recurrentes';
	@override String get cashFlow => 'Flujo de caja';
	@override String get budget => 'Presupuesto';
	@override String get needs => 'Necesidades (50%)';
	@override String get wants => 'Deseos (30%)';
	@override String get savings => 'Ahorro (20%)';
	@override String get saved => 'ahorrado';
	@override String get onTrack => 'En camino';
	@override String get needsAttention => 'Atención';
	@override String get income => 'Ingreso';
	@override String get expense => 'Gasto';
	@override String get other => 'Otro';
	@override String get noData => 'Sin datos';
	@override String get spendingActivity => 'Actividad de gasto';
	@override String get total => 'Total';
	@override String get average => 'Promedio';
	@override String get budgetPerDay => 'Presupuesto/Día';
	@override String get todaysBudget => 'Presupuesto de hoy';
	@override String get overbudget => '¡Sobrepasado!';
	@override String get setDailyBudget => 'Fijar presupuesto diario';
	@override String get amount => 'Importe';
	@override String get amountHint => 'ej. 50';
	@override String get recentTransactions => 'Transacciones recientes';
	@override String get thisMonth => 'Este mes';
	@override String get noRecentTransactions => 'Sin transacciones recientes';
	@override String get recentTransactionsSubtitle => 'Las transacciones que registres aparecerán aquí.';
	@override String get seeAll => 'Ver todas';
	@override String get notSet => 'No definido';
	@override late final _Translations$dashboard$insight$es insight = _Translations$dashboard$insight$es._(_root);
	@override late final _Translations$dashboard$days$es days = _Translations$dashboard$days$es._(_root);
}

// Path: debts
class _Translations$debts$es extends Translations$debts$en {
	_Translations$debts$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get addRepayment => 'Añadir pago';
	@override String get iOwe => 'Debo';
	@override String get theyOwe => 'Me deben';
	@override String get personName => 'Nombre de la persona';
	@override String get principalAmount => 'Importe principal';
	@override String get transactionBinding => 'Vincular a transacción';
	@override String get cancel => 'Cancelar';
	@override String get save => 'Guardar';
	@override String get ok => 'Aceptar';
	@override String get addRecord => 'Añadir registro';
	@override String get createRecord => 'Crear registro';
	@override String get debtDetails => 'Detalles de deuda';
	@override String get repaymentHistory => 'Historial de pagos';
	@override String get debtsLoans => 'Deudas y préstamos';
	@override String get deleteDebt => 'Eliminar deuda';
	@override String get delete => 'Eliminar';
	@override String get writeoffDebt => 'Condonar deuda';
	@override String get areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances => '¿Seguro que deseas condonar esta deuda? Se marcará como pagada sin afectar a los saldos de tus billeteras.';
	@override String get writeoff => 'Condonar';
	@override String get egJohnDoe => 'ej. Juan Pérez';
	@override String get category => 'Categoría';
	@override String get account => 'Cuenta';
	@override String get egDinnerLastFriday => 'ej. Cena del viernes';
	@override String get selectDueDate => 'Seleccionar fecha límite';
	@override String get outstanding => 'Pendiente';
	@override String get paid => 'Pagado';
	@override String get principal => 'Principal';
	@override String get actionDenied => 'Acción denegada';
	@override String get paymentCannotExceedRemaining => 'El pago no puede superar la deuda pendiente.';
	@override String get addNote => 'Añadir nota';
	@override String get payInFull => 'Pagar todo';
	@override String get remaining => 'restante';
	@override String get paid1 => 'Pagado ';
	@override String reminder({required Object type, required Object name}) => 'Recordatorio de ${type}: ${name}';
	@override String due({required Object type, required Object name}) => 'Vencimiento de ${type}: ${name}';
	@override String noHistoryFoundForThis({required Object type}) => 'No hay historial para este ${type}';
	@override String repaymentHistorySubtitle({required Object type}) => 'Los pagos de este ${type} aparecerán aquí.';
	@override String failedToLoadDebts({required Object error}) => 'Error al cargar deudas: ${error}';
	@override String percentOf({required Object percent}) => '${percent}% de ';
	@override String settled({required Object count}) => '${count} saldado(s)';
	@override String get payable => 'Por pagar';
	@override String get receivable => 'Por cobrar';
	@override String get noDebtsRecorded => 'No hay deudas registradas';
	@override String get noLoansRecorded => 'No hay préstamos registrados';
	@override String get trackMoneyYouOweToOthersAndLogRepayments => 'Lleva el control de lo que debes a otros y anota cada pago.';
	@override String get trackMoneyOthersOweYouAndLogCollections => 'Registra el dinero que te deben y anota cada cobro.';
	@override String get editRecord => 'Editar registro';
	@override String get newRecord => 'Nuevo registro';
	@override String get personNameCannotBeEmpty => 'El nombre no puede estar vacío';
	@override String get amountGreaterThanZero => 'El importe debe ser mayor que 0';
	@override String get selectCategoryAndAccount => 'Por favor, selecciona una categoría y cuenta';
	@override String get selectCategoryPrompt => 'Seleccionar categoría';
	@override String get selectAccountPrompt => 'Seleccionar cuenta';
	@override String get debtBindingHelp => 'Registrar esta deuda añade dinero a la cuenta (ingreso).';
	@override String get loanBindingHelp => 'Registrar este préstamo descuenta dinero de la cuenta (gasto).';
	@override String get noteLabel => 'Nota';
	@override String get dueDateLabel => 'Fecha límite';
	@override String get saveChanges => 'Guardar cambios';
	@override String deleteConfirm({required Object type}) => '¿Seguro que deseas eliminar este ${type}? El registro se borrará para siempre. No se puede deshacer.';
	@override String debtDetailsTitle({required Object type}) => 'Detalles de ${type}';
	@override String get debtTypeLoan => 'Préstamo';
	@override String get debtTypeDebt => 'Deuda';
	@override String reminderAlert({required Object type, required Object amount, required Object action, required Object when}) => 'El ${type} de ${amount} debe ser ${action} ${when}.';
	@override String overdueAlert({required Object type, required Object amount, required Object action}) => 'El ${type} de ${amount} está vencido y debe ser ${action} de inmediato.';
	@override String get actionCollect => 'cobrado';
	@override String get actionPay => 'pagado';
	@override String get today => 'hoy';
	@override String inDays({required Object days}) => 'en ${days} días';
	@override String owedCount({required Object count}) => '${count} por pagar';
	@override String receivableCount({required Object count}) => '${count} por cobrar';
	@override String get disbursedAmount => 'Importe entregado/recibido';
	@override String get lentAmount => 'Importe prestado';
	@override String get totalRepaymentAmount => 'Total a reembolsar';
	@override String get totalReceivableAmount => 'Total a recibir';
	@override String get interestFee => 'Interés / Comisión';
	@override String get disbursedAmountHelp => 'Efectivo real transferido a tu billetera o desde ella.';
	@override String get totalAmountMustBeGreaterOrEqual => 'El reembolso total no puede ser inferior al dinero entregado';
	@override String disbursedAmountLabel({required Object type}) => '${type}:';
	@override String get interestLabel => 'Interés:';
	@override String get received => 'Recibido';
	@override String get lent => 'Prestado';
}

// Path: goals
class _Translations$goals$es extends Translations$goals$en {
	_Translations$goals$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get goals => 'Metas';
	@override String get fulfillGoal => 'Cumplir meta (Gastar)';
	@override String get goalName => 'Nombre de la meta';
	@override String get targetAmount => 'Importe objetivo';
	@override String get createGoal => 'Crear meta';
	@override String errorPrefix({required Object error}) => 'Error: ${error}';
	@override String get goalDetails => 'Detalles de la meta';
	@override String get transactions => 'Transacciones';
	@override String get active => 'Activas';
	@override String get past => 'Completadas';
	@override String get actionDenied => 'Acción denegada';
	@override String get emptyBalanceBeforeDelete => 'Transfiere el saldo a otra cuenta antes de eliminar esta meta.';
	@override String get ok => 'Aceptar';
	@override String get deleteGoal => 'Eliminar meta';
	@override String get areYouSureYouWantToDeleteThisGoalTheAssociatedPocketAccountAndItsHistoryWillAlsoBeRemovedThisActionCannotBeUndone => '¿Seguro que deseas eliminar esta meta? El bolsillo vinculado y su historial se borrarán. Esta acción no se puede deshacer.';
	@override String get delete => 'Eliminar';
	@override String get egEmergencyFundNewLaptop => 'ej. Fondo de emergencia, Portátil nuevo';
	@override String get completed => 'Completada';
	@override String get fullyFunded => 'Financiada al 100%';
	@override String get inProgress => 'En curso';
	@override String get totalSaved => 'Total ahorrado';
	@override String get stillNeeded => 'Falta todavía';
	@override String get totalTarget => 'Objetivo total';
	@override String get selectTargetDate => 'Seleccionar fecha objetivo';
	@override String get noTransactionsFoundForThisGoal => 'No se encontraron transacciones para esta meta.';
	@override String get goalTransactionsSubtitle => 'Las transferencias o aportaciones para esta meta aparecerán aquí.';
	@override String get addGoal => 'Añadir meta';
	@override String get aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal => 'Se creará automáticamente un bolsillo dedicado para controlar esta meta.';
	@override String get saved => 'ahorrado';
	@override String get needs => 'Faltan ';
	@override String get more => ' más';
	@override String get noGoalsYet => 'Sin metas todavía';
	@override String get setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal => 'Fija metas de ahorro: se crea un bolsillo automáticamente para cada una.';
	@override String percentOfTarget({required Object percent}) => '${percent}% del objetivo';
	@override String goalsCount({required Object count}) => '${count} meta(s)';
	@override String fullyFundedCount({required Object count}) => '${count} completadas';
	@override String get noCompletedGoalsYet => 'Sin metas completadas todavía';
	@override String get completedGoalsWillAppearHere => 'Las metas que alcances aparecerán aquí.';
	@override String get editGoal => 'Editar meta';
	@override String get newGoal => 'Nueva meta';
	@override String get nameCannotBeEmpty => 'El nombre no puede estar vacío';
	@override String get targetAmountGreaterThanZero => 'El importe objetivo debe ser mayor que 0';
	@override String get saveChanges => 'Guardar cambios';
	@override String get targetDateLabel => 'Fecha objetivo';
	@override String get activeGoals => 'Metas activas';
	@override String get completedGoals => 'Metas completadas';
	@override String get noActiveGoalsYet => 'No hay metas activas';
	@override String get noActiveGoalsSubtitle => 'Crea una nueva meta para empezar a ahorrar.';
	@override String get saveInAccount => 'Guardar en cuenta';
	@override String get selectAccount => 'Seleccionar cuenta';
	@override String get accountRequired => 'Por favor, selecciona una cuenta';
	@override String storedIn({required Object account}) => 'Guardado en ${account}';
}

// Path: icons
class _Translations$icons$es extends Translations$icons$en {
	_Translations$icons$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

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
class _Translations$lock$es extends Translations$lock$en {
	_Translations$lock$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get confirmPin => 'Confirmar PIN';
	@override String get createPin => 'Crear PIN';
	@override String get pinsDoNotMatch => 'Los PIN no coinciden';
	@override String get reenterPin => 'Vuelve a introducir el PIN';
	@override String get enterPinAppLock => 'Introduce el PIN para desbloquear';
	@override String get incorrectPin => 'PIN incorrecto';
	@override String get verifyIdentity => 'Verificar identidad';
	@override String retryInSeconds({required Object seconds}) => 'Reinténtalo en ${seconds} segundos';
	@override String get setupPinTitle => 'Configurar PIN';
	@override String get setupPinBody => 'Crea un PIN antes de activar el bloqueo de app o biometría.';
	@override String get unlocked => 'Desbloqueado';
	@override String get enter6DigitPin => 'Introduce un PIN de 6 dígitos';
	@override String get enterPin => 'Introduce el PIN';
	@override String get invalidPin => 'PIN no válido';
	@override String get tooManyAttempts => 'Demasiados intentos';
	@override String get temporarilyLocked => 'Bloqueado temporalmente';
	@override String get authenticateReason => 'Identifícate para entrar a Poka';
}

// Path: onboarding
class _Translations$onboarding$es extends Translations$onboarding$en {
	_Translations$onboarding$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get continueWithCurrency => 'Continuar con la moneda seleccionada';
	@override String get chooseYourBaseCurrency => 'Elige tu moneda base';
	@override String get thisCurrencyWillBeUsedForAllAccountsPocketsAndTransactionsYouCanChangeThisLaterInSettings => 'Esta moneda se usará en todas las cuentas, bolsillos y transacciones. Puedes cambiarla luego en ajustes.';
}

// Path: recurring
class _Translations$recurring$es extends Translations$recurring$en {
	_Translations$recurring$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get addSchedule => 'Añadir recurrencia';
	@override String get transactionDetails => 'Detalles de la transacción';
	@override String get amount => 'Importe';
	@override String get frequency => 'Frecuencia';
	@override String get startDate => 'Fecha de inicio';
	@override String get recurring => 'Recurrentes';
	@override String get schedules => 'Programaciones';
	@override String get scheduleDetails => 'Detalles de la programación';
	@override String get deleteSchedule => 'Eliminar recurrencia';
	@override String get areYouSureYouWantToDeleteThisRecurringScheduleExistingGeneratedTransactionsWillNotBeDeleted => '¿Seguro que deseas eliminar esta programación? Las transacciones ya creadas no se borrarán.';
	@override String get delete => 'Eliminar';
	@override String get triggerHistory => 'Historial de ejecuciones';
	@override String get destinationAccount => 'Cuenta de destino';
	@override String get category => 'Categoría';
	@override String get egNetflixSubscription => 'ej. Suscripción a Netflix';
	@override String get selectFirstDueDate => 'Seleccionar primer vencimiento';
	@override String get estMonthlyNet => 'Balance mensual est.';
	@override String get monthlyIn => 'Ingresos/mes';
	@override String get monthlyOut => 'Gastos/mes';
	@override String get noRecurringTransactions => 'Sin transacciones recurrentes';
	@override String get automateBillsLikeSubscriptionsOrSalary => 'Automatiza gastos fijos como suscripciones o nómina. La app los anotará a tiempo.';
	@override String get noHistoryFoundForThisSchedule => 'Sin historial para esta programación.';
	@override String get scheduleHistorySubtitle => 'Las transacciones generadas aparecerán aquí.';
	@override String get allocation => 'Distribución';
	@override String get active => 'Activo';
	@override String get eachTimeTheAppOpensOverdueRecurringTransactionsAre => 'Cada vez que abras la app, las transacciones recurrentes vencidas se registrarán automáticamente.';
	@override String schedulesCount({required Object count}) => '${count} programaciones';
	@override String pausedCount({required Object count}) => '${count} en pausa';
	@override String get editRecurring => 'Editar recurrencia';
	@override String get newRecurring => 'Nueva recurrencia';
	@override String get mustSelectAccount => 'Debes seleccionar una cuenta';
	@override String get sourceAccount => 'Cuenta de origen';
	@override String get account => 'Cuenta';
	@override String get selectAccountPrompt => 'Seleccionar cuenta';
	@override String get selectDestinationPrompt => 'Seleccionar destino';
	@override String get selectCategoryOptional => 'Seleccionar categoría (opcional)';
	@override String get noteLabel => 'Nota';
	@override String get saveChanges => 'Guardar cambios';
	@override String get createRecurring => 'Crear recurrencia';
	@override String get amountGreaterThanZero => 'El importe debe ser mayor que 0';
	@override String get mustSelectStartDate => 'Debes seleccionar una fecha de inicio';
	@override String get periodDaily => 'Diario';
	@override String get periodWeekly => 'Semanal';
	@override String get periodMonthly => 'Mensual';
	@override String get periodYearly => 'Anual';
	@override String get autoGenerateActive => 'Generará transacciones automáticamente';
	@override String get autoGeneratePaused => 'En pausa — no se generarán transacciones';
	@override String get recurringIncome => 'Ingreso recurrente';
	@override String get recurringExpense => 'Gasto recurrente';
	@override String get recurringTransfer => 'Transferencia recurrente';
	@override String nextDateLabel({required Object date}) => 'Siguiente: ${date}';
}

// Path: reports
class _Translations$reports$es extends Translations$reports$en {
	_Translations$reports$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Informes';
	@override String get overview => 'Resumen financiero';
	@override String get tabCashflow => 'Flujo de caja';
	@override String get tabBudgets => 'Presupuestos y metas';
	@override String get period => 'Periodo';
	@override String get thisMonth => 'Este mes';
	@override String get lastMonth => 'Mes anterior';
	@override String get last3Months => '3 meses';
	@override String get last6Months => '6 meses';
	@override String get custom => 'Personalizado';
	@override String get income => 'Ingreso';
	@override String get expense => 'Gasto';
	@override String get netSavings => 'Ahorro neto';
	@override String get netCashflow => 'Flujo neto';
	@override String get cashflow => 'Flujo de caja';
	@override String get savingsRate => 'Tasa de ahorro';
	@override String get topCategories => 'Categorías principales';
	@override String get topExpenses => 'Mayores gastos';
	@override String get topIncome => 'Mayores ingresos';
	@override String get monthlyTrend => 'Tendencia mensual';
	@override String get cashflowTrend => 'Ingresos vs Gastos';
	@override String get budgetBreakdown => 'Desglose de presupuestos';
	@override String get budgetUtilization => 'Uso del presupuesto';
	@override String get spendingAllocation => 'Distribución del gasto';
	@override String get noData => 'Sin datos en este periodo';
	@override String get noExpenseDataDesc => 'Registra gastos para ver la distribución de tu dinero.';
	@override String get noBudgets => 'Sin presupuestos configurados';
	@override String get noBudgetsDesc => 'Añade presupuestos para seguir tus límites de gasto';
	@override String get onTrack => 'En camino';
	@override String get needsAttention => 'Atención requerida';
	@override String get overBudget => 'Excedido';
	@override String get onBudget => 'En límite';
	@override String get needs => 'Necesidades';
	@override String get wants => 'Deseos';
	@override String get savings => 'Ahorro';
	@override String get other => 'Otro';
	@override String get total => 'Total';
	@override String get average => 'Promedio';
	@override String get remaining => 'Restante';
	@override String get spent => 'Gastado';
	@override String get limit => 'Límite';
	@override String txCount({required Object count}) => '${count} transacciones';
	@override String get selectDateRange => 'Seleccionar rango de fechas';
	@override String get apply => 'Aplicar';
	@override String get from => 'Desde';
	@override String get to => 'Hasta';
	@override String comparedTo({required Object period}) => 'vs ${period}';
	@override String get higher => 'más alto';
	@override String get lower => 'más bajo';
	@override String get same => 'igual que';
	@override String get noChange => 'Sin cambios';
	@override String get percent50 => '50%';
	@override String get percent30 => '30%';
	@override String get percent20 => '20%';
	@override String get rule503020 => '50/30/20';
	@override String get prevLastMonth => 'mes pasado';
	@override String get prevMonth => 'mes anterior';
	@override String get prev3Months => '3 meses prev.';
	@override String get prev6Months => '6 meses prev.';
	@override String get prevPeriod => 'periodo anterior';
	@override String get exportExcel => 'Exportar a Excel';
	@override String get exportExcelSuccess => 'Archivo Excel exportado con éxito';
	@override String get exportExcelError => 'Error al exportar archivo Excel';
}

// Path: settings
class _Translations$settings$es extends Translations$settings$en {
	_Translations$settings$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ajustes';
	@override String get preferences => 'Preferencias';
	@override String get baseCurrency => 'Moneda base';
	@override String get theme => 'Tema';
	@override String get language => 'Idioma';
	@override String get numberFormat => 'Formato de números';
	@override String get selectNumberFormat => 'Seleccionar formato de números';
	@override String get formatSystem => 'Predeterminado';
	@override String get formatId => '1.000.000,00';
	@override String get formatUs => '1,000,000.00';
	@override String get formatFr => '1 000 000,00';
	@override String get system => 'Sistema';
	@override String get english => 'English';
	@override String get indonesia => 'Indonesia';
	@override String get malay => 'Bahasa Melayu';
	@override String get vietnam => 'Tiếng Việt';
	@override String get russian => 'Русский';
	@override String get spanish => 'Español';
	@override String get portuguese => 'Português';
	@override String get german => 'Deutsch';
	@override String get security => 'Seguridad';
	@override String get appLock => 'Bloqueo de app';
	@override String get appLockDesc => 'Proteger con PIN';
	@override String get biometrics => 'Biometría';
	@override String get biometricsDesc => 'Desbloquear con huella';
	@override String get dataManagement => 'Gestión de datos';
	@override String get backupRestore => 'Copia de seguridad';
	@override String get backupRestoreDesc => 'Guardar o restaurar datos';
	@override String get clearOld => 'Limpiar transacciones antiguas';
	@override String get clearOldDesc => 'Eliminar transacciones de más de 1 año';
	@override String get resetData => 'Restablecer datos';
	@override String get resetDataDesc => 'Borrar todos los datos locales';
	@override String get support => 'Soporte';
	@override String get faq => 'Preguntas frecuentes';
	@override String get faqDesc => 'Preguntas frecuentes';
	@override String get about => 'Acerca de Poka CE';
	@override String get aboutDesc => 'Versión e información legal';
	@override String get selectTheme => 'Seleccionar tema';
	@override String get themeLight => 'Claro';
	@override String get themeDark => 'Oscuro';
	@override String get selectLanguage => 'Seleccionar idioma';
	@override String get oldTransactionsCleared => 'Transacciones antiguas eliminadas con éxito';
	@override String get appDataReset => 'Datos de la app restablecidos con éxito';
	@override String get failedToExportLogs => 'Error al exportar registros';
	@override String easterEggRemaining({required Object remaining}) => 'A ${remaining} toques de una sorpresa...';
	@override String get easterEggFound => '🎉 ¡Encontraste la sorpresa!';
	@override String get selectCurrency => 'Seleccionar moneda';
	@override String get openSourceLicenses => 'Licencias de código abierto';
	@override String get checkForUpdates => 'Buscar actualizaciones';
	@override String get viewLatestReleasesOnGithub => 'Ver las últimas versiones en GitHub';
	@override String get helpIssues => 'Ayuda y problemas';
	@override String get reportBugsOrRequestFeatures => 'Informar errores o solicitar funciones';
	@override String get legal => 'Legal';
	@override String get termsOfService => 'Términos de servicio';
	@override String get readOurTermsAndConditions => 'Lee nuestros términos y condiciones';
	@override String get privacyPolicy => 'Política de privacidad';
	@override String get learnHowWeHandleYourData => 'Conoce cómo tratamos tus datos';
	@override String get viewThirdpartySoftwareLicenses => 'Ver licencias de software de terceros';
	@override String get advanced => 'Avanzado';
	@override String get exportDebugLogs => 'Exportar registros de depuración';
	@override String get shareErrorLogsForTroubleshooting => 'Compartir registros para solucionar problemas';
	@override String get search => 'Buscar...';
	@override String get errorLoadingContent => 'Error al cargar el contenido';
	@override String get noLicensesFound => 'No se encontraron licencias';
	@override String get pokaCe => 'Poka CE';
	@override String get communityEdition => 'Community Edition';
	@override String get aboutDescription => 'Un gestor de finanzas personales gratuito y de código abierto diseñado para ayudarte a registrar gastos, gestionar presupuestos y controlar tus cuentas de forma local.';
	@override String get copyright => '© 2026 POKA. Todos los derechos reservados.';
	@override String get noResultsFound => 'No se encontraron resultados';
	@override String weCouldntFindAnyCurrencyMatching({required Object search}) => 'No pudimos encontrar ninguna moneda que coincida con "${search}".';
	@override String get notSet => 'No establecido';
	@override String get exportExcel => 'Exportar a Excel';
	@override String get exportExcelDesc => 'Exportar transacciones, cuentas y categorías a .xlsx';
	@override String get exportExcelSuccess => 'Excel exportado con éxito';
	@override String get exportExcelError => 'Error al exportar el archivo Excel';
	@override String get currencyLockedToast => 'La moneda no se puede cambiar después de registrar transacciones. Restablece los datos si deseas cambiarla.';
}

// Path: shared
class _Translations$shared$es extends Translations$shared$en {
	_Translations$shared$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get authRequired => 'Autenticación requerida';
	@override String get hexColorCode => 'Código de color Hex';
	@override String get apply => 'Aplicar';
	@override String get enterAmount => 'Introduce importe';
	@override String get selectCategory => 'Seleccionar categoría';
	@override String get egFf5733 => 'ej. FF5733';
	@override String get amount => 'Importe';
	@override String get noCategoriesAvailable => 'No hay categorías disponibles.';
	@override String get noWalletsFoundPleaseCreateOneFirst => 'No se encontraron billeteras. Por favor, crea una primero.';
	@override String get balance => 'Saldo: ';
	@override String get optional => 'Opcional';
	@override String get customColor => 'Color personalizado';
	@override String get selectWallet => 'Seleccionar billetera';
}

// Path: transactions
class _Translations$transactions$es extends Translations$transactions$en {
	_Translations$transactions$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get searchTransactions => 'Buscar transacciones...';
	@override String get failedToLoad => 'Error al cargar las transacciones';
	@override String get cancel => 'Cancelar';
	@override String get delete => 'Eliminar';
	@override String get goToToday => 'Ir a hoy';
	@override String get addItem => 'Añadir artículo';
	@override String get saveSplitTransaction => 'Guardar recibo detallado';
	@override String get transactionType => 'Tipo de transacción';
	@override String get applyFilter => 'Aplicar filtro';
	@override String get noAccountsAvailable => 'No hay cuentas disponibles';
	@override String get account => 'Cuenta';
	@override String get category => 'Categoría';
	@override String get done => 'Listo';
	@override String get save => 'Guardar';
	@override String get transactions => 'Transacciones';
	@override String get splitTransaction => 'Recibo detallado';
	@override String get from => 'De';
	@override String get to => 'A';
	@override String get empty => '+/-';
	@override String get filtered => 'Filtrado';
	@override String get netBalance => 'Saldo neto';
	@override String get income => 'Ingresos';
	@override String get expense => 'Gastos';
	@override String get selectCategory => 'Seleccionar categoría';
	@override String get filter => 'Filtrar';
	@override String get backToToday => 'Volver a hoy';
	@override String get deleteTransaction => 'Eliminar transacción';
	@override String get deleteTransactionWarning => 'Eliminar esta transacción revertirá el saldo de tu cuenta y el presupuesto a su estado anterior.';
	@override String get out => 'Salida ';
	@override String get noTransactions => 'Sin transacciones';
	@override String get addNote => 'Añadir nota';
	@override String get noItemsYet => 'Aún no hay artículos';
	@override String get tapAddItemToBeginSplittingntheTransaction => 'Toca "Añadir artículo" para desglosar este recibo entre categorías.';
	@override String get addAtLeastOneMoreItemToSave => 'Añade al menos un artículo más para guardar.';
	@override String get noTransactions1 => 'Sin transacciones';
	@override String get reset => 'Restablecer';
	@override String get incoming => 'Entrada ';
	@override String nothingRecordedFor({required Object period}) => 'Nada registrado para ${period}.';
	@override String splitItems({required Object count}) => '${count} artículos del recibo';
	@override String itemsCount({required Object count}) => '${count} artículo(s)';
	@override String transactionsCount({required Object count}) => '${count} transacciones';
	@override String get editTransaction => 'Editar transacción';
	@override String get newTransaction => 'Nueva transacción';
	@override String get fromAccount => 'De la cuenta';
	@override String get toAccount => 'A la cuenta';
	@override String get need => 'Necesidad';
	@override String get want => 'Deseo';
	@override String get saving => 'Ahorro';
	@override String get addNoteEllipsis => 'Añadir nota...';
	@override String get editItem => 'Editar artículo';
	@override String get newItem => 'Nuevo artículo';
	@override String get viewModeDay => 'Día';
	@override String get viewModeWeek => 'Semana';
	@override String get viewModeMonth => 'Mes';
	@override String get viewModeDaily => 'Diario';
	@override String get viewModeWeekly => 'Semanal';
	@override String get viewModeMonthly => 'Mensual';
	@override String get debt => 'Deuda';
	@override String get recurring => 'Recurrente';
	@override String get transfer => 'Transferencia';
	@override String weekNumber({required Object weekNum, required Object date}) => 'Semana ${weekNum} · ${date}';
	@override String get insufficientBalance => 'Saldo insuficiente';
	@override String insufficientBalanceWarning({required Object amount, required Object account, required Object balance}) => 'El importe (${amount}) supera el saldo actual en ${account} (${balance}). ¿Quizás olvidaste registrar primero los ingresos?';
	@override String get insufficientBalanceConsequence => 'El saldo de tu cuenta será negativo si continúas.';
	@override String get continueAnyway => 'Continuar de todos modos';
	@override String get checkAgain => 'Comprobar de nuevo';
	@override String get transactionDeleted => 'Transacción eliminada';
	@override String get transactionRestored => 'Transacción restaurada';
	@override String get allocation => 'Asignación';
}

// Path: app.nav
class _Translations$app$nav$es extends Translations$app$nav$en {
	_Translations$app$nav$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get home => 'Inicio';
	@override String get transactions => 'Transacciones';
	@override String get reports => 'Informes';
	@override String get accounts => 'Cuentas';
	@override String get settings => 'Ajustes';
}

// Path: dashboard.insight
class _Translations$dashboard$insight$es extends Translations$dashboard$insight$en {
	_Translations$dashboard$insight$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get noData => 'Sin datos suficientes este mes para analizar.';
	@override String get thisMonth => 'este mes es';
	@override String get up => 'superior en';
	@override String get down => 'inferior en';
	@override String get same => 'igual que';
	@override String get fromLastMonth => 'respecto al mes anterior.';
}

// Path: dashboard.days
class _Translations$dashboard$days$es extends Translations$dashboard$days$en {
	_Translations$dashboard$days$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get mon => 'Lun';
	@override String get tue => 'Mar';
	@override String get wed => 'Mié';
	@override String get thu => 'Jue';
	@override String get fri => 'Vie';
	@override String get sat => 'Sáb';
	@override String get sun => 'Dom';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'accounts.accountName' => 'Nombre de la cuenta',
			'accounts.pocketName' => 'Nombre del bolsillo',
			'accounts.initialBalance' => 'Saldo inicial',
			'accounts.icon' => 'Icono',
			'accounts.color' => 'Color',
			'accounts.assets' => 'Activos',
			'accounts.liability' => 'Pasivo',
			'accounts.income' => 'Ingresos',
			'accounts.expense' => 'Gastos',
			'accounts.balance' => 'Saldo',
			'accounts.walletsPockets' => 'Billeteras y bolsillos',
			'accounts.accounts' => 'Cuentas',
			'accounts.mainAccounts' => 'Cuentas principales',
			'accounts.deleteAccount' => 'Eliminar cuenta',
			'accounts.areYouSureYouWantToDeleteThisAccountItWillBeHiddenFromTheApp' => '¿Seguro que deseas eliminar esta cuenta? Se ocultará de la aplicación.',
			'accounts.delete' => 'Eliminar',
			'accounts.account' => 'Cuenta',
			'accounts.totalBalance' => 'Saldo total',
			'accounts.pockets' => 'Bolsillos',
			'accounts.deletePocket' => 'Eliminar bolsillo',
			'accounts.cannotDeleteMainPocket' => 'El bolsillo principal no se puede eliminar',
			'accounts.mainPocket' => 'Principal',
			'accounts.areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp' => '¿Seguro que deseas eliminar este bolsillo? Se ocultará de la aplicación.',
			'accounts.nameCannotBeEmpty' => 'El nombre no puede estar vacío',
			'accounts.egMainWallet' => 'p. ej., Billetera principal',
			'accounts.egPocket' => 'p. ej., Comestibles, Vacaciones',
			'accounts.selectIcon' => 'Seleccionar icono',
			'accounts.allowedCategories' => 'Categorías permitidas',
			'accounts.transactions' => 'Transacciones',
			'accounts.editAccount' => 'Editar cuenta',
			'accounts.editPocket' => 'Editar bolsillo',
			'accounts.updateNameIconOrColor' => 'Actualizar nombre, icono o color',
			'accounts.permanentlyRemoveThisAccount' => 'Eliminar permanentemente esta cuenta',
			'accounts.seeAll' => 'Ver todo',
			'accounts.noTransactionsYet' => 'Aún no hay transacciones',
			'accounts.accountTransactionsSubtitle' => 'Las transacciones registradas en esta cuenta aparecerán aquí.',
			'accounts.pocketTransactionsSubtitle' => 'Las transacciones registradas en este bolsillo aparecerán aquí.',
			'accounts.addAccount' => 'Añadir cuenta',
			'accounts.noAccountsFound' => 'No se encontraron cuentas.',
			'accounts.addPocket' => 'Añadir bolsillo',
			'accounts.noPocketsYet' => 'Aún no hay bolsillos',
			'accounts.pocketsHelpYouSplitYourWalletIntoCategories' => 'Los bolsillos te ayudan a dividir tu billetera en categorías. Tu saldo actual se moverá a un bolsillo "Principal" automáticamente.',
			'accounts.activeAccount' => 'Cuenta activa',
			'accounts.inactiveAccountsWillBeHidden' => 'Las cuentas inactivas se ocultarán',
			'accounts.noCategoriesAvailable' => 'No hay categorías disponibles.',
			'accounts.noAccountsFound1' => 'No se encontraron cuentas',
			'accounts.subcategoriesCount' => ({required Object count}) => '${count} subcategoría(s)',
			'accounts.pocketsCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(count, one: '1 bolsillo', other: '${count} bolsillos', ), 
			'accounts.totalActiveAccounts' => 'Total de cuentas activas',
			'accounts.noAccountsYet' => 'Aún no hay cuentas',
			'accounts.tapTheButtonBelowToAddYourFirstAccount' => 'Toca el botón de abajo para añadir tu primera cuenta',
			'accounts.allCategoriesAllowed' => 'Todas las categorías permitidas',
			'accounts.categoriesSelected' => ({required Object count}) => '${count} categorías seleccionadas',
			'accounts.ratioOfAccount' => ({required Object percent}) => '${percent}% de la cuenta',
			'accounts.noMainAccountsYet' => 'Aún no hay cuentas principales.',
			'accounts.percentOfAssets' => ({required Object percent}) => '${percent}% de los activos',
			'accounts.recentTransactions' => 'Transacciones recientes',
			'accounts.recentTransactionsCount' => ({required Object count}) => 'Transacciones recientes (${count})',
			'accounts.reconcileBalance' => 'Conciliar saldo',
			'accounts.reconcileBalanceSubtitle' => 'Alinear el saldo de la app con el saldo real de la cuenta',
			'accounts.currentBalanceInPoka' => 'Saldo en Poka',
			'accounts.actualBalance' => 'Saldo real',
			'accounts.difference' => 'Diferencia',
			'accounts.adjustmentExpense' => 'Ajuste (Gasto)',
			'accounts.adjustmentIncome' => 'Ajuste (Ingreso)',
			'accounts.balanceAdjustment' => 'Ajuste de saldo',
			'accounts.saveAdjustment' => 'Guardar ajuste',
			'accounts.balancesMatch' => 'Los saldos coinciden, no se necesita ajuste',
			'accounts.noteOptional' => 'Nota (opcional)',
			'accounts.reconcileAccount' => 'Conciliar saldo de cuenta',
			'app.name' => 'Poka',
			'app.tagline' => 'Tu compañero de finanzas personales',
			'app.nav.home' => 'Inicio',
			'app.nav.transactions' => 'Transacciones',
			'app.nav.reports' => 'Informes',
			'app.nav.accounts' => 'Cuentas',
			'app.nav.settings' => 'Ajustes',
			'app.termsOfService' => 'Términos del servicio',
			'app.privacyPolicy' => 'Política de privacidad',
			'backup.title' => 'Copia de seguridad y restauración',
			'backup.backupAction' => 'Crear copia',
			'backup.restoreAction' => 'Restaurar',
			'backup.password' => 'Contraseña',
			'backup.confirmPassword' => 'Confirmar contraseña',
			'backup.passwordsDoNotMatch' => 'Las contraseñas no coinciden',
			'backup.backupSuccess' => 'Copia de seguridad completada con éxito',
			'backup.restoreSuccess' => 'Restauración completada con éxito',
			'backup.incorrectPassword' => 'Contraseña incorrecta o archivo dañado',
			'backup.enterPasswordToEncrypt' => 'Introduce contraseña para cifrar la copia',
			'backup.enterPasswordToDecrypt' => 'Introduce contraseña para descifrar la copia',
			'backup.pleaseRestart' => 'Por favor, reinicia la app para aplicar los cambios.',
			'backup.passwordRequired' => 'La contraseña es obligatoria',
			'backup.reminder' => 'Recordatorio de copia de seguridad',
			'backup.reminderDesc' => 'Te recuerda periódicamente que hagas una copia de seguridad',
			'backup.reminderOff' => 'Desactivado',
			'backup.reminderWeekly' => 'Semanal',
			'backup.reminderMonthly' => 'Mensual',
			'backup.reminderNotificationTitle' => 'Hora de hacer una copia de seguridad',
			'backup.reminderNotificationBody' => 'Ha pasado tiempo desde tu última copia. Mantén tus finanzas a salvo creando un respaldo ahora.',
			'backup.reminderSaved' => 'Recordatorio actualizado',
			'backup.restoreWarningDesc' => 'Al restaurar se sustituirán todos los datos actuales por los del archivo seleccionado. Se perderán los cambios no guardados. ¿Deseas continuar?',
			'backup.sendTestNotification' => 'Enviar notificación de prueba',
			'backup.testNotificationSent' => 'Notificación de prueba enviada',
			'backup.permissionRationaleTitle' => 'Recordatorio de copia local',
			'backup.permissionRationaleDesc' => 'Poka necesita permiso de notificaciones para recordarte que respaldes tus datos. Los recordatorios se ejecutan de forma local y privada.',
			'backup.allowNotifications' => 'Permitir notificaciones',
			'backup.permissionDenied' => 'Permiso de notificaciones denegado. Los recordatorios quedan desactivados.',
			'budgets.budgetName' => 'Nombre del presupuesto',
			'budgets.spendingLimit' => 'Límite de gasto',
			'budgets.period' => 'Periodo',
			'budgets.resetDay' => 'Día de reinicio (1–31)',
			'budgets.createBudget' => 'Crear presupuesto',
			'budgets.endDate' => 'Fecha de fin',
			'budgets.budgetDetails' => 'Detalles del presupuesto',
			'budgets.deleteBudget' => 'Eliminar presupuesto',
			'budgets.areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone' => '¿Seguro que deseas eliminar este presupuesto? Se borrará todo el historial relacionado de forma permanente. Esta acción no se puede deshacer.',
			'budgets.delete' => 'Eliminar',
			'budgets.transactions' => 'Transacciones',
			'budgets.budgets' => 'Presupuestos',
			'budgets.allBudgets' => 'Todos los presupuestos',
			'budgets.egGroceriesEntertainment' => 'ej. Comestibles, Ocio',
			'budgets.eg80' => 'ej. 80',
			'budgets.category' => 'Categoría',
			'budgets.account' => 'Cuenta',
			'budgets.overLimit' => 'Excedido',
			'budgets.remaining' => 'Restante',
			'budgets.totalSpent' => 'Total gastado',
			'budgets.totalLimit' => 'Límite total',
			'budgets.selectEndDate' => 'Seleccionar fecha final',
			'budgets.noTransactionsFoundForThisBudgetPeriod' => 'No se encontraron transacciones para este periodo de presupuesto.',
			'budgets.budgetTransactionsSubtitle' => 'Las transacciones que coincidan con este presupuesto aparecerán aquí.',
			'budgets.addBudget' => 'Añadir presupuesto',
			'budgets.spent' => 'Gastado ',
			'budgets.noBudgetsYet' => 'Sin presupuestos todavía',
			'budgets.setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod' => 'Fija límites de gasto para controlar a dónde va tu dinero en cada periodo.',
			'budgets.budgetAlert' => ({required Object name}) => 'Alerta de presupuesto: ${name}',
			'budgets.percentOf' => ({required Object percent}) => '${percent}% de ',
			'budgets.budgetsCount' => ({required Object count}) => '${count} presupuesto(s)',
			'budgets.editBudget' => 'Editar presupuesto',
			'budgets.newBudget' => 'Nuevo presupuesto',
			'budgets.nameCannotBeEmpty' => 'El nombre no puede estar vacío',
			'budgets.amountGreaterThanZero' => 'El importe debe ser mayor que 0',
			'budgets.alertThresholdLabel' => 'Umbral de alerta (%)',
			'budgets.scope' => 'Ámbito',
			'budgets.anyCategory' => 'Cualquier categoría',
			'budgets.anyAccount' => 'Cualquier cuenta',
			'budgets.saveChanges' => 'Guardar cambios',
			'budgets.periodWeekly' => 'Semanal',
			'budgets.periodMonthly' => 'Mensual',
			'budgets.periodYearly' => 'Anual',
			'budgets.periodCustom' => 'Personalizado',
			'budgets.budgetExceededAlert' => ({required Object percentage, required Object name}) => 'Has consumido el ${percentage}% de tu presupuesto de ${name}.',
			'categories.expense' => 'Gasto',
			'categories.income' => 'Ingreso',
			'categories.categoryName' => 'Nombre de la categoría',
			'categories.icon' => 'Icono',
			'categories.color' => 'Color',
			'categories.noCategoriesFound' => 'No se encontraron categorías.',
			'categories.subcategories' => 'Subcategorías',
			'categories.categories' => 'Categorías',
			'categories.egFoodDining' => 'ej. Restaurantes y Comida',
			'categories.deleteCategory' => 'Eliminar categoría',
			'categories.delete' => 'Eliminar',
			'categories.selectIcon' => 'Seleccionar icono',
			'categories.searchIcons' => 'Buscar iconos...',
			'categories.noIconsFound' => 'No se encontraron iconos',
			'categories.weCouldntFindAnyIconMatching' => ({required Object search}) => 'No encontramos ningún icono que coincida con "${search}".',
			'categories.noSubcategoriesYet' => 'Sin subcategorías todavía',
			'categories.noCategoriesFound1' => 'No se encontraron categorías',
			'categories.subcategoriesCount' => ({required Object count}) => '${count} subcategorías',
			'categories.addSubcategory' => 'Añadir subcategoría',
			'categories.addCategory' => 'Añadir categoría',
			'categories.emptyCategorySubtitle' => 'Comienza a organizar tus gastos añadiendo una categoría',
			'categories.emptySubcategorySubtitle' => 'Divide tu categoría en partes más detalladas',
			'categories.saveSubCategory' => 'Guardar subcategoría',
			'categories.saveCategory' => 'Guardar categoría',
			'categories.newSubCategory' => 'Nueva subcategoría',
			'categories.newCategory' => 'Nueva categoría',
			'categories.editSubCategory' => 'Editar subcategoría',
			'categories.editCategory' => 'Editar categoría',
			'categories.deleteConfirmWithChildren' => ({required Object count}) => '¿Seguro que deseas eliminar esta categoría? Sus ${count} subcategoría(s) pasarán a ser principales y sus transacciones quedarán sin categoría.',
			'categories.deleteConfirmNoChildren' => '¿Seguro que deseas eliminar esta categoría? Todas sus transacciones quedarán sin categoría.',
			'common.save' => 'Guardar',
			'common.cancel' => 'Cancelar',
			'common.delete' => 'Eliminar',
			'common.edit' => 'Editar',
			'common.confirm' => 'Confirmar',
			'common.back' => 'Atrás',
			'common.loading' => 'Cargando...',
			'common.error' => 'Ocurrió un error',
			'common.retry' => 'Reintentar',
			'common.empty' => 'Sin datos todavía',
			'common.cannotBeUndone' => 'Esta acción no se puede deshacer.',
			'common.pleaseWait' => 'Por favor, espera',
			'common.today' => 'Hoy',
			'common.yesterday' => 'Ayer',
			'common.dueToday' => 'Vence hoy',
			'common.overdue' => 'Vencido',
			'common.uncategorized' => 'Sin categoría',
			'common.unknown' => 'Desconocido',
			'common.notSet' => 'No definido',
			'common.undo' => 'Deshacer',
			'dashboard.overview' => 'Resumen',
			'dashboard.myFinances' => 'Mis Finanzas',
			'dashboard.netWorth' => 'Patrimonio neto',
			'dashboard.accountsCount' => ({required Object count}) => '${count} cuentas',
			'dashboard.assets' => 'Activos',
			'dashboard.liabilities' => 'Pasivos',
			'dashboard.budgets' => 'Presupuestos',
			'dashboard.categories' => 'Categorías',
			'dashboard.goals' => 'Metas',
			'dashboard.debts' => 'Deudas',
			'dashboard.recurring' => 'Recurrentes',
			'dashboard.cashFlow' => 'Flujo de caja',
			'dashboard.budget' => 'Presupuesto',
			'dashboard.needs' => 'Necesidades (50%)',
			'dashboard.wants' => 'Deseos (30%)',
			'dashboard.savings' => 'Ahorro (20%)',
			'dashboard.saved' => 'ahorrado',
			'dashboard.onTrack' => 'En camino',
			'dashboard.needsAttention' => 'Atención',
			'dashboard.income' => 'Ingreso',
			'dashboard.expense' => 'Gasto',
			'dashboard.other' => 'Otro',
			'dashboard.noData' => 'Sin datos',
			'dashboard.spendingActivity' => 'Actividad de gasto',
			'dashboard.total' => 'Total',
			'dashboard.average' => 'Promedio',
			'dashboard.budgetPerDay' => 'Presupuesto/Día',
			'dashboard.todaysBudget' => 'Presupuesto de hoy',
			'dashboard.overbudget' => '¡Sobrepasado!',
			'dashboard.setDailyBudget' => 'Fijar presupuesto diario',
			'dashboard.amount' => 'Importe',
			'dashboard.amountHint' => 'ej. 50',
			'dashboard.recentTransactions' => 'Transacciones recientes',
			'dashboard.thisMonth' => 'Este mes',
			'dashboard.noRecentTransactions' => 'Sin transacciones recientes',
			'dashboard.recentTransactionsSubtitle' => 'Las transacciones que registres aparecerán aquí.',
			'dashboard.seeAll' => 'Ver todas',
			'dashboard.notSet' => 'No definido',
			'dashboard.insight.noData' => 'Sin datos suficientes este mes para analizar.',
			'dashboard.insight.thisMonth' => 'este mes es',
			'dashboard.insight.up' => 'superior en',
			'dashboard.insight.down' => 'inferior en',
			'dashboard.insight.same' => 'igual que',
			'dashboard.insight.fromLastMonth' => 'respecto al mes anterior.',
			'dashboard.days.mon' => 'Lun',
			'dashboard.days.tue' => 'Mar',
			'dashboard.days.wed' => 'Mié',
			'dashboard.days.thu' => 'Jue',
			'dashboard.days.fri' => 'Vie',
			'dashboard.days.sat' => 'Sáb',
			'dashboard.days.sun' => 'Dom',
			'debts.addRepayment' => 'Añadir pago',
			'debts.iOwe' => 'Debo',
			'debts.theyOwe' => 'Me deben',
			'debts.personName' => 'Nombre de la persona',
			'debts.principalAmount' => 'Importe principal',
			'debts.transactionBinding' => 'Vincular a transacción',
			'debts.cancel' => 'Cancelar',
			'debts.save' => 'Guardar',
			'debts.ok' => 'Aceptar',
			'debts.addRecord' => 'Añadir registro',
			'debts.createRecord' => 'Crear registro',
			'debts.debtDetails' => 'Detalles de deuda',
			'debts.repaymentHistory' => 'Historial de pagos',
			'debts.debtsLoans' => 'Deudas y préstamos',
			'debts.deleteDebt' => 'Eliminar deuda',
			'debts.delete' => 'Eliminar',
			'debts.writeoffDebt' => 'Condonar deuda',
			'debts.areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances' => '¿Seguro que deseas condonar esta deuda? Se marcará como pagada sin afectar a los saldos de tus billeteras.',
			'debts.writeoff' => 'Condonar',
			'debts.egJohnDoe' => 'ej. Juan Pérez',
			'debts.category' => 'Categoría',
			'debts.account' => 'Cuenta',
			'debts.egDinnerLastFriday' => 'ej. Cena del viernes',
			'debts.selectDueDate' => 'Seleccionar fecha límite',
			'debts.outstanding' => 'Pendiente',
			'debts.paid' => 'Pagado',
			'debts.principal' => 'Principal',
			'debts.actionDenied' => 'Acción denegada',
			'debts.paymentCannotExceedRemaining' => 'El pago no puede superar la deuda pendiente.',
			'debts.addNote' => 'Añadir nota',
			'debts.payInFull' => 'Pagar todo',
			'debts.remaining' => 'restante',
			'debts.paid1' => 'Pagado ',
			'debts.reminder' => ({required Object type, required Object name}) => 'Recordatorio de ${type}: ${name}',
			'debts.due' => ({required Object type, required Object name}) => 'Vencimiento de ${type}: ${name}',
			'debts.noHistoryFoundForThis' => ({required Object type}) => 'No hay historial para este ${type}',
			'debts.repaymentHistorySubtitle' => ({required Object type}) => 'Los pagos de este ${type} aparecerán aquí.',
			'debts.failedToLoadDebts' => ({required Object error}) => 'Error al cargar deudas: ${error}',
			'debts.percentOf' => ({required Object percent}) => '${percent}% de ',
			'debts.settled' => ({required Object count}) => '${count} saldado(s)',
			'debts.payable' => 'Por pagar',
			'debts.receivable' => 'Por cobrar',
			'debts.noDebtsRecorded' => 'No hay deudas registradas',
			'debts.noLoansRecorded' => 'No hay préstamos registrados',
			'debts.trackMoneyYouOweToOthersAndLogRepayments' => 'Lleva el control de lo que debes a otros y anota cada pago.',
			'debts.trackMoneyOthersOweYouAndLogCollections' => 'Registra el dinero que te deben y anota cada cobro.',
			'debts.editRecord' => 'Editar registro',
			'debts.newRecord' => 'Nuevo registro',
			'debts.personNameCannotBeEmpty' => 'El nombre no puede estar vacío',
			'debts.amountGreaterThanZero' => 'El importe debe ser mayor que 0',
			'debts.selectCategoryAndAccount' => 'Por favor, selecciona una categoría y cuenta',
			'debts.selectCategoryPrompt' => 'Seleccionar categoría',
			'debts.selectAccountPrompt' => 'Seleccionar cuenta',
			'debts.debtBindingHelp' => 'Registrar esta deuda añade dinero a la cuenta (ingreso).',
			'debts.loanBindingHelp' => 'Registrar este préstamo descuenta dinero de la cuenta (gasto).',
			'debts.noteLabel' => 'Nota',
			'debts.dueDateLabel' => 'Fecha límite',
			'debts.saveChanges' => 'Guardar cambios',
			'debts.deleteConfirm' => ({required Object type}) => '¿Seguro que deseas eliminar este ${type}? El registro se borrará para siempre. No se puede deshacer.',
			'debts.debtDetailsTitle' => ({required Object type}) => 'Detalles de ${type}',
			'debts.debtTypeLoan' => 'Préstamo',
			'debts.debtTypeDebt' => 'Deuda',
			'debts.reminderAlert' => ({required Object type, required Object amount, required Object action, required Object when}) => 'El ${type} de ${amount} debe ser ${action} ${when}.',
			'debts.overdueAlert' => ({required Object type, required Object amount, required Object action}) => 'El ${type} de ${amount} está vencido y debe ser ${action} de inmediato.',
			'debts.actionCollect' => 'cobrado',
			'debts.actionPay' => 'pagado',
			'debts.today' => 'hoy',
			'debts.inDays' => ({required Object days}) => 'en ${days} días',
			'debts.owedCount' => ({required Object count}) => '${count} por pagar',
			'debts.receivableCount' => ({required Object count}) => '${count} por cobrar',
			'debts.disbursedAmount' => 'Importe entregado/recibido',
			'debts.lentAmount' => 'Importe prestado',
			'debts.totalRepaymentAmount' => 'Total a reembolsar',
			'debts.totalReceivableAmount' => 'Total a recibir',
			'debts.interestFee' => 'Interés / Comisión',
			'debts.disbursedAmountHelp' => 'Efectivo real transferido a tu billetera o desde ella.',
			'debts.totalAmountMustBeGreaterOrEqual' => 'El reembolso total no puede ser inferior al dinero entregado',
			'debts.disbursedAmountLabel' => ({required Object type}) => '${type}:',
			'debts.interestLabel' => 'Interés:',
			'debts.received' => 'Recibido',
			'debts.lent' => 'Prestado',
			'error.generic' => 'Ha ocurrido un error inesperado',
			'error.network' => 'Comprueba tu conexión a internet e inténtalo de nuevo',
			'error.database' => 'No se pudo acceder a los datos locales',
			'goals.goals' => 'Metas',
			'goals.fulfillGoal' => 'Cumplir meta (Gastar)',
			'goals.goalName' => 'Nombre de la meta',
			'goals.targetAmount' => 'Importe objetivo',
			'goals.createGoal' => 'Crear meta',
			'goals.errorPrefix' => ({required Object error}) => 'Error: ${error}',
			'goals.goalDetails' => 'Detalles de la meta',
			'goals.transactions' => 'Transacciones',
			'goals.active' => 'Activas',
			'goals.past' => 'Completadas',
			'goals.actionDenied' => 'Acción denegada',
			'goals.emptyBalanceBeforeDelete' => 'Transfiere el saldo a otra cuenta antes de eliminar esta meta.',
			'goals.ok' => 'Aceptar',
			'goals.deleteGoal' => 'Eliminar meta',
			'goals.areYouSureYouWantToDeleteThisGoalTheAssociatedPocketAccountAndItsHistoryWillAlsoBeRemovedThisActionCannotBeUndone' => '¿Seguro que deseas eliminar esta meta? El bolsillo vinculado y su historial se borrarán. Esta acción no se puede deshacer.',
			'goals.delete' => 'Eliminar',
			'goals.egEmergencyFundNewLaptop' => 'ej. Fondo de emergencia, Portátil nuevo',
			'goals.completed' => 'Completada',
			'goals.fullyFunded' => 'Financiada al 100%',
			'goals.inProgress' => 'En curso',
			'goals.totalSaved' => 'Total ahorrado',
			'goals.stillNeeded' => 'Falta todavía',
			'goals.totalTarget' => 'Objetivo total',
			'goals.selectTargetDate' => 'Seleccionar fecha objetivo',
			'goals.noTransactionsFoundForThisGoal' => 'No se encontraron transacciones para esta meta.',
			'goals.goalTransactionsSubtitle' => 'Las transferencias o aportaciones para esta meta aparecerán aquí.',
			'goals.addGoal' => 'Añadir meta',
			'goals.aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal' => 'Se creará automáticamente un bolsillo dedicado para controlar esta meta.',
			'goals.saved' => 'ahorrado',
			'goals.needs' => 'Faltan ',
			'goals.more' => ' más',
			'goals.noGoalsYet' => 'Sin metas todavía',
			'goals.setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal' => 'Fija metas de ahorro: se crea un bolsillo automáticamente para cada una.',
			'goals.percentOfTarget' => ({required Object percent}) => '${percent}% del objetivo',
			'goals.goalsCount' => ({required Object count}) => '${count} meta(s)',
			'goals.fullyFundedCount' => ({required Object count}) => '${count} completadas',
			'goals.noCompletedGoalsYet' => 'Sin metas completadas todavía',
			'goals.completedGoalsWillAppearHere' => 'Las metas que alcances aparecerán aquí.',
			'goals.editGoal' => 'Editar meta',
			'goals.newGoal' => 'Nueva meta',
			'goals.nameCannotBeEmpty' => 'El nombre no puede estar vacío',
			'goals.targetAmountGreaterThanZero' => 'El importe objetivo debe ser mayor que 0',
			'goals.saveChanges' => 'Guardar cambios',
			'goals.targetDateLabel' => 'Fecha objetivo',
			'goals.activeGoals' => 'Metas activas',
			'goals.completedGoals' => 'Metas completadas',
			'goals.noActiveGoalsYet' => 'No hay metas activas',
			'goals.noActiveGoalsSubtitle' => 'Crea una nueva meta para empezar a ahorrar.',
			'goals.saveInAccount' => 'Guardar en cuenta',
			'goals.selectAccount' => 'Seleccionar cuenta',
			'goals.accountRequired' => 'Por favor, selecciona una cuenta',
			'goals.storedIn' => ({required Object account}) => 'Guardado en ${account}',
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
			'lock.confirmPin' => 'Confirmar PIN',
			'lock.createPin' => 'Crear PIN',
			'lock.pinsDoNotMatch' => 'Los PIN no coinciden',
			'lock.reenterPin' => 'Vuelve a introducir el PIN',
			'lock.enterPinAppLock' => 'Introduce el PIN para desbloquear',
			'lock.incorrectPin' => 'PIN incorrecto',
			'lock.verifyIdentity' => 'Verificar identidad',
			'lock.retryInSeconds' => ({required Object seconds}) => 'Reinténtalo en ${seconds} segundos',
			'lock.setupPinTitle' => 'Configurar PIN',
			'lock.setupPinBody' => 'Crea un PIN antes de activar el bloqueo de app o biometría.',
			'lock.unlocked' => 'Desbloqueado',
			'lock.enter6DigitPin' => 'Introduce un PIN de 6 dígitos',
			'lock.enterPin' => 'Introduce el PIN',
			'lock.invalidPin' => 'PIN no válido',
			'lock.tooManyAttempts' => 'Demasiados intentos',
			'lock.temporarilyLocked' => 'Bloqueado temporalmente',
			'lock.authenticateReason' => 'Identifícate para entrar a Poka',
			'onboarding.continueWithCurrency' => 'Continuar con la moneda seleccionada',
			'onboarding.chooseYourBaseCurrency' => 'Elige tu moneda base',
			'onboarding.thisCurrencyWillBeUsedForAllAccountsPocketsAndTransactionsYouCanChangeThisLaterInSettings' => 'Esta moneda se usará en todas las cuentas, bolsillos y transacciones. Puedes cambiarla luego en ajustes.',
			'recurring.addSchedule' => 'Añadir recurrencia',
			'recurring.transactionDetails' => 'Detalles de la transacción',
			'recurring.amount' => 'Importe',
			'recurring.frequency' => 'Frecuencia',
			'recurring.startDate' => 'Fecha de inicio',
			'recurring.recurring' => 'Recurrentes',
			'recurring.schedules' => 'Programaciones',
			'recurring.scheduleDetails' => 'Detalles de la programación',
			'recurring.deleteSchedule' => 'Eliminar recurrencia',
			'recurring.areYouSureYouWantToDeleteThisRecurringScheduleExistingGeneratedTransactionsWillNotBeDeleted' => '¿Seguro que deseas eliminar esta programación? Las transacciones ya creadas no se borrarán.',
			'recurring.delete' => 'Eliminar',
			'recurring.triggerHistory' => 'Historial de ejecuciones',
			'recurring.destinationAccount' => 'Cuenta de destino',
			'recurring.category' => 'Categoría',
			'recurring.egNetflixSubscription' => 'ej. Suscripción a Netflix',
			'recurring.selectFirstDueDate' => 'Seleccionar primer vencimiento',
			'recurring.estMonthlyNet' => 'Balance mensual est.',
			'recurring.monthlyIn' => 'Ingresos/mes',
			'recurring.monthlyOut' => 'Gastos/mes',
			'recurring.noRecurringTransactions' => 'Sin transacciones recurrentes',
			'recurring.automateBillsLikeSubscriptionsOrSalary' => 'Automatiza gastos fijos como suscripciones o nómina. La app los anotará a tiempo.',
			'recurring.noHistoryFoundForThisSchedule' => 'Sin historial para esta programación.',
			'recurring.scheduleHistorySubtitle' => 'Las transacciones generadas aparecerán aquí.',
			'recurring.allocation' => 'Distribución',
			'recurring.active' => 'Activo',
			'recurring.eachTimeTheAppOpensOverdueRecurringTransactionsAre' => 'Cada vez que abras la app, las transacciones recurrentes vencidas se registrarán automáticamente.',
			'recurring.schedulesCount' => ({required Object count}) => '${count} programaciones',
			'recurring.pausedCount' => ({required Object count}) => '${count} en pausa',
			'recurring.editRecurring' => 'Editar recurrencia',
			'recurring.newRecurring' => 'Nueva recurrencia',
			'recurring.mustSelectAccount' => 'Debes seleccionar una cuenta',
			'recurring.sourceAccount' => 'Cuenta de origen',
			'recurring.account' => 'Cuenta',
			'recurring.selectAccountPrompt' => 'Seleccionar cuenta',
			'recurring.selectDestinationPrompt' => 'Seleccionar destino',
			'recurring.selectCategoryOptional' => 'Seleccionar categoría (opcional)',
			'recurring.noteLabel' => 'Nota',
			'recurring.saveChanges' => 'Guardar cambios',
			'recurring.createRecurring' => 'Crear recurrencia',
			'recurring.amountGreaterThanZero' => 'El importe debe ser mayor que 0',
			'recurring.mustSelectStartDate' => 'Debes seleccionar una fecha de inicio',
			'recurring.periodDaily' => 'Diario',
			'recurring.periodWeekly' => 'Semanal',
			'recurring.periodMonthly' => 'Mensual',
			'recurring.periodYearly' => 'Anual',
			'recurring.autoGenerateActive' => 'Generará transacciones automáticamente',
			'recurring.autoGeneratePaused' => 'En pausa — no se generarán transacciones',
			'recurring.recurringIncome' => 'Ingreso recurrente',
			'recurring.recurringExpense' => 'Gasto recurrente',
			'recurring.recurringTransfer' => 'Transferencia recurrente',
			'recurring.nextDateLabel' => ({required Object date}) => 'Siguiente: ${date}',
			'reports.title' => 'Informes',
			'reports.overview' => 'Resumen financiero',
			'reports.tabCashflow' => 'Flujo de caja',
			'reports.tabBudgets' => 'Presupuestos y metas',
			'reports.period' => 'Periodo',
			'reports.thisMonth' => 'Este mes',
			'reports.lastMonth' => 'Mes anterior',
			'reports.last3Months' => '3 meses',
			'reports.last6Months' => '6 meses',
			'reports.custom' => 'Personalizado',
			'reports.income' => 'Ingreso',
			'reports.expense' => 'Gasto',
			'reports.netSavings' => 'Ahorro neto',
			'reports.netCashflow' => 'Flujo neto',
			'reports.cashflow' => 'Flujo de caja',
			'reports.savingsRate' => 'Tasa de ahorro',
			'reports.topCategories' => 'Categorías principales',
			'reports.topExpenses' => 'Mayores gastos',
			'reports.topIncome' => 'Mayores ingresos',
			'reports.monthlyTrend' => 'Tendencia mensual',
			'reports.cashflowTrend' => 'Ingresos vs Gastos',
			'reports.budgetBreakdown' => 'Desglose de presupuestos',
			'reports.budgetUtilization' => 'Uso del presupuesto',
			'reports.spendingAllocation' => 'Distribución del gasto',
			'reports.noData' => 'Sin datos en este periodo',
			'reports.noExpenseDataDesc' => 'Registra gastos para ver la distribución de tu dinero.',
			'reports.noBudgets' => 'Sin presupuestos configurados',
			'reports.noBudgetsDesc' => 'Añade presupuestos para seguir tus límites de gasto',
			'reports.onTrack' => 'En camino',
			'reports.needsAttention' => 'Atención requerida',
			'reports.overBudget' => 'Excedido',
			'reports.onBudget' => 'En límite',
			'reports.needs' => 'Necesidades',
			'reports.wants' => 'Deseos',
			'reports.savings' => 'Ahorro',
			'reports.other' => 'Otro',
			'reports.total' => 'Total',
			'reports.average' => 'Promedio',
			'reports.remaining' => 'Restante',
			'reports.spent' => 'Gastado',
			'reports.limit' => 'Límite',
			'reports.txCount' => ({required Object count}) => '${count} transacciones',
			'reports.selectDateRange' => 'Seleccionar rango de fechas',
			'reports.apply' => 'Aplicar',
			'reports.from' => 'Desde',
			'reports.to' => 'Hasta',
			'reports.comparedTo' => ({required Object period}) => 'vs ${period}',
			'reports.higher' => 'más alto',
			'reports.lower' => 'más bajo',
			'reports.same' => 'igual que',
			'reports.noChange' => 'Sin cambios',
			'reports.percent50' => '50%',
			'reports.percent30' => '30%',
			'reports.percent20' => '20%',
			'reports.rule503020' => '50/30/20',
			'reports.prevLastMonth' => 'mes pasado',
			'reports.prevMonth' => 'mes anterior',
			'reports.prev3Months' => '3 meses prev.',
			'reports.prev6Months' => '6 meses prev.',
			'reports.prevPeriod' => 'periodo anterior',
			'reports.exportExcel' => 'Exportar a Excel',
			'reports.exportExcelSuccess' => 'Archivo Excel exportado con éxito',
			'reports.exportExcelError' => 'Error al exportar archivo Excel',
			'settings.title' => 'Ajustes',
			'settings.preferences' => 'Preferencias',
			'settings.baseCurrency' => 'Moneda base',
			'settings.theme' => 'Tema',
			'settings.language' => 'Idioma',
			'settings.numberFormat' => 'Formato de números',
			'settings.selectNumberFormat' => 'Seleccionar formato de números',
			'settings.formatSystem' => 'Predeterminado',
			'settings.formatId' => '1.000.000,00',
			'settings.formatUs' => '1,000,000.00',
			'settings.formatFr' => '1 000 000,00',
			'settings.system' => 'Sistema',
			'settings.english' => 'English',
			'settings.indonesia' => 'Indonesia',
			'settings.malay' => 'Bahasa Melayu',
			'settings.vietnam' => 'Tiếng Việt',
			'settings.russian' => 'Русский',
			'settings.spanish' => 'Español',
			'settings.portuguese' => 'Português',
			'settings.german' => 'Deutsch',
			'settings.security' => 'Seguridad',
			'settings.appLock' => 'Bloqueo de app',
			'settings.appLockDesc' => 'Proteger con PIN',
			'settings.biometrics' => 'Biometría',
			'settings.biometricsDesc' => 'Desbloquear con huella',
			'settings.dataManagement' => 'Gestión de datos',
			'settings.backupRestore' => 'Copia de seguridad',
			'settings.backupRestoreDesc' => 'Guardar o restaurar datos',
			'settings.clearOld' => 'Limpiar transacciones antiguas',
			'settings.clearOldDesc' => 'Eliminar transacciones de más de 1 año',
			'settings.resetData' => 'Restablecer datos',
			'settings.resetDataDesc' => 'Borrar todos los datos locales',
			'settings.support' => 'Soporte',
			'settings.faq' => 'Preguntas frecuentes',
			'settings.faqDesc' => 'Preguntas frecuentes',
			'settings.about' => 'Acerca de Poka CE',
			'settings.aboutDesc' => 'Versión e información legal',
			'settings.selectTheme' => 'Seleccionar tema',
			'settings.themeLight' => 'Claro',
			'settings.themeDark' => 'Oscuro',
			'settings.selectLanguage' => 'Seleccionar idioma',
			'settings.oldTransactionsCleared' => 'Transacciones antiguas eliminadas con éxito',
			'settings.appDataReset' => 'Datos de la app restablecidos con éxito',
			'settings.failedToExportLogs' => 'Error al exportar registros',
			'settings.easterEggRemaining' => ({required Object remaining}) => 'A ${remaining} toques de una sorpresa...',
			'settings.easterEggFound' => '🎉 ¡Encontraste la sorpresa!',
			'settings.selectCurrency' => 'Seleccionar moneda',
			'settings.openSourceLicenses' => 'Licencias de código abierto',
			'settings.checkForUpdates' => 'Buscar actualizaciones',
			'settings.viewLatestReleasesOnGithub' => 'Ver las últimas versiones en GitHub',
			'settings.helpIssues' => 'Ayuda y problemas',
			'settings.reportBugsOrRequestFeatures' => 'Informar errores o solicitar funciones',
			'settings.legal' => 'Legal',
			'settings.termsOfService' => 'Términos de servicio',
			'settings.readOurTermsAndConditions' => 'Lee nuestros términos y condiciones',
			'settings.privacyPolicy' => 'Política de privacidad',
			'settings.learnHowWeHandleYourData' => 'Conoce cómo tratamos tus datos',
			'settings.viewThirdpartySoftwareLicenses' => 'Ver licencias de software de terceros',
			'settings.advanced' => 'Avanzado',
			'settings.exportDebugLogs' => 'Exportar registros de depuración',
			'settings.shareErrorLogsForTroubleshooting' => 'Compartir registros para solucionar problemas',
			'settings.search' => 'Buscar...',
			'settings.errorLoadingContent' => 'Error al cargar el contenido',
			'settings.noLicensesFound' => 'No se encontraron licencias',
			'settings.pokaCe' => 'Poka CE',
			'settings.communityEdition' => 'Community Edition',
			'settings.aboutDescription' => 'Un gestor de finanzas personales gratuito y de código abierto diseñado para ayudarte a registrar gastos, gestionar presupuestos y controlar tus cuentas de forma local.',
			'settings.copyright' => '© 2026 POKA. Todos los derechos reservados.',
			'settings.noResultsFound' => 'No se encontraron resultados',
			'settings.weCouldntFindAnyCurrencyMatching' => ({required Object search}) => 'No pudimos encontrar ninguna moneda que coincida con "${search}".',
			'settings.notSet' => 'No establecido',
			'settings.exportExcel' => 'Exportar a Excel',
			'settings.exportExcelDesc' => 'Exportar transacciones, cuentas y categorías a .xlsx',
			'settings.exportExcelSuccess' => 'Excel exportado con éxito',
			'settings.exportExcelError' => 'Error al exportar el archivo Excel',
			'settings.currencyLockedToast' => 'La moneda no se puede cambiar después de registrar transacciones. Restablece los datos si deseas cambiarla.',
			'shared.authRequired' => 'Autenticación requerida',
			'shared.hexColorCode' => 'Código de color Hex',
			'shared.apply' => 'Aplicar',
			'shared.enterAmount' => 'Introduce importe',
			'shared.selectCategory' => 'Seleccionar categoría',
			'shared.egFf5733' => 'ej. FF5733',
			'shared.amount' => 'Importe',
			'shared.noCategoriesAvailable' => 'No hay categorías disponibles.',
			'shared.noWalletsFoundPleaseCreateOneFirst' => 'No se encontraron billeteras. Por favor, crea una primero.',
			'shared.balance' => 'Saldo: ',
			'shared.optional' => 'Opcional',
			'shared.customColor' => 'Color personalizado',
			'shared.selectWallet' => 'Seleccionar billetera',
			'transactions.searchTransactions' => 'Buscar transacciones...',
			'transactions.failedToLoad' => 'Error al cargar las transacciones',
			'transactions.cancel' => 'Cancelar',
			'transactions.delete' => 'Eliminar',
			'transactions.goToToday' => 'Ir a hoy',
			'transactions.addItem' => 'Añadir artículo',
			'transactions.saveSplitTransaction' => 'Guardar recibo detallado',
			'transactions.transactionType' => 'Tipo de transacción',
			'transactions.applyFilter' => 'Aplicar filtro',
			'transactions.noAccountsAvailable' => 'No hay cuentas disponibles',
			'transactions.account' => 'Cuenta',
			'transactions.category' => 'Categoría',
			'transactions.done' => 'Listo',
			'transactions.save' => 'Guardar',
			'transactions.transactions' => 'Transacciones',
			'transactions.splitTransaction' => 'Recibo detallado',
			'transactions.from' => 'De',
			'transactions.to' => 'A',
			'transactions.empty' => '+/-',
			'transactions.filtered' => 'Filtrado',
			'transactions.netBalance' => 'Saldo neto',
			'transactions.income' => 'Ingresos',
			'transactions.expense' => 'Gastos',
			'transactions.selectCategory' => 'Seleccionar categoría',
			'transactions.filter' => 'Filtrar',
			'transactions.backToToday' => 'Volver a hoy',
			'transactions.deleteTransaction' => 'Eliminar transacción',
			'transactions.deleteTransactionWarning' => 'Eliminar esta transacción revertirá el saldo de tu cuenta y el presupuesto a su estado anterior.',
			'transactions.out' => 'Salida ',
			'transactions.noTransactions' => 'Sin transacciones',
			'transactions.addNote' => 'Añadir nota',
			'transactions.noItemsYet' => 'Aún no hay artículos',
			'transactions.tapAddItemToBeginSplittingntheTransaction' => 'Toca "Añadir artículo" para desglosar este recibo entre categorías.',
			'transactions.addAtLeastOneMoreItemToSave' => 'Añade al menos un artículo más para guardar.',
			'transactions.noTransactions1' => 'Sin transacciones',
			'transactions.reset' => 'Restablecer',
			'transactions.incoming' => 'Entrada ',
			'transactions.nothingRecordedFor' => ({required Object period}) => 'Nada registrado para ${period}.',
			'transactions.splitItems' => ({required Object count}) => '${count} artículos del recibo',
			'transactions.itemsCount' => ({required Object count}) => '${count} artículo(s)',
			'transactions.transactionsCount' => ({required Object count}) => '${count} transacciones',
			'transactions.editTransaction' => 'Editar transacción',
			'transactions.newTransaction' => 'Nueva transacción',
			'transactions.fromAccount' => 'De la cuenta',
			'transactions.toAccount' => 'A la cuenta',
			'transactions.need' => 'Necesidad',
			'transactions.want' => 'Deseo',
			'transactions.saving' => 'Ahorro',
			'transactions.addNoteEllipsis' => 'Añadir nota...',
			'transactions.editItem' => 'Editar artículo',
			'transactions.newItem' => 'Nuevo artículo',
			'transactions.viewModeDay' => 'Día',
			'transactions.viewModeWeek' => 'Semana',
			'transactions.viewModeMonth' => 'Mes',
			'transactions.viewModeDaily' => 'Diario',
			'transactions.viewModeWeekly' => 'Semanal',
			'transactions.viewModeMonthly' => 'Mensual',
			'transactions.debt' => 'Deuda',
			'transactions.recurring' => 'Recurrente',
			'transactions.transfer' => 'Transferencia',
			'transactions.weekNumber' => ({required Object weekNum, required Object date}) => 'Semana ${weekNum} · ${date}',
			'transactions.insufficientBalance' => 'Saldo insuficiente',
			'transactions.insufficientBalanceWarning' => ({required Object amount, required Object account, required Object balance}) => 'El importe (${amount}) supera el saldo actual en ${account} (${balance}). ¿Quizás olvidaste registrar primero los ingresos?',
			'transactions.insufficientBalanceConsequence' => 'El saldo de tu cuenta será negativo si continúas.',
			'transactions.continueAnyway' => 'Continuar de todos modos',
			'transactions.checkAgain' => 'Comprobar de nuevo',
			'transactions.transactionDeleted' => 'Transacción eliminada',
			'transactions.transactionRestored' => 'Transacción restaurada',
			'transactions.allocation' => 'Asignación',
			_ => null,
		};
	}
}
