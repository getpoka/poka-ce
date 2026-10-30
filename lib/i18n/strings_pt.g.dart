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
class TranslationsPt extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsPt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.pt,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <pt>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsPt _root = this; // ignore: unused_field

	@override 
	TranslationsPt $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsPt(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$accounts$pt accounts = _Translations$accounts$pt._(_root);
	@override late final _Translations$app$pt app = _Translations$app$pt._(_root);
	@override late final _Translations$backup$pt backup = _Translations$backup$pt._(_root);
	@override late final _Translations$budgets$pt budgets = _Translations$budgets$pt._(_root);
	@override late final _Translations$categories$pt categories = _Translations$categories$pt._(_root);
	@override late final _Translations$common$pt common = _Translations$common$pt._(_root);
	@override late final _Translations$dashboard$pt dashboard = _Translations$dashboard$pt._(_root);
	@override late final _Translations$debts$pt debts = _Translations$debts$pt._(_root);
	@override Map<String, String> get error => {
		'generic': 'Ocorreu um erro inesperado',
		'network': 'Verifique sua conexão com a internet e tente novamente',
		'database': 'Não foi possível acessar os dados locais',
	};
	@override late final _Translations$goals$pt goals = _Translations$goals$pt._(_root);
	@override late final _Translations$icons$pt icons = _Translations$icons$pt._(_root);
	@override late final _Translations$lock$pt lock = _Translations$lock$pt._(_root);
	@override late final _Translations$onboarding$pt onboarding = _Translations$onboarding$pt._(_root);
	@override late final _Translations$recurring$pt recurring = _Translations$recurring$pt._(_root);
	@override late final _Translations$reports$pt reports = _Translations$reports$pt._(_root);
	@override late final _Translations$settings$pt settings = _Translations$settings$pt._(_root);
	@override late final _Translations$shared$pt shared = _Translations$shared$pt._(_root);
	@override late final _Translations$transactions$pt transactions = _Translations$transactions$pt._(_root);
}

// Path: accounts
class _Translations$accounts$pt extends Translations$accounts$en {
	_Translations$accounts$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get accountName => 'Nome da conta';
	@override String get pocketName => 'Nome do bolso';
	@override String get initialBalance => 'Saldo inicial';
	@override String get icon => 'Ícone';
	@override String get color => 'Cor';
	@override String get assets => 'Ativos';
	@override String get liability => 'Passivo';
	@override String get income => 'Receita';
	@override String get expense => 'Despesa';
	@override String get balance => 'Saldo';
	@override String get walletsPockets => 'Carteiras e bolsos';
	@override String get accounts => 'Contas';
	@override String get mainAccounts => 'Contas principais';
	@override String get deleteAccount => 'Excluir conta';
	@override String get areYouSureYouWantToDeleteThisAccountItWillBeHiddenFromTheApp => 'Tem certeza de que deseja excluir esta conta? Ela será ocultada no app.';
	@override String get delete => 'Excluir';
	@override String get account => 'Conta';
	@override String get totalBalance => 'Saldo total';
	@override String get pockets => 'Bolsos';
	@override String get deletePocket => 'Excluir bolso';
	@override String get cannotDeleteMainPocket => 'O bolso principal não pode ser excluído';
	@override String get mainPocket => 'Principal';
	@override String get areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp => 'Tem certeza de que deseja excluir este bolso? Ele será ocultado no app.';
	@override String get nameCannotBeEmpty => 'O nome não pode ficar em branco';
	@override String get egMainWallet => 'ex.: Carteira principal';
	@override String get egPocket => 'ex.: Mercado, Férias';
	@override String get selectIcon => 'Selecionar ícone';
	@override String get allowedCategories => 'Categorias permitidas';
	@override String get transactions => 'Transações';
	@override String get editAccount => 'Editar conta';
	@override String get editPocket => 'Editar bolso';
	@override String get updateNameIconOrColor => 'Atualizar nome, ícone ou cor';
	@override String get permanentlyRemoveThisAccount => 'Excluir esta conta permanentemente';
	@override String get seeAll => 'Ver tudo';
	@override String get noTransactionsYet => 'Nenhuma transação ainda';
	@override String get accountTransactionsSubtitle => 'As transações registradas nesta conta aparecerão aqui.';
	@override String get pocketTransactionsSubtitle => 'As transações registradas neste bolso aparecerão aqui.';
	@override String get addAccount => 'Adicionar conta';
	@override String get noAccountsFound => 'Nenhuma conta encontrada.';
	@override String get addPocket => 'Adicionar bolso';
	@override String get noPocketsYet => 'Nenhum bolso ainda';
	@override String get pocketsHelpYouSplitYourWalletIntoCategories => 'Os bolsos ajudam a dividir sua carteira em categorias. Seu saldo atual será movido para um bolso "Principal" automaticamente.';
	@override String get activeAccount => 'Conta ativa';
	@override String get inactiveAccountsWillBeHidden => 'Contas inativas serão ocultadas';
	@override String get noCategoriesAvailable => 'Nenhuma categoria disponível.';
	@override String get noAccountsFound1 => 'Nenhuma conta encontrada';
	@override String subcategoriesCount({required Object count}) => '${count} subcategoria(s)';
	@override String pocketsCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(count,
		one: '1 bolso',
		other: '${count} bolsos',
	);
	@override String get totalActiveAccounts => 'Total de contas ativas';
	@override String get noAccountsYet => 'Nenhuma conta cadastrada';
	@override String get tapTheButtonBelowToAddYourFirstAccount => 'Toque no botão abaixo para adicionar sua primeira conta';
	@override String get allCategoriesAllowed => 'Todas as categorias permitidas';
	@override String categoriesSelected({required Object count}) => '${count} categorias selecionadas';
	@override String ratioOfAccount({required Object percent}) => '${percent}% da conta';
	@override String get noMainAccountsYet => 'Nenhuma conta principal ainda.';
	@override String percentOfAssets({required Object percent}) => '${percent}% dos ativos';
	@override String get recentTransactions => 'Transações recentes';
	@override String recentTransactionsCount({required Object count}) => 'Transações recentes (${count})';
	@override String get reconcileBalance => 'Conciliar saldo';
	@override String get reconcileBalanceSubtitle => 'Ajustar o saldo do app com o saldo real da conta';
	@override String get currentBalanceInPoka => 'Saldo no Poka';
	@override String get actualBalance => 'Saldo real';
	@override String get difference => 'Diferença';
	@override String get adjustmentExpense => 'Ajuste (Despesa)';
	@override String get adjustmentIncome => 'Ajuste (Receita)';
	@override String get balanceAdjustment => 'Ajuste de saldo';
	@override String get saveAdjustment => 'Salvar ajuste';
	@override String get balancesMatch => 'Os saldos coincidem, nenhum ajuste necessário';
	@override String get noteOptional => 'Nota (opcional)';
	@override String get reconcileAccount => 'Conciliar saldo da conta';
}

// Path: app
class _Translations$app$pt extends Translations$app$en {
	_Translations$app$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get name => 'Poka';
	@override String get tagline => 'Seu assistente de finanças pessoais';
	@override late final _Translations$app$nav$pt nav = _Translations$app$nav$pt._(_root);
	@override String get termsOfService => 'Termos de Serviço';
	@override String get privacyPolicy => 'Política de Privacidade';
}

// Path: backup
class _Translations$backup$pt extends Translations$backup$en {
	_Translations$backup$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Backup e Restauração';
	@override String get backupAction => 'Criar Backup';
	@override String get restoreAction => 'Restaurar';
	@override String get password => 'Senha';
	@override String get confirmPassword => 'Confirmar senha';
	@override String get passwordsDoNotMatch => 'As senhas não coincidem';
	@override String get backupSuccess => 'Backup realizado com sucesso';
	@override String get restoreSuccess => 'Restauração realizada com sucesso';
	@override String get incorrectPassword => 'Senha incorreta ou arquivo corrompido';
	@override String get enterPasswordToEncrypt => 'Digite a senha para criptografar o backup';
	@override String get enterPasswordToDecrypt => 'Digite a senha para descriptografar o backup';
	@override String get pleaseRestart => 'Por favor, reinicie o aplicativo para aplicar as alterações.';
	@override String get passwordRequired => 'A senha é obrigatória';
	@override String get reminder => 'Lembrete de backup';
	@override String get reminderDesc => 'Lembrar periodicamente de fazer backup dos seus dados';
	@override String get reminderOff => 'Desativado';
	@override String get reminderWeekly => 'Semanal';
	@override String get reminderMonthly => 'Mensal';
	@override String get reminderNotificationTitle => 'Hora de fazer backup dos seus dados';
	@override String get reminderNotificationBody => 'Faz algum tempo desde o seu último backup. Mantenha seus dados seguros criando uma cópia agora.';
	@override String get reminderSaved => 'Lembrete de backup atualizado';
	@override String get restoreWarningDesc => 'A restauração substituirá todos os dados atuais pelos dados do arquivo selecionado. As alterações não salvas serão perdidas. Deseja continuar?';
	@override String get sendTestNotification => 'Enviar notificação de teste';
	@override String get testNotificationSent => 'Notificação de teste enviada';
	@override String get permissionRationaleTitle => 'Lembrete de backup local';
	@override String get permissionRationaleDesc => 'O Poka precisa de permissão de notificação para lembrá-lo de fazer backup. Os lembretes são 100% locais e privados.';
	@override String get allowNotifications => 'Permitir notificações';
	@override String get permissionDenied => 'Permissão de notificação negada. Lembretes desativados.';
}

// Path: budgets
class _Translations$budgets$pt extends Translations$budgets$en {
	_Translations$budgets$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get budgetName => 'Nome do orçamento';
	@override String get spendingLimit => 'Limite de gastos';
	@override String get period => 'Período';
	@override String get resetDay => 'Dia de reinício (1–31)';
	@override String get createBudget => 'Criar orçamento';
	@override String get endDate => 'Data de término';
	@override String get budgetDetails => 'Detalhes do orçamento';
	@override String get deleteBudget => 'Excluir orçamento';
	@override String get areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone => 'Tem certeza de que deseja excluir este orçamento? Todo o histórico relacionado será excluído permanentemente. Esta ação não pode ser desfeita.';
	@override String get delete => 'Excluir';
	@override String get transactions => 'Transações';
	@override String get budgets => 'Orçamentos';
	@override String get allBudgets => 'Todos os orçamentos';
	@override String get egGroceriesEntertainment => 'ex.: Supermercado, Lazer';
	@override String get eg80 => 'ex.: 80';
	@override String get category => 'Categoria';
	@override String get account => 'Conta';
	@override String get overLimit => 'Estourado';
	@override String get remaining => 'Restante';
	@override String get totalSpent => 'Total gasto';
	@override String get totalLimit => 'Limite total';
	@override String get selectEndDate => 'Selecionar data de término';
	@override String get noTransactionsFoundForThisBudgetPeriod => 'Nenhuma transação encontrada neste período de orçamento.';
	@override String get budgetTransactionsSubtitle => 'As transações que correspondem a este orçamento aparecerão aqui.';
	@override String get addBudget => 'Adicionar orçamento';
	@override String get spent => 'Gasto ';
	@override String get noBudgetsYet => 'Nenhum orçamento ainda';
	@override String get setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod => 'Defina limites de gastos para controlar para onde vai seu dinheiro em cada período.';
	@override String budgetAlert({required Object name}) => 'Alerta de orçamento: ${name}';
	@override String percentOf({required Object percent}) => '${percent}% de ';
	@override String budgetsCount({required Object count}) => '${count} orçamento(s)';
	@override String get editBudget => 'Editar orçamento';
	@override String get newBudget => 'Novo orçamento';
	@override String get nameCannotBeEmpty => 'O nome não pode ficar em branco';
	@override String get amountGreaterThanZero => 'O valor deve ser maior que 0';
	@override String get alertThresholdLabel => 'Limite de alerta (%)';
	@override String get scope => 'Abrangência';
	@override String get anyCategory => 'Qualquer categoria';
	@override String get anyAccount => 'Qualquer conta';
	@override String get saveChanges => 'Salvar alterações';
	@override String get periodWeekly => 'Semanal';
	@override String get periodMonthly => 'Mensal';
	@override String get periodYearly => 'Anual';
	@override String get periodCustom => 'Personalizado';
	@override String budgetExceededAlert({required Object percentage, required Object name}) => 'Você utilizou ${percentage}% do seu orçamento de ${name}.';
}

// Path: categories
class _Translations$categories$pt extends Translations$categories$en {
	_Translations$categories$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get expense => 'Despesa';
	@override String get income => 'Receita';
	@override String get categoryName => 'Nome da categoria';
	@override String get icon => 'Ícone';
	@override String get color => 'Cor';
	@override String get noCategoriesFound => 'Nenhuma categoria encontrada.';
	@override String get subcategories => 'Subcategorias';
	@override String get categories => 'Categorias';
	@override String get egFoodDining => 'ex.: Alimentação e Restaurantes';
	@override String get deleteCategory => 'Excluir categoria';
	@override String get delete => 'Excluir';
	@override String get selectIcon => 'Selecionar ícone';
	@override String get searchIcons => 'Buscar ícones...';
	@override String get noIconsFound => 'Nenhum ícone encontrado';
	@override String weCouldntFindAnyIconMatching({required Object search}) => 'Não encontramos nenhum ícone correspondente a "${search}".';
	@override String get noSubcategoriesYet => 'Nenhuma subcategoria ainda';
	@override String get noCategoriesFound1 => 'Nenhuma categoria encontrada';
	@override String subcategoriesCount({required Object count}) => '${count} subcategorias';
	@override String get addSubcategory => 'Adicionar subcategoria';
	@override String get addCategory => 'Adicionar categoria';
	@override String get emptyCategorySubtitle => 'Comece a organizar suas despesas adicionando uma categoria';
	@override String get emptySubcategorySubtitle => 'Divida sua categoria em partes mais detalhadas';
	@override String get saveSubCategory => 'Salvar subcategoria';
	@override String get saveCategory => 'Salvar categoria';
	@override String get newSubCategory => 'Nova subcategoria';
	@override String get newCategory => 'Nova categoria';
	@override String get editSubCategory => 'Editar subcategoria';
	@override String get editCategory => 'Editar categoria';
	@override String deleteConfirmWithChildren({required Object count}) => 'Tem certeza de que deseja excluir esta categoria? Suas ${count} subcategoria(s) se tornarão categorias principais e suas transações ficarão sem categoria.';
	@override String get deleteConfirmNoChildren => 'Tem certeza de que deseja excluir esta categoria? Todas as suas transações ficarão sem categoria.';
}

// Path: common
class _Translations$common$pt extends Translations$common$en {
	_Translations$common$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get save => 'Salvar';
	@override String get cancel => 'Cancelar';
	@override String get delete => 'Excluir';
	@override String get edit => 'Editar';
	@override String get confirm => 'Confirmar';
	@override String get back => 'Voltar';
	@override String get loading => 'Carregando...';
	@override String get error => 'Ocorreu um erro';
	@override String get retry => 'Tentar novamente';
	@override String get empty => 'Nenhum dado ainda';
	@override String get cannotBeUndone => 'Esta ação não pode ser desfeita.';
	@override String get pleaseWait => 'Por favor, aguarde';
	@override String get today => 'Hoje';
	@override String get yesterday => 'Ontem';
	@override String get dueToday => 'Vence hoje';
	@override String get overdue => 'Vencido';
	@override String get uncategorized => 'Sem categoria';
	@override String get unknown => 'Desconhecido';
	@override String get notSet => 'Não definido';
	@override String get undo => 'Desfazer';
}

// Path: dashboard
class _Translations$dashboard$pt extends Translations$dashboard$en {
	_Translations$dashboard$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get overview => 'Visão geral';
	@override String get myFinances => 'Minhas Finanças';
	@override String get netWorth => 'Patrimônio líquido';
	@override String accountsCount({required Object count}) => '${count} contas';
	@override String get assets => 'Ativos';
	@override String get liabilities => 'Passivos';
	@override String get budgets => 'Orçamentos';
	@override String get categories => 'Categorias';
	@override String get goals => 'Metas';
	@override String get debts => 'Dívidas';
	@override String get recurring => 'Recorrentes';
	@override String get cashFlow => 'Fluxo de caixa';
	@override String get budget => 'Orçamento';
	@override String get needs => 'Necessidades (50%)';
	@override String get wants => 'Desejos (30%)';
	@override String get savings => 'Poupança (20%)';
	@override String get saved => 'economizado';
	@override String get onTrack => 'No plano';
	@override String get needsAttention => 'Requer atenção';
	@override String get income => 'Receita';
	@override String get expense => 'Despesa';
	@override String get other => 'Outro';
	@override String get noData => 'Sem dados';
	@override String get spendingActivity => 'Atividade de gastos';
	@override String get total => 'Total';
	@override String get average => 'Média';
	@override String get budgetPerDay => 'Orçamento/Dia';
	@override String get todaysBudget => 'Orçamento de hoje';
	@override String get overbudget => 'Estourado!';
	@override String get setDailyBudget => 'Definir orçamento diário';
	@override String get amount => 'Valor';
	@override String get amountHint => 'ex.: 100';
	@override String get recentTransactions => 'Transações recentes';
	@override String get thisMonth => 'Este mês';
	@override String get noRecentTransactions => 'Nenhuma transação recente';
	@override String get recentTransactionsSubtitle => 'As transações que você registrar aparecerão aqui.';
	@override String get seeAll => 'Ver todas';
	@override String get notSet => 'Não definido';
	@override late final _Translations$dashboard$insight$pt insight = _Translations$dashboard$insight$pt._(_root);
	@override late final _Translations$dashboard$days$pt days = _Translations$dashboard$days$pt._(_root);
}

// Path: debts
class _Translations$debts$pt extends Translations$debts$en {
	_Translations$debts$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get addRepayment => 'Adicionar pagamento';
	@override String get iOwe => 'Eu Devo';
	@override String get theyOwe => 'Me Devem';
	@override String get personName => 'Nome da pessoa';
	@override String get principalAmount => 'Valor principal';
	@override String get transactionBinding => 'Vincular à transação';
	@override String get cancel => 'Cancelar';
	@override String get save => 'Salvar';
	@override String get ok => 'OK';
	@override String get addRecord => 'Adicionar registro';
	@override String get createRecord => 'Criar registro';
	@override String get debtDetails => 'Detalhes da dívida';
	@override String get repaymentHistory => 'Histórico de pagamentos';
	@override String get debtsLoans => 'Dívidas e empréstimos';
	@override String get deleteDebt => 'Excluir dívida';
	@override String get delete => 'Excluir';
	@override String get writeoffDebt => 'Dar baixa na dívida';
	@override String get areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances => 'Tem certeza de que deseja dar baixa nesta dívida? Ela será marcada como quitada sem alterar os saldos das suas contas.';
	@override String get writeoff => 'Dar baixa';
	@override String get egJohnDoe => 'ex.: João Silva';
	@override String get category => 'Categoria';
	@override String get account => 'Conta';
	@override String get egDinnerLastFriday => 'ex.: Jantar de sexta-feira';
	@override String get selectDueDate => 'Selecionar data de vencimento';
	@override String get outstanding => 'Em aberto';
	@override String get paid => 'Pago';
	@override String get principal => 'Principal';
	@override String get actionDenied => 'Ação negada';
	@override String get paymentCannotExceedRemaining => 'O pagamento não pode exceder o saldo restante da dívida.';
	@override String get addNote => 'Adicionar observação';
	@override String get payInFull => 'Quitar total';
	@override String get remaining => 'restante';
	@override String get paid1 => 'Pago ';
	@override String reminder({required Object type, required Object name}) => 'Lembrete de ${type}: ${name}';
	@override String due({required Object type, required Object name}) => 'Vencimento de ${type}: ${name}';
	@override String noHistoryFoundForThis({required Object type}) => 'Nenhum histórico para este(a) ${type}';
	@override String repaymentHistorySubtitle({required Object type}) => 'Os pagamentos deste(a) ${type} aparecerão aqui.';
	@override String failedToLoadDebts({required Object error}) => 'Falha ao carregar dívidas: ${error}';
	@override String percentOf({required Object percent}) => '${percent}% de ';
	@override String settled({required Object count}) => '${count} quitada(s)';
	@override String get payable => 'A pagar';
	@override String get receivable => 'A receber';
	@override String get noDebtsRecorded => 'Nenhuma dívida registrada';
	@override String get noLoansRecorded => 'Nenhum empréstimo registrado';
	@override String get trackMoneyYouOweToOthersAndLogRepayments => 'Controle o dinheiro que você deve a outros e registre cada quitação.';
	@override String get trackMoneyOthersOweYouAndLogCollections => 'Controle o dinheiro que outros devem a você e registre cada recebimento.';
	@override String get editRecord => 'Editar registro';
	@override String get newRecord => 'Novo registro';
	@override String get personNameCannotBeEmpty => 'O nome não pode ficar em branco';
	@override String get amountGreaterThanZero => 'O valor deve ser maior que 0';
	@override String get selectCategoryAndAccount => 'Selecione uma categoria e uma conta';
	@override String get selectCategoryPrompt => 'Selecionar categoria';
	@override String get selectAccountPrompt => 'Selecionar conta';
	@override String get debtBindingHelp => 'Registrar esta dívida adiciona dinheiro à conta (receita).';
	@override String get loanBindingHelp => 'Registrar este empréstimo desconta dinheiro da conta (despesa).';
	@override String get noteLabel => 'Observação';
	@override String get dueDateLabel => 'Data de vencimento';
	@override String get saveChanges => 'Salvar alterações';
	@override String deleteConfirm({required Object type}) => 'Tem certeza de que deseja excluir este(a) ${type}? O registro será apagado permanentemente.';
	@override String debtDetailsTitle({required Object type}) => 'Detalhes de ${type}';
	@override String get debtTypeLoan => 'Empréstimo';
	@override String get debtTypeDebt => 'Dívida';
	@override String reminderAlert({required Object type, required Object amount, required Object action, required Object when}) => '${type} de ${amount} deve ser ${action} ${when}.';
	@override String overdueAlert({required Object type, required Object amount, required Object action}) => '${type} de ${amount} está vencido(a) e deve ser ${action} imediatamente.';
	@override String get actionCollect => 'recebido(a)';
	@override String get actionPay => 'pago(a)';
	@override String get today => 'hoje';
	@override String inDays({required Object days}) => 'em ${days} dias';
	@override String owedCount({required Object count}) => '${count} a pagar';
	@override String receivableCount({required Object count}) => '${count} a receber';
	@override String get disbursedAmount => 'Valor transferido/recebido';
	@override String get lentAmount => 'Valor emprestado';
	@override String get totalRepaymentAmount => 'Total a reembolsar';
	@override String get totalReceivableAmount => 'Total a receber';
	@override String get interestFee => 'Juros / Taxa';
	@override String get disbursedAmountHelp => 'Valor em dinheiro transferido de ou para a sua carteira.';
	@override String get totalAmountMustBeGreaterOrEqual => 'O reembolso total não pode ser menor que o valor entregue';
	@override String disbursedAmountLabel({required Object type}) => '${type}:';
	@override String get interestLabel => 'Juros:';
	@override String get received => 'Recebido';
	@override String get lent => 'Emprestado';
}

// Path: goals
class _Translations$goals$pt extends Translations$goals$en {
	_Translations$goals$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get goals => 'Metas';
	@override String get fulfillGoal => 'Cumprir meta (Gastar)';
	@override String get goalName => 'Nome da meta';
	@override String get targetAmount => 'Valor alvo';
	@override String get createGoal => 'Criar meta';
	@override String errorPrefix({required Object error}) => 'Erro: ${error}';
	@override String get goalDetails => 'Detalhes da meta';
	@override String get transactions => 'Transações';
	@override String get active => 'Ativas';
	@override String get past => 'Concluídas';
	@override String get actionDenied => 'Ação negada';
	@override String get emptyBalanceBeforeDelete => 'Zere o saldo (transfira para outra conta) antes de excluir esta meta.';
	@override String get ok => 'OK';
	@override String get deleteGoal => 'Excluir meta';
	@override String get areYouSureYouWantToDeleteThisGoalTheAssociatedPocketAccountAndItsHistoryWillAlsoBeRemovedThisActionCannotBeUndone => 'Tem certeza de que deseja excluir esta meta? O bolso vinculado e seu histórico também serão apagados. Esta ação não pode ser desfeita.';
	@override String get delete => 'Excluir';
	@override String get egEmergencyFundNewLaptop => 'ex.: Reserva de emergência, Notebook novo';
	@override String get completed => 'Concluída';
	@override String get fullyFunded => '100% financiada';
	@override String get inProgress => 'Em andamento';
	@override String get totalSaved => 'Total poupado';
	@override String get stillNeeded => 'Ainda falta';
	@override String get totalTarget => 'Alvo total';
	@override String get selectTargetDate => 'Selecionar data alvo';
	@override String get noTransactionsFoundForThisGoal => 'Nenhuma transação encontrada para esta meta.';
	@override String get goalTransactionsSubtitle => 'Transferências ou depósitos para esta meta aparecerão aqui.';
	@override String get addGoal => 'Adicionar meta';
	@override String get aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal => 'Um bolso dedicado será criado automaticamente para controlar esta meta.';
	@override String get saved => 'economizado';
	@override String get needs => 'Faltam ';
	@override String get more => ' restantes';
	@override String get noGoalsYet => 'Nenhuma meta ainda';
	@override String get setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal => 'Defina metas de poupança: um bolso dedicado é criado automaticamente para cada uma.';
	@override String percentOfTarget({required Object percent}) => '${percent}% do alvo';
	@override String goalsCount({required Object count}) => '${count} meta(s)';
	@override String fullyFundedCount({required Object count}) => '${count} concluída(s)';
	@override String get noCompletedGoalsYet => 'Nenhuma meta concluída ainda';
	@override String get completedGoalsWillAppearHere => 'As metas que você atingir aparecerão aqui.';
	@override String get editGoal => 'Editar meta';
	@override String get newGoal => 'Nova meta';
	@override String get nameCannotBeEmpty => 'O nome não pode ficar em branco';
	@override String get targetAmountGreaterThanZero => 'O valor alvo deve ser maior que 0';
	@override String get saveChanges => 'Salvar alterações';
	@override String get targetDateLabel => 'Data alvo';
	@override String get activeGoals => 'Metas ativas';
	@override String get completedGoals => 'Metas concluídas';
	@override String get noActiveGoalsYet => 'Nenhuma meta ativa';
	@override String get noActiveGoalsSubtitle => 'Crie uma nova meta para começar a poupar para o seu próximo objetivo.';
	@override String get saveInAccount => 'Guardar na conta';
	@override String get selectAccount => 'Selecionar conta';
	@override String get accountRequired => 'Selecione uma conta';
	@override String storedIn({required Object account}) => 'Guardado em ${account}';
}

// Path: icons
class _Translations$icons$pt extends Translations$icons$en {
	_Translations$icons$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

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
class _Translations$lock$pt extends Translations$lock$en {
	_Translations$lock$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get confirmPin => 'Confirmar PIN';
	@override String get createPin => 'Criar PIN';
	@override String get pinsDoNotMatch => 'Os PINs não coincidem';
	@override String get reenterPin => 'Digite o PIN novamente';
	@override String get enterPinAppLock => 'Digite o PIN para desbloquear';
	@override String get incorrectPin => 'PIN incorreto';
	@override String get verifyIdentity => 'Verificar identidade';
	@override String retryInSeconds({required Object seconds}) => 'Tente novamente em ${seconds} segundos';
	@override String get setupPinTitle => 'Configurar PIN';
	@override String get setupPinBody => 'Crie um PIN antes de ativar o bloqueio do app ou biometria.';
	@override String get unlocked => 'Desbloqueado';
	@override String get enter6DigitPin => 'Digite o PIN de 6 dígitos';
	@override String get enterPin => 'Digite o PIN';
	@override String get invalidPin => 'PIN inválido';
	@override String get tooManyAttempts => 'Muitas tentativas';
	@override String get temporarilyLocked => 'Bloqueado temporariamente';
	@override String get authenticateReason => 'Autentique-se para acessar o Poka';
}

// Path: onboarding
class _Translations$onboarding$pt extends Translations$onboarding$en {
	_Translations$onboarding$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get continueWithCurrency => 'Continuar com a moeda selecionada';
	@override String get chooseYourBaseCurrency => 'Escolha sua moeda base';
	@override String get thisCurrencyWillBeUsedForAllAccountsPocketsAndTransactionsYouCanChangeThisLaterInSettings => 'Esta moeda será usada em todas as contas, bolsos e transações. Você poderá alterá-la mais tarde nas configurações.';
}

// Path: recurring
class _Translations$recurring$pt extends Translations$recurring$en {
	_Translations$recurring$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get addSchedule => 'Adicionar recorrência';
	@override String get transactionDetails => 'Detalhes da transação';
	@override String get amount => 'Valor';
	@override String get frequency => 'Frequência';
	@override String get startDate => 'Data de início';
	@override String get recurring => 'Recorrentes';
	@override String get schedules => 'Agendamentos';
	@override String get scheduleDetails => 'Detalhes do agendamento';
	@override String get deleteSchedule => 'Excluir agendamento';
	@override String get areYouSureYouWantToDeleteThisRecurringScheduleExistingGeneratedTransactionsWillNotBeDeleted => 'Tem certeza de que deseja excluir este agendamento? As transações já criadas não serão apagadas.';
	@override String get delete => 'Excluir';
	@override String get triggerHistory => 'Histórico de lançamentos';
	@override String get destinationAccount => 'Conta de destino';
	@override String get category => 'Categoria';
	@override String get egNetflixSubscription => 'ex.: Assinatura Netflix';
	@override String get selectFirstDueDate => 'Selecionar primeira data de vencimento';
	@override String get estMonthlyNet => 'Balanço mensal est.';
	@override String get monthlyIn => 'Entradas/mês';
	@override String get monthlyOut => 'Saídas/mês';
	@override String get noRecurringTransactions => 'Nenhuma transação recorrente';
	@override String get automateBillsLikeSubscriptionsOrSalary => 'Automatize contas fixas como assinaturas ou salário. O app fará o registro no prazo.';
	@override String get noHistoryFoundForThisSchedule => 'Nenhum histórico para este agendamento.';
	@override String get scheduleHistorySubtitle => 'As transações criadas por este agendamento aparecerão aqui.';
	@override String get allocation => 'Alocação';
	@override String get active => 'Ativo';
	@override String get eachTimeTheAppOpensOverdueRecurringTransactionsAre => 'Cada vez que o app for aberto, as transações recorrentes vencidas serão registradas automaticamente.';
	@override String schedulesCount({required Object count}) => '${count} agendamentos';
	@override String pausedCount({required Object count}) => '${count} em pausa';
	@override String get editRecurring => 'Editar recorrência';
	@override String get newRecurring => 'Nova recorrência';
	@override String get mustSelectAccount => 'É necessário selecionar uma conta';
	@override String get sourceAccount => 'Conta de origem';
	@override String get account => 'Conta';
	@override String get selectAccountPrompt => 'Selecionar conta';
	@override String get selectDestinationPrompt => 'Selecionar destino';
	@override String get selectCategoryOptional => 'Selecionar categoria (opcional)';
	@override String get noteLabel => 'Observação';
	@override String get saveChanges => 'Salvar alterações';
	@override String get createRecurring => 'Criar recorrência';
	@override String get amountGreaterThanZero => 'O valor deve ser maior que 0';
	@override String get mustSelectStartDate => 'É necessário selecionar uma data de início';
	@override String get periodDaily => 'Diário';
	@override String get periodWeekly => 'Semanal';
	@override String get periodMonthly => 'Mensal';
	@override String get periodYearly => 'Anual';
	@override String get autoGenerateActive => 'Irá gerar transações automaticamente';
	@override String get autoGeneratePaused => 'Em pausa — nenhuma transação será gerada';
	@override String get recurringIncome => 'Receita recorrente';
	@override String get recurringExpense => 'Despesa recorrente';
	@override String get recurringTransfer => 'Transferência recorrente';
	@override String nextDateLabel({required Object date}) => 'Próximo: ${date}';
}

// Path: reports
class _Translations$reports$pt extends Translations$reports$en {
	_Translations$reports$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Relatórios';
	@override String get overview => 'Visão geral financeira';
	@override String get tabCashflow => 'Fluxo de caixa';
	@override String get tabBudgets => 'Orçamentos e metas';
	@override String get period => 'Período';
	@override String get thisMonth => 'Este mês';
	@override String get lastMonth => 'Mês passado';
	@override String get last3Months => '3 meses';
	@override String get last6Months => '6 meses';
	@override String get custom => 'Personalizado';
	@override String get income => 'Receita';
	@override String get expense => 'Despesa';
	@override String get netSavings => 'Poupança líquida';
	@override String get netCashflow => 'Fluxo líquido';
	@override String get cashflow => 'Fluxo de caixa';
	@override String get savingsRate => 'Taxa de poupança';
	@override String get topCategories => 'Principais categorias';
	@override String get topExpenses => 'Maiores despesas';
	@override String get topIncome => 'Maiores receitas';
	@override String get monthlyTrend => 'Tendência mensal';
	@override String get cashflowTrend => 'Receitas vs Despesas';
	@override String get budgetBreakdown => 'Detalhamento do orçamento';
	@override String get budgetUtilization => 'Uso do orçamento';
	@override String get spendingAllocation => 'Distribuição de gastos';
	@override String get noData => 'Sem dados neste período';
	@override String get noExpenseDataDesc => 'Registre transações de despesa para ver a distribuição dos seus gastos.';
	@override String get noBudgets => 'Nenhum orçamento configurado';
	@override String get noBudgetsDesc => 'Adicione orçamentos para acompanhar seus limites de gastos';
	@override String get onTrack => 'No plano';
	@override String get needsAttention => 'Requer atenção';
	@override String get overBudget => 'Estourado';
	@override String get onBudget => 'No limite';
	@override String get needs => 'Necessidades';
	@override String get wants => 'Desejos';
	@override String get savings => 'Poupança';
	@override String get other => 'Outro';
	@override String get total => 'Total';
	@override String get average => 'Média';
	@override String get remaining => 'Restante';
	@override String get spent => 'Gasto';
	@override String get limit => 'Limite';
	@override String txCount({required Object count}) => '${count} transações';
	@override String get selectDateRange => 'Selecionar intervalo de datas';
	@override String get apply => 'Aplicar';
	@override String get from => 'De';
	@override String get to => 'Até';
	@override String comparedTo({required Object period}) => 'vs ${period}';
	@override String get higher => 'maior';
	@override String get lower => 'menor';
	@override String get same => 'igual a';
	@override String get noChange => 'Sem alteração';
	@override String get percent50 => '50%';
	@override String get percent30 => '30%';
	@override String get percent20 => '20%';
	@override String get rule503020 => '50/30/20';
	@override String get prevLastMonth => 'mês passado';
	@override String get prevMonth => 'mês anterior';
	@override String get prev3Months => '3 meses anteriores';
	@override String get prev6Months => '6 meses anteriores';
	@override String get prevPeriod => 'período anterior';
	@override String get exportExcel => 'Exportar para Excel';
	@override String get exportExcelSuccess => 'Arquivo Excel exportado com sucesso';
	@override String get exportExcelError => 'Falha ao exportar arquivo Excel';
}

// Path: settings
class _Translations$settings$pt extends Translations$settings$en {
	_Translations$settings$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Configurações';
	@override String get preferences => 'Preferências';
	@override String get baseCurrency => 'Moeda base';
	@override String get theme => 'Tema';
	@override String get language => 'Idioma';
	@override String get numberFormat => 'Formato de números';
	@override String get selectNumberFormat => 'Selecionar formato de números';
	@override String get formatSystem => 'Padrão do app';
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
	@override String get security => 'Segurança';
	@override String get appLock => 'Bloqueio do app';
	@override String get appLockDesc => 'Proteger app com PIN';
	@override String get biometrics => 'Biometria';
	@override String get biometricsDesc => 'Desbloquear com biometria';
	@override String get dataManagement => 'Gerenciamento de dados';
	@override String get backupRestore => 'Backup e restauração';
	@override String get backupRestoreDesc => 'Salvar ou restaurar seus dados';
	@override String get clearOld => 'Limpar transações antigas';
	@override String get clearOldDesc => 'Remover transações com mais de 1 ano';
	@override String get resetData => 'Redefinir dados';
	@override String get resetDataDesc => 'Apagar todos os dados locais';
	@override String get support => 'Suporte';
	@override String get faq => 'Perguntas frequentes';
	@override String get faqDesc => 'Dúvidas frequentes';
	@override String get about => 'Sobre o Poka CE';
	@override String get aboutDesc => 'Versão e informações legais';
	@override String get selectTheme => 'Selecionar tema';
	@override String get themeLight => 'Claro';
	@override String get themeDark => 'Escuro';
	@override String get selectLanguage => 'Selecionar idioma';
	@override String get oldTransactionsCleared => 'Transações antigas limpas com sucesso';
	@override String get appDataReset => 'Dados do app redefinidos com sucesso';
	@override String get failedToExportLogs => 'Falha ao exportar registros';
	@override String easterEggRemaining({required Object remaining}) => 'Faltam ${remaining} toques para uma surpresa...';
	@override String get easterEggFound => '🎉 Você encontrou o easter egg!';
	@override String get selectCurrency => 'Selecionar moeda';
	@override String get openSourceLicenses => 'Licenças de código aberto';
	@override String get checkForUpdates => 'Verificar atualizações';
	@override String get viewLatestReleasesOnGithub => 'Ver versões mais recentes no GitHub';
	@override String get helpIssues => 'Ajuda e problemas';
	@override String get reportBugsOrRequestFeatures => 'Relatar bugs ou sugerir recursos';
	@override String get legal => 'Legal';
	@override String get termsOfService => 'Termos de serviço';
	@override String get readOurTermsAndConditions => 'Leia nossos termos e condições';
	@override String get privacyPolicy => 'Política de privacidade';
	@override String get learnHowWeHandleYourData => 'Saiba como tratamos seus dados';
	@override String get viewThirdpartySoftwareLicenses => 'Ver licenças de software de terceiros';
	@override String get advanced => 'Avançado';
	@override String get exportDebugLogs => 'Exportar logs de depuração';
	@override String get shareErrorLogsForTroubleshooting => 'Compartilhar logs de erro para suporte';
	@override String get search => 'Buscar...';
	@override String get errorLoadingContent => 'Erro ao carregar conteúdo';
	@override String get noLicensesFound => 'Nenhuma licença encontrada';
	@override String get pokaCe => 'Poka CE';
	@override String get communityEdition => 'Community Edition';
	@override String get aboutDescription => 'Um gerenciador de finanças pessoais gratuito e de código aberto feito para ajudar você a controlar gastos, gerenciar orçamentos e monitorar suas contas localmente.';
	@override String get copyright => '© 2026 POKA. Todos os direitos reservados.';
	@override String get noResultsFound => 'Nenhum resultado encontrado';
	@override String weCouldntFindAnyCurrencyMatching({required Object search}) => 'Não encontramos nenhuma moeda correspondente a "${search}".';
	@override String get notSet => 'Não definido';
	@override String get exportExcel => 'Exportar para Excel';
	@override String get exportExcelDesc => 'Exportar transações, contas e categorias para .xlsx';
	@override String get exportExcelSuccess => 'Arquivo Excel exportado com sucesso';
	@override String get exportExcelError => 'Falha ao exportar arquivo Excel';
	@override String get currencyLockedToast => 'A moeda não pode ser alterada após o registro de transações. Redefina os dados se desejar alterá-la.';
}

// Path: shared
class _Translations$shared$pt extends Translations$shared$en {
	_Translations$shared$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get authRequired => 'Autenticação necessária';
	@override String get hexColorCode => 'Código Hex da cor';
	@override String get apply => 'Aplicar';
	@override String get enterAmount => 'Digite o valor';
	@override String get selectCategory => 'Selecionar categoria';
	@override String get egFf5733 => 'ex.: FF5733';
	@override String get amount => 'Valor';
	@override String get noCategoriesAvailable => 'Nenhuma categoria disponível.';
	@override String get noWalletsFoundPleaseCreateOneFirst => 'Nenhuma carteira encontrada. Crie uma primeiro.';
	@override String get balance => 'Saldo: ';
	@override String get optional => 'Opcional';
	@override String get customColor => 'Cor personalizada';
	@override String get selectWallet => 'Selecionar carteira';
}

// Path: transactions
class _Translations$transactions$pt extends Translations$transactions$en {
	_Translations$transactions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get searchTransactions => 'Buscar transações...';
	@override String get failedToLoad => 'Falha ao carregar transações';
	@override String get cancel => 'Cancelar';
	@override String get delete => 'Excluir';
	@override String get goToToday => 'Ir para hoje';
	@override String get addItem => 'Adicionar item';
	@override String get saveSplitTransaction => 'Salvar recibo discriminado';
	@override String get transactionType => 'Tipo de transação';
	@override String get applyFilter => 'Aplicar filtro';
	@override String get noAccountsAvailable => 'Nenhuma conta disponível';
	@override String get account => 'Conta';
	@override String get category => 'Categoria';
	@override String get done => 'Concluído';
	@override String get save => 'Salvar';
	@override String get transactions => 'Transações';
	@override String get splitTransaction => 'Recibo discriminado';
	@override String get from => 'De';
	@override String get to => 'Para';
	@override String get empty => '+/-';
	@override String get filtered => 'Filtrado';
	@override String get netBalance => 'Saldo líquido';
	@override String get income => 'Receita';
	@override String get expense => 'Despesa';
	@override String get selectCategory => 'Selecionar categoria';
	@override String get filter => 'Filtrar';
	@override String get backToToday => 'Voltar para hoje';
	@override String get deleteTransaction => 'Excluir transação';
	@override String get deleteTransactionWarning => 'Excluir esta transação reverterá o saldo da conta e o orçamento para o estado anterior.';
	@override String get out => 'Saída ';
	@override String get noTransactions => 'Sem transações';
	@override String get addNote => 'Adicionar nota';
	@override String get noItemsYet => 'Nenhum item ainda';
	@override String get tapAddItemToBeginSplittingntheTransaction => 'Toque em "Adicionar item" para discriminar este recibo em categorias.';
	@override String get addAtLeastOneMoreItemToSave => 'Adicione pelo menos mais um item para salvar.';
	@override String get noTransactions1 => 'Sem transações';
	@override String get reset => 'Redefinir';
	@override String get incoming => 'Entrada ';
	@override String nothingRecordedFor({required Object period}) => 'Nada registrado para ${period}.';
	@override String splitItems({required Object count}) => '${count} itens do recibo';
	@override String itemsCount({required Object count}) => '${count} item(ns)';
	@override String transactionsCount({required Object count}) => '${count} transações';
	@override String get editTransaction => 'Editar transação';
	@override String get newTransaction => 'Nova transação';
	@override String get fromAccount => 'Da conta';
	@override String get toAccount => 'Para a conta';
	@override String get need => 'Necessidade';
	@override String get want => 'Desejo';
	@override String get saving => 'Poupança';
	@override String get addNoteEllipsis => 'Adicionar nota...';
	@override String get editItem => 'Editar item';
	@override String get newItem => 'Novo item';
	@override String get viewModeDay => 'Dia';
	@override String get viewModeWeek => 'Semana';
	@override String get viewModeMonth => 'Mês';
	@override String get viewModeDaily => 'Diário';
	@override String get viewModeWeekly => 'Semanal';
	@override String get viewModeMonthly => 'Mensal';
	@override String get debt => 'Dívida';
	@override String get recurring => 'Recorrente';
	@override String get transfer => 'Transferência';
	@override String weekNumber({required Object weekNum, required Object date}) => 'Semana ${weekNum} · ${date}';
	@override String get insufficientBalance => 'Saldo insuficiente';
	@override String insufficientBalanceWarning({required Object amount, required Object account, required Object balance}) => 'O valor (${amount}) excede o saldo atual em ${account} (${balance}). Talvez você tenha esquecido de registrar a receita primeiro?';
	@override String get insufficientBalanceConsequence => 'O saldo da sua conta ficará negativo se você prosseguir.';
	@override String get continueAnyway => 'Continuar mesmo assim';
	@override String get checkAgain => 'Verificar novamente';
	@override String get transactionDeleted => 'Transação excluída';
	@override String get transactionRestored => 'Transação restaurada';
	@override String get allocation => 'Alocação';
}

// Path: app.nav
class _Translations$app$nav$pt extends Translations$app$nav$en {
	_Translations$app$nav$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get home => 'Início';
	@override String get transactions => 'Transações';
	@override String get reports => 'Relatórios';
	@override String get accounts => 'Contas';
	@override String get settings => 'Ajustes';
}

// Path: dashboard.insight
class _Translations$dashboard$insight$pt extends Translations$dashboard$insight$en {
	_Translations$dashboard$insight$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get noData => 'Sem dados suficientes este mês para analisar.';
	@override String get thisMonth => 'este mês está';
	@override String get up => 'acima em';
	@override String get down => 'abaixo em';
	@override String get same => 'igual a';
	@override String get fromLastMonth => 'em relação ao mês passado.';
}

// Path: dashboard.days
class _Translations$dashboard$days$pt extends Translations$dashboard$days$en {
	_Translations$dashboard$days$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get mon => 'Seg';
	@override String get tue => 'Ter';
	@override String get wed => 'Qua';
	@override String get thu => 'Qui';
	@override String get fri => 'Sex';
	@override String get sat => 'Sáb';
	@override String get sun => 'Dom';
}

/// The flat map containing all translations for locale <pt>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsPt {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'accounts.accountName' => 'Nome da conta',
			'accounts.pocketName' => 'Nome do bolso',
			'accounts.initialBalance' => 'Saldo inicial',
			'accounts.icon' => 'Ícone',
			'accounts.color' => 'Cor',
			'accounts.assets' => 'Ativos',
			'accounts.liability' => 'Passivo',
			'accounts.income' => 'Receita',
			'accounts.expense' => 'Despesa',
			'accounts.balance' => 'Saldo',
			'accounts.walletsPockets' => 'Carteiras e bolsos',
			'accounts.accounts' => 'Contas',
			'accounts.mainAccounts' => 'Contas principais',
			'accounts.deleteAccount' => 'Excluir conta',
			'accounts.areYouSureYouWantToDeleteThisAccountItWillBeHiddenFromTheApp' => 'Tem certeza de que deseja excluir esta conta? Ela será ocultada no app.',
			'accounts.delete' => 'Excluir',
			'accounts.account' => 'Conta',
			'accounts.totalBalance' => 'Saldo total',
			'accounts.pockets' => 'Bolsos',
			'accounts.deletePocket' => 'Excluir bolso',
			'accounts.cannotDeleteMainPocket' => 'O bolso principal não pode ser excluído',
			'accounts.mainPocket' => 'Principal',
			'accounts.areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp' => 'Tem certeza de que deseja excluir este bolso? Ele será ocultado no app.',
			'accounts.nameCannotBeEmpty' => 'O nome não pode ficar em branco',
			'accounts.egMainWallet' => 'ex.: Carteira principal',
			'accounts.egPocket' => 'ex.: Mercado, Férias',
			'accounts.selectIcon' => 'Selecionar ícone',
			'accounts.allowedCategories' => 'Categorias permitidas',
			'accounts.transactions' => 'Transações',
			'accounts.editAccount' => 'Editar conta',
			'accounts.editPocket' => 'Editar bolso',
			'accounts.updateNameIconOrColor' => 'Atualizar nome, ícone ou cor',
			'accounts.permanentlyRemoveThisAccount' => 'Excluir esta conta permanentemente',
			'accounts.seeAll' => 'Ver tudo',
			'accounts.noTransactionsYet' => 'Nenhuma transação ainda',
			'accounts.accountTransactionsSubtitle' => 'As transações registradas nesta conta aparecerão aqui.',
			'accounts.pocketTransactionsSubtitle' => 'As transações registradas neste bolso aparecerão aqui.',
			'accounts.addAccount' => 'Adicionar conta',
			'accounts.noAccountsFound' => 'Nenhuma conta encontrada.',
			'accounts.addPocket' => 'Adicionar bolso',
			'accounts.noPocketsYet' => 'Nenhum bolso ainda',
			'accounts.pocketsHelpYouSplitYourWalletIntoCategories' => 'Os bolsos ajudam a dividir sua carteira em categorias. Seu saldo atual será movido para um bolso "Principal" automaticamente.',
			'accounts.activeAccount' => 'Conta ativa',
			'accounts.inactiveAccountsWillBeHidden' => 'Contas inativas serão ocultadas',
			'accounts.noCategoriesAvailable' => 'Nenhuma categoria disponível.',
			'accounts.noAccountsFound1' => 'Nenhuma conta encontrada',
			'accounts.subcategoriesCount' => ({required Object count}) => '${count} subcategoria(s)',
			'accounts.pocketsCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pt'))(count, one: '1 bolso', other: '${count} bolsos', ), 
			'accounts.totalActiveAccounts' => 'Total de contas ativas',
			'accounts.noAccountsYet' => 'Nenhuma conta cadastrada',
			'accounts.tapTheButtonBelowToAddYourFirstAccount' => 'Toque no botão abaixo para adicionar sua primeira conta',
			'accounts.allCategoriesAllowed' => 'Todas as categorias permitidas',
			'accounts.categoriesSelected' => ({required Object count}) => '${count} categorias selecionadas',
			'accounts.ratioOfAccount' => ({required Object percent}) => '${percent}% da conta',
			'accounts.noMainAccountsYet' => 'Nenhuma conta principal ainda.',
			'accounts.percentOfAssets' => ({required Object percent}) => '${percent}% dos ativos',
			'accounts.recentTransactions' => 'Transações recentes',
			'accounts.recentTransactionsCount' => ({required Object count}) => 'Transações recentes (${count})',
			'accounts.reconcileBalance' => 'Conciliar saldo',
			'accounts.reconcileBalanceSubtitle' => 'Ajustar o saldo do app com o saldo real da conta',
			'accounts.currentBalanceInPoka' => 'Saldo no Poka',
			'accounts.actualBalance' => 'Saldo real',
			'accounts.difference' => 'Diferença',
			'accounts.adjustmentExpense' => 'Ajuste (Despesa)',
			'accounts.adjustmentIncome' => 'Ajuste (Receita)',
			'accounts.balanceAdjustment' => 'Ajuste de saldo',
			'accounts.saveAdjustment' => 'Salvar ajuste',
			'accounts.balancesMatch' => 'Os saldos coincidem, nenhum ajuste necessário',
			'accounts.noteOptional' => 'Nota (opcional)',
			'accounts.reconcileAccount' => 'Conciliar saldo da conta',
			'app.name' => 'Poka',
			'app.tagline' => 'Seu assistente de finanças pessoais',
			'app.nav.home' => 'Início',
			'app.nav.transactions' => 'Transações',
			'app.nav.reports' => 'Relatórios',
			'app.nav.accounts' => 'Contas',
			'app.nav.settings' => 'Ajustes',
			'app.termsOfService' => 'Termos de Serviço',
			'app.privacyPolicy' => 'Política de Privacidade',
			'backup.title' => 'Backup e Restauração',
			'backup.backupAction' => 'Criar Backup',
			'backup.restoreAction' => 'Restaurar',
			'backup.password' => 'Senha',
			'backup.confirmPassword' => 'Confirmar senha',
			'backup.passwordsDoNotMatch' => 'As senhas não coincidem',
			'backup.backupSuccess' => 'Backup realizado com sucesso',
			'backup.restoreSuccess' => 'Restauração realizada com sucesso',
			'backup.incorrectPassword' => 'Senha incorreta ou arquivo corrompido',
			'backup.enterPasswordToEncrypt' => 'Digite a senha para criptografar o backup',
			'backup.enterPasswordToDecrypt' => 'Digite a senha para descriptografar o backup',
			'backup.pleaseRestart' => 'Por favor, reinicie o aplicativo para aplicar as alterações.',
			'backup.passwordRequired' => 'A senha é obrigatória',
			'backup.reminder' => 'Lembrete de backup',
			'backup.reminderDesc' => 'Lembrar periodicamente de fazer backup dos seus dados',
			'backup.reminderOff' => 'Desativado',
			'backup.reminderWeekly' => 'Semanal',
			'backup.reminderMonthly' => 'Mensal',
			'backup.reminderNotificationTitle' => 'Hora de fazer backup dos seus dados',
			'backup.reminderNotificationBody' => 'Faz algum tempo desde o seu último backup. Mantenha seus dados seguros criando uma cópia agora.',
			'backup.reminderSaved' => 'Lembrete de backup atualizado',
			'backup.restoreWarningDesc' => 'A restauração substituirá todos os dados atuais pelos dados do arquivo selecionado. As alterações não salvas serão perdidas. Deseja continuar?',
			'backup.sendTestNotification' => 'Enviar notificação de teste',
			'backup.testNotificationSent' => 'Notificação de teste enviada',
			'backup.permissionRationaleTitle' => 'Lembrete de backup local',
			'backup.permissionRationaleDesc' => 'O Poka precisa de permissão de notificação para lembrá-lo de fazer backup. Os lembretes são 100% locais e privados.',
			'backup.allowNotifications' => 'Permitir notificações',
			'backup.permissionDenied' => 'Permissão de notificação negada. Lembretes desativados.',
			'budgets.budgetName' => 'Nome do orçamento',
			'budgets.spendingLimit' => 'Limite de gastos',
			'budgets.period' => 'Período',
			'budgets.resetDay' => 'Dia de reinício (1–31)',
			'budgets.createBudget' => 'Criar orçamento',
			'budgets.endDate' => 'Data de término',
			'budgets.budgetDetails' => 'Detalhes do orçamento',
			'budgets.deleteBudget' => 'Excluir orçamento',
			'budgets.areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone' => 'Tem certeza de que deseja excluir este orçamento? Todo o histórico relacionado será excluído permanentemente. Esta ação não pode ser desfeita.',
			'budgets.delete' => 'Excluir',
			'budgets.transactions' => 'Transações',
			'budgets.budgets' => 'Orçamentos',
			'budgets.allBudgets' => 'Todos os orçamentos',
			'budgets.egGroceriesEntertainment' => 'ex.: Supermercado, Lazer',
			'budgets.eg80' => 'ex.: 80',
			'budgets.category' => 'Categoria',
			'budgets.account' => 'Conta',
			'budgets.overLimit' => 'Estourado',
			'budgets.remaining' => 'Restante',
			'budgets.totalSpent' => 'Total gasto',
			'budgets.totalLimit' => 'Limite total',
			'budgets.selectEndDate' => 'Selecionar data de término',
			'budgets.noTransactionsFoundForThisBudgetPeriod' => 'Nenhuma transação encontrada neste período de orçamento.',
			'budgets.budgetTransactionsSubtitle' => 'As transações que correspondem a este orçamento aparecerão aqui.',
			'budgets.addBudget' => 'Adicionar orçamento',
			'budgets.spent' => 'Gasto ',
			'budgets.noBudgetsYet' => 'Nenhum orçamento ainda',
			'budgets.setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod' => 'Defina limites de gastos para controlar para onde vai seu dinheiro em cada período.',
			'budgets.budgetAlert' => ({required Object name}) => 'Alerta de orçamento: ${name}',
			'budgets.percentOf' => ({required Object percent}) => '${percent}% de ',
			'budgets.budgetsCount' => ({required Object count}) => '${count} orçamento(s)',
			'budgets.editBudget' => 'Editar orçamento',
			'budgets.newBudget' => 'Novo orçamento',
			'budgets.nameCannotBeEmpty' => 'O nome não pode ficar em branco',
			'budgets.amountGreaterThanZero' => 'O valor deve ser maior que 0',
			'budgets.alertThresholdLabel' => 'Limite de alerta (%)',
			'budgets.scope' => 'Abrangência',
			'budgets.anyCategory' => 'Qualquer categoria',
			'budgets.anyAccount' => 'Qualquer conta',
			'budgets.saveChanges' => 'Salvar alterações',
			'budgets.periodWeekly' => 'Semanal',
			'budgets.periodMonthly' => 'Mensal',
			'budgets.periodYearly' => 'Anual',
			'budgets.periodCustom' => 'Personalizado',
			'budgets.budgetExceededAlert' => ({required Object percentage, required Object name}) => 'Você utilizou ${percentage}% do seu orçamento de ${name}.',
			'categories.expense' => 'Despesa',
			'categories.income' => 'Receita',
			'categories.categoryName' => 'Nome da categoria',
			'categories.icon' => 'Ícone',
			'categories.color' => 'Cor',
			'categories.noCategoriesFound' => 'Nenhuma categoria encontrada.',
			'categories.subcategories' => 'Subcategorias',
			'categories.categories' => 'Categorias',
			'categories.egFoodDining' => 'ex.: Alimentação e Restaurantes',
			'categories.deleteCategory' => 'Excluir categoria',
			'categories.delete' => 'Excluir',
			'categories.selectIcon' => 'Selecionar ícone',
			'categories.searchIcons' => 'Buscar ícones...',
			'categories.noIconsFound' => 'Nenhum ícone encontrado',
			'categories.weCouldntFindAnyIconMatching' => ({required Object search}) => 'Não encontramos nenhum ícone correspondente a "${search}".',
			'categories.noSubcategoriesYet' => 'Nenhuma subcategoria ainda',
			'categories.noCategoriesFound1' => 'Nenhuma categoria encontrada',
			'categories.subcategoriesCount' => ({required Object count}) => '${count} subcategorias',
			'categories.addSubcategory' => 'Adicionar subcategoria',
			'categories.addCategory' => 'Adicionar categoria',
			'categories.emptyCategorySubtitle' => 'Comece a organizar suas despesas adicionando uma categoria',
			'categories.emptySubcategorySubtitle' => 'Divida sua categoria em partes mais detalhadas',
			'categories.saveSubCategory' => 'Salvar subcategoria',
			'categories.saveCategory' => 'Salvar categoria',
			'categories.newSubCategory' => 'Nova subcategoria',
			'categories.newCategory' => 'Nova categoria',
			'categories.editSubCategory' => 'Editar subcategoria',
			'categories.editCategory' => 'Editar categoria',
			'categories.deleteConfirmWithChildren' => ({required Object count}) => 'Tem certeza de que deseja excluir esta categoria? Suas ${count} subcategoria(s) se tornarão categorias principais e suas transações ficarão sem categoria.',
			'categories.deleteConfirmNoChildren' => 'Tem certeza de que deseja excluir esta categoria? Todas as suas transações ficarão sem categoria.',
			'common.save' => 'Salvar',
			'common.cancel' => 'Cancelar',
			'common.delete' => 'Excluir',
			'common.edit' => 'Editar',
			'common.confirm' => 'Confirmar',
			'common.back' => 'Voltar',
			'common.loading' => 'Carregando...',
			'common.error' => 'Ocorreu um erro',
			'common.retry' => 'Tentar novamente',
			'common.empty' => 'Nenhum dado ainda',
			'common.cannotBeUndone' => 'Esta ação não pode ser desfeita.',
			'common.pleaseWait' => 'Por favor, aguarde',
			'common.today' => 'Hoje',
			'common.yesterday' => 'Ontem',
			'common.dueToday' => 'Vence hoje',
			'common.overdue' => 'Vencido',
			'common.uncategorized' => 'Sem categoria',
			'common.unknown' => 'Desconhecido',
			'common.notSet' => 'Não definido',
			'common.undo' => 'Desfazer',
			'dashboard.overview' => 'Visão geral',
			'dashboard.myFinances' => 'Minhas Finanças',
			'dashboard.netWorth' => 'Patrimônio líquido',
			'dashboard.accountsCount' => ({required Object count}) => '${count} contas',
			'dashboard.assets' => 'Ativos',
			'dashboard.liabilities' => 'Passivos',
			'dashboard.budgets' => 'Orçamentos',
			'dashboard.categories' => 'Categorias',
			'dashboard.goals' => 'Metas',
			'dashboard.debts' => 'Dívidas',
			'dashboard.recurring' => 'Recorrentes',
			'dashboard.cashFlow' => 'Fluxo de caixa',
			'dashboard.budget' => 'Orçamento',
			'dashboard.needs' => 'Necessidades (50%)',
			'dashboard.wants' => 'Desejos (30%)',
			'dashboard.savings' => 'Poupança (20%)',
			'dashboard.saved' => 'economizado',
			'dashboard.onTrack' => 'No plano',
			'dashboard.needsAttention' => 'Requer atenção',
			'dashboard.income' => 'Receita',
			'dashboard.expense' => 'Despesa',
			'dashboard.other' => 'Outro',
			'dashboard.noData' => 'Sem dados',
			'dashboard.spendingActivity' => 'Atividade de gastos',
			'dashboard.total' => 'Total',
			'dashboard.average' => 'Média',
			'dashboard.budgetPerDay' => 'Orçamento/Dia',
			'dashboard.todaysBudget' => 'Orçamento de hoje',
			'dashboard.overbudget' => 'Estourado!',
			'dashboard.setDailyBudget' => 'Definir orçamento diário',
			'dashboard.amount' => 'Valor',
			'dashboard.amountHint' => 'ex.: 100',
			'dashboard.recentTransactions' => 'Transações recentes',
			'dashboard.thisMonth' => 'Este mês',
			'dashboard.noRecentTransactions' => 'Nenhuma transação recente',
			'dashboard.recentTransactionsSubtitle' => 'As transações que você registrar aparecerão aqui.',
			'dashboard.seeAll' => 'Ver todas',
			'dashboard.notSet' => 'Não definido',
			'dashboard.insight.noData' => 'Sem dados suficientes este mês para analisar.',
			'dashboard.insight.thisMonth' => 'este mês está',
			'dashboard.insight.up' => 'acima em',
			'dashboard.insight.down' => 'abaixo em',
			'dashboard.insight.same' => 'igual a',
			'dashboard.insight.fromLastMonth' => 'em relação ao mês passado.',
			'dashboard.days.mon' => 'Seg',
			'dashboard.days.tue' => 'Ter',
			'dashboard.days.wed' => 'Qua',
			'dashboard.days.thu' => 'Qui',
			'dashboard.days.fri' => 'Sex',
			'dashboard.days.sat' => 'Sáb',
			'dashboard.days.sun' => 'Dom',
			'debts.addRepayment' => 'Adicionar pagamento',
			'debts.iOwe' => 'Eu Devo',
			'debts.theyOwe' => 'Me Devem',
			'debts.personName' => 'Nome da pessoa',
			'debts.principalAmount' => 'Valor principal',
			'debts.transactionBinding' => 'Vincular à transação',
			'debts.cancel' => 'Cancelar',
			'debts.save' => 'Salvar',
			'debts.ok' => 'OK',
			'debts.addRecord' => 'Adicionar registro',
			'debts.createRecord' => 'Criar registro',
			'debts.debtDetails' => 'Detalhes da dívida',
			'debts.repaymentHistory' => 'Histórico de pagamentos',
			'debts.debtsLoans' => 'Dívidas e empréstimos',
			'debts.deleteDebt' => 'Excluir dívida',
			'debts.delete' => 'Excluir',
			'debts.writeoffDebt' => 'Dar baixa na dívida',
			'debts.areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances' => 'Tem certeza de que deseja dar baixa nesta dívida? Ela será marcada como quitada sem alterar os saldos das suas contas.',
			'debts.writeoff' => 'Dar baixa',
			'debts.egJohnDoe' => 'ex.: João Silva',
			'debts.category' => 'Categoria',
			'debts.account' => 'Conta',
			'debts.egDinnerLastFriday' => 'ex.: Jantar de sexta-feira',
			'debts.selectDueDate' => 'Selecionar data de vencimento',
			'debts.outstanding' => 'Em aberto',
			'debts.paid' => 'Pago',
			'debts.principal' => 'Principal',
			'debts.actionDenied' => 'Ação negada',
			'debts.paymentCannotExceedRemaining' => 'O pagamento não pode exceder o saldo restante da dívida.',
			'debts.addNote' => 'Adicionar observação',
			'debts.payInFull' => 'Quitar total',
			'debts.remaining' => 'restante',
			'debts.paid1' => 'Pago ',
			'debts.reminder' => ({required Object type, required Object name}) => 'Lembrete de ${type}: ${name}',
			'debts.due' => ({required Object type, required Object name}) => 'Vencimento de ${type}: ${name}',
			'debts.noHistoryFoundForThis' => ({required Object type}) => 'Nenhum histórico para este(a) ${type}',
			'debts.repaymentHistorySubtitle' => ({required Object type}) => 'Os pagamentos deste(a) ${type} aparecerão aqui.',
			'debts.failedToLoadDebts' => ({required Object error}) => 'Falha ao carregar dívidas: ${error}',
			'debts.percentOf' => ({required Object percent}) => '${percent}% de ',
			'debts.settled' => ({required Object count}) => '${count} quitada(s)',
			'debts.payable' => 'A pagar',
			'debts.receivable' => 'A receber',
			'debts.noDebtsRecorded' => 'Nenhuma dívida registrada',
			'debts.noLoansRecorded' => 'Nenhum empréstimo registrado',
			'debts.trackMoneyYouOweToOthersAndLogRepayments' => 'Controle o dinheiro que você deve a outros e registre cada quitação.',
			'debts.trackMoneyOthersOweYouAndLogCollections' => 'Controle o dinheiro que outros devem a você e registre cada recebimento.',
			'debts.editRecord' => 'Editar registro',
			'debts.newRecord' => 'Novo registro',
			'debts.personNameCannotBeEmpty' => 'O nome não pode ficar em branco',
			'debts.amountGreaterThanZero' => 'O valor deve ser maior que 0',
			'debts.selectCategoryAndAccount' => 'Selecione uma categoria e uma conta',
			'debts.selectCategoryPrompt' => 'Selecionar categoria',
			'debts.selectAccountPrompt' => 'Selecionar conta',
			'debts.debtBindingHelp' => 'Registrar esta dívida adiciona dinheiro à conta (receita).',
			'debts.loanBindingHelp' => 'Registrar este empréstimo desconta dinheiro da conta (despesa).',
			'debts.noteLabel' => 'Observação',
			'debts.dueDateLabel' => 'Data de vencimento',
			'debts.saveChanges' => 'Salvar alterações',
			'debts.deleteConfirm' => ({required Object type}) => 'Tem certeza de que deseja excluir este(a) ${type}? O registro será apagado permanentemente.',
			'debts.debtDetailsTitle' => ({required Object type}) => 'Detalhes de ${type}',
			'debts.debtTypeLoan' => 'Empréstimo',
			'debts.debtTypeDebt' => 'Dívida',
			'debts.reminderAlert' => ({required Object type, required Object amount, required Object action, required Object when}) => '${type} de ${amount} deve ser ${action} ${when}.',
			'debts.overdueAlert' => ({required Object type, required Object amount, required Object action}) => '${type} de ${amount} está vencido(a) e deve ser ${action} imediatamente.',
			'debts.actionCollect' => 'recebido(a)',
			'debts.actionPay' => 'pago(a)',
			'debts.today' => 'hoje',
			'debts.inDays' => ({required Object days}) => 'em ${days} dias',
			'debts.owedCount' => ({required Object count}) => '${count} a pagar',
			'debts.receivableCount' => ({required Object count}) => '${count} a receber',
			'debts.disbursedAmount' => 'Valor transferido/recebido',
			'debts.lentAmount' => 'Valor emprestado',
			'debts.totalRepaymentAmount' => 'Total a reembolsar',
			'debts.totalReceivableAmount' => 'Total a receber',
			'debts.interestFee' => 'Juros / Taxa',
			'debts.disbursedAmountHelp' => 'Valor em dinheiro transferido de ou para a sua carteira.',
			'debts.totalAmountMustBeGreaterOrEqual' => 'O reembolso total não pode ser menor que o valor entregue',
			'debts.disbursedAmountLabel' => ({required Object type}) => '${type}:',
			'debts.interestLabel' => 'Juros:',
			'debts.received' => 'Recebido',
			'debts.lent' => 'Emprestado',
			'error.generic' => 'Ocorreu um erro inesperado',
			'error.network' => 'Verifique sua conexão com a internet e tente novamente',
			'error.database' => 'Não foi possível acessar os dados locais',
			'goals.goals' => 'Metas',
			'goals.fulfillGoal' => 'Cumprir meta (Gastar)',
			'goals.goalName' => 'Nome da meta',
			'goals.targetAmount' => 'Valor alvo',
			'goals.createGoal' => 'Criar meta',
			'goals.errorPrefix' => ({required Object error}) => 'Erro: ${error}',
			'goals.goalDetails' => 'Detalhes da meta',
			'goals.transactions' => 'Transações',
			'goals.active' => 'Ativas',
			'goals.past' => 'Concluídas',
			'goals.actionDenied' => 'Ação negada',
			'goals.emptyBalanceBeforeDelete' => 'Zere o saldo (transfira para outra conta) antes de excluir esta meta.',
			'goals.ok' => 'OK',
			'goals.deleteGoal' => 'Excluir meta',
			'goals.areYouSureYouWantToDeleteThisGoalTheAssociatedPocketAccountAndItsHistoryWillAlsoBeRemovedThisActionCannotBeUndone' => 'Tem certeza de que deseja excluir esta meta? O bolso vinculado e seu histórico também serão apagados. Esta ação não pode ser desfeita.',
			'goals.delete' => 'Excluir',
			'goals.egEmergencyFundNewLaptop' => 'ex.: Reserva de emergência, Notebook novo',
			'goals.completed' => 'Concluída',
			'goals.fullyFunded' => '100% financiada',
			'goals.inProgress' => 'Em andamento',
			'goals.totalSaved' => 'Total poupado',
			'goals.stillNeeded' => 'Ainda falta',
			'goals.totalTarget' => 'Alvo total',
			'goals.selectTargetDate' => 'Selecionar data alvo',
			'goals.noTransactionsFoundForThisGoal' => 'Nenhuma transação encontrada para esta meta.',
			'goals.goalTransactionsSubtitle' => 'Transferências ou depósitos para esta meta aparecerão aqui.',
			'goals.addGoal' => 'Adicionar meta',
			'goals.aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal' => 'Um bolso dedicado será criado automaticamente para controlar esta meta.',
			'goals.saved' => 'economizado',
			'goals.needs' => 'Faltam ',
			'goals.more' => ' restantes',
			'goals.noGoalsYet' => 'Nenhuma meta ainda',
			'goals.setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal' => 'Defina metas de poupança: um bolso dedicado é criado automaticamente para cada uma.',
			'goals.percentOfTarget' => ({required Object percent}) => '${percent}% do alvo',
			'goals.goalsCount' => ({required Object count}) => '${count} meta(s)',
			'goals.fullyFundedCount' => ({required Object count}) => '${count} concluída(s)',
			'goals.noCompletedGoalsYet' => 'Nenhuma meta concluída ainda',
			'goals.completedGoalsWillAppearHere' => 'As metas que você atingir aparecerão aqui.',
			'goals.editGoal' => 'Editar meta',
			'goals.newGoal' => 'Nova meta',
			'goals.nameCannotBeEmpty' => 'O nome não pode ficar em branco',
			'goals.targetAmountGreaterThanZero' => 'O valor alvo deve ser maior que 0',
			'goals.saveChanges' => 'Salvar alterações',
			'goals.targetDateLabel' => 'Data alvo',
			'goals.activeGoals' => 'Metas ativas',
			'goals.completedGoals' => 'Metas concluídas',
			'goals.noActiveGoalsYet' => 'Nenhuma meta ativa',
			'goals.noActiveGoalsSubtitle' => 'Crie uma nova meta para começar a poupar para o seu próximo objetivo.',
			'goals.saveInAccount' => 'Guardar na conta',
			'goals.selectAccount' => 'Selecionar conta',
			'goals.accountRequired' => 'Selecione uma conta',
			'goals.storedIn' => ({required Object account}) => 'Guardado em ${account}',
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
			'lock.createPin' => 'Criar PIN',
			'lock.pinsDoNotMatch' => 'Os PINs não coincidem',
			'lock.reenterPin' => 'Digite o PIN novamente',
			'lock.enterPinAppLock' => 'Digite o PIN para desbloquear',
			'lock.incorrectPin' => 'PIN incorreto',
			'lock.verifyIdentity' => 'Verificar identidade',
			'lock.retryInSeconds' => ({required Object seconds}) => 'Tente novamente em ${seconds} segundos',
			'lock.setupPinTitle' => 'Configurar PIN',
			'lock.setupPinBody' => 'Crie um PIN antes de ativar o bloqueio do app ou biometria.',
			'lock.unlocked' => 'Desbloqueado',
			'lock.enter6DigitPin' => 'Digite o PIN de 6 dígitos',
			'lock.enterPin' => 'Digite o PIN',
			'lock.invalidPin' => 'PIN inválido',
			'lock.tooManyAttempts' => 'Muitas tentativas',
			'lock.temporarilyLocked' => 'Bloqueado temporariamente',
			'lock.authenticateReason' => 'Autentique-se para acessar o Poka',
			'onboarding.continueWithCurrency' => 'Continuar com a moeda selecionada',
			'onboarding.chooseYourBaseCurrency' => 'Escolha sua moeda base',
			'onboarding.thisCurrencyWillBeUsedForAllAccountsPocketsAndTransactionsYouCanChangeThisLaterInSettings' => 'Esta moeda será usada em todas as contas, bolsos e transações. Você poderá alterá-la mais tarde nas configurações.',
			'recurring.addSchedule' => 'Adicionar recorrência',
			'recurring.transactionDetails' => 'Detalhes da transação',
			'recurring.amount' => 'Valor',
			'recurring.frequency' => 'Frequência',
			'recurring.startDate' => 'Data de início',
			'recurring.recurring' => 'Recorrentes',
			'recurring.schedules' => 'Agendamentos',
			'recurring.scheduleDetails' => 'Detalhes do agendamento',
			'recurring.deleteSchedule' => 'Excluir agendamento',
			'recurring.areYouSureYouWantToDeleteThisRecurringScheduleExistingGeneratedTransactionsWillNotBeDeleted' => 'Tem certeza de que deseja excluir este agendamento? As transações já criadas não serão apagadas.',
			'recurring.delete' => 'Excluir',
			'recurring.triggerHistory' => 'Histórico de lançamentos',
			'recurring.destinationAccount' => 'Conta de destino',
			'recurring.category' => 'Categoria',
			'recurring.egNetflixSubscription' => 'ex.: Assinatura Netflix',
			'recurring.selectFirstDueDate' => 'Selecionar primeira data de vencimento',
			'recurring.estMonthlyNet' => 'Balanço mensal est.',
			'recurring.monthlyIn' => 'Entradas/mês',
			'recurring.monthlyOut' => 'Saídas/mês',
			'recurring.noRecurringTransactions' => 'Nenhuma transação recorrente',
			'recurring.automateBillsLikeSubscriptionsOrSalary' => 'Automatize contas fixas como assinaturas ou salário. O app fará o registro no prazo.',
			'recurring.noHistoryFoundForThisSchedule' => 'Nenhum histórico para este agendamento.',
			'recurring.scheduleHistorySubtitle' => 'As transações criadas por este agendamento aparecerão aqui.',
			'recurring.allocation' => 'Alocação',
			'recurring.active' => 'Ativo',
			'recurring.eachTimeTheAppOpensOverdueRecurringTransactionsAre' => 'Cada vez que o app for aberto, as transações recorrentes vencidas serão registradas automaticamente.',
			'recurring.schedulesCount' => ({required Object count}) => '${count} agendamentos',
			'recurring.pausedCount' => ({required Object count}) => '${count} em pausa',
			'recurring.editRecurring' => 'Editar recorrência',
			'recurring.newRecurring' => 'Nova recorrência',
			'recurring.mustSelectAccount' => 'É necessário selecionar uma conta',
			'recurring.sourceAccount' => 'Conta de origem',
			'recurring.account' => 'Conta',
			'recurring.selectAccountPrompt' => 'Selecionar conta',
			'recurring.selectDestinationPrompt' => 'Selecionar destino',
			'recurring.selectCategoryOptional' => 'Selecionar categoria (opcional)',
			'recurring.noteLabel' => 'Observação',
			'recurring.saveChanges' => 'Salvar alterações',
			'recurring.createRecurring' => 'Criar recorrência',
			'recurring.amountGreaterThanZero' => 'O valor deve ser maior que 0',
			'recurring.mustSelectStartDate' => 'É necessário selecionar uma data de início',
			'recurring.periodDaily' => 'Diário',
			'recurring.periodWeekly' => 'Semanal',
			'recurring.periodMonthly' => 'Mensal',
			'recurring.periodYearly' => 'Anual',
			'recurring.autoGenerateActive' => 'Irá gerar transações automaticamente',
			'recurring.autoGeneratePaused' => 'Em pausa — nenhuma transação será gerada',
			'recurring.recurringIncome' => 'Receita recorrente',
			'recurring.recurringExpense' => 'Despesa recorrente',
			'recurring.recurringTransfer' => 'Transferência recorrente',
			'recurring.nextDateLabel' => ({required Object date}) => 'Próximo: ${date}',
			'reports.title' => 'Relatórios',
			'reports.overview' => 'Visão geral financeira',
			'reports.tabCashflow' => 'Fluxo de caixa',
			'reports.tabBudgets' => 'Orçamentos e metas',
			'reports.period' => 'Período',
			'reports.thisMonth' => 'Este mês',
			'reports.lastMonth' => 'Mês passado',
			'reports.last3Months' => '3 meses',
			'reports.last6Months' => '6 meses',
			'reports.custom' => 'Personalizado',
			'reports.income' => 'Receita',
			'reports.expense' => 'Despesa',
			'reports.netSavings' => 'Poupança líquida',
			'reports.netCashflow' => 'Fluxo líquido',
			'reports.cashflow' => 'Fluxo de caixa',
			'reports.savingsRate' => 'Taxa de poupança',
			'reports.topCategories' => 'Principais categorias',
			'reports.topExpenses' => 'Maiores despesas',
			'reports.topIncome' => 'Maiores receitas',
			'reports.monthlyTrend' => 'Tendência mensal',
			'reports.cashflowTrend' => 'Receitas vs Despesas',
			'reports.budgetBreakdown' => 'Detalhamento do orçamento',
			'reports.budgetUtilization' => 'Uso do orçamento',
			'reports.spendingAllocation' => 'Distribuição de gastos',
			'reports.noData' => 'Sem dados neste período',
			'reports.noExpenseDataDesc' => 'Registre transações de despesa para ver a distribuição dos seus gastos.',
			'reports.noBudgets' => 'Nenhum orçamento configurado',
			'reports.noBudgetsDesc' => 'Adicione orçamentos para acompanhar seus limites de gastos',
			'reports.onTrack' => 'No plano',
			'reports.needsAttention' => 'Requer atenção',
			'reports.overBudget' => 'Estourado',
			'reports.onBudget' => 'No limite',
			'reports.needs' => 'Necessidades',
			'reports.wants' => 'Desejos',
			'reports.savings' => 'Poupança',
			'reports.other' => 'Outro',
			'reports.total' => 'Total',
			'reports.average' => 'Média',
			'reports.remaining' => 'Restante',
			'reports.spent' => 'Gasto',
			'reports.limit' => 'Limite',
			'reports.txCount' => ({required Object count}) => '${count} transações',
			'reports.selectDateRange' => 'Selecionar intervalo de datas',
			'reports.apply' => 'Aplicar',
			'reports.from' => 'De',
			'reports.to' => 'Até',
			'reports.comparedTo' => ({required Object period}) => 'vs ${period}',
			'reports.higher' => 'maior',
			'reports.lower' => 'menor',
			'reports.same' => 'igual a',
			'reports.noChange' => 'Sem alteração',
			'reports.percent50' => '50%',
			'reports.percent30' => '30%',
			'reports.percent20' => '20%',
			'reports.rule503020' => '50/30/20',
			'reports.prevLastMonth' => 'mês passado',
			'reports.prevMonth' => 'mês anterior',
			'reports.prev3Months' => '3 meses anteriores',
			'reports.prev6Months' => '6 meses anteriores',
			'reports.prevPeriod' => 'período anterior',
			'reports.exportExcel' => 'Exportar para Excel',
			'reports.exportExcelSuccess' => 'Arquivo Excel exportado com sucesso',
			'reports.exportExcelError' => 'Falha ao exportar arquivo Excel',
			'settings.title' => 'Configurações',
			'settings.preferences' => 'Preferências',
			'settings.baseCurrency' => 'Moeda base',
			'settings.theme' => 'Tema',
			'settings.language' => 'Idioma',
			'settings.numberFormat' => 'Formato de números',
			'settings.selectNumberFormat' => 'Selecionar formato de números',
			'settings.formatSystem' => 'Padrão do app',
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
			'settings.security' => 'Segurança',
			'settings.appLock' => 'Bloqueio do app',
			'settings.appLockDesc' => 'Proteger app com PIN',
			'settings.biometrics' => 'Biometria',
			'settings.biometricsDesc' => 'Desbloquear com biometria',
			'settings.dataManagement' => 'Gerenciamento de dados',
			'settings.backupRestore' => 'Backup e restauração',
			'settings.backupRestoreDesc' => 'Salvar ou restaurar seus dados',
			'settings.clearOld' => 'Limpar transações antigas',
			'settings.clearOldDesc' => 'Remover transações com mais de 1 ano',
			'settings.resetData' => 'Redefinir dados',
			'settings.resetDataDesc' => 'Apagar todos os dados locais',
			'settings.support' => 'Suporte',
			'settings.faq' => 'Perguntas frequentes',
			'settings.faqDesc' => 'Dúvidas frequentes',
			'settings.about' => 'Sobre o Poka CE',
			'settings.aboutDesc' => 'Versão e informações legais',
			'settings.selectTheme' => 'Selecionar tema',
			'settings.themeLight' => 'Claro',
			'settings.themeDark' => 'Escuro',
			'settings.selectLanguage' => 'Selecionar idioma',
			'settings.oldTransactionsCleared' => 'Transações antigas limpas com sucesso',
			'settings.appDataReset' => 'Dados do app redefinidos com sucesso',
			'settings.failedToExportLogs' => 'Falha ao exportar registros',
			'settings.easterEggRemaining' => ({required Object remaining}) => 'Faltam ${remaining} toques para uma surpresa...',
			'settings.easterEggFound' => '🎉 Você encontrou o easter egg!',
			'settings.selectCurrency' => 'Selecionar moeda',
			'settings.openSourceLicenses' => 'Licenças de código aberto',
			'settings.checkForUpdates' => 'Verificar atualizações',
			'settings.viewLatestReleasesOnGithub' => 'Ver versões mais recentes no GitHub',
			'settings.helpIssues' => 'Ajuda e problemas',
			'settings.reportBugsOrRequestFeatures' => 'Relatar bugs ou sugerir recursos',
			'settings.legal' => 'Legal',
			'settings.termsOfService' => 'Termos de serviço',
			'settings.readOurTermsAndConditions' => 'Leia nossos termos e condições',
			'settings.privacyPolicy' => 'Política de privacidade',
			'settings.learnHowWeHandleYourData' => 'Saiba como tratamos seus dados',
			'settings.viewThirdpartySoftwareLicenses' => 'Ver licenças de software de terceiros',
			'settings.advanced' => 'Avançado',
			'settings.exportDebugLogs' => 'Exportar logs de depuração',
			'settings.shareErrorLogsForTroubleshooting' => 'Compartilhar logs de erro para suporte',
			'settings.search' => 'Buscar...',
			'settings.errorLoadingContent' => 'Erro ao carregar conteúdo',
			'settings.noLicensesFound' => 'Nenhuma licença encontrada',
			'settings.pokaCe' => 'Poka CE',
			'settings.communityEdition' => 'Community Edition',
			'settings.aboutDescription' => 'Um gerenciador de finanças pessoais gratuito e de código aberto feito para ajudar você a controlar gastos, gerenciar orçamentos e monitorar suas contas localmente.',
			'settings.copyright' => '© 2026 POKA. Todos os direitos reservados.',
			'settings.noResultsFound' => 'Nenhum resultado encontrado',
			'settings.weCouldntFindAnyCurrencyMatching' => ({required Object search}) => 'Não encontramos nenhuma moeda correspondente a "${search}".',
			'settings.notSet' => 'Não definido',
			'settings.exportExcel' => 'Exportar para Excel',
			'settings.exportExcelDesc' => 'Exportar transações, contas e categorias para .xlsx',
			'settings.exportExcelSuccess' => 'Arquivo Excel exportado com sucesso',
			'settings.exportExcelError' => 'Falha ao exportar arquivo Excel',
			'settings.currencyLockedToast' => 'A moeda não pode ser alterada após o registro de transações. Redefina os dados se desejar alterá-la.',
			'shared.authRequired' => 'Autenticação necessária',
			'shared.hexColorCode' => 'Código Hex da cor',
			'shared.apply' => 'Aplicar',
			'shared.enterAmount' => 'Digite o valor',
			'shared.selectCategory' => 'Selecionar categoria',
			'shared.egFf5733' => 'ex.: FF5733',
			'shared.amount' => 'Valor',
			'shared.noCategoriesAvailable' => 'Nenhuma categoria disponível.',
			'shared.noWalletsFoundPleaseCreateOneFirst' => 'Nenhuma carteira encontrada. Crie uma primeiro.',
			'shared.balance' => 'Saldo: ',
			'shared.optional' => 'Opcional',
			'shared.customColor' => 'Cor personalizada',
			'shared.selectWallet' => 'Selecionar carteira',
			'transactions.searchTransactions' => 'Buscar transações...',
			'transactions.failedToLoad' => 'Falha ao carregar transações',
			'transactions.cancel' => 'Cancelar',
			'transactions.delete' => 'Excluir',
			'transactions.goToToday' => 'Ir para hoje',
			'transactions.addItem' => 'Adicionar item',
			'transactions.saveSplitTransaction' => 'Salvar recibo discriminado',
			'transactions.transactionType' => 'Tipo de transação',
			'transactions.applyFilter' => 'Aplicar filtro',
			'transactions.noAccountsAvailable' => 'Nenhuma conta disponível',
			'transactions.account' => 'Conta',
			'transactions.category' => 'Categoria',
			'transactions.done' => 'Concluído',
			'transactions.save' => 'Salvar',
			'transactions.transactions' => 'Transações',
			'transactions.splitTransaction' => 'Recibo discriminado',
			'transactions.from' => 'De',
			'transactions.to' => 'Para',
			'transactions.empty' => '+/-',
			'transactions.filtered' => 'Filtrado',
			'transactions.netBalance' => 'Saldo líquido',
			'transactions.income' => 'Receita',
			'transactions.expense' => 'Despesa',
			'transactions.selectCategory' => 'Selecionar categoria',
			'transactions.filter' => 'Filtrar',
			'transactions.backToToday' => 'Voltar para hoje',
			'transactions.deleteTransaction' => 'Excluir transação',
			'transactions.deleteTransactionWarning' => 'Excluir esta transação reverterá o saldo da conta e o orçamento para o estado anterior.',
			'transactions.out' => 'Saída ',
			'transactions.noTransactions' => 'Sem transações',
			'transactions.addNote' => 'Adicionar nota',
			'transactions.noItemsYet' => 'Nenhum item ainda',
			'transactions.tapAddItemToBeginSplittingntheTransaction' => 'Toque em "Adicionar item" para discriminar este recibo em categorias.',
			'transactions.addAtLeastOneMoreItemToSave' => 'Adicione pelo menos mais um item para salvar.',
			'transactions.noTransactions1' => 'Sem transações',
			'transactions.reset' => 'Redefinir',
			'transactions.incoming' => 'Entrada ',
			'transactions.nothingRecordedFor' => ({required Object period}) => 'Nada registrado para ${period}.',
			'transactions.splitItems' => ({required Object count}) => '${count} itens do recibo',
			'transactions.itemsCount' => ({required Object count}) => '${count} item(ns)',
			'transactions.transactionsCount' => ({required Object count}) => '${count} transações',
			'transactions.editTransaction' => 'Editar transação',
			'transactions.newTransaction' => 'Nova transação',
			'transactions.fromAccount' => 'Da conta',
			'transactions.toAccount' => 'Para a conta',
			'transactions.need' => 'Necessidade',
			'transactions.want' => 'Desejo',
			'transactions.saving' => 'Poupança',
			'transactions.addNoteEllipsis' => 'Adicionar nota...',
			'transactions.editItem' => 'Editar item',
			'transactions.newItem' => 'Novo item',
			'transactions.viewModeDay' => 'Dia',
			'transactions.viewModeWeek' => 'Semana',
			'transactions.viewModeMonth' => 'Mês',
			'transactions.viewModeDaily' => 'Diário',
			'transactions.viewModeWeekly' => 'Semanal',
			'transactions.viewModeMonthly' => 'Mensal',
			'transactions.debt' => 'Dívida',
			'transactions.recurring' => 'Recorrente',
			'transactions.transfer' => 'Transferência',
			'transactions.weekNumber' => ({required Object weekNum, required Object date}) => 'Semana ${weekNum} · ${date}',
			'transactions.insufficientBalance' => 'Saldo insuficiente',
			'transactions.insufficientBalanceWarning' => ({required Object amount, required Object account, required Object balance}) => 'O valor (${amount}) excede o saldo atual em ${account} (${balance}). Talvez você tenha esquecido de registrar a receita primeiro?',
			'transactions.insufficientBalanceConsequence' => 'O saldo da sua conta ficará negativo se você prosseguir.',
			'transactions.continueAnyway' => 'Continuar mesmo assim',
			'transactions.checkAgain' => 'Verificar novamente',
			'transactions.transactionDeleted' => 'Transação excluída',
			'transactions.transactionRestored' => 'Transação restaurada',
			'transactions.allocation' => 'Alocação',
			_ => null,
		};
	}
}
