import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/features/budgets/domain/i_budget_repository.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_list_notifier.dart';
import 'package:poka_ce/features/categories/domain/i_category_repository.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/debts/domain/i_debt_repository.dart';
import 'package:poka_ce/features/debts/presentation/controllers/debt_list_notifier.dart';
import 'package:poka_ce/features/goals/domain/i_goal_repository.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_notifier.dart';
import 'package:poka_ce/features/recurring/domain/i_recurring_repository.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_list_notifier.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';

class MockBudgetRepo extends Mock implements IBudgetRepository {}

class MockCategoryRepo extends Mock implements ICategoryRepository {}

class MockDebtRepo extends Mock implements IDebtRepository {}

class MockGoalRepo extends Mock implements IGoalRepository {}

class MockRecurringRepo extends Mock implements IRecurringRepository {}

class MockTransactionRepo extends Mock implements ITransactionRepository {}

class MockAccountRepo extends Mock implements IAccountRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  void stubTxWatch(
    MockTransactionRepo mock,
    Result<List<TransactionModel>, Failure> result,
  ) {
    when(
      () => mock.watchTransactions(
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
        accountIds: any(named: 'accountIds'),
        categoryIds: any(named: 'categoryIds'),
        types: any(named: 'types'),
      ),
    ).thenAnswer((_) => Stream.value(result));
  }

  group('List notifiers error branches', () {
    test('BudgetListNotifier handles Failure', () async {
      final mock = MockBudgetRepo();
      when(() => mock.getBudgets()).thenAnswer((_) async => const ErrorResult(DatabaseFailure('boom')));
      final container = ProviderContainer(overrides: [budgetRepositoryProvider.overrideWithValue(mock)]);
      container.listen(budgetListProvider, (_, __) {});
      addTearDown(container.dispose);
      await container.read(budgetListProvider.notifier).refresh();
      expect(container.read(budgetListProvider).hasError, true);
    });

    test('CategoryListNotifier handles Failure', () async {
      final mock = MockCategoryRepo();
      when(() => mock.getActiveCategories()).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = ProviderContainer(overrides: [categoryRepositoryProvider.overrideWithValue(mock)]);
      container.listen(categoryListProvider, (_, __) {});
      addTearDown(container.dispose);
      await container.read(categoryListProvider.notifier).refresh();
      expect(container.read(categoryListProvider).hasError, true);
    });

    test('DebtListNotifier handles Failure', () async {
      final mock = MockDebtRepo();
      when(() => mock.watchDebts()).thenAnswer((_) => Stream.error(Exception('fail')));
      final container = ProviderContainer(overrides: [debtRepositoryProvider.overrideWithValue(mock)]);
      container.listen(debtListProvider, (_, __) {});
      addTearDown(container.dispose);
      await Future.delayed(const Duration(milliseconds: 50));
      expect(container.read(debtListProvider).hasError, true);
    });

    test('GoalNotifier handles Failure', () async {
      final mock = MockGoalRepo();
      when(() => mock.watchGoals()).thenAnswer((_) => Stream.error(Exception('fail')));
      final container = ProviderContainer(overrides: [goalRepositoryProvider.overrideWithValue(mock)]);
      container.listen(goalProvider, (_, __) {});
      addTearDown(container.dispose);
      await Future.delayed(const Duration(milliseconds: 50));
      expect(container.read(goalProvider).hasError, true);
    });

    test('RecurringListNotifier handles Failure', () async {
      final mock = MockRecurringRepo();
      when(() => mock.getRecurringTransactions()).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));
      final container = ProviderContainer(overrides: [recurringRepositoryProvider.overrideWithValue(mock)]);
      container.listen(recurringListProvider, (_, __) {});
      addTearDown(container.dispose);
      await container.read(recurringListProvider.notifier).refresh();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(container.read(recurringListProvider).error, 'fail');
      expect(container.read(recurringListProvider).isLoading, false);
    });

    test('TransactionListNotifier handles Failure', () async {
      final mock = MockTransactionRepo();
      stubTxWatch(mock, const ErrorResult(DatabaseFailure('fail')));
      final container = ProviderContainer(overrides: [transactionRepositoryProvider.overrideWithValue(mock)]);
      container.listen(transactionListNotifierProvider, (_, __) {});
      addTearDown(container.dispose);
      await container.read(transactionListNotifierProvider.notifier).refresh();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(container.read(transactionListNotifierProvider).isLoading, false);
      expect(container.read(transactionListNotifierProvider).transactions, isEmpty);
    });

    test('TransactionListNotifier refresh', () async {
      final mock = MockTransactionRepo();
      stubTxWatch(mock, const Success([]));
      final container = ProviderContainer(overrides: [transactionRepositoryProvider.overrideWithValue(mock)]);
      container.listen(transactionListNotifierProvider, (_, __) {});
      addTearDown(container.dispose);
      final notifier = container.read(transactionListNotifierProvider.notifier);
      await notifier.refresh();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(container.read(transactionListNotifierProvider).isLoading, false);
    });

    test('copyWith covers isLoading branches for remaining list states', () {
      const r = RecurringListState(isLoading: false, error: 'e', recurrings: []);
      expect(r.copyWith(isLoading: true).isLoading, true);
      expect(r.copyWith(isLoading: true).error, 'e');

      final t = TransactionListState(
        isLoading: false,
        transactions: const [],
        focusedDate: DateTime.utc(2024, 1, 1),
      );
      expect(t.copyWith(isLoading: true).isLoading, true);
      expect(t.copyWith(transactions: const []).transactions, isEmpty);
    });
  });
}
