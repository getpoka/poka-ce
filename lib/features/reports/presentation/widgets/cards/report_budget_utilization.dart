import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_progress_provider.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/tiles/budget_item_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_amount_text.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_budget_utilization.g.dart';

@riverpod
Future<int> reportBudgetTotalSpent(Ref ref) async {
  final state = ref.watch(reportProvider);
  final budgets = state.budgets;
  var total = 0;
  for (final b in budgets) {
    // Awaiting in a loop is supported by Riverpod inside async providers
    final spent = await ref.watch(budgetProgressProvider(b).future);
    total += spent;
  }
  return total;
}

/// Budget utilization section — shows each budget's progress and overall utilization.
/// Section label lives OUTSIDE this card on the parent page.
class ReportBudgetUtilization extends ConsumerWidget {
  const ReportBudgetUtilization({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reportProvider);
    final budgets = state.budgets;
    final t = context.t.reports;

    if (budgets.isEmpty) {
      return PokaEmptyView(
        icon: FPhosphorIcons.chartPieSlice,
        title: t.noBudgets,
        subtitle: t.noBudgetsDesc,
        hasBorder: true,
      );
    }

    final totalSpentAsync = ref.watch(reportBudgetTotalSpentProvider);
    final totalSpent = totalSpentAsync.value ?? 0;

    final totalLimit = budgets.fold<int>(0, (sum, b) => sum + b.amount);
    final overallProgress = totalLimit > 0 ? (totalSpent / totalLimit).clamp(0.0, 1.0) : 0.0;

    return FCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Overall utilization bar ──────────────────────────────────
            _OverallBar(
              totalSpent: totalSpent,
              totalLimit: totalLimit,
              overallProgress: overallProgress,
            ),
            const SizedBox(height: 16),

            // ── Individual budgets ──────────────────────────────────────
            ...List.generate(budgets.length, (index) {
              final budget = budgets[index];
              return Padding(
                padding: EdgeInsets.only(bottom: index < budgets.length - 1 ? 14 : 0),
                child: BudgetItemTile(budget: budget),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _OverallBar extends StatelessWidget {
  const _OverallBar({
    required this.totalSpent,
    required this.totalLimit,
    required this.overallProgress,
  });

  final int totalSpent;
  final int totalLimit;
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
                style: theme.typography.bodySecondary.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
              Row(
                children: [
                  Text(
                    t.remaining,
                    style: theme.typography.bodySecondary.copyWith(
                      color: theme.colors.mutedForeground,
                    ),
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
          _ProgressBar(progress: overallProgress, color: barColor),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

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
          child: FractionallySizedBox(
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
