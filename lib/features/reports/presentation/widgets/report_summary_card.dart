import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/stat_row_tile.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

/// Cashflow summary hero card — donut chart + income/expense/net rows.
/// Section label lives OUTSIDE this card on the parent page.
class ReportSummaryCard extends ConsumerWidget {
  const ReportSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(reportProvider);
    final summary = state.data.summary;
    final comparison = state.data.comparison;
    final t = context.t.reports;

    final settingsState = ref.watch(settingsProvider);
    final baseCurrency = settingsState.settings?.baseCurrency;
    final symbol = baseCurrency?.symbol ?? 'Rp';
    final precision = baseCurrency?.precision ?? 0;
    final localeFormat = settingsState.settings?.numberFormat ?? 'system';
    final isBalanceVisible = ref.watch(balanceVisibilityProvider);

    final incomeStr = summary.totalIncome.toCurrencyFormat(
      symbol: symbol,
      precision: precision,
      locale: localeFormat,
      isVisible: isBalanceVisible,
    );
    final expenseStr = summary.totalExpense.toCurrencyFormat(
      symbol: symbol,
      precision: precision,
      locale: localeFormat,
      isVisible: isBalanceVisible,
    );
    final netStr = summary.netCashflow.abs().toCurrencyFormat(
      symbol: symbol,
      precision: precision,
      locale: localeFormat,
      isVisible: isBalanceVisible,
    );
    final savingsPct = summary.savingsRatePct;
    final isOnTrack = summary.isOnTrack;
    final isNegative = summary.netCashflow < 0;

    // Period-over-period deltas
    final incomeDelta = comparison.incomeChangePct(summary.totalIncome);
    final expenseDelta = comparison.expenseChangePct(summary.totalExpense);
    final netDelta = comparison.netChangePct(summary.netCashflow);
    final prevLabel = state.previousPeriodLabel;

    // Donut proportions: income vs expense
    final total = summary.totalIncome + summary.totalExpense;
    final incomeVal = total > 0 ? summary.totalIncome : 1.0;
    final expenseVal = total > 0 ? summary.totalExpense : 1.0;

    final incomeColor = theme.colors.app.income;
    final expenseColor = theme.colors.app.expense;

    return FCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Status badge ────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.cashflow,
                  style: theme.typography.bodyPrimary.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
                _StatusBadge(isOnTrack: isOnTrack),
              ],
            ),
            const SizedBox(height: 12),

            // ── Donut chart + stats ─────────────────────────────────────
            Row(
              children: [
                // Donut (fl_chart PieChart)
                SizedBox(
                  width: 90,
                  height: 90,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          sectionsSpace: 2,
                          centerSpaceRadius: 30,
                          startDegreeOffset: -90,
                          sections: [
                            PieChartSectionData(
                              value: incomeVal,
                              color: incomeColor,
                              radius: 14,
                              showTitle: false,
                            ),
                            PieChartSectionData(
                              value: expenseVal,
                              color: expenseColor,
                              radius: 14,
                              showTitle: false,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$savingsPct%',
                            style: theme.typography.bodyPrimary.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colors.primary,
                            ),
                          ),
                          Text(
                            t.savingsRate,
                            style: theme.typography.labelBadge.copyWith(
                              color: theme.colors.mutedForeground,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Stats column
                Expanded(
                  child: Column(
                    children: [
                      StatRowTile(
                        icon: FPhosphorIcons.arrowDownLeft,
                        iconColor: incomeColor,
                        label: t.income,
                        value: incomeStr,
                        delta: incomeDelta,
                        prevLabel: prevLabel,
                        positiveIsGood: true,
                      ),
                      const SizedBox(height: 10),
                      StatRowTile(
                        icon: FPhosphorIcons.arrowUpRight,
                        iconColor: expenseColor,
                        label: t.expense,
                        value: expenseStr,
                        delta: expenseDelta,
                        prevLabel: prevLabel,
                        positiveIsGood: false,
                      ),
                      const SizedBox(height: 10),
                      StatRowTile(
                        icon: isNegative ? FPhosphorIcons.trendDown : FPhosphorIcons.trendUp,
                        iconColor: isNegative ? expenseColor : incomeColor,
                        label: t.netCashflow,
                        value: (isNegative ? '-' : '+') + netStr,
                        delta: netDelta,
                        prevLabel: prevLabel,
                        positiveIsGood: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.isOnTrack});

  final bool isOnTrack;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final color = isOnTrack ? theme.colors.app.success : theme.colors.app.warning;
    final label = isOnTrack ? (context.t.reports.onTrack) : (context.t.reports.needsAttention);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.typography.labelBadge.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
