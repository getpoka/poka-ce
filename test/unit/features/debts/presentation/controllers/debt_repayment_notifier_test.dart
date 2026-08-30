import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/use_case_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/presentation/controllers/debt_repayment_notifier.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/create_transaction_use_case.dart';

class MockCreateTransactionUseCase extends Mock implements CreateTransactionUseCase {}

class FakeDashboardNotifier extends DashboardNotifier {
  int refreshCount = 0;
  @override
  DashboardState build() => const DashboardState(isLoading: false);
  @override
  Future<void> refresh() async => refreshCount++;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockCreateTransactionUseCase mockUseCase;
  late FakeDashboardNotifier fakeDashboard;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(TransactionType.expense);
  });

  setUp(() {
    mockUseCase = MockCreateTransactionUseCase();
    fakeDashboard = FakeDashboardNotifier();
    container = ProviderContainer(
      overrides: [
        createTransactionUseCaseProvider.overrideWithValue(mockUseCase),
        dashboardProvider.overrideWith(() => fakeDashboard),
      ],
    );
    addTearDown(container.dispose);
  });

  DebtModel debt(DebtType type) => DebtModel(
    id: 'd1',
    personName: 'Budi',
    type: type,
    amount: 100000,
    remainingAmount: 50000,
    status: DebtStatus.active,
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
  );

  DebtRepaymentNotifier notifier() => container.read(debtRepaymentProvider.notifier);

  group('DebtRepaymentNotifier', () {
    test('initial state has today date and empty expression', () {
      final state = container.read(debtRepaymentProvider);
      expect(state.amountExpression, '');
      expect(state.note, '');
      expect(state.isSaving, false);
      expect(state.accountId, isNull);
    });

    test('setters update state fields', () {
      notifier().setAccountId('a1');
      notifier().setAmountExpression('100');
      notifier().setNote('repay');
      final date = DateTime(2026, 8, 1);
      notifier().setDate(date);

      final state = container.read(debtRepaymentProvider);
      expect(state.accountId, 'a1');
      expect(state.amountExpression, '100');
      expect(state.note, 'repay');
      expect(state.date, date);
    });

    test('setHistoryExpression null clears history', () {
      notifier().setHistoryExpression('50');
      expect(container.read(debtRepaymentProvider).historyExpression, '50');

      notifier().setHistoryExpression(null);
      expect(container.read(debtRepaymentProvider).historyExpression, isNull);
    });

    test('onKeyPressed evaluates expression on equals sign', () {
      notifier().setAmountExpression('100+50');
      notifier().onKeyPressed('=');
      expect(container.read(debtRepaymentProvider).amountExpression, '150');
    });

    test('onKeyPressed OK does not modify expression', () {
      notifier().setAmountExpression('100');
      notifier().onKeyPressed('OK');
      expect(container.read(debtRepaymentProvider).amountExpression, '100');
    });

    test('onKeyPressed appends operator and attempts history preview', () {
      notifier().setAmountExpression('100');
      notifier().onKeyPressed('+');
      final state = container.read(debtRepaymentProvider);
      expect(state.amountExpression, '100+');
    });

    test('saveRepayment returns false when no account selected', () async {
      final ok = await notifier().saveRepayment(debt: debt(DebtType.debt));
      expect(ok, isFalse);
    });

    test('saveRepayment returns false when amount is invalid', () async {
      notifier().setAccountId('a1');
      notifier().setAmountExpression('abc');
      final ok = await notifier().saveRepayment(debt: debt(DebtType.debt));
      expect(ok, isFalse);
    });

    test('saveRepayment creates expense transaction for a debt and refreshes', () async {
      notifier().setAccountId('a1');
      notifier().setAmountExpression('25000');

      when(
        () => mockUseCase.execute(
          type: any(named: 'type'),
          accountId: any(named: 'accountId'),
          amount: any(named: 'amount'),
          debtId: any(named: 'debtId'),
          note: any(named: 'note'),
          transactionDate: any(named: 'transactionDate'),
        ),
      ).thenAnswer(
        (_) async => Success(
          TransactionModel(
            id: 'tx1',
            accountId: 'a1',
            type: TransactionType.expense,
            amount: 25000,
            transactionDate: DateTime(2026, 8, 1),
            createdAt: DateTime(2026, 8, 1),
            updatedAt: DateTime(2026, 8, 1),
          ),
        ),
      );

      final ok = await notifier().saveRepayment(debt: debt(DebtType.debt));

      expect(ok, isTrue);
      expect(fakeDashboard.refreshCount, 1);
      expect(container.read(debtRepaymentProvider).isSaving, isFalse);
      verify(
        () => mockUseCase.execute(
          type: TransactionType.expense,
          accountId: 'a1',
          amount: 25000,
          debtId: 'd1',
          note: 'Repayment for Budi',
          transactionDate: any(named: 'transactionDate'),
        ),
      ).called(1);
    });

    test('saveRepayment creates income transaction for a loan', () async {
      notifier().setAccountId('a1');
      notifier().setAmountExpression('10000');

      when(
        () => mockUseCase.execute(
          type: any(named: 'type'),
          accountId: any(named: 'accountId'),
          amount: any(named: 'amount'),
          debtId: any(named: 'debtId'),
          note: any(named: 'note'),
          transactionDate: any(named: 'transactionDate'),
        ),
      ).thenAnswer(
        (_) async => Success(
          TransactionModel(
            id: 'tx2',
            accountId: 'a1',
            type: TransactionType.income,
            amount: 10000,
            transactionDate: DateTime(2026, 8, 1),
            createdAt: DateTime(2026, 8, 1),
            updatedAt: DateTime(2026, 8, 1),
          ),
        ),
      );

      final ok = await notifier().saveRepayment(debt: debt(DebtType.loan));

      expect(ok, isTrue);
      verify(
        () => mockUseCase.execute(
          type: TransactionType.income,
          accountId: 'a1',
          amount: 10000,
          debtId: 'd1',
          note: any(named: 'note'),
          transactionDate: any(named: 'transactionDate'),
        ),
      ).called(1);
    });

    test('saveRepayment returns false when use case fails', () async {
      notifier().setAccountId('a1');
      notifier().setAmountExpression('25000');

      when(
        () => mockUseCase.execute(
          type: any(named: 'type'),
          accountId: any(named: 'accountId'),
          amount: any(named: 'amount'),
          debtId: any(named: 'debtId'),
          note: any(named: 'note'),
          transactionDate: any(named: 'transactionDate'),
        ),
      ).thenAnswer((_) async => const ErrorResult<TransactionModel, Failure>(DatabaseFailure('boom')));

      final ok = await notifier().saveRepayment(debt: debt(DebtType.debt));

      expect(ok, isFalse);
      expect(container.read(debtRepaymentProvider).isSaving, isFalse);
    });
  });
}
