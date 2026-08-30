import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/domain/i_budget_repository.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_progress_provider.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';

class MockBudgetRepository extends Mock implements IBudgetRepository {}

class MockTransactionListNotifier extends TransactionListNotifier with Mock {
  @override
  TransactionListState build() => TransactionListState(focusedDate: DateTime.now());
}

void main() {
  late MockBudgetRepository mockRepo;
  late ProviderContainer container;

  setUp(() {
    mockRepo = MockBudgetRepository();
    container = ProviderContainer(
      overrides: [
        budgetRepositoryProvider.overrideWithValue(mockRepo),
        transactionListNotifierProvider.overrideWith(() => MockTransactionListNotifier()),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  BudgetModel createBudget(BudgetPeriod period, {int? resetDay, DateTime? startDate, DateTime? endDate}) {
    final now = DateTime.now();
    return BudgetModel(
      id: 'b1',
      name: 'Test',
      amount: 1000,
      period: period,
      startDate: startDate ?? now,
      endDate: endDate,
      categoryId: 'c1',
      accountId: 'a1',
      resetDay: resetDay,
      createdAt: now,
      updatedAt: now,
    );
  }

  group('budgetProgressProvider', () {
    test('monthly period with day >= resetDay', () async {
      when(
        () => mockRepo.getSpentAmountForBudget(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          categoryId: 'c1',
          accountId: 'a1',
        ),
      ).thenAnswer((_) async => const Success(500));

      final budget = createBudget(BudgetPeriod.monthly, resetDay: 1);
      final spent = await container.read(budgetProgressProvider(budget).future);
      expect(spent, 500);
    });

    test('monthly period with day < resetDay', () async {
      when(
        () => mockRepo.getSpentAmountForBudget(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          categoryId: 'c1',
          accountId: 'a1',
        ),
      ).thenAnswer((_) async => const Success(200));

      final budget = createBudget(BudgetPeriod.monthly, resetDay: 31);
      final spent = await container.read(budgetProgressProvider(budget).future);
      expect(spent, 200);
    });

    test('weekly period', () async {
      when(
        () => mockRepo.getSpentAmountForBudget(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          categoryId: 'c1',
          accountId: 'a1',
        ),
      ).thenAnswer((_) async => const Success(100));

      final budget = createBudget(BudgetPeriod.weekly);
      final spent = await container.read(budgetProgressProvider(budget).future);
      expect(spent, 100);
    });

    test('yearly period', () async {
      when(
        () => mockRepo.getSpentAmountForBudget(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          categoryId: 'c1',
          accountId: 'a1',
        ),
      ).thenAnswer((_) async => const Success(900));

      final budget = createBudget(BudgetPeriod.yearly);
      final spent = await container.read(budgetProgressProvider(budget).future);
      expect(spent, 900);
    });

    test('custom period', () async {
      when(
        () => mockRepo.getSpentAmountForBudget(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          categoryId: 'c1',
          accountId: 'a1',
        ),
      ).thenAnswer((_) async => const Success(150));

      final budget = createBudget(BudgetPeriod.custom, startDate: DateTime(2020), endDate: DateTime(2021));
      final spent = await container.read(budgetProgressProvider(budget).future);
      expect(spent, 150);
    });

    test('returns 0 on ErrorResult', () async {
      when(
        () => mockRepo.getSpentAmountForBudget(
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
          categoryId: 'c1',
          accountId: 'a1',
        ),
      ).thenAnswer((_) async => const ErrorResult(DatabaseFailure('fail')));

      final budget = createBudget(BudgetPeriod.yearly);
      final spent = await container.read(budgetProgressProvider(budget).future);
      expect(spent, 0);
    });
  });
}
