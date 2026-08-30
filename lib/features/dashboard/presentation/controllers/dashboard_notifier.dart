import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/dashboard/domain/services/dashboard_analytics_service.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_notifier.g.dart';

/// State for the dashboard containing accounts and recent transactions.
class DashboardState {
  const DashboardState({
    this.accounts = const [],
    this.recentTransactions = const [],
    this.isLoading = true,
    this.netWorth = 0.0,
    this.totalAssets = 0.0,
    this.totalLiabilities = 0.0,
    this.totalIncome = 0.0,
    this.totalExpense = 0.0,
    this.activeAccountCount = 0,
    this.categoryExpenses = const [],
    this.budgetAllocations = const {},
    this.dailySpending = const [0, 0, 0, 0, 0, 0, 0],
    this.maxDailySpending = 0.0,
    this.normalizedDailySpending = const [0, 0, 0, 0, 0, 0, 0],
    this.expenseDelta = 0.0,
    this.incomeDelta = 0.0,
    this.categoriesById = const {},
    this.accountsById = const {},
  });

  final List<AccountModel> accounts;
  final List<TransactionModel> recentTransactions;
  final bool isLoading;
  final double netWorth;
  final double totalAssets;
  final double totalLiabilities;
  final double totalIncome;
  final double totalExpense;
  final int activeAccountCount;
  final List<CategoryExpenseItem> categoryExpenses;
  final Map<TransactionAllocation, double> budgetAllocations;
  final List<double> dailySpending;
  final double maxDailySpending;
  final List<double> normalizedDailySpending;
  final double expenseDelta;
  final double incomeDelta;
  final Map<String, CategoryModel> categoriesById;
  final Map<String, AccountModel> accountsById;

  DashboardState copyWith({
    List<AccountModel>? accounts,
    List<TransactionModel>? recentTransactions,
    bool? isLoading,
    double? netWorth,
    double? totalAssets,
    double? totalLiabilities,
    double? totalIncome,
    double? totalExpense,
    int? activeAccountCount,
    List<CategoryExpenseItem>? categoryExpenses,
    Map<TransactionAllocation, double>? budgetAllocations,
    List<double>? dailySpending,
    double? maxDailySpending,
    List<double>? normalizedDailySpending,
    double? expenseDelta,
    double? incomeDelta,
    Map<String, CategoryModel>? categoriesById,
    Map<String, AccountModel>? accountsById,
  }) {
    return DashboardState(
      accounts: accounts ?? this.accounts,
      recentTransactions: recentTransactions ?? this.recentTransactions,
      isLoading: isLoading ?? this.isLoading,
      netWorth: netWorth ?? this.netWorth,
      totalAssets: totalAssets ?? this.totalAssets,
      totalLiabilities: totalLiabilities ?? this.totalLiabilities,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      activeAccountCount: activeAccountCount ?? this.activeAccountCount,
      categoryExpenses: categoryExpenses ?? this.categoryExpenses,
      budgetAllocations: budgetAllocations ?? this.budgetAllocations,
      dailySpending: dailySpending ?? this.dailySpending,
      maxDailySpending: maxDailySpending ?? this.maxDailySpending,
      normalizedDailySpending: normalizedDailySpending ?? this.normalizedDailySpending,
      expenseDelta: expenseDelta ?? this.expenseDelta,
      incomeDelta: incomeDelta ?? this.incomeDelta,
      categoriesById: categoriesById ?? this.categoriesById,
      accountsById: accountsById ?? this.accountsById,
    );
  }
}

@riverpod
class DashboardNotifier extends _$DashboardNotifier {
  @override
  DashboardState build() {
    final accountsAsync = ref.watch(accountsStreamProvider);
    final transactionsAsync = ref.watch(recentTransactionsStreamProvider);
    final categoriesAsync = ref.watch(categoriesStreamProvider);

    final isLoading = accountsAsync.isLoading || transactionsAsync.isLoading || categoriesAsync.isLoading;

    final accounts = accountsAsync.value ?? [];
    final transactions = transactionsAsync.value ?? [];
    final categories = categoriesAsync.value ?? [];

    final accountMetrics = DashboardAnalyticsService.calculateAccountMetrics(accounts);
    final txMetrics = DashboardAnalyticsService.calculateTransactionMetrics(transactions, categories);

    return DashboardState(
      accounts: accounts,
      recentTransactions: transactions,
      isLoading: isLoading && accountsAsync.value == null, // Only truly loading if no data
      netWorth: accountMetrics.netWorth,
      totalAssets: accountMetrics.totalAssets,
      totalLiabilities: accountMetrics.totalLiabilities,
      totalIncome: txMetrics.totalIncome,
      totalExpense: txMetrics.totalExpense,
      activeAccountCount: accountMetrics.activeAccountCount,
      categoryExpenses: txMetrics.categoryExpenses,
      budgetAllocations: txMetrics.budgetAllocations,
      dailySpending: txMetrics.dailySpending,
      maxDailySpending: txMetrics.maxDailySpending,
      normalizedDailySpending: txMetrics.normalizedDailySpending,
      expenseDelta: txMetrics.expenseDelta,
      incomeDelta: txMetrics.incomeDelta,
      categoriesById: {for (final c in categories) c.id: c},
      accountsById: {for (final a in accounts) a.id: a},
    );
  }

  /// Refreshes the dashboard data by invalidating the streams.
  Future<void> refresh() async {
    ref
      ..invalidate(accountsStreamProvider)
      ..invalidate(recentTransactionsStreamProvider)
      ..invalidate(categoriesStreamProvider);
  }
}
