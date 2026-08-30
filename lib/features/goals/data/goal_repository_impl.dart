import 'package:drift/drift.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/core/utils/logger.dart';
import 'package:poka_ce/database/daos/goals_dao.dart';
import 'package:poka_ce/database/database.dart' as db;
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/features/goals/domain/i_goal_repository.dart';

class GoalRepositoryImpl implements IGoalRepository {
  GoalRepositoryImpl(this._dao);
  final GoalsDao _dao;

  @override
  Future<Result<List<GoalModel>, Failure>> getGoals() async {
    try {
      final goals = await _dao.getAllGoals();
      final models = goals.map(_mapToModel).toList();
      return Success(models);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'GoalRepositoryImpl.getGoals');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Stream<List<GoalModel>> watchGoals() {
    return _dao.watchAllGoals().map((goals) => goals.map(_mapToModel).toList());
  }

  @override
  Future<Result<GoalModel, Failure>> getGoalById(String id) async {
    try {
      final goal = await _dao.getGoal(id);
      if (goal == null) {
        return const ErrorResult(DatabaseFailure('Goal not found'));
      }
      return Success(_mapToModel(goal));
    } on Exception catch (e, st) {
      talker.handle(e, st, 'GoalRepositoryImpl.getGoalById');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> createGoal(GoalModel model) async {
    try {
      final now = DateTimeUtils.nowUtc();

      final accountCompanion = db.AccountsCompanion.insert(
        id: Value(model.accountId),
        name: 'Goal: ${model.name}',
        type: AccountType.goal,
        createdAt: Value(now),
        updatedAt: Value(now),
        icon: Value(model.icon),
        color: Value(model.color),
      );

      final goalCompanion = db.GoalsCompanion.insert(
        id: Value(model.id),
        accountId: model.accountId,
        name: model.name,
        targetAmount: model.targetAmount,
        targetDate: Value(model.targetDate?.toUtc()),
        status: Value(model.status),
        icon: Value(model.icon),
        color: Value(model.color),
        createdAt: Value(model.createdAt.toUtc()),
        updatedAt: Value(model.updatedAt.toUtc()),
      );

      await _dao.insertGoalWithAccount(goalCompanion, accountCompanion);
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'GoalRepositoryImpl.createGoal');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> updateGoal(GoalModel model) async {
    try {
      await _dao.updateGoal(
        db.GoalsCompanion(
          id: Value(model.id),
          accountId: Value(model.accountId),
          name: Value(model.name),
          targetAmount: Value(model.targetAmount),
          targetDate: Value(model.targetDate?.toUtc()),
          status: Value(model.status),
          icon: Value(model.icon),
          color: Value(model.color),
          updatedAt: Value(DateTimeUtils.nowUtc()),
        ),
      );
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'GoalRepositoryImpl.updateGoal');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> deleteGoal(String id) async {
    try {
      await _dao.deleteGoalWithAccount(id);
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'GoalRepositoryImpl.deleteGoal');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  GoalModel _mapToModel(db.Goal goal) {
    return GoalModel(
      id: goal.id,
      accountId: goal.accountId,
      name: goal.name,
      targetAmount: goal.targetAmount,
      targetDate: goal.targetDate,
      status: goal.status,
      icon: goal.icon,
      color: goal.color,
      createdAt: goal.createdAt,
      updatedAt: goal.updatedAt,
    );
  }
}
