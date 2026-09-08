/// Use case for transferring funds between two accounts.
/// Validates transfer parameters and creates a transfer transaction.
library;

import 'package:poka_ce/core/domain/i_unit_of_work.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:uuid/uuid.dart';

/// Use case for transferring funds between two distinct accounts.
class TransferFundsUseCase {
  /// Creates a [TransferFundsUseCase] with the required [IUnitOfWork] and [ITransactionRepository].
  const TransferFundsUseCase(
    this._unitOfWork,
    this._transactionRepository,
  );

  final IUnitOfWork _unitOfWork;
  final ITransactionRepository _transactionRepository;

  /// Executes funds transfer inside a database transaction, validating account inequality
  /// and positive amount.
  Future<Result<TransactionModel, Failure>> execute({
    required int amount,
    required String sourceAccountId,
    required String destinationAccountId,
    String? note,
    DateTime? transactionDate,
  }) async {
    if (amount <= 0) {
      return const ErrorResult(ValidationFailure('Transfer amount must be greater than 0'));
    }
    if (sourceAccountId == destinationAccountId) {
      return const ErrorResult(ValidationFailure('Source and destination accounts must be different'));
    }

    try {
      return await _unitOfWork.execute(() async {
        final nowUtc = DateTimeUtils.nowUtc();
        final txDateUtc = transactionDate?.toUtc() ?? nowUtc;
        final transactionId = const Uuid().v7();

        final transaction = TransactionModel(
          id: transactionId,
          accountId: sourceAccountId,
          destinationAccountId: destinationAccountId,
          type: TransactionType.transfer,
          amount: amount,
          transactionDate: txDateUtc,
          createdAt: nowUtc,
          updatedAt: nowUtc,
          note: note,
          items: [
            TransactionItemModel(
              id: const Uuid().v7(),
              transactionId: transactionId,
              amount: amount,
              createdAt: nowUtc,
              updatedAt: nowUtc,
            ),
          ],
        );

        final result = await _transactionRepository.createTransaction(transaction);
        if (result is ErrorResult<void, Failure>) {
          return ErrorResult(result.error);
        }

        return Success(transaction);
      });
    } on Exception catch (e) {
      return ErrorResult(DatabaseFailure(e.toString()));
    }
  }
}
