import 'package:drift/drift.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/core/utils/logger.dart';
import 'package:poka_ce/database/daos/budgets_dao.dart';
import 'package:poka_ce/database/database.dart' as db;
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/domain/i_budget_repository.dart';

class BudgetRepositoryImpl implements IBudgetRepository {
  BudgetRepositoryImpl(this._dao);
  final BudgetsDao _dao;

  @override
  Future<Result<List<BudgetModel>, Failure>> getBudgets() async {
    try {
      final budgets = await _dao.getAllBudgets();
      final models = budgets.map(_mapToModel).toList();
      return Success(models);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'BudgetRepositoryImpl.getBudgets');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<BudgetModel, Failure>> getBudgetById(String id) async {
    try {
      final budget = await _dao.getBudget(id);
      if (budget == null) {
        return const ErrorResult(DatabaseFailure('Budget not found'));
      }
      return Success(_mapToModel(budget));
    } on Exception catch (e, st) {
      talker.handle(e, st, 'BudgetRepositoryImpl.getBudgetById');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> createBudget(BudgetModel model) async {
    try {
      await _dao.insertBudget(
        db.BudgetsCompanion.insert(
          id: Value(model.id),
          name: model.name,
          amount: model.amount,
          period: model.period,
          startDate: model.startDate.toUtc(),
          categoryId: Value(model.categoryId),
          accountId: Value(model.accountId),
          resetDay: Value(model.resetDay),
          alertThreshold: Value(model.alertThreshold),
          endDate: Value(model.endDate?.toUtc()),
          createdAt: Value(model.createdAt.toUtc()),
          updatedAt: Value(model.updatedAt.toUtc()),
        ),
      );
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'BudgetRepositoryImpl.createBudget');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> updateBudget(BudgetModel model) async {
    try {
      await _dao.updateBudget(
        db.BudgetsCompanion(
          id: Value(model.id),
          name: Value(model.name),
          amount: Value(model.amount),
          period: Value(model.period),
          startDate: Value(model.startDate.toUtc()),
          categoryId: Value(model.categoryId),
          accountId: Value(model.accountId),
          resetDay: Value(model.resetDay),
          alertThreshold: Value(model.alertThreshold),
          endDate: Value(model.endDate?.toUtc()),
          updatedAt: Value(DateTimeUtils.nowUtc()),
        ),
      );
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'BudgetRepositoryImpl.updateBudget');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> deleteBudget(String id) async {
    try {
      await _dao.deleteBudget(id);
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'BudgetRepositoryImpl.deleteBudget');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<int, Failure>> getSpentAmountForBudget({
    required DateTime startDate,
    required DateTime endDate,
    String? categoryId,
    String? accountId,
  }) async {
    try {
      final spent = await _dao.getSpentAmountForBudget(
        startDate: startDate.toUtc(),
        endDate: endDate.toUtc(),
        categoryId: categoryId,
        accountId: accountId,
      );
      return Success(spent);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'BudgetRepositoryImpl.getSpentAmountForBudget');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  BudgetModel _mapToModel(db.Budget budget) {
    return BudgetModel(
      id: budget.id,
      name: budget.name,
      amount: budget.amount,
      period: budget.period,
      startDate: budget.startDate,
      categoryId: budget.categoryId,
      accountId: budget.accountId,
      resetDay: budget.resetDay,
      alertThreshold: budget.alertThreshold,
      endDate: budget.endDate,
      createdAt: budget.createdAt,
      updatedAt: budget.updatedAt,
    );
  }
}
