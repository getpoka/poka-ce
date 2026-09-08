import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_list_notifier.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_notifier.g.dart';
part 'report_notifier.freezed.dart';

// ─────────────────────────────────────────────────────────────────────────────
// State
// ─────────────────────────────────────────────────────────────────────────────

/// UI state holding the active period selection, loaded budgets, and computed financial report data.
@freezed
abstract class ReportState with _$ReportState {
  const factory ReportState({
    @Default(ReportPeriod.thisMonth) ReportPeriod period,
    DateTime? customDateStart,
    DateTime? customDateEnd,
    @Default(ReportData()) ReportData data,
    @Default([]) List<BudgetModel> budgets,
    @Default(true) bool isLoading,
  }) = _ReportState;

  const ReportState._();

  /// Human-readable label for the previous period (used by comparison banner).
  String get previousPeriodLabel => switch (period) {
    ReportPeriod.thisMonth => t.reports.prevLastMonth,
    ReportPeriod.lastMonth => t.reports.prevMonth,
    ReportPeriod.last3Months => t.reports.prev3Months,
    ReportPeriod.last6Months => t.reports.prev6Months,
    ReportPeriod.custom => t.reports.prevPeriod,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// Notifier
// ─────────────────────────────────────────────────────────────────────────────

/// Notifier driving the financial reports tab, calculating metrics dynamically as ledger data mutates.
@riverpod
class ReportNotifier extends _$ReportNotifier {
  /// Tracks selected period as a field so it survives reactive rebuilds
  /// without accessing [state] (which is uninitialized during first [build]).
  ReportPeriod _period = ReportPeriod.thisMonth;
  DateTime? _customStart;
  DateTime? _customEnd;

  @override
  ReportState build() {
    // Watch streams reactively — recalculate when data changes.
    final transactionsAsync = ref.watch(recentTransactionsStreamProvider);
    final categoriesAsync = ref.watch(categoriesStreamProvider);
    final budgetsAsync = ref.watch(budgetListProvider);

    final isLoadingBase =
        (transactionsAsync.isLoading && !transactionsAsync.hasValue) ||
        (categoriesAsync.isLoading && !categoriesAsync.hasValue);

    final transactions = transactionsAsync.value ?? [];
    final categories = categoriesAsync.value ?? [];

    // Budgets are now watched at the root level, but progress is watched in UI tiles!
    final budgets = budgetsAsync.value ?? [];

    final reportData = ReportAnalyticsService.calculate(
      transactions,
      categories,
      _period,
      customStart: _customStart,
      customEnd: _customEnd,
    );

    return ReportState(
      period: _period,
      customDateStart: _customStart,
      customDateEnd: _customEnd,
      data: reportData,
      budgets: budgets,
      isLoading: isLoadingBase,
    );
  }

  /// Changes the selected period and triggers a reactive rebuild.
  void setPeriod(ReportPeriod period) {
    _period = period;
    if (period != ReportPeriod.custom) {
      _customStart = null;
      _customEnd = null;
    }
    ref.invalidateSelf();
  }

  /// Applies a custom date range and switches to the custom period.
  void setCustomRange(DateTime start, DateTime end) {
    _period = ReportPeriod.custom;
    _customStart = start;
    _customEnd = end;
    ref.invalidateSelf();
  }
}
