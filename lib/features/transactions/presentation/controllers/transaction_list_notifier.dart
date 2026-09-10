import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/extensions/datetime_extension.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';

/// The date-grouping mode for the transaction list.
enum TransactionViewMode { day, week, month }

/// Immutable filter applied on top of the active date window.
class TransactionFilter {
  /// Creates a [TransactionFilter] with optional criteria.
  const TransactionFilter({
    this.types = const {},
    this.accountIds = const {},
    this.categoryIds = const {},
    this.searchQuery = '',
  });

  /// Transaction types to include.
  final Set<TransactionType> types;

  /// Account IDs to filter by.
  final Set<String> accountIds;

  /// Category IDs to filter by.
  final Set<String> categoryIds;

  /// Text query matched against note or amount.
  final String searchQuery;

  /// Returns `true` if any filtering criteria is currently active.
  bool get isActive => types.isNotEmpty || accountIds.isNotEmpty || categoryIds.isNotEmpty || searchQuery.isNotEmpty;

  /// Creates a copy of this filter with updated criteria.
  TransactionFilter copyWith({
    Set<TransactionType>? types,
    Set<String>? accountIds,
    Set<String>? categoryIds,
    String? searchQuery,
  }) => TransactionFilter(
    types: types ?? this.types,
    accountIds: accountIds ?? this.accountIds,
    categoryIds: categoryIds ?? this.categoryIds,
    searchQuery: searchQuery ?? this.searchQuery,
  );
}

/// State for the transaction list screen, including date window and filter.
class TransactionListState {
  /// Creates a [TransactionListState] instance.
  const TransactionListState({
    required this.focusedDate,
    this.transactions = const [],
    this.viewMode = TransactionViewMode.day,
    this.filter = const TransactionFilter(),
    this.isLoading = true,
    this.errorMessage,
  });

  /// The active transactions returned from the repository.
  final List<TransactionModel> transactions;

  /// The active date-grouping mode (day / week / month).
  final TransactionViewMode viewMode;

  /// The anchor date used to determine the current visible period.
  final DateTime focusedDate;

  /// The currently active advanced filter.
  final TransactionFilter filter;

  final bool isLoading;
  final String? errorMessage;

  // ── Private date helpers ─────────────────────────────────────────────────

  static DateTime startOfWeek(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);
    return d.subtract(Duration(days: d.weekday - 1));
  }

  static int _weekNumber(DateTime date) {
    final startOfYear = DateTime(date.year);
    final firstThursday = startOfYear.add(
      Duration(days: (4 - startOfYear.weekday + 7) % 7),
    );
    final firstMonday = firstThursday.subtract(const Duration(days: 3));
    final diff = DateTime(date.year, date.month, date.day).difference(firstMonday);
    return (diff.inDays / 7).floor() + 1;
  }

  // ── Period summary (based on fetched transactions) ─────────────

  int get periodIncome =>
      transactions.where((t) => t.type == TransactionType.income).fold(0, (sum, t) => sum + t.amount);

  int get periodExpense =>
      transactions.where((t) => t.type == TransactionType.expense).fold(0, (sum, t) => sum + t.amount);

  int get periodNet => periodIncome - periodExpense;

  // ── Period label ─────────────────────────────────────────────────────────

  String get periodLabel => switch (viewMode) {
    TransactionViewMode.day => focusedDate.toRelativeDateString(),
    TransactionViewMode.week => () {
      final weekNum = _weekNumber(focusedDate);
      return t.transactions.weekNumber(
        weekNum: weekNum.toString(),
        date: DateFormat('MMM yyyy', LocaleSettings.currentLocale.languageCode).format(focusedDate),
      );
    }(),
    TransactionViewMode.month => DateFormat('MMMM yyyy', LocaleSettings.currentLocale.languageCode).format(focusedDate),
  };

  String get periodShortLabel => switch (viewMode) {
    TransactionViewMode.day => t.transactions.viewModeDaily,
    TransactionViewMode.week => t.transactions.viewModeWeekly,
    TransactionViewMode.month => t.transactions.viewModeMonthly,
  };

  bool get isCurrentPeriod {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final focused = DateTime(focusedDate.year, focusedDate.month, focusedDate.day);
    return switch (viewMode) {
      TransactionViewMode.day => focused == today,
      TransactionViewMode.week => startOfWeek(focused) == startOfWeek(today),
      TransactionViewMode.month => focused.year == now.year && focused.month == now.month,
    };
  }

  TransactionListState copyWith({
    List<TransactionModel>? transactions,
    TransactionViewMode? viewMode,
    DateTime? focusedDate,
    TransactionFilter? filter,
    bool? isLoading,
    String? errorMessage,
  }) => TransactionListState(
    transactions: transactions ?? this.transactions,
    viewMode: viewMode ?? this.viewMode,
    focusedDate: focusedDate ?? this.focusedDate,
    filter: filter ?? this.filter,
    isLoading: isLoading ?? this.isLoading,
    errorMessage: errorMessage,
  );
}

/// Notifier for the TransactionListPage.
class TransactionListNotifier extends Notifier<TransactionListState> {
  StreamSubscription<Result<List<TransactionModel>, Failure>>? _subscription;

  @override
  TransactionListState build() {
    ref.onDispose(() {
      _subscription?.cancel();
    });

    final initialState = TransactionListState(
      focusedDate: DateTime.now(),
    );

    // Defer the subscription so it runs after build returns
    Future.microtask(() => _listenToTransactions(initialState));

    return initialState;
  }

  void _listenToTransactions(TransactionListState targetState) {
    _subscription?.cancel();
    state = targetState.copyWith(isLoading: true);

    final focused = DateTime(targetState.focusedDate.year, targetState.focusedDate.month, targetState.focusedDate.day);

    DateTime? windowStart;
    DateTime? windowEnd;

    switch (targetState.viewMode) {
      case TransactionViewMode.day:
        windowStart = focused;
        windowEnd = focused.add(const Duration(days: 1)).subtract(const Duration(milliseconds: 1));
      case TransactionViewMode.week:
        final start = TransactionListState.startOfWeek(focused);
        windowStart = start;
        windowEnd = start.add(const Duration(days: 7)).subtract(const Duration(milliseconds: 1));
      case TransactionViewMode.month:
        windowStart = DateTime(focused.year, focused.month);
        final nextMonth = focused.month == 12 ? 1 : focused.month + 1;
        final nextYear = focused.month == 12 ? focused.year + 1 : focused.year;
        windowEnd = DateTime(nextYear, nextMonth).subtract(const Duration(milliseconds: 1));
    }

    _subscription = ref
        .read(transactionRepositoryProvider)
        .watchTransactions(
          startDate: windowStart,
          endDate: windowEnd,
          accountIds: targetState.filter.accountIds,
          categoryIds: targetState.filter.categoryIds,
          types: targetState.filter.types,
        )
        .listen((result) {
          result.fold(
            (transactions) {
              var filtered = transactions;
              final query = targetState.filter.searchQuery.trim().toLowerCase();
              if (query.isNotEmpty) {
                filtered = transactions.where((t) {
                  final inHeader =
                      (t.note?.toLowerCase().contains(query) ?? false) || t.amount.toString().contains(query);
                  if (inHeader) return true;

                  return t.items.any(
                    (item) =>
                        (item.note?.toLowerCase().contains(query) ?? false) || item.amount.toString().contains(query),
                  );
                }).toList();
              }
              state = state.copyWith(transactions: filtered, isLoading: false);
            },
            (failure) => state = state.copyWith(isLoading: false, errorMessage: failure.message),
          );
        });
  }

  /// Re-triggers database query subscription with the current state configuration.
  Future<void> refresh() async {
    _listenToTransactions(state);
  }

  /// Sets the active calendar grouping mode (daily, weekly, or monthly).
  void setViewMode(TransactionViewMode mode) {
    _listenToTransactions(state.copyWith(viewMode: mode));
  }

  /// Navigates the focused date window backwards by one unit.
  void navigatePrev() {
    _listenToTransactions(state.copyWith(focusedDate: _offsetDate(-1)));
  }

  /// Navigates the focused date window forwards by one unit unless already at current period.
  void navigateNext() {
    if (state.isCurrentPeriod) return;
    _listenToTransactions(state.copyWith(focusedDate: _offsetDate(1)));
  }

  /// Centers the date window onto today's date.
  void goToToday() {
    _listenToTransactions(state.copyWith(focusedDate: DateTime.now()));
  }

  /// Jumps the date window to the specified arbitrary [date].
  void jumpToDate(DateTime date) {
    _listenToTransactions(state.copyWith(focusedDate: date));
  }

  /// Applies advanced filtering criteria to the reactive stream.
  void applyFilter(TransactionFilter filter) {
    _listenToTransactions(state.copyWith(filter: filter));
  }

  /// Clears all active filters back to default.
  void clearFilter() {
    _listenToTransactions(state.copyWith(filter: const TransactionFilter()));
  }

  /// Deletes a transaction by its [id].
  Future<void> deleteTransaction(String id) async {
    await ref.read(transactionRepositoryProvider).deleteTransaction(id);
  }

  /// Restores a previously deleted [transaction].
  Future<void> restoreTransaction(TransactionModel transaction) async {
    await ref.read(transactionRepositoryProvider).restoreTransaction(transaction);
  }

  DateTime _offsetDate(int direction) {
    final d = state.focusedDate;
    return switch (state.viewMode) {
      TransactionViewMode.day => d.add(Duration(days: direction)),
      TransactionViewMode.week => d.add(Duration(days: direction * 7)),
      TransactionViewMode.month => DateTime(d.year, d.month + direction),
    };
  }
}

/// Provider exposing the reactive [TransactionListNotifier] and its state.
final transactionListNotifierProvider = NotifierProvider<TransactionListNotifier, TransactionListState>(() {
  return TransactionListNotifier();
});
