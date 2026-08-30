import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/budgets/domain/budget_alert_service.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/domain/i_budget_repository.dart';

class MockBudgetRepository extends Mock implements IBudgetRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockBudgetRepository mockRepo;
  late BudgetAlertService service;

  setUp(() {
    mockRepo = MockBudgetRepository();
    service = BudgetAlertService(budgetRepository: mockRepo);
  });

  BudgetModel budget({
    int? alertThreshold,
    BudgetPeriod period = BudgetPeriod.monthly,
    int amount = 1000,
    DateTime? endDate,
  }) => BudgetModel(
    id: 'b1',
    name: 'Food',
    amount: amount,
    period: period,
    startDate: DateTime(2026, 1, 1),
    endDate: endDate,
    categoryId: 'c1',
    accountId: 'a1',
    alertThreshold: alertThreshold,
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
  );

  test('returns early when getBudgets fails', () async {
    when(() => mockRepo.getBudgets()).thenAnswer(
      (_) async => const ErrorResult<List<BudgetModel>, Failure>(DatabaseFailure('boom')),
    );

    await service.checkAlerts();
    verify(() => mockRepo.getBudgets()).called(1);
    verifyNever(
      () => mockRepo.getSpentAmountForBudget(
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
        categoryId: any(named: 'categoryId'),
        accountId: any(named: 'accountId'),
      ),
    );
  });

  test('skips budgets without an alert threshold', () async {
    when(() => mockRepo.getBudgets()).thenAnswer(
      (_) async => Success<List<BudgetModel>, Failure>([
        budget(),
        budget(alertThreshold: 0),
      ]),
    );

    await service.checkAlerts();
    verifyNever(
      () => mockRepo.getSpentAmountForBudget(
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
        categoryId: any(named: 'categoryId'),
        accountId: any(named: 'accountId'),
      ),
    );
  });

  test('does not notify when spending is below threshold', () async {
    when(() => mockRepo.getBudgets()).thenAnswer(
      (_) async => Success<List<BudgetModel>, Failure>([
        budget(alertThreshold: 80),
      ]),
    );
    when(
      () => mockRepo.getSpentAmountForBudget(
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
        categoryId: any(named: 'categoryId'),
        accountId: any(named: 'accountId'),
      ),
    ).thenAnswer((_) async => const Success<int, Failure>(500)); // 50% < 80%

    await service.checkAlerts();
  });

  test('triggers notification path when spending exceeds threshold', () async {
    when(() => mockRepo.getBudgets()).thenAnswer(
      (_) async => Success<List<BudgetModel>, Failure>([
        budget(alertThreshold: 80),
      ]),
    );
    when(
      () => mockRepo.getSpentAmountForBudget(
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
        categoryId: any(named: 'categoryId'),
        accountId: any(named: 'accountId'),
      ),
    ).thenAnswer((_) async => const Success<int, Failure>(900)); // 90% >= 80%

    await service.checkAlerts();
  });

  test('handles weekly, yearly and custom periods', () async {
    when(() => mockRepo.getBudgets()).thenAnswer(
      (_) async => Success<List<BudgetModel>, Failure>([
        budget(alertThreshold: 50, period: BudgetPeriod.weekly),
        budget(alertThreshold: 50, period: BudgetPeriod.yearly),
        budget(alertThreshold: 50, period: BudgetPeriod.custom, endDate: null),
      ]),
    );
    when(
      () => mockRepo.getSpentAmountForBudget(
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
        categoryId: any(named: 'categoryId'),
        accountId: any(named: 'accountId'),
      ),
    ).thenAnswer((_) async => const Success<int, Failure>(100));

    await service.checkAlerts();
  });

  test('skips budget when spent query fails', () async {
    when(() => mockRepo.getBudgets()).thenAnswer(
      (_) async => Success<List<BudgetModel>, Failure>([
        budget(alertThreshold: 50),
      ]),
    );
    when(
      () => mockRepo.getSpentAmountForBudget(
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
        categoryId: any(named: 'categoryId'),
        accountId: any(named: 'accountId'),
      ),
    ).thenAnswer(
      (_) async => const ErrorResult<int, Failure>(DatabaseFailure('boom')),
    );

    await service.checkAlerts();
  });
}
