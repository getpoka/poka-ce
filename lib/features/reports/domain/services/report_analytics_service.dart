import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Enums & value types
// ─────────────────────────────────────────────────────────────────────────────

/// Represents the period type for reports filtering.
enum ReportPeriod { thisMonth, lastMonth, last3Months, last6Months, custom }

// ─────────────────────────────────────────────────────────────────────────────
// Domain data classes
// ─────────────────────────────────────────────────────────────────────────────

/// Summary of income / expense / net for a period.
class ReportSummary {
  const ReportSummary({
    this.totalIncome = 0,
    this.totalExpense = 0,
    this.transactionCount = 0,
  });

  final double totalIncome;
  final double totalExpense;
  final int transactionCount;

  double get netCashflow => totalIncome - totalExpense;

  /// Savings rate as 0–100, capped.
  int get savingsRatePct => totalIncome > 0 ? ((netCashflow / totalIncome) * 100).clamp(0, 100).toInt() : 0;

  bool get isOnTrack => savingsRatePct >= 10;
}

/// Period-over-period comparison data.
class ReportComparison {
  const ReportComparison({
    this.prevIncome = 0,
    this.prevExpense = 0,
    this.prevNetCashflow = 0,
  });

  final double prevIncome;
  final double prevExpense;
  final double prevNetCashflow;

  bool get hasPrevData => prevIncome > 0 || prevExpense > 0;

  /// Delta percentage for income vs previous period (positive = increased).
  double incomeChangePct(double currentIncome) =>
      prevIncome > 0 ? ((currentIncome - prevIncome) / prevIncome) * 100 : 0;

  /// Delta percentage for expense vs previous period (positive = increased).
  double expenseChangePct(double currentExpense) =>
      prevExpense > 0 ? ((currentExpense - prevExpense) / prevExpense) * 100 : 0;

  /// Delta percentage for net cashflow vs previous period.
  double netChangePct(double currentNet) {
    final absBase = prevNetCashflow.abs();
    return absBase > 0 ? ((currentNet - prevNetCashflow) / absBase) * 100 : 0;
  }
}

/// One category's spend/income item for the report.
class ReportCategoryItem {
  const ReportCategoryItem({
    required this.name,
    required this.color,
    required this.amount,
    required this.ratio,
    required this.txCount,
  });

  final String name;
  final String color;
  final double amount;

  /// Ratio vs total expense or income (0.0 – 1.0).
  final double ratio;
  final int txCount;
}

/// A single weekly/monthly data point for the trend chart.
class ReportTrendPoint {
  const ReportTrendPoint({
    required this.label,
    required this.income,
    required this.expense,
    this.normalizedIncome = 0,
    this.normalizedExpense = 0,
  });

  final String label;
  final double income;
  final double expense;
  final double normalizedIncome;
  final double normalizedExpense;
}

/// Spending allocation by budget category (Need / Want / Save).
class ReportBudgetAllocation {
  const ReportBudgetAllocation({
    this.need = 0,
    this.want = 0,
    this.saving = 0,
  });

  final double need;
  final double want;
  final double saving;

  double get total => need + want + saving;
  double get needRatio => total > 0 ? need / total : 0;
  double get wantRatio => total > 0 ? want / total : 0;
  double get savingRatio => total > 0 ? saving / total : 0;
}

/// Aggregated report data for the selected period.
class ReportData {
  const ReportData({
    this.summary = const ReportSummary(),
    this.comparison = const ReportComparison(),
    this.expenseCategoryItems = const [],
    this.incomeCategoryItems = const [],
    this.trendPoints = const [],
    this.budgetAllocation = const ReportBudgetAllocation(),
  });

  final ReportSummary summary;
  final ReportComparison comparison;
  final List<ReportCategoryItem> expenseCategoryItems;
  final List<ReportCategoryItem> incomeCategoryItems;
  final List<ReportTrendPoint> trendPoints;
  final ReportBudgetAllocation budgetAllocation;
}

// ─────────────────────────────────────────────────────────────────────────────
// Analytics Service
// ─────────────────────────────────────────────────────────────────────────────

/// Pure static calculation service — no Flutter/state dependencies.
class ReportAnalyticsService {
  const ReportAnalyticsService._();

  static ReportData calculate(
    List<TransactionModel> allTransactions,
    List<CategoryModel> categories,
    ReportPeriod period, {
    DateTime? customStart,
    DateTime? customEnd,
  }) {
    final now = DateTime.now();

    // ── Date range ────────────────────────────────────────────────────────────
    final (DateTime start, DateTime end) = _dateRange(period, now, customStart, customEnd);

    // ── Previous period ───────────────────────────────────────────────────────
    final periodLength = end.difference(start);
    final prevEnd = start.subtract(const Duration(seconds: 1));
    final prevStart = prevEnd.subtract(periodLength);

    final txs = _filterTx(allTransactions, start, end);
    final prevTxs = _filterTx(allTransactions, prevStart, prevEnd);

    // ── Category map ──────────────────────────────────────────────────────────
    final categoryMap = {for (final c in categories) c.id: c};

    // ── Aggregate current period ──────────────────────────────────────────────
    var income = 0.0;
    var expense = 0.0;
    var txCount = 0;
    final categorySumsExpense = <String, double>{};
    final categoryTxCountExpense = <String, int>{};
    final categorySumsIncome = <String, double>{};
    final categoryTxCountIncome = <String, int>{};
    final budgetSums = <TransactionAllocation, double>{
      TransactionAllocation.need: 0,
      TransactionAllocation.want: 0,
      TransactionAllocation.saving: 0,
    };

    for (final tx in txs) {
      txCount++;
      if (tx.type == TransactionType.income) income += tx.amount;
      if (tx.type == TransactionType.expense) expense += tx.amount;

      for (final item in tx.items) {
        if (tx.type == TransactionType.expense && item.categoryId != null) {
          categorySumsExpense[item.categoryId!] = (categorySumsExpense[item.categoryId!] ?? 0) + item.amount;
          categoryTxCountExpense[item.categoryId!] = (categoryTxCountExpense[item.categoryId!] ?? 0) + 1;
        }
        if (tx.type == TransactionType.income && item.categoryId != null) {
          categorySumsIncome[item.categoryId!] = (categorySumsIncome[item.categoryId!] ?? 0) + item.amount;
          categoryTxCountIncome[item.categoryId!] = (categoryTxCountIncome[item.categoryId!] ?? 0) + 1;
        }
        if (item.allocation != null) {
          budgetSums[item.allocation!] = (budgetSums[item.allocation!] ?? 0) + item.amount;
        }
      }
    }

    final summary = ReportSummary(
      totalIncome: income,
      totalExpense: expense,
      transactionCount: txCount,
    );

    // ── Previous period summary (for comparison) ──────────────────────────────
    var prevIncome = 0.0;
    var prevExpense = 0.0;
    for (final tx in prevTxs) {
      if (tx.type == TransactionType.income) prevIncome += tx.amount;
      if (tx.type == TransactionType.expense) prevExpense += tx.amount;
    }
    final comparison = ReportComparison(
      prevIncome: prevIncome,
      prevExpense: prevExpense,
      prevNetCashflow: prevIncome - prevExpense,
    );

    // ── Expense category breakdown ────────────────────────────────────────────
    final totalExpForRatio = expense > 0 ? expense : 1.0;
    final expCategoryList = categorySumsExpense.entries.map((e) {
      final cat = categoryMap[e.key];
      return ReportCategoryItem(
        name: cat?.name ?? 'Unknown',
        color: cat?.color ?? '#CCCCCC',
        amount: e.value,
        ratio: e.value / totalExpForRatio,
        txCount: categoryTxCountExpense[e.key] ?? 0,
      );
    }).toList()..sort((a, b) => b.amount.compareTo(a.amount));

    // ── Income category breakdown ─────────────────────────────────────────────
    final totalIncForRatio = income > 0 ? income : 1.0;
    final incCategoryList = categorySumsIncome.entries.map((e) {
      final cat = categoryMap[e.key];
      return ReportCategoryItem(
        name: cat?.name ?? 'Unknown',
        color: cat?.color ?? '#CCCCCC',
        amount: e.value,
        ratio: e.value / totalIncForRatio,
        txCount: categoryTxCountIncome[e.key] ?? 0,
      );
    }).toList()..sort((a, b) => b.amount.compareTo(a.amount));

    // ── Trend ─────────────────────────────────────────────────────────────────
    final trendPoints = _buildTrend(txs, period, start);

    // ── Budget allocation ──────────────────────────────────────────────────────
    final budgetAllocation = ReportBudgetAllocation(
      need: budgetSums[TransactionAllocation.need]!,
      want: budgetSums[TransactionAllocation.want]!,
      saving: budgetSums[TransactionAllocation.saving]!,
    );

    return ReportData(
      summary: summary,
      comparison: comparison,
      expenseCategoryItems: expCategoryList,
      incomeCategoryItems: incCategoryList,
      trendPoints: trendPoints,
      budgetAllocation: budgetAllocation,
    );
  }

  // ── Helpers ─────────────────────────────────────────────────────────────────

  static (DateTime, DateTime) _dateRange(
    ReportPeriod period,
    DateTime now,
    DateTime? customStart,
    DateTime? customEnd,
  ) {
    return switch (period) {
      ReportPeriod.thisMonth => (
        DateTime(now.year, now.month),
        DateTime(now.year, now.month + 1).subtract(const Duration(seconds: 1)),
      ),
      ReportPeriod.lastMonth => (
        DateTime(now.year, now.month - 1),
        DateTime(now.year, now.month).subtract(const Duration(seconds: 1)),
      ),
      ReportPeriod.last3Months => (
        DateTime(now.year, now.month - 2),
        DateTime(now.year, now.month + 1).subtract(const Duration(seconds: 1)),
      ),
      ReportPeriod.last6Months => (
        DateTime(now.year, now.month - 5),
        DateTime(now.year, now.month + 1).subtract(const Duration(seconds: 1)),
      ),
      ReportPeriod.custom => (
        customStart ?? DateTime(now.year, now.month),
        customEnd ?? DateTime(now.year, now.month + 1).subtract(const Duration(seconds: 1)),
      ),
    };
  }

  static List<TransactionModel> _filterTx(
    List<TransactionModel> txs,
    DateTime start,
    DateTime end,
  ) {
    return txs.where((t) {
      final d = t.transactionDate.toLocal();
      return d.isAfter(start.subtract(const Duration(seconds: 1))) && d.isBefore(end.add(const Duration(seconds: 1)));
    }).toList();
  }

  static List<ReportTrendPoint> _buildTrend(
    List<TransactionModel> txs,
    ReportPeriod period,
    DateTime start,
  ) {
    if (period == ReportPeriod.thisMonth || period == ReportPeriod.lastMonth || period == ReportPeriod.custom) {
      return _buildWeeklyTrend(txs, start);
    }
    final months = period == ReportPeriod.last3Months ? 3 : 6;
    return _buildMonthlyTrend(txs, start, months);
  }

  static List<ReportTrendPoint> _buildWeeklyTrend(
    List<TransactionModel> txs,
    DateTime start,
  ) {
    final buckets = List.generate(4, (_) => (income: 0.0, expense: 0.0));
    for (final tx in txs) {
      final d = tx.transactionDate.toLocal();
      final dayOffset = d.difference(start).inDays;
      final week = (dayOffset ~/ 7).clamp(0, 3);
      if (tx.type == TransactionType.income) {
        buckets[week] = (income: buckets[week].income + tx.amount, expense: buckets[week].expense);
      }
      if (tx.type == TransactionType.expense) {
        buckets[week] = (income: buckets[week].income, expense: buckets[week].expense + tx.amount);
      }
    }

    final maxExp = buckets.map((b) => b.expense).fold<double>(0, (a, b) => a > b ? a : b);
    final maxInc = buckets.map((b) => b.income).fold<double>(0, (a, b) => a > b ? a : b);
    final labels = ['W1', 'W2', 'W3', 'W4'];

    return List.generate(
      4,
      (i) => ReportTrendPoint(
        label: labels[i],
        income: buckets[i].income,
        expense: buckets[i].expense,
        normalizedExpense: maxExp > 0 ? buckets[i].expense / maxExp : 0,
        normalizedIncome: maxInc > 0 ? buckets[i].income / maxInc : 0,
      ),
    );
  }

  static List<ReportTrendPoint> _buildMonthlyTrend(
    List<TransactionModel> txs,
    DateTime start,
    int months,
  ) {
    final now = DateTime.now();
    final points = <ReportTrendPoint>[];
    final monthlyData = <String, (double income, double expense)>{};

    for (var i = 0; i < months; i++) {
      final m = DateTime(now.year, now.month - (months - 1 - i));
      final key = '${m.year}-${m.month.toString().padLeft(2, '0')}';
      monthlyData[key] = (0, 0);
    }

    for (final tx in txs) {
      final d = tx.transactionDate.toLocal();
      final key = '${d.year}-${d.month.toString().padLeft(2, '0')}';
      if (monthlyData.containsKey(key)) {
        final cur = monthlyData[key]!;
        if (tx.type == TransactionType.income) {
          monthlyData[key] = (cur.$1 + tx.amount, cur.$2);
        }
        if (tx.type == TransactionType.expense) {
          monthlyData[key] = (cur.$1, cur.$2 + tx.amount);
        }
      }
    }

    final maxExp = monthlyData.values.map((v) => v.$2).fold<double>(0, (a, b) => a > b ? a : b);
    final maxInc = monthlyData.values.map((v) => v.$1).fold<double>(0, (a, b) => a > b ? a : b);

    const monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    for (final entry in monthlyData.entries) {
      final parts = entry.key.split('-');
      final monthIdx = int.parse(parts[1]) - 1;
      points.add(
        ReportTrendPoint(
          label: monthNames[monthIdx],
          income: entry.value.$1,
          expense: entry.value.$2,
          normalizedExpense: maxExp > 0 ? entry.value.$2 / maxExp : 0,
          normalizedIncome: maxInc > 0 ? entry.value.$1 / maxInc : 0,
        ),
      );
    }

    return points;
  }
}
