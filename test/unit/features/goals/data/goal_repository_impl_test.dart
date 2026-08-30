import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/database/database.dart';
import 'package:poka_ce/features/goals/data/goal_repository_impl.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late GoalRepositoryImpl repo;
  setUp(() {
    db = AppDatabase(connection: NativeDatabase.memory());
    repo = GoalRepositoryImpl(db.goalsDao);
  });
  tearDown(() async => db.close());
  final now = DateTimeUtils.nowUtc();

  test('getGoals empty then one', () async {
    var res = await repo.getGoals();
    res.fold((v) => expect(v, isEmpty), (e) => fail('fail'));
    await repo.createGoal(
      GoalModel(id: 'g1', accountId: 'acc1', name: 'Trip', targetAmount: 1000, createdAt: now, updatedAt: now),
    );
    res = await repo.getGoals();
    res.fold((v) => expect(v.length, 1), (e) => fail('fail'));
  });

  test('getGoalById not found', () async {
    expect(await repo.getGoalById('none'), isA<ErrorResult<GoalModel, Failure>>());
  });

  test('create and getGoalById', () async {
    await repo.createGoal(
      GoalModel(id: 'g1', accountId: 'acc1', name: 'House', targetAmount: 5000, createdAt: now, updatedAt: now),
    );
    expect(await repo.getGoalById('g1'), isA<Success<GoalModel, Failure>>());
  });

  test('updateGoal modifies targetAmount', () async {
    await repo.createGoal(
      GoalModel(id: 'g1', accountId: 'acc1', name: 'Old', targetAmount: 100, createdAt: now, updatedAt: now),
    );
    await repo.updateGoal(
      GoalModel(id: 'g1', accountId: 'acc1', name: 'New', targetAmount: 999, createdAt: now, updatedAt: now),
    );
    final res = await repo.getGoalById('g1');
    res.fold((v) => expect(v.targetAmount, 999), (e) => fail('fail'));
  });

  test('deleteGoal removes', () async {
    await repo.createGoal(
      GoalModel(id: 'g1', accountId: 'acc1', name: 'ToDel', targetAmount: 100, createdAt: now, updatedAt: now),
    );
    await repo.deleteGoal('g1');
    expect(await repo.getGoalById('g1'), isA<ErrorResult<GoalModel, Failure>>());
  });

  test('goal with targetDate persisted', () async {
    final target = DateTime.utc(2027, 5);
    await repo.createGoal(
      GoalModel(
        id: 'g1',
        accountId: 'acc1',
        name: 'Car',
        targetAmount: 10000000,
        targetDate: target,
        createdAt: now,
        updatedAt: now,
      ),
    );
    final res = await repo.getGoalById('g1');
    res.fold((v) => expect(v.targetDate!.toUtc(), target.toUtc()), (e) => fail('fail'));
  });
}
