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

/// Implementation of [IDebtRepository] handling persistence and cash flow bindings for debts and loans.
class DebtRepositoryImpl implements IDebtRepository {
  /// Creates a [DebtRepositoryImpl] backed by the provided [DebtsDao].
  DebtRepositoryImpl(this._dao);

  final DebtsDao _dao;

  /// Fetches all debts and loans.
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

  /// Watches all debts and loans in real-time as a reactive stream.
  @override
  Stream<List<DebtModel>> watchDebts() {
    return _dao.watchAllDebts().map((debts) => debts.map(_mapToModel).toList());
  }

  /// Fetches only unsettled (active) debts and loans.
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

  /// Fetches a specific debt by its unique identifier [id].
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

  /// Creates a debt/loan record and simultaneously generates its corresponding initial disbursement transaction.
  @override
  Future<Result<void, Failure>> createDebt(DebtModel model, String accountId, String categoryId) async {
    try {
      final now = DateTimeUtils.nowUtc();
      final isDebt = model.type == DebtType.debt;

      final transactionId = const Uuid().v7();

      // Cash flow binding: Debts print an income transaction (borrowed funds added to wallet),
      // while Loans print an expense transaction (lent funds deducted from wallet)
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

  /// Updates debt record metadata such as due date, person name, or notes.
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

  /// Permanently removes a debt record and reverts associated disbursements and repayments.
  @override
  Future<Result<void, Failure>> deleteDebt(String id) async {
    try {
      // Revert all disbursements and repayment transactions associated with this debt record to maintain balance integrity
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
