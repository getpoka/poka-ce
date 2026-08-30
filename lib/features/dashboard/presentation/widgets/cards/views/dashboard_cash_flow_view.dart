import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class DashboardCashFlowView extends ConsumerWidget {
  const DashboardCashFlowView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(dashboardProvider);

    final income = state.totalIncome;
    final expense = state.totalExpense;
    final saved = income > 0 ? ((income - expense) / income * 100).clamp(0, 100).toInt() : 0;

    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: theme.colors.primary, width: 12),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$saved%',
                  style: theme.typography.titleCard.copyWith(color: theme.colors.primary),
                ),
                Text(context.t.dashboard.saved, style: theme.typography.caption),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: saved >= 20
                      ? theme.colors.primary.withValues(alpha: 0.1)
                      : theme.colors.destructive.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  saved >= 20 ? context.t.dashboard.onTrack : context.t.dashboard.needsAttention,
                  style: theme.typography.bodySecondary.copyWith(
                    color: saved >= 20 ? theme.colors.primary : theme.colors.destructive,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildStatRow(
                context,
                context.t.dashboard.income,
                income.toCompactFormat(),
                theme.colors.app.income,
                FPhosphorIcons.arrowDownLeft,
              ),
              const SizedBox(height: 6),
              _buildStatRow(
                context,
                context.t.dashboard.expense,
                expense.toCompactFormat(),
                theme.colors.app.expense,
                FPhosphorIcons.arrowUpRight,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(BuildContext context, String label, String value, Color color, IconData iconData) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(iconData, size: 14, color: color),
              const SizedBox(width: 8),
              Text(label, style: theme.typography.bodySecondary),
            ],
          ),
          Text(value, style: theme.typography.amountTile),
        ],
      ),
    );
  }
}
