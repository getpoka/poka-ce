import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

class CategoryExpenseItem {
  CategoryExpenseItem(this.name, this.color, this.amount);
  final String name;
  final String color;
  final double amount;
}

class DashboardAnalyticsService {
  DashboardAnalyticsService._();

  static ({
    double netWorth,
    double totalAssets,
    double totalLiabilities,
    int activeAccountCount,
  })
  calculateAccountMetrics(List<AccountModel> accounts) {
    double netWorth = 0;
    double totalAssets = 0;
    double totalLiabilities = 0;
    var activeAccountCount = 0;

    for (final account in accounts) {
      if (account.isActive) {
        activeAccountCount++;
        netWorth += account.balance;
        if (account.balance > 0) {
          totalAssets += account.balance;
        } else if (account.balance < 0) {
          totalLiabilities += account.balance.abs();
        }
      }
    }

    return (
      netWorth: netWorth,
      totalAssets: totalAssets,
      totalLiabilities: totalLiabilities,
      activeAccountCount: activeAccountCount,
    );
  }

  static ({
    double totalIncome,
    double totalExpense,
    List<CategoryExpenseItem> categoryExpenses,
    Map<TransactionAllocation, double> budgetAllocations,
    List<double> dailySpending,
    double maxDailySpending,
    List<double> normalizedDailySpending,
    double expenseDelta,
    double incomeDelta,
  })
  calculateTransactionMetrics(
    List<TransactionModel> transactions,
    List<CategoryModel> categories,
  ) {
    double totalIncome = 0;
    double totalExpense = 0;
    final categorySums = <String, double>{};
    final budgetSums = <TransactionAllocation, double>{
      TransactionAllocation.need: 0,
      TransactionAllocation.want: 0,
      TransactionAllocation.saving: 0,
    };

    double currentMonthIncome = 0;
    double currentMonthExpense = 0;
    double lastMonthIncome = 0;
    double lastMonthExpense = 0;

    final now = DateTime.now().toUtc();
    final currentMonth = now.month;
    final currentYear = now.year;

    final lastMonth = currentMonth == 1 ? 12 : currentMonth - 1;
    final lastMonthYear = currentMonth == 1 ? currentYear - 1 : currentYear;

    final categoryMap = {for (final c in categories) c.id: c};

    for (final tx in transactions) {
      if (tx.type == TransactionType.income) totalIncome += tx.amount;
      if (tx.type == TransactionType.expense) totalExpense += tx.amount;

      final txDate = tx.transactionDate.toUtc();
      if (txDate.year == currentYear && txDate.month == currentMonth) {
        if (tx.type == TransactionType.income) currentMonthIncome += tx.amount;
        if (tx.type == TransactionType.expense) currentMonthExpense += tx.amount;
      } else if (txDate.year == lastMonthYear && txDate.month == lastMonth) {
        if (tx.type == TransactionType.income) lastMonthIncome += tx.amount;
        if (tx.type == TransactionType.expense) lastMonthExpense += tx.amount;
      }

      for (final item in tx.items) {
        if (tx.type == TransactionType.expense && item.categoryId != null) {
          categorySums[item.categoryId!] = (categorySums[item.categoryId!] ?? 0) + item.amount;
        }
        if (item.allocation != null) {
          budgetSums[item.allocation!] = (budgetSums[item.allocation!] ?? 0) + item.amount;
        }
      }
    }

    final categoryExpenses = categorySums.entries.map((e) {
      final cat = categoryMap[e.key];
      return CategoryExpenseItem(
        cat?.name ?? 'Unknown',
        cat?.color ?? '#CCCCCC',
        e.value,
      );
    }).toList()..sort((a, b) => b.amount.compareTo(a.amount));

    final spending = List<double>.filled(7, 0);
    for (final tx in transactions) {
      if (tx.type == TransactionType.expense) {
        final daysDiff = now.difference(tx.transactionDate.toUtc()).inDays;
        if (daysDiff >= 0 && daysDiff < 7) {
          spending[6 - daysDiff] += tx.amount;
        }
      }
    }

    final maxDailySpending = spending.reduce((a, b) => a > b ? a : b);

    List<double> normalizedDailySpending;
    if (maxDailySpending <= 0) {
      normalizedDailySpending = List.filled(7, 0);
    } else {
      normalizedDailySpending = spending.map((e) => e / maxDailySpending).toList();
    }

    double expenseDelta = 0;
    if (lastMonthExpense > 0) {
      expenseDelta = ((currentMonthExpense - lastMonthExpense) / lastMonthExpense) * 100;
    } else if (currentMonthExpense > 0) {
      expenseDelta = 100;
    }

    double incomeDelta = 0;
    if (lastMonthIncome > 0) {
      incomeDelta = ((currentMonthIncome - lastMonthIncome) / lastMonthIncome) * 100;
    } else if (currentMonthIncome > 0) {
      incomeDelta = 100;
    }

    return (
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      categoryExpenses: categoryExpenses,
      budgetAllocations: budgetSums,
      dailySpending: spending,
      maxDailySpending: maxDailySpending,
      normalizedDailySpending: normalizedDailySpending,
      expenseDelta: expenseDelta,
      incomeDelta: incomeDelta,
    );
  }

  /// Calculates the cumulative Net Worth trend across the specified number of days (default: 7).
  /// Reconstructs historical points by subtracting income and adding back expenses
  /// that occurred between each historical day and the present.
  static List<double> calculateNetWorthTrend({
    required double currentNetWorth,
    required List<TransactionModel> transactions,
    int days = 7,
  }) {
    if (days <= 0) return const [];

    final now = DateTime.now().toUtc();
    final todayMidnight = DateTime.utc(now.year, now.month, now.day);

    // Group transactions by daysAgo (0 = today, 1 = yesterday, ..., days - 1 = days - 1 days ago)
    final dailyNetChanges = List<double>.filled(days, 0);

    for (final tx in transactions) {
      final txDate = tx.transactionDate.toUtc();
      final txMidnight = DateTime.utc(txDate.year, txDate.month, txDate.day);
      final daysAgo = todayMidnight.difference(txMidnight).inDays;

      if (daysAgo >= 0 && daysAgo < days) {
        if (tx.type == TransactionType.income) {
          dailyNetChanges[daysAgo] += tx.amount;
        } else if (tx.type == TransactionType.expense) {
          dailyNetChanges[daysAgo] -= tx.amount;
        }
      }
    }

    final result = List<double>.filled(days, 0);
    var runningNetWorth = currentNetWorth;
    // Today's end-of-day net worth is currentNetWorth
    result[days - 1] = runningNetWorth;

    // Moving backward in time:
    for (var i = 1; i < days; i++) {
      final daysAgo = i - 1; // transactions of day (i - 1)
      runningNetWorth -= dailyNetChanges[daysAgo];
      result[days - 1 - i] = runningNetWorth;
    }

    return result;
  }
}
