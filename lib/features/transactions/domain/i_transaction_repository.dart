import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

/// Abstract repository for managing Transaction data.
abstract class ITransactionRepository {
  /// Retrieves all transactions.
  Future<Result<List<TransactionModel>, Failure>> getTransactions();

  /// Watches all transactions.
  Stream<Result<List<TransactionModel>, Failure>> watchTransactions({
    DateTime? startDate,
    DateTime? endDate,
    Set<String> accountIds = const {},
    Set<String> categoryIds = const {},
    Set<TransactionType> types = const {},
    Set<String> debtIds = const {},
    Set<String> recurringIds = const {},
  });

  /// Retrieves a specific transaction by ID.
  Future<Result<TransactionModel, Failure>> getTransactionById(String id);

  /// Creates a new transaction along with its items.
  Future<Result<void, Failure>> createTransaction(TransactionModel transaction);

  /// Updates an existing transaction along with its items.
  Future<Result<void, Failure>> updateTransaction(TransactionModel transaction);

  /// Deletes a transaction by ID.
  Future<Result<void, Failure>> deleteTransaction(String id);
}
