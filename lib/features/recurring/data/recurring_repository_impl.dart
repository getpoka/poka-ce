import 'package:drift/drift.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/core/utils/logger.dart';
import 'package:poka_ce/database/daos/recurring_dao.dart';
import 'package:poka_ce/database/database.dart' as db;
import 'package:poka_ce/features/recurring/domain/i_recurring_repository.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';

class RecurringRepositoryImpl implements IRecurringRepository {
  RecurringRepositoryImpl(this._dao);
  final RecurringDao _dao;

  @override
  Future<Result<List<RecurringTransactionModel>, Failure>> getRecurringTransactions() async {
    try {
      final recurrings = await _dao.getAllRecurring();
      final models = recurrings.map(_mapToModel).toList();
      return Success(models);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'RecurringRepositoryImpl.getRecurringTransactions');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<RecurringTransactionModel>, Failure>> getActiveRecurringTransactions() async {
    try {
      final recurrings = await _dao.getActiveRecurring();
      final models = recurrings.map(_mapToModel).toList();
      return Success(models);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'RecurringRepositoryImpl.getActiveRecurringTransactions');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<RecurringTransactionModel>, Failure>> getDueRecurringTransactions(
    DateTime asOf,
  ) async {
    try {
      final recurrings = await _dao.getDueRecurring(asOf);
      final models = recurrings.map(_mapToModel).toList();
      return Success(models);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'RecurringRepositoryImpl.getDueRecurringTransactions');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<RecurringTransactionModel, Failure>> getRecurringById(String id) async {
    try {
      final recurring = await _dao.getRecurring(id);
      if (recurring == null) {
        return const ErrorResult(DatabaseFailure('Recurring transaction not found'));
      }
      return Success(_mapToModel(recurring));
    } on Exception catch (e, st) {
      talker.handle(e, st, 'RecurringRepositoryImpl.getRecurringById');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> createRecurring(RecurringTransactionModel model) async {
    try {
      await _dao.insertRecurring(
        db.RecurringTransactionsCompanion.insert(
          id: Value(model.id),
          accountId: model.accountId,
          destinationAccountId: Value(model.destinationAccountId),
          categoryId: Value(model.categoryId),
          allocation: Value(model.allocation),
          type: model.type,
          amount: model.amount,
          period: model.period,
          nextDate: model.nextDate.toUtc(),
          note: Value(model.note),
          isActive: Value(model.isActive),
          createdAt: Value(model.createdAt.toUtc()),
          updatedAt: Value(model.updatedAt.toUtc()),
        ),
      );
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'RecurringRepositoryImpl.createRecurring');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> updateRecurring(RecurringTransactionModel model) async {
    try {
      await _dao.updateRecurring(
        db.RecurringTransactionsCompanion(
          id: Value(model.id),
          accountId: Value(model.accountId),
          destinationAccountId: Value(model.destinationAccountId),
          categoryId: Value(model.categoryId),
          allocation: Value(model.allocation),
          type: Value(model.type),
          amount: Value(model.amount),
          period: Value(model.period),
          nextDate: Value(model.nextDate.toUtc()),
          note: Value(model.note),
          isActive: Value(model.isActive),
          updatedAt: Value(DateTimeUtils.nowUtc()),
        ),
      );
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'RecurringRepositoryImpl.updateRecurring');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> deleteRecurring(String id) async {
    try {
      await _dao.deleteRecurring(id);
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'RecurringRepositoryImpl.deleteRecurring');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  RecurringTransactionModel _mapToModel(db.RecurringTransaction recurring) {
    return RecurringTransactionModel(
      id: recurring.id,
      accountId: recurring.accountId,
      destinationAccountId: recurring.destinationAccountId,
      categoryId: recurring.categoryId,
      allocation: recurring.allocation,
      type: recurring.type,
      amount: recurring.amount,
      period: recurring.period,
      nextDate: recurring.nextDate,
      note: recurring.note,
      isActive: recurring.isActive,
      createdAt: recurring.createdAt,
      updatedAt: recurring.updatedAt,
    );
  }
}
