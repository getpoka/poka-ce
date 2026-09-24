import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/charts/report_cashflow_bar_chart.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

/// Income vs Expense grouped bar chart card showing cashflow distribution and periodic average.
class ReportCashflowChart extends ConsumerWidget {
  /// Creates a [ReportCashflowChart].
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(reportProvider);
    final isBalanceVisible = ref.watch(balanceVisibilityProvider);
    final precision = ref.watch(settingsProvider).settings?.baseCurrency?.precision ?? 0;
    final trendPoints = state.data.trendPoints;
    final t = context.t.reports;
    final expenseColor = theme.colors.app.expense;
    final incomeColor = theme.colors.app.income;

    return FCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Legend + quick stats ──────────────────────────────────
            Row(
              children: [
                _LegendDot(color: incomeColor, label: t.income),
                const SizedBox(width: 14),
                _LegendDot(color: expenseColor, label: t.expense),
                const Spacer(),
                _QuickStat(
                  label: t.average,
                  value: trendPoints.isNotEmpty
                      ? (state.data.summary.totalExpense / trendPoints.length).toCompactFormat(
                          precision: precision,
                          isVisible: isBalanceVisible,
                        )
                      : (isBalanceVisible ? '0' : '••••••'),
                  color: theme.colors.mutedForeground,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ── Bar Chart ──────────────────────────────────────────────
            if (trendPoints.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text(
                    t.noData,
                    style: theme.typography.bodyPrimary.copyWith(color: theme.colors.mutedForeground),
                  ),
                ),
              )
            else
              SizedBox(
                height: 160,
                child: ReportCashflowBarChart(
                  points: trendPoints,
                  incomeColor: incomeColor,
                  expenseColor: expenseColor,
                  theme: theme,
                  isBalanceVisible: isBalanceVisible,
                  precision: precision,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const new({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: theme.typography.bodyPrimary.copyWith(color: theme.colors.mutedForeground)),
      ],
    );
  }
}

class _QuickStat extends StatelessWidget {
  const new({required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label, style: theme.typography.caption.copyWith(color: theme.colors.mutedForeground)),
        Text(
          value,
          style: theme.typography.bodySecondary.copyWith(fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}
