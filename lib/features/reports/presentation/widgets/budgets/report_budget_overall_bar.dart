import 'package:flutter/material.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/reports/presentation/widgets/budgets/report_progress_bar.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/theme/theme.dart';

/// Overall budget utilization header card with total spent, remaining, and progress bar.
class ReportBudgetOverallBar extends StatelessWidget {
  /// Creates a [ReportBudgetOverallBar].
  const new({required this.totalSpent, required this.totalLimit, required this.overallProgress, super.key});

  /// Total money spent across all budgets in the period.
  final int totalSpent;

  /// Total budget spending limit sum across all budgets.
  final int totalLimit;

  /// Clamped fraction of total limit spent.
  final double overallProgress;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final t = context.t.reports;
    final isDanger = overallProgress >= 1.0;
    final isWarning = !isDanger && overallProgress >= 0.8;
    final barColor = isDanger
        ? theme.colors.destructive
        : isWarning
        ? theme.colors.app.warning
        : theme.colors.primary;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colors.muted,
        borderRadius: theme.style.borderRadius.md,
        border: Border.all(color: theme.colors.border.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(overallProgress * 100).toStringAsFixed(1)}% ${t.spent}',
                style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
              ),
              Row(
                children: [
                  Text(
                    t.remaining,
                    style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
                  ),
                  const SizedBox(width: 4),
                  PokaAmountText(
                    amount: (totalLimit - totalSpent).abs(),
                    type: totalLimit >= totalSpent ? TransactionType.income : TransactionType.expense,
                    style: theme.typography.bodySecondary.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          ReportProgressBar(progress: overallProgress, color: barColor, animated: false),
        ],
      ),
    );
  }
}
