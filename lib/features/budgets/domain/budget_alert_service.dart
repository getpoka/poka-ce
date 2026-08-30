import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/services/notification_service.dart';
import 'package:poka_ce/core/utils/logger.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/domain/i_budget_repository.dart';
import 'package:poka_ce/i18n/strings.g.dart';

class BudgetAlertService {
  const BudgetAlertService({
    required IBudgetRepository budgetRepository,
  }) : _budgetRepo = budgetRepository;

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

        var startDate = now;
        var endDate = now;

        switch (budget.period) {
          case BudgetPeriod.monthly:
            final resetDay = budget.resetDay ?? 1;
            if (now.day >= resetDay) {
              startDate = DateTime(now.year, now.month, resetDay);
              endDate = DateTime(now.year, now.month + 1, resetDay).subtract(const Duration(seconds: 1));
            } else {
              startDate = DateTime(now.year, now.month - 1, resetDay);
              endDate = DateTime(now.year, now.month, resetDay).subtract(const Duration(seconds: 1));
            }
          case BudgetPeriod.weekly:
            final daysSinceMonday = now.weekday - 1;
            startDate = DateTime(now.year, now.month, now.day).subtract(Duration(days: daysSinceMonday));
            endDate = startDate.add(const Duration(days: 7)).subtract(const Duration(seconds: 1));
          case BudgetPeriod.yearly:
            startDate = DateTime(now.year);
            endDate = DateTime(now.year, 12, 31, 23, 59, 59);
          case BudgetPeriod.custom:
            startDate = budget.startDate;
            endDate = budget.endDate ?? now.add(const Duration(days: 3650));
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
              body: 'You have used ${percentage.toStringAsFixed(1)}% of your ${budget.name} budget.',
            );
          }
        }
      }
    } on Object catch (e, st) {
      talker.handle(e, st, 'BudgetAlertService.checkAlerts');
    }
  }
}
