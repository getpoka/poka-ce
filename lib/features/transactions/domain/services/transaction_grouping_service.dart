import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/extensions/datetime_extension.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

/// A grouped collection of transactions belonging to a single calendar day,
/// along with aggregated daily income and expense totals.
class TransactionGroup {
  /// Creates a [TransactionGroup] with date labels, child transactions, and aggregated daily totals.
  TransactionGroup({
    required this.dateStr,
    required this.dateObj,
    required this.transactions,
    required this.totalIncome,
    required this.totalExpense,
  });

  /// Relative or formatted human-readable date string (e.g. "Today", "Yesterday").
  final String dateStr;

  /// Pure date object at midnight representing the group day.
  final DateTime dateObj;

  /// Transactions occurring on this date.
  final List<TransactionModel> transactions;

  /// Total sum of all income transactions on this day.
  final int totalIncome;

  /// Total sum of all expense transactions on this day.
  final int totalExpense;
}

/// Service providing logic to organize transactions into daily buckets.
class TransactionGroupingService {
  /// Groups a list of transactions by date (formatted relatively, e.g., "Today")
  /// and calculates daily income and expense totals.
  static List<TransactionGroup> groupTransactions(List<TransactionModel> transactions) {
    // Group by date string (Today, Yesterday, or formatted date)
    final grouped = <String, List<TransactionModel>>{};

    for (final t in transactions) {
      final local = t.transactionDate.toLocal();
      // Use YYYY-MM-DD for sorting stability
      final dateKey =
          '${local.year.toString().padLeft(4, '0')}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
      grouped.putIfAbsent(dateKey, () => []).add(t);
    }

    // Sort groups newest-first
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) {
        final dateA = grouped[a]!.first.transactionDate;
        final dateB = grouped[b]!.first.transactionDate;
        return dateB.compareTo(dateA);
      });

    final result = <TransactionGroup>[];

    for (final dateKey in sortedKeys) {
      final group = grouped[dateKey]!;
      final dateObj = DateTime.parse(dateKey);

      var income = 0;
      var expense = 0;
      for (final t in group) {
        if (t.type == TransactionType.income) income += t.amount;
        if (t.type == TransactionType.expense) expense += t.amount;
      }

      result.add(
        TransactionGroup(
          dateStr: dateObj.toRelativeDateString(),
          dateObj: dateObj,
          transactions: group,
          totalIncome: income,
          totalExpense: expense,
        ),
      );
    }

    return result;
  }
}
