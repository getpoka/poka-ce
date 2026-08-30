import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/transactions/presentation/controllers/transaction_list_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'budget_progress_provider.g.dart';

@riverpod
Future<int> budgetProgress(Ref ref, BudgetModel budget) async {
  // Watch transactionListNotifierProvider so that if new transactions are added,
  // this budget progress is re-evaluated.
  ref.watch(transactionListNotifierProvider);

  final repo = ref.read(budgetRepositoryProvider);

  DateTime startDate;
  DateTime endDate;

  final now = DateTime.now();

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
      // Week starts on Monday
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
