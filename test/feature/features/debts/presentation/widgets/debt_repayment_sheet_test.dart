import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/use_case_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/presentation/widgets/debt_repayment_sheet.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/create_transaction_use_case.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class MockCreateTransactionUseCase extends Mock implements CreateTransactionUseCase {}

class FakeTransactionModel extends Fake implements TransactionModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
    registerFallbackValue(FakeTransactionModel());
    registerFallbackValue(TransactionType.expense);
  });

  late MockCreateTransactionUseCase mockCreate;

  setUp(() {
    mockCreate = MockCreateTransactionUseCase();
    when(
      () => mockCreate.execute(
        type: any(named: 'type'),
        accountId: any(named: 'accountId'),
        amount: any(named: 'amount'),
        debtId: any(named: 'debtId'),
        note: any(named: 'note'),
        transactionDate: any(named: 'transactionDate'),
        categoryId: any(named: 'categoryId'),
        allocation: any(named: 'allocation'),
        splitItems: any(named: 'splitItems'),
      ),
    ).thenAnswer((_) async {
      final now = DateTime.utc(2024, 1, 1);
      return Success(
        TransactionModel(
          id: 'tx1',
          accountId: 'a1',
          type: TransactionType.expense,
          amount: 100,
          transactionDate: now,
          createdAt: now,
          updatedAt: now,
        ),
      );
    });
  });

  List<AccountModel> sampleAccounts() => [
    AccountModel(
      id: 'a1',
      name: 'Wallet',
      type: AccountType.assets,
      balance: 100000,
      createdAt: DateTime.utc(2024, 1, 1),
      updatedAt: DateTime.utc(2024, 1, 1),
    ),
    AccountModel(
      id: 'a2',
      name: 'Bank',
      type: AccountType.assets,
      balance: 50000,
      createdAt: DateTime.utc(2024, 1, 1),
      updatedAt: DateTime.utc(2024, 1, 1),
    ),
  ];

  DebtModel sampleDebt({DebtType type = DebtType.debt}) => DebtModel(
    id: 'd1',
    personName: 'Alice',
    type: type,
    amount: 1000,
    remainingAmount: 1000,
    status: DebtStatus.active,
    createdAt: DateTime.utc(2024, 1, 1),
    updatedAt: DateTime.utc(2024, 1, 1),
    note: 'dinner',
  );

  Widget buildWidget(DebtModel debt) {
    return ProviderScope(
      overrides: [
        createTransactionUseCaseProvider.overrideWithValue(mockCreate),
        dashboardProvider.overrideWith(
          () => _FakeDashboardNotifier(
            DashboardState(accounts: sampleAccounts(), isLoading: false),
          ),
        ),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: Scaffold(
            body: SingleChildScrollView(child: DebtRepaymentSheet(debt: debt)),
          ),
        ),
      ),
    );
  }

  Widget buildShowWidget(DebtModel debt) {
    return ProviderScope(
      overrides: [
        createTransactionUseCaseProvider.overrideWithValue(mockCreate),
        dashboardProvider.overrideWith(
          () => _FakeDashboardNotifier(
            DashboardState(accounts: sampleAccounts(), isLoading: false),
          ),
        ),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () => DebtRepaymentSheet.show(context, debt),
                child: const Text('OpenRepayment'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  group('DebtRepaymentSheet', () {
    testWidgets('renders date nav, account shelf, amount display and numpad', (tester) async {
      await tester.pumpWidget(buildWidget(sampleDebt()));
      await tester.pumpAndSettle();

      expect(find.text('Pay in Full'), findsOneWidget);
      expect(find.text('Wallet'), findsOneWidget);
      expect(find.text('Bank'), findsOneWidget);
      expect(find.byKey(const Key('numpad-7')), findsOneWidget);
      expect(find.byKey(const Key('numpad-ok')), findsOneWidget);
    });

    testWidgets('pay in full sets amount to remaining amount', (tester) async {
      await tester.pumpWidget(buildWidget(sampleDebt()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Pay in Full'));
      await tester.pumpAndSettle();

      expect(find.text('1,000'), findsWidgets);
    });

    testWidgets('numpad keys update the amount expression', (tester) async {
      await tester.pumpWidget(buildWidget(sampleDebt()));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('numpad-2')));
      await tester.pumpAndSettle();
      expect(find.text('2'), findsWidgets);

      await tester.tap(find.byKey(const Key('numpad-5')));
      await tester.pumpAndSettle();
      expect(find.text('25'), findsWidgets);
    });

    testWidgets('OK with amount exceeding remaining shows denied dialog and skips save', (tester) async {
      await tester.pumpWidget(buildWidget(sampleDebt()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Pay in Full'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad-5')));
      await tester.pumpAndSettle();
      // amount is now 10005 > 1000
      await tester.tap(find.byKey(const Key('numpad-ok')));
      await tester.pumpAndSettle();

      expect(find.text('Action Denied'), findsOneWidget);
      verifyNever(
        () => mockCreate.execute(
          type: any(named: 'type'),
          accountId: any(named: 'accountId'),
          amount: any(named: 'amount'),
          debtId: any(named: 'debtId'),
          note: any(named: 'note'),
          transactionDate: any(named: 'transactionDate'),
          categoryId: any(named: 'categoryId'),
          allocation: any(named: 'allocation'),
          splitItems: any(named: 'splitItems'),
        ),
      );
    });

    testWidgets('OK with valid amount saves repayment and closes sheet', (tester) async {
      await tester.pumpWidget(buildShowWidget(sampleDebt()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('OpenRepayment'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Pay in Full'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad-ok')));
      await tester.pumpAndSettle();

      final captured = verify(
        () => mockCreate.execute(
          type: captureAny(named: 'type'),
          accountId: any(named: 'accountId'),
          amount: captureAny(named: 'amount'),
          debtId: captureAny(named: 'debtId'),
          note: captureAny(named: 'note'),
          transactionDate: any(named: 'transactionDate'),
          categoryId: any(named: 'categoryId'),
          allocation: any(named: 'allocation'),
          splitItems: any(named: 'splitItems'),
        ),
      ).captured;
      expect(captured[0], TransactionType.expense);
      expect(captured[1], 1000);
      expect(captured[2], 'd1');
      expect(captured[3], 'Repayment for Alice');
      // Sheet should be closed after successful save
      expect(find.text('Pay in Full'), findsNothing);
    });

    testWidgets('loan repayment saves as income', (tester) async {
      await tester.pumpWidget(buildShowWidget(sampleDebt(type: DebtType.loan)));
      await tester.pumpAndSettle();

      await tester.tap(find.text('OpenRepayment'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Pay in Full'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad-ok')));
      await tester.pumpAndSettle();

      final captured = verify(
        () => mockCreate.execute(
          type: captureAny(named: 'type'),
          accountId: any(named: 'accountId'),
          amount: any(named: 'amount'),
          debtId: any(named: 'debtId'),
          note: any(named: 'note'),
          transactionDate: any(named: 'transactionDate'),
          categoryId: any(named: 'categoryId'),
          allocation: any(named: 'allocation'),
          splitItems: any(named: 'splitItems'),
        ),
      ).captured;
      expect(captured[0], TransactionType.income);
    });

    testWidgets('selecting another account uses it as source', (tester) async {
      await tester.pumpWidget(buildShowWidget(sampleDebt()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('OpenRepayment'));
      await tester.pumpAndSettle();

      // The sheet auto-selects the first account via microtask.
      await tester.tap(find.text('Bank'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Pay in Full'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad-ok')));
      await tester.pumpAndSettle();

      final captured = verify(
        () => mockCreate.execute(
          type: any(named: 'type'),
          accountId: captureAny(named: 'accountId'),
          amount: any(named: 'amount'),
          debtId: any(named: 'debtId'),
          note: any(named: 'note'),
          transactionDate: any(named: 'transactionDate'),
          categoryId: any(named: 'categoryId'),
          allocation: any(named: 'allocation'),
          splitItems: any(named: 'splitItems'),
        ),
      ).captured;
      expect(captured[0], 'a2');
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
