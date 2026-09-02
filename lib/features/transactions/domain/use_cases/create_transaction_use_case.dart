/// Use case for creating a new transaction (income, expense, or transfer).
/// Handles the mapping of parameters and split items before saving to repository.
library;

import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:uuid/uuid.dart';

class CreateTransactionUseCase {
  const CreateTransactionUseCase(this._repository);

  final ITransactionRepository _repository;

  Future<Result<TransactionModel, Failure>> execute({
    required TransactionType type,
    required String accountId,
    int? amount, // Total amount. If null, calculated from items
    String? categoryId,
    String? note,
    String? debtId,
    DateTime? transactionDate,
    TransactionAllocation? allocation,
    List<({String? categoryId, int amount, String? note, TransactionAllocation? allocation})>? splitItems,
  }) async {
    final nowUtc = DateTimeUtils.nowUtc();
    final txDateUtc = transactionDate?.toUtc() ?? nowUtc;
    final transactionId = const Uuid().v7();

    final txItems = <TransactionItemModel>[];
    var totalAmount = 0;

    if (splitItems != null && splitItems.isNotEmpty) {
      for (final item in splitItems) {
        if (item.amount <= 0) continue;
        totalAmount += item.amount;
        txItems.add(
          TransactionItemModel(
            id: const Uuid().v7(),
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
          id: const Uuid().v7(),
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

    final transaction = TransactionModel(
      id: transactionId,
      accountId: accountId,
      type: type,
      amount: totalAmount,
      transactionDate: txDateUtc,
      createdAt: nowUtc,
      updatedAt: nowUtc,
      note: note,
      debtId: debtId,
      items: txItems,
    );

    final result = await _repository.createTransaction(transaction);
    if (result is ErrorResult<void, Failure>) {
      return ErrorResult(result.error);
    }
    return Success(transaction);
  }
}
