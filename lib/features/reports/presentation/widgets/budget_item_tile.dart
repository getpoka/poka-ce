import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_progress_provider.dart';
import 'package:poka_ce/features/reports/presentation/widgets/budgets/report_budget_status_chip.dart';
import 'package:poka_ce/features/reports/presentation/widgets/budgets/report_progress_bar.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/theme/theme.dart';

/// Single budget utilization item row showing name, progress bar, spent and limit amounts.
class BudgetItemTile extends ConsumerWidget {
  /// Creates a [BudgetItemTile].
  const new({required this.budget, super.key});

  /// The budget model being tracked.
  final BudgetModel budget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final t = context.t.reports;

    final spentAsync = ref.watch(budgetProgressProvider(budget));
    final spent = spentAsync.value ?? 0;

    final isDanger = spent > budget.amount;
    final progress = budget.amount > 0 ? (spent / budget.amount).clamp(0.0, 1.0) : 0.0;
    final isWarning = !isDanger && progress >= 0.8;

    final progressColor = isDanger
        ? theme.colors.destructive
        : isWarning
        ? theme.colors.app.warning
        : theme.colors.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                budget.name,
                style: theme.typography.bodyPrimary.copyWith(fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            if (isDanger)
              ReportBudgetStatusChip(label: t.overBudget, color: theme.colors.destructive)
            else
              Text(
                '${(progress * 100).toStringAsFixed(0)}%',
                style: theme.typography.bodySecondary.copyWith(
                  color: theme.colors.mutedForeground,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        ReportProgressBar(progress: progress, color: progressColor),
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PokaAmountText(
              amount: spent,
              type: TransactionType.expense,
              style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
            ),
            PokaAmountText(
              amount: budget.amount,
              type: TransactionType.transfer,
              style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
            ),
          ],
        ),
      ],
    );
  }
}
