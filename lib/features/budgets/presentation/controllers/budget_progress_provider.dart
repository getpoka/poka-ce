import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/database/converters/local_date_converter.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'budget_progress_provider.g.dart';

/// Calculates the current cycle's total spent amount for [budget], reactively recomputing whenever transactions mutate.
@riverpod
Future<int> budgetProgress(Ref ref, BudgetModel budget) async {
  // Subscribe to transactions stream so progress automatically recalculates upon transaction mutations
  ref.watch(transactionListNotifierProvider);

  final repo = ref.read(budgetRepositoryProvider);

  final now = DateTime.now();
  String startDate;
  String endDate;

  // Compute active cycle date boundaries based on configured recurrence period and reset day
  switch (budget.period) {
    case BudgetPeriod.monthly:
      final resetDay = budget.resetDay ?? 1;
      final DateTime startDt;
      final DateTime endDt;
      if (now.day >= resetDay) {
        startDt = DateTime(now.year, now.month, resetDay);
        endDt = DateTime(now.year, now.month + 1, resetDay).subtract(const Duration(seconds: 1));
      } else {
        startDt = DateTime(now.year, now.month - 1, resetDay);
        endDt = DateTime(now.year, now.month, resetDay).subtract(const Duration(seconds: 1));
      }
      startDate = formatAsLocalDateTime(startDt);
      endDate = formatAsLocalDateTime(endDt);
    case BudgetPeriod.weekly:
      // Week starts on Monday
      final daysSinceMonday = now.weekday - 1;
      final startDt = DateTime(now.year, now.month, now.day).subtract(Duration(days: daysSinceMonday));
      final endDt = startDt.add(const Duration(days: 7)).subtract(const Duration(seconds: 1));
      startDate = formatAsLocalDateTime(startDt);
      endDate = formatAsLocalDateTime(endDt);
    case BudgetPeriod.yearly:
      startDate = '${now.year}-01-01T00:00:00';
      endDate = '${now.year}-12-31T23:59:59';
    case BudgetPeriod.custom:
      startDate = budget.startDate.contains('T') ? budget.startDate : '${budget.startDate}T00:00:00';
      final end = budget.endDate;
      endDate = end != null ? (end.contains('T') ? end : '${end}T23:59:59') : '${now.year + 10}-12-31T23:59:59';
  }

  final result = await repo.getSpentAmountForBudget(
    startDate: startDate,
    endDate: endDate,
    categoryId: budget.categoryId,
    accountId: budget.accountId,
  );

  switch (result) {
    case Success(value: final spent):
      return spent;
    case ErrorResult():
      return 0;
  }
}
