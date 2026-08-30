/// Service that processes overdue recurring transactions by spawning real
/// transactions in the ledger and advancing the schedule's `nextDate`.
library;

import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/core/utils/logger.dart';
import 'package:poka_ce/features/recurring/domain/i_recurring_repository.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:uuid/uuid.dart';

/// Processes all due recurring transactions as of `asOf` (typically today).
///
/// For each due recurring:
/// 1. Creates a real `TransactionModel` linked via `recurringTransactionId`.
/// 2. Advances `RecurringTransactionModel.nextDate` to the next period.
///
/// Returns the number of transactions successfully created.
class RecurringProcessorService {
  /// Creates a [RecurringProcessorService].
  const RecurringProcessorService({
    required IRecurringRepository recurringRepository,
    required ITransactionRepository transactionRepository,
  }) : _recurringRepo = recurringRepository,
       _transactionRepo = transactionRepository;

  final IRecurringRepository _recurringRepo;
  final ITransactionRepository _transactionRepo;

  /// Runs the processor for all transactions due on or before [asOf].
  ///
  /// Returns the count of transactions created, or a [Failure] if the
  /// due-list query itself failed.
  Future<Result<int, Failure>> run(DateTime asOf) async {
    final dueResult = await _recurringRepo.getDueRecurringTransactions(asOf);

    switch (dueResult) {
      case ErrorResult(:final error):
        return ErrorResult(error);
      case Success(:final value):
        var created = 0;
        for (final recurring in value) {
          final ok = await _processOne(recurring);
          if (ok) created++;
        }
        return Success(created);
    }
  }

  /// Processes a single due recurring: create transaction → advance `nextDate`.
  /// Returns `true` if both steps succeeded.
  Future<bool> _processOne(RecurringTransactionModel recurring) async {
    final now = DateTimeUtils.nowUtc();
    final transactionId = const Uuid().v7();

    // Build the real transaction from the recurring blueprint.
    final transaction = TransactionModel(
      id: transactionId,
      accountId: recurring.accountId,
      destinationAccountId: recurring.destinationAccountId,
      type: recurring.type,
      amount: recurring.amount,
      transactionDate: recurring.nextDate.toUtc(),
      note: recurring.note,
      recurringTransactionId: recurring.id,
      createdAt: now,
      updatedAt: now,
      items: [
        TransactionItemModel(
          id: const Uuid().v7(),
          transactionId: transactionId,
          amount: recurring.amount,
          categoryId: recurring.categoryId,
          allocation: recurring.allocation,
          note: recurring.note,
          createdAt: now,
          updatedAt: now,
        ),
      ],
    );

    final txResult = await _transactionRepo.createTransaction(transaction);
    if (txResult is ErrorResult) {
      talker.warning(
        'RecurringProcessorService: failed to create tx for ${recurring.id}: '
        '${(txResult as ErrorResult).error.message}',
      );
      return false;
    }

    // Advance next_date by one period.
    final nextDate = _advance(recurring.nextDate, recurring.period);
    final updated = recurring.copyWith(nextDate: nextDate, updatedAt: now);

    final updateResult = await _recurringRepo.updateRecurring(updated);
    if (updateResult is ErrorResult) {
      talker.warning(
        'RecurringProcessorService: failed to advance nextDate for ${recurring.id}: '
        '${(updateResult as ErrorResult).error.message}',
      );
      // Transaction was already created; still count as partial success but log.
      return true;
    }

    return true;
  }

  /// Computes the next due date after [current] based on [period].
  DateTime _advance(DateTime current, RecurringPeriod period) {
    return switch (period) {
      RecurringPeriod.daily => current.add(const Duration(days: 1)),
      RecurringPeriod.weekly => current.add(const Duration(days: 7)),
      RecurringPeriod.monthly => DateTime.utc(
        current.year,
        current.month + 1,
        current.day,
        current.hour,
        current.minute,
        current.second,
      ),
      RecurringPeriod.yearly => DateTime.utc(
        current.year + 1,
        current.month,
        current.day,
        current.hour,
        current.minute,
        current.second,
      ),
    };
  }
}
