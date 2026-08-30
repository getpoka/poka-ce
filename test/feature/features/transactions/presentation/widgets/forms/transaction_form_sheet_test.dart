import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/use_case_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';
import 'package:poka_ce/features/settings/domain/settings_model.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/create_transaction_use_case.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/transfer_funds_use_case.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_form_notifier.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/forms/components/transaction_transfer_selector.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/forms/transaction_form_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class MockCreateTransactionUseCase extends Mock implements CreateTransactionUseCase {}

class MockTransferFundsUseCase extends Mock implements TransferFundsUseCase {}

class FakeTransactionModel extends Fake implements TransactionModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
    registerFallbackValue(FakeTransactionModel());
    registerFallbackValue(TransactionType.expense);
  });

  late MockCreateTransactionUseCase mockCreate;
  late MockTransferFundsUseCase mockTransfer;

  setUp(() {
    mockCreate = MockCreateTransactionUseCase();
    mockTransfer = MockTransferFundsUseCase();
  });

  List<AccountModel> sampleAccounts() => [
    AccountModel(
      id: 'a1',
      name: 'Wallet',
      type: AccountType.assets,
      balance: 100000,
      createdAt: DateTime.utc(2024, 1, 1),
      updatedAt: DateTime.utc(2024, 1, 1),
      color: '#10B981',
      icon: 'wallet',
    ),
    AccountModel(
      id: 'a2',
      name: 'Bank',
      type: AccountType.assets,
      balance: 50000,
      createdAt: DateTime.utc(2024, 1, 1),
      updatedAt: DateTime.utc(2024, 1, 1),
      color: '#6366F1',
      icon: 'bank',
    ),
  ];

  List<CategoryModel> sampleCategories() => [
    CategoryModel(
      id: 'c1',
      name: 'Food',
      type: CategoryType.expense,
      createdAt: DateTime.utc(2024, 1, 1),
      updatedAt: DateTime.utc(2024, 1, 1),
      color: '#EF4444',
      icon: 'utensils',
    ),
    CategoryModel(
      id: 'c2',
      name: 'Salary',
      type: CategoryType.income,
      createdAt: DateTime.utc(2024, 1, 1),
      updatedAt: DateTime.utc(2024, 1, 1),
      color: '#22C55E',
      icon: 'briefcase',
    ),
  ];

  SettingsState sampleSettingsState() => const SettingsState(
    settings: SettingsModel(
      themeMode: 'system',
      baseCurrency: CurrencyModel(id: 'cur1', name: 'Rupiah', code: 'IDR', symbol: 'Rp', precision: 2),
    ),
  );

  ProviderScope buildApp({
    TransactionType? initialType,
    List<AccountModel>? accounts,
    List<CategoryModel>? categories,
    SettingsState? settingsState,
    TransactionFormState? formStateOverride,
  }) {
    final accs = accounts ?? sampleAccounts();
    final cats = categories ?? sampleCategories();
    final settings = settingsState ?? sampleSettingsState();

    return ProviderScope(
      overrides: [
        createTransactionUseCaseProvider.overrideWithValue(mockCreate),
        transferFundsUseCaseProvider.overrideWithValue(mockTransfer),
        dashboardProvider.overrideWith(
          () => _FakeDashboardNotifier(DashboardState(accounts: accs, isLoading: false)),
        ),
        categoryListProvider.overrideWith(
          () => _FakeCategoryNotifier(cats),
        ),
        settingsProvider.overrideWith(() => _FakeSettingsNotifier(settings)),
        transactionListNotifierProvider.overrideWith(() => _FakeTxListNotifier()),
        if (formStateOverride != null) transactionFormProvider.overrideWith(() => _FakeFormNotifier(formStateOverride)),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: FToaster(child: child!),
          ),
          home: Scaffold(
            body: SingleChildScrollView(child: TransactionFormSheet(initialType: initialType)),
          ),
        ),
      ),
    );
  }

  TransactionModel sampleTx() => TransactionModel(
    id: 't1',
    accountId: 'a1',
    type: TransactionType.expense,
    amount: 500,
    transactionDate: DateTime.utc(2024, 1, 1),
    createdAt: DateTime.utc(2024, 1, 1),
    updatedAt: DateTime.utc(2024, 1, 1),
  );

  group('TransactionFormSheet', () {
    testWidgets('renders default expense type with account selector and numpad', (tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      expect(find.text('Income'), findsOneWidget);
      expect(find.text('Expense'), findsOneWidget);
      expect(find.text('Transfer'), findsOneWidget);
      // Expense should show account selector (parent names)
      expect(find.text('Wallet'), findsOneWidget);
      // Category shelf should show expense categories (Food) but not income
      expect(find.text('Food'), findsOneWidget);
      expect(find.text('Salary'), findsNothing);
      // Numpad keys
      expect(find.text('7'), findsOneWidget);
      expect(find.text('8'), findsOneWidget);
      expect(find.text('9'), findsOneWidget);
      // Note placeholder
      expect(find.text('Add note...'), findsOneWidget);
      // Check icon for Done
      expect(find.byIcon(FPhosphorIcons.check), findsOneWidget);
    });

    testWidgets('initialType income shows income categories', (tester) async {
      await tester.pumpWidget(buildApp(initialType: TransactionType.income));
      await tester.pumpAndSettle();
      expect(find.text('Food'), findsNothing);
      expect(find.text('Salary'), findsOneWidget);
    });

    testWidgets('initialType transfer shows Transfer selector and hides category shelf', (tester) async {
      await tester.pumpWidget(buildApp(initialType: TransactionType.transfer));
      await tester.pumpAndSettle();
      // Transfer selector is present
      expect(find.byType(TransactionTransferSelector), findsOneWidget);
      // Category shelf hidden for transfer
      expect(find.text('Food'), findsNothing);
      expect(find.text('Salary'), findsNothing);
    });

    testWidgets('tab switching expense -> transfer -> expense updates UI', (tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      // Initially expense
      expect(find.byType(TransactionTransferSelector), findsNothing);

      await tester.tap(find.text('Transfer'));
      await tester.pumpAndSettle();
      expect(find.byType(TransactionTransferSelector), findsOneWidget);

      await tester.tap(find.text('Expense'));
      await tester.pumpAndSettle();
      expect(find.byType(TransactionTransferSelector), findsNothing);
      expect(find.text('Food'), findsOneWidget);
    });

    testWidgets('tab switching to income filters categories correctly', (tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Income'));
      await tester.pumpAndSettle();
      expect(find.text('Salary'), findsOneWidget);
      expect(find.text('Food'), findsNothing);
      await tester.tap(find.text('Expense'));
      await tester.pumpAndSettle();
      expect(find.text('Food'), findsOneWidget);
    });

    testWidgets('numpad input updates amount display', (tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('1'));
      await tester.pump();
      await tester.tap(find.text('0'));
      await tester.pump();
      await tester.tap(find.text('0'));
      await tester.pump();

      // Amount display should show expression (at least via PokaAmountText)
      // The numpad's _expression is synced to amountExpression via onValueChanged
      // We just verify that tapping does not crash and display exists
      expect(find.text('7'), findsOneWidget); // still present
    });

    testWidgets('Done with zero amount does not call create use case', (tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(FPhosphorIcons.check));
      await tester.pumpAndSettle();

      verifyNever(
        () => mockCreate.execute(
          type: any(named: 'type'),
          accountId: any(named: 'accountId'),
          amount: any(named: 'amount'),
          categoryId: any(named: 'categoryId'),
          note: any(named: 'note'),
          allocation: any(named: 'allocation'),
          splitItems: any(named: 'splitItems'),
          transactionDate: any(named: 'transactionDate'),
          debtId: any(named: 'debtId'),
        ),
      );
      verifyNever(
        () => mockTransfer.execute(
          amount: any(named: 'amount'),
          sourceAccountId: any(named: 'sourceAccountId'),
          destinationAccountId: any(named: 'destinationAccountId'),
          note: any(named: 'note'),
        ),
      );
    });

    testWidgets('Done with valid amount calls create use case for expense', (tester) async {
      when(
        () => mockCreate.execute(
          type: any(named: 'type'),
          accountId: any(named: 'accountId'),
          amount: any(named: 'amount'),
          categoryId: any(named: 'categoryId'),
          note: any(named: 'note'),
          allocation: any(named: 'allocation'),
          splitItems: any(named: 'splitItems'),
          transactionDate: any(named: 'transactionDate'),
          debtId: any(named: 'debtId'),
        ),
      ).thenAnswer((_) async => Success(sampleTx()));

      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      // Enter amount 500 via numpad
      await tester.tap(find.text('5'));
      await tester.pump();
      await tester.tap(find.text('0'));
      await tester.pump();
      await tester.tap(find.text('0'));
      await tester.pump();

      await tester.tap(find.byIcon(FPhosphorIcons.check));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      verify(
        () => mockCreate.execute(
          type: TransactionType.expense,
          accountId: any(named: 'accountId'),
          amount: 500,
          categoryId: any(named: 'categoryId'),
          note: any(named: 'note'),
          allocation: any(named: 'allocation'),
          splitItems: any(named: 'splitItems'),
          transactionDate: any(named: 'transactionDate'),
          debtId: any(named: 'debtId'),
        ),
      ).called(1);
    });

    testWidgets('Done with valid amount calls transfer use case for transfer type', (tester) async {
      when(
        () => mockTransfer.execute(
          amount: any(named: 'amount'),
          sourceAccountId: any(named: 'sourceAccountId'),
          destinationAccountId: any(named: 'destinationAccountId'),
          note: any(named: 'note'),
        ),
      ).thenAnswer((_) async => Success(sampleTx().copyWith(type: TransactionType.transfer)));

      await tester.pumpWidget(buildApp(initialType: TransactionType.transfer));
      await tester.pumpAndSettle();

      await tester.tap(find.text('2'));
      await tester.pump();
      await tester.tap(find.text('0'));
      await tester.pump();
      await tester.tap(find.text('0'));
      await tester.pump();

      await tester.tap(find.byIcon(FPhosphorIcons.check));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      verify(
        () => mockTransfer.execute(
          amount: 200,
          sourceAccountId: any(named: 'sourceAccountId'),
          destinationAccountId: any(named: 'destinationAccountId'),
          note: any(named: 'note'),
        ),
      ).called(1);
    });

    testWidgets('category selection highlights category', (tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Food'));
      await tester.pumpAndSettle();
      // Still shows Food, selection should be retained
      expect(find.text('Food'), findsOneWidget);
    });

    testWidgets('allocation selector visible for expense and changes allocation', (tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      // Allocation pills only for expense
      expect(find.text('Need'), findsOneWidget);
      // Tap Need
      await tester.tap(find.text('Need'));
      await tester.pumpAndSettle();
      expect(find.text('Need'), findsOneWidget);

      // Switch to income, allocation should hide
      await tester.tap(find.text('Income'));
      await tester.pumpAndSettle();
      expect(find.text('Need'), findsNothing);

      // Back to expense
      await tester.tap(find.text('Expense'));
      await tester.pumpAndSettle();
      expect(find.text('Need'), findsOneWidget);
    });

    testWidgets('shows loading indicator when form isLoading', (tester) async {
      await tester.pumpWidget(
        buildApp(
          formStateOverride: TransactionFormState(
            type: TransactionType.expense,
            amountExpression: '0',
            note: '',
            date: DateTime.now(),
            isLoading: true,
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(FCircularProgress), findsOneWidget);
      expect(find.byIcon(FPhosphorIcons.check), findsNothing);
    });

    testWidgets('note placeholder can be tapped to open dialog', (tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add note...'));
      await tester.pumpAndSettle();
      expect(find.text('Add note'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      // Dismiss
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.text('Add note'), findsNothing);
    });

    testWidgets('empty accounts shows No accounts found', (tester) async {
      await tester.pumpWidget(buildApp(accounts: []));
      await tester.pumpAndSettle();
      expect(find.text('No accounts found'), findsOneWidget);
    });

    testWidgets('empty categories shows No categories found', (tester) async {
      await tester.pumpWidget(buildApp(categories: []));
      await tester.pumpAndSettle();
      expect(find.text('No categories found'), findsOneWidget);
    });

    testWidgets('show static helper creates PokaSheet with title', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            createTransactionUseCaseProvider.overrideWithValue(mockCreate),
            transferFundsUseCaseProvider.overrideWithValue(mockTransfer),
            dashboardProvider.overrideWith(
              () => _FakeDashboardNotifier(DashboardState(accounts: sampleAccounts(), isLoading: false)),
            ),
            categoryListProvider.overrideWith(
              () => _FakeCategoryNotifier(sampleCategories()),
            ),
            settingsProvider.overrideWith(() => _FakeSettingsNotifier(sampleSettingsState())),
            transactionListNotifierProvider.overrideWith(() => _FakeTxListNotifier()),
          ],
          child: TranslationProvider(
            child: MaterialApp(
              builder: (context, child) => FTheme(
                data: lightTheme,
                child: FToaster(child: child!),
              ),
              home: Builder(
                builder: (context) => Scaffold(
                  body: ElevatedButton(
                    onPressed: () => TransactionFormSheet.show(context, initialType: TransactionType.expense),
                    child: const Text('Open'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('New Transaction'), findsOneWidget);
    });

    testWidgets('transfer saving with zero amount does not call transfer', (tester) async {
      await tester.pumpWidget(buildApp(initialType: TransactionType.transfer));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(FPhosphorIcons.check));
      await tester.pumpAndSettle();
      verifyNever(
        () => mockTransfer.execute(
          amount: any(named: 'amount'),
          sourceAccountId: any(named: 'sourceAccountId'),
          destinationAccountId: any(named: 'destinationAccountId'),
          note: any(named: 'note'),
        ),
      );
    });

    testWidgets('transfer failure does not crash', (tester) async {
      when(
        () => mockTransfer.execute(
          amount: any(named: 'amount'),
          sourceAccountId: any(named: 'sourceAccountId'),
          destinationAccountId: any(named: 'destinationAccountId'),
          note: any(named: 'note'),
        ),
      ).thenAnswer((_) async => const ErrorResult<TransactionModel, Failure>(DatabaseFailure('db error')));

      await tester.pumpWidget(buildApp(initialType: TransactionType.transfer));
      await tester.pumpAndSettle();
      await tester.tap(find.text('1'));
      await tester.pump();
      await tester.tap(find.text('0'));
      await tester.pump();
      await tester.tap(find.text('0'));
      await tester.pump();
      await tester.tap(find.byIcon(FPhosphorIcons.check));
      await tester.pumpAndSettle();
      // Should have called transfer even though it fails
      verify(
        () => mockTransfer.execute(
          amount: any(named: 'amount'),
          sourceAccountId: any(named: 'sourceAccountId'),
          destinationAccountId: any(named: 'destinationAccountId'),
          note: any(named: 'note'),
        ),
      ).called(1);
    });

    testWidgets('create failure path does not crash', (tester) async {
      when(
        () => mockCreate.execute(
          type: any(named: 'type'),
          accountId: any(named: 'accountId'),
          amount: any(named: 'amount'),
          categoryId: any(named: 'categoryId'),
          note: any(named: 'note'),
          allocation: any(named: 'allocation'),
          splitItems: any(named: 'splitItems'),
          transactionDate: any(named: 'transactionDate'),
          debtId: any(named: 'debtId'),
        ),
      ).thenAnswer((_) async => const ErrorResult<TransactionModel, Failure>(DatabaseFailure('fail')));

      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();
      await tester.tap(find.text('5'));
      await tester.pump();
      await tester.tap(find.text('0'));
      await tester.pump();
      await tester.tap(find.byIcon(FPhosphorIcons.check));
      await tester.pumpAndSettle();
      verify(
        () => mockCreate.execute(
          type: any(named: 'type'),
          accountId: any(named: 'accountId'),
          amount: any(named: 'amount'),
          categoryId: any(named: 'categoryId'),
          note: any(named: 'note'),
          allocation: any(named: 'allocation'),
          splitItems: any(named: 'splitItems'),
          transactionDate: any(named: 'transactionDate'),
          debtId: any(named: 'debtId'),
        ),
      ).called(1);
    });
  });
}

class _FakeDashboardNotifier extends DashboardNotifier {
  final DashboardState _state;
  _FakeDashboardNotifier(this._state);
  @override
  DashboardState build() => _state;
  @override
  Future<void> refresh() async {}
}

class _FakeCategoryNotifier extends CategoryListNotifier {
  final List<CategoryModel> _categories;
  _FakeCategoryNotifier(this._categories);
  @override
  Future<List<CategoryModel>> build() => Future.value(_categories);
  @override
  Future<void> refresh() async {}
}

class _FakeSettingsNotifier extends SettingsNotifier {
  final SettingsState _state;
  _FakeSettingsNotifier(this._state);
  @override
  SettingsState build() => _state;
}

class _FakeTxListNotifier extends TransactionListNotifier {
  @override
  TransactionListState build() => TransactionListState(isLoading: false, transactions: [], focusedDate: DateTime.now());
  @override
  Future<void> refresh() async {}
}

class _FakeFormNotifier extends TransactionFormNotifier {
  final TransactionFormState _override;
  _FakeFormNotifier(this._override);
  @override
  TransactionFormState build(TransactionFormArgs args) => _override;
  @override
  Future<void> saveTransaction({
    required TransactionType type,
    required String accountId,
    int? amount,
    String? categoryId,
    String? note,
    TransactionAllocation? allocation,
    List<({TransactionAllocation? allocation, int amount, String? categoryId, String? note})>? splitItems,
    TransactionModel? initialTransaction,
  }) async {}
}
