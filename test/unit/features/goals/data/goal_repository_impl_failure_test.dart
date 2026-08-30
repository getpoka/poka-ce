// Tests exception-to-Failure translation of GoalRepositoryImpl by mocking
// its DAO to throw, covering every defensive catch branch.
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/database/daos/goals_dao.dart';
import 'package:poka_ce/database/database.dart' as db;
import 'package:poka_ce/features/goals/data/goal_repository_impl.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';

class MockGoalsDao extends Mock implements GoalsDao {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockGoalsDao dao;
  late GoalRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(const db.GoalsCompanion());
    registerFallbackValue(const db.AccountsCompanion());
  });

  setUp(() {
    dao = MockGoalsDao();
    repository = GoalRepositoryImpl(dao);
  });

  test('getGoals returns DatabaseFailure when DAO throws', () async {
    when(() => dao.getAllGoals()).thenThrow(Exception('boom'));

    final result = await repository.getGoals();

    expect(result, isA<ErrorResult<List<GoalModel>, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('getGoalById returns DatabaseFailure when DAO throws', () async {
    when(() => dao.getGoal(any())).thenThrow(Exception('boom'));

    final result = await repository.getGoalById('goal-1');

    expect(result, isA<ErrorResult<GoalModel, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('createGoal returns DatabaseFailure when DAO throws', () async {
    when(() => dao.insertGoalWithAccount(any(), any())).thenThrow(Exception('boom'));

    final result = await repository.createGoal(_buildGoal());

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('updateGoal returns DatabaseFailure when DAO throws', () async {
    when(() => dao.updateGoal(any())).thenThrow(Exception('boom'));

    final result = await repository.updateGoal(_buildGoal());

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });

  test('deleteGoal returns DatabaseFailure when DAO throws', () async {
    when(() => dao.deleteGoalWithAccount(any())).thenThrow(Exception('boom'));

    final result = await repository.deleteGoal('goal-1');

    expect(result, isA<ErrorResult<void, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, isA<DatabaseFailure>()),
    );
  });
}

GoalModel _buildGoal() {
  return GoalModel(
    id: 'goal-1',
    accountId: 'acc-goal-pocket',
    name: 'New iPhone',
    targetAmount: 10000000,
    createdAt: DateTimeUtils.nowUtc(),
    updatedAt: DateTimeUtils.nowUtc(),
  );
}
