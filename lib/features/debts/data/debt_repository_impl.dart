import 'package:drift/drift.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/core/utils/logger.dart';
import 'package:poka_ce/database/daos/debts_dao.dart';
import 'package:poka_ce/database/database.dart' as db;
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/domain/i_debt_repository.dart';
import 'package:uuid/uuid.dart';

class DebtRepositoryImpl implements IDebtRepository {
  DebtRepositoryImpl(this._dao);
  final DebtsDao _dao;

  @override
  Future<Result<List<DebtModel>, Failure>> getDebts() async {
    try {
      final debts = await _dao.getAllDebts();
      final models = debts.map(_mapToModel).toList();
      return Success(models);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'DebtRepositoryImpl.getDebts');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Stream<List<DebtModel>> watchDebts() {
    return _dao.watchAllDebts().map((debts) => debts.map(_mapToModel).toList());
  }

  @override
  Future<Result<List<DebtModel>, Failure>> getActiveDebts() async {
    try {
      final debts = await _dao.getActiveDebts();
      final models = debts.map(_mapToModel).toList();
      return Success(models);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'DebtRepositoryImpl.getActiveDebts');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<DebtModel, Failure>> getDebtById(String id) async {
    try {
      final debt = await _dao.getDebt(id);
      if (debt == null) {
        return const ErrorResult(DatabaseFailure('Debt not found'));
      }
      return Success(_mapToModel(debt));
    } on Exception catch (e, st) {
      talker.handle(e, st, 'DebtRepositoryImpl.getDebtById');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> createDebt(DebtModel model, String accountId, String categoryId) async {
    try {
      final now = DateTimeUtils.nowUtc();
      final isDebt = model.type == DebtType.debt;

      final transactionId = const Uuid().v7();

      final txHeader = db.TransactionsCompanion.insert(
        id: Value(transactionId),
        accountId: accountId,
        type: isDebt ? TransactionType.income : TransactionType.expense,
        amount: model.amount,
        transactionDate: now,
        debtId: Value(model.id),
        note: Value(isDebt ? 'Borrowed from ${model.personName}' : 'Lent to ${model.personName}'),
        createdAt: Value(now),
        updatedAt: Value(now),
      );

      final txItem = db.TransactionItemsCompanion.insert(
        transactionId: transactionId,
        categoryId: Value(categoryId),
        amount: model.amount,
        createdAt: Value(now),
        updatedAt: Value(now),
      );

      final debt = db.DebtsCompanion.insert(
        id: Value(model.id),
        personName: model.personName,
        type: model.type,
        amount: model.amount,
        remainingAmount: model.remainingAmount,
        status: model.status,
        dueDate: Value(model.dueDate?.toUtc()),
        note: Value(model.note),
        createdAt: Value(model.createdAt.toUtc()),
        updatedAt: Value(model.updatedAt.toUtc()),
      );

      await _dao.insertDebtWithTransaction(debt, txHeader, txItem);
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'DebtRepositoryImpl.createDebt');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> updateDebt(DebtModel model) async {
    try {
      await _dao.updateDebt(
        db.DebtsCompanion(
          id: Value(model.id),
          personName: Value(model.personName),
          type: Value(model.type),
          amount: Value(model.amount),
          remainingAmount: Value(model.remainingAmount),
          status: Value(model.status),
          dueDate: Value(model.dueDate?.toUtc()),
          note: Value(model.note),
          updatedAt: Value(DateTimeUtils.nowUtc()),
        ),
      );
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'DebtRepositoryImpl.updateDebt');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> deleteDebt(String id) async {
    try {
      await _dao.deleteDebtWithTransactionReversal(id);
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'DebtRepositoryImpl.deleteDebt');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  DebtModel _mapToModel(db.Debt debt) {
    return DebtModel(
      id: debt.id,
      personName: debt.personName,
      type: debt.type,
      amount: debt.amount,
      remainingAmount: debt.remainingAmount,
      status: debt.status,
      dueDate: debt.dueDate,
      note: debt.note,
      createdAt: debt.createdAt,
      updatedAt: debt.updatedAt,
    );
  }
}
