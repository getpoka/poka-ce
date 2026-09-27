import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/services/notification_service.dart';
import 'package:poka_ce/core/utils/logger.dart';
import 'package:poka_ce/database/converters/local_date_converter.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/domain/i_budget_repository.dart';
import 'package:poka_ce/i18n/strings.g.dart';

/// Domain service that monitors budget utilization and dispatches threshold alert notifications.
class BudgetAlertService {
  /// Creates a [BudgetAlertService] with the provided [IBudgetRepository].
  const new({required IBudgetRepository budgetRepository}) : _budgetRepo = budgetRepository;

  final IBudgetRepository _budgetRepo;

  /// Evaluates all budgets and triggers local notifications if the threshold is exceeded.
  Future<void> checkAlerts() async {
    try {
      final budgetsResult = await _budgetRepo.getBudgets();
      if (budgetsResult is! Success<List<BudgetModel>, Failure>) return;
      final budgets = budgetsResult.value;

      final now = DateTime.now();

      for (final budget in budgets) {
        if (budget.alertThreshold == null || budget.alertThreshold! <= 0) continue;

        String startDate;
        String endDate;

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

        final spentResult = await _budgetRepo.getSpentAmountForBudget(
          startDate: startDate,
          endDate: endDate,
          categoryId: budget.categoryId,
          accountId: budget.accountId,
        );

        if (spentResult is Success<int, Failure>) {
          final spent = spentResult.value;
          final percentage = (spent / budget.amount) * 100;

          if (percentage >= budget.alertThreshold!) {
            await notificationService.showNotification(
              id: budget.id.hashCode,
              title: t.budgets.budgetAlert(name: budget.name),
              body: t.budgets.budgetExceededAlert(percentage: percentage.toStringAsFixed(1), name: budget.name),
            );
          }
        }
      }
    } on Object catch (e, st) {
      talker.handle(e, st, 'BudgetAlertService.checkAlerts');
    }
  }
}
