import 'package:drift/drift.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/logger.dart';
import 'package:poka_ce/database/daos/transactions_dao.dart';
import 'package:poka_ce/database/database.dart' as db;
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

/// Implementation of [ITransactionRepository] mapping Drift DAO to Freezed Domain Models.
class TransactionRepositoryImpl implements ITransactionRepository {
  TransactionRepositoryImpl(this._dao);
  final TransactionsDao _dao;

  @override
  Future<Result<List<TransactionModel>, Failure>> getTransactions() async {
    try {
      final transactionsWithItems = await _dao.getAllTransactionsWithItems();
      final models = transactionsWithItems.map((twi) => _mapToModel(twi.transaction, twi.items)).toList();
      return Success(models);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'TransactionRepositoryImpl.getTransactions');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Stream<Result<List<TransactionModel>, Failure>> watchTransactions({
    DateTime? startDate,
    DateTime? endDate,
    Set<String> accountIds = const {},
    Set<String> categoryIds = const {},
    Set<TransactionType> types = const {},
    Set<String> debtIds = const {},
    Set<String> recurringIds = const {},
  }) async* {
    try {
      await for (final transactionsWithItems in _dao.watchTransactionsFiltered(
        startDate: startDate,
        endDate: endDate,
        accountIds: accountIds,
        categoryIds: categoryIds,
        types: types,
        debtIds: debtIds,
        recurringIds: recurringIds,
      )) {
        final models = transactionsWithItems.map((twi) => _mapToModel(twi.transaction, twi.items)).toList();
        yield Success(models);
      }
    } on Exception catch (e, st) {
      talker.handle(e, st, 'TransactionRepositoryImpl.watchTransactions');
      yield ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<TransactionModel, Failure>> getTransactionById(String id) async {
    try {
      final transaction = await _dao.getTransaction(id);
      if (transaction == null) {
        return const ErrorResult(DatabaseFailure('Transaction not found'));
      }
      final items = await _dao.getTransactionItems(id);
      return Success(_mapToModel(transaction, items));
    } on Exception catch (e, st) {
      talker.handle(e, st, 'TransactionRepositoryImpl.getTransactionById');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> createTransaction(TransactionModel model) async {
    try {
      final header = db.TransactionsCompanion.insert(
        id: Value(model.id),
        accountId: model.accountId,
        destinationAccountId: Value(model.destinationAccountId),
        type: model.type,
        amount: model.amount,
        transactionDate: model.transactionDate.toUtc(),
        note: Value(model.note),
        recurringTransactionId: Value(model.recurringTransactionId),
        debtId: Value(model.debtId),
        createdAt: Value(model.createdAt.toUtc()),
        updatedAt: Value(model.updatedAt.toUtc()),
      );

      final items = model.items
          .map(
            (i) => db.TransactionItemsCompanion.insert(
              id: Value(i.id),
              transactionId: model.id,
              categoryId: Value(i.categoryId),
              allocation: Value(i.allocation),
              amount: i.amount,
              note: Value(i.note),
              createdAt: Value(i.createdAt.toUtc()),
              updatedAt: Value(i.updatedAt.toUtc()),
            ),
          )
          .toList();

      await _dao.insertTransactionWithItems(header, items);

      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'TransactionRepositoryImpl.createTransaction');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> updateTransaction(TransactionModel model) async {
    try {
      final header = db.TransactionsCompanion.insert(
        id: Value(model.id),
        accountId: model.accountId,
        destinationAccountId: Value(model.destinationAccountId),
        type: model.type,
        amount: model.amount,
        transactionDate: model.transactionDate.toUtc(),
        note: Value(model.note),
        recurringTransactionId: Value(model.recurringTransactionId),
        debtId: Value(model.debtId),
        createdAt: Value(model.createdAt.toUtc()),
        updatedAt: Value(DateTime.now().toUtc()),
      );

      final items = model.items
          .map(
            (i) => db.TransactionItemsCompanion.insert(
              id: Value(i.id),
              transactionId: model.id,
              categoryId: Value(i.categoryId),
              allocation: Value(i.allocation),
              amount: i.amount,
              note: Value(i.note),
              createdAt: Value(i.createdAt.toUtc()),
              updatedAt: Value(DateTime.now().toUtc()),
            ),
          )
          .toList();

      await _dao.updateTransaction(header, items);

      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'TransactionRepositoryImpl.updateTransaction');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> deleteTransaction(String id) async {
    try {
      await _dao.deleteTransaction(id);
      return const Success(null);
    } on Exception catch (e, st) {
      talker.handle(e, st, 'TransactionRepositoryImpl.deleteTransaction');
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }

  /// Maps Drift Transaction object to Domain TransactionModel.
  TransactionModel _mapToModel(db.Transaction header, List<db.TransactionItem> items) {
    return TransactionModel(
      id: header.id,
      accountId: header.accountId,
      destinationAccountId: header.destinationAccountId,
      type: header.type,
      amount: header.amount,
      transactionDate: header.transactionDate,
      note: header.note,
      recurringTransactionId: header.recurringTransactionId,
      debtId: header.debtId,
      createdAt: header.createdAt,
      updatedAt: header.updatedAt,
      items: items
          .map(
            (i) => TransactionItemModel(
              id: i.id,
              transactionId: i.transactionId,
              categoryId: i.categoryId,
              allocation: i.allocation,
              amount: i.amount,
              note: i.note,
              createdAt: i.createdAt,
              updatedAt: i.updatedAt,
            ),
          )
          .toList(),
    );
  }
}
