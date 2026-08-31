import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

/// Income vs Expense grouped bar chart using fl_chart.
/// Section label lives OUTSIDE this card on the parent page.
class ReportCashflowChart extends ConsumerWidget {
  const ReportCashflowChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(reportProvider);
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
                      ? (state.data.summary.totalExpense / trendPoints.length).toCompactFormat()
                      : '0',
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
                child: _CashflowBarChart(
                  points: trendPoints,
                  incomeColor: incomeColor,
                  expenseColor: expenseColor,
                  theme: theme,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _CashflowBarChart extends StatelessWidget {
  const _CashflowBarChart({
    required this.points,
    required this.incomeColor,
    required this.expenseColor,
    required this.theme,
  });

  final List<ReportTrendPoint> points;
  final Color incomeColor;
  final Color expenseColor;
  final FThemeData theme;

  @override
  Widget build(BuildContext context) {
    final maxVal = points.expand((p) => [p.income, p.expense]).fold<double>(0, (a, b) => a > b ? a : b);
    final yMax = maxVal > 0 ? maxVal * 1.25 : 100.0;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: yMax,
        minY: 0,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => theme.colors.card,
            tooltipBorder: BorderSide(color: theme.colors.border),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final point = points[groupIndex];
              final isIncome = rodIndex == 0;
              return BarTooltipItem(
                isIncome ? point.income.toCompactFormat() : point.expense.toCompactFormat(),
                theme.typography.labelBadge.copyWith(
                  color: isIncome ? incomeColor : expenseColor,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value == meta.max || value == 0 && meta.min > 0) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Text(
                    value.toCompactFormat(),
                    style: theme.typography.labelBadge.copyWith(
                      color: theme.colors.mutedForeground,
                    ),
                    textAlign: TextAlign.right,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= points.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    points[idx].label,
                    style: theme.typography.labelBadge.copyWith(
                      color: theme.colors.mutedForeground,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval: yMax / 4,
          getDrawingHorizontalLine: (_) => FlLine(
            color: theme.colors.border.withValues(alpha: 0.4),
            strokeWidth: 1,
            dashArray: [4, 4],
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(points.length, (i) {
          final point = points[i];
          return BarChartGroupData(
            x: i,
            groupVertically: false,
            barRods: [
              BarChartRodData(
                toY: point.income,
                color: incomeColor.withValues(alpha: 0.85),
                width: 9,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              ),
              BarChartRodData(
                toY: point.expense,
                color: expenseColor,
                width: 9,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ],
            barsSpace: 3,
          );
        }),
      ),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

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
        Text(
          label,
          style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _QuickStat extends StatelessWidget {
  const _QuickStat({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
        ),
        Text(
          value,
          style: theme.typography.bodySecondary.copyWith(fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}
