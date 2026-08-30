// Tests exception-to-Failure translation of BudgetRepositoryImpl by mocking
// its DAO to throw, covering every defensive catch branch.
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/database/daos/budgets_dao.dart';
import 'package:poka_ce/database/database.dart' as db;
import 'package:poka_ce/features/budgets/data/budget_repository_impl.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';

class MockBudgetsDao extends Mock implements BudgetsDao {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockBudgetsDao dao;
  late BudgetRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(const db.BudgetsCompanion());
  });

  setUp(() {
    dao = MockBudgetsDao();
    repository = BudgetRepositoryImpl(dao);
  });

  test('getBudgets returns DatabaseFailure when DAO throws', () async {
    when(() => dao.getAllBudgets()).thenThrow(Exception('boom'));

    final result = await repository.getBudgets();

    expect(result, isA<ErrorResult<List<BudgetModel>, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('getBudgetById returns DatabaseFailure when DAO throws', () async {
    when(() => dao.getBudget(any())).thenThrow(Exception('boom'));

    final result = await repository.getBudgetById('budget-1');

    expect(result, isA<ErrorResult<BudgetModel, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('createBudget returns DatabaseFailure when DAO throws', () async {
    when(() => dao.insertBudget(any())).thenThrow(Exception('boom'));

    final result = await repository.createBudget(_buildBudget());

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('updateBudget returns DatabaseFailure when DAO throws', () async {
    when(() => dao.updateBudget(any())).thenThrow(Exception('boom'));

    final result = await repository.updateBudget(_buildBudget());

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('deleteBudget returns DatabaseFailure when DAO throws', () async {
    when(() => dao.deleteBudget(any())).thenThrow(Exception('boom'));

    final result = await repository.deleteBudget('budget-1');

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });
}

BudgetModel _buildBudget() {
  return BudgetModel(
    id: 'budget-1',
    name: 'Food Budget',
    amount: 2000000,
    period: BudgetPeriod.monthly,
    startDate: DateTimeUtils.nowUtc(),
    resetDay: 1,
    createdAt: DateTimeUtils.nowUtc(),
    updatedAt: DateTimeUtils.nowUtc(),
  );
}
