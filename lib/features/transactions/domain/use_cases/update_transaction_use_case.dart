/// Use case for updating an existing transaction.
/// Replaces the old transaction with new values and items.
library;

import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:uuid/uuid.dart';

class UpdateTransactionUseCase {
  const UpdateTransactionUseCase(this._repository);

  final ITransactionRepository _repository;

  Future<Result<TransactionModel, Failure>> execute(
    TransactionModel existingTransaction, {
    required TransactionType type,
    required String accountId,
    String? destinationAccountId,
    int? amount, // Total amount. If null, calculated from items
    String? categoryId,
    String? note,
    DateTime? transactionDate,
    TransactionAllocation? allocation,
    List<({String? categoryId, int amount, String? note, TransactionAllocation? allocation})>? splitItems,
  }) async {
    final nowUtc = DateTimeUtils.nowUtc();
    final transactionId = existingTransaction.id;
    final txDate = transactionDate ?? existingTransaction.transactionDate;

    final txItems = <TransactionItemModel>[];
    var totalAmount = 0;

    if (splitItems != null && splitItems.isNotEmpty) {
      for (final item in splitItems) {
        if (item.amount <= 0) continue;
        totalAmount += item.amount;
        txItems.add(
          TransactionItemModel(
            id: const Uuid()
                .v4(), // We regenerate IDs for split items for simplicity since old ones are deleted by cascade
            transactionId: transactionId,
            amount: item.amount,
            createdAt: nowUtc,
            updatedAt: nowUtc,
            categoryId: item.categoryId,
            note: item.note,
            allocation: item.allocation,
          ),
        );
      }
    } else {
      if (amount == null || amount <= 0) {
        return const ErrorResult(ValidationFailure('Transaction amount must be greater than 0'));
      }
      totalAmount = amount;
      txItems.add(
        TransactionItemModel(
          id: const Uuid().v4(),
          transactionId: transactionId,
          amount: amount,
          createdAt: nowUtc,
          updatedAt: nowUtc,
          categoryId: categoryId,
          note: note,
          allocation: allocation,
        ),
      );
    }

    if (txItems.isEmpty || totalAmount <= 0) {
      return const ErrorResult(ValidationFailure('Invalid transaction items or amount'));
    }

    final transaction = existingTransaction.copyWith(
      accountId: accountId,
      destinationAccountId: destinationAccountId,
      type: type,
      amount: totalAmount,
      transactionDate: txDate,
      updatedAt: nowUtc,
      note: note,
      items: txItems,
    );

    final result = await _repository.updateTransaction(transaction);
    if (result is ErrorResult<void, Failure>) {
      return ErrorResult(result.error);
    }
    return Success(transaction);
  }
}
