import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_progress_provider.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/theme/theme.dart';

class BudgetItemTile extends ConsumerWidget {
  const BudgetItemTile({required this.budget, super.key});
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
              _StatusChip(label: t.overBudget, color: theme.colors.destructive)
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
        _ProgressBar(progress: progress, color: progressColor),
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
              type: TransactionType.income,
              style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: context.theme.typography.labelBadge.copyWith(color: color),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.progress, required this.color});
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        height: 5,
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          color: theme.colors.muted,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: progress),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            builder: (_, value, _) => FractionallySizedBox(
              widthFactor: value,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
