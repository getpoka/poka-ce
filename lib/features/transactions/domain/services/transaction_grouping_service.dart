import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/extensions/datetime_extension.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

class TransactionGroup {
  TransactionGroup({
    required this.dateStr,
    required this.dateObj,
    required this.transactions,
    required this.totalIncome,
    required this.totalExpense,
  });

  final String dateStr;
  final DateTime dateObj;
  final List<TransactionModel> transactions;
  final int totalIncome;
  final int totalExpense;
}

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
