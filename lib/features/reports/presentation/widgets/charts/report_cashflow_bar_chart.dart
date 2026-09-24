import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/theme/theme.dart';

/// Bar chart rendering historical cashflow trend points for income and expense rods.
class ReportCashflowBarChart extends StatelessWidget {
  /// Creates a [ReportCashflowBarChart].
  const new({
    required this.points,
    required this.incomeColor,
    required this.expenseColor,
    required this.theme,
    required this.isBalanceVisible,
    super.key,
  });

  /// Trend points to plot along the horizontal axis.
  final List<ReportTrendPoint> points;

  /// Theme color for income bars.
  final Color incomeColor;

  /// Theme color for expense bars.
  final Color expenseColor;

  /// Active theme data for typography and borders.
  final FThemeData theme;

  /// Whether numeric values are revealed or obscured.
  final bool isBalanceVisible;

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
                isIncome
                    ? point.income.toCompactFormat(isVisible: isBalanceVisible)
                    : point.expense.toCompactFormat(isVisible: isBalanceVisible),
                theme.typography.labelBadge.copyWith(color: isIncome ? incomeColor : expenseColor),
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
              reservedSize: isBalanceVisible ? 40 : 44,
              getTitlesWidget: (value, meta) {
                if (value == meta.max || value == 0 && meta.min > 0) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Text(
                    value.toCompactFormat(isVisible: isBalanceVisible),
                    style: theme.typography.caption.copyWith(color: theme.colors.mutedForeground),
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
                if (idx < 0 || idx >= points.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    points[idx].label,
                    style: theme.typography.caption.copyWith(color: theme.colors.mutedForeground),
                  ),
                );
              },
            ),
          ),
        ),
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval: yMax / 4,
          getDrawingHorizontalLine: (_) =>
              FlLine(color: theme.colors.border.withValues(alpha: 0.25), strokeWidth: 1, dashArray: [4, 4]),
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
                width: 13,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
              ),
              BarChartRodData(
                toY: point.expense,
                color: expenseColor,
                width: 13,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
              ),
            ],
            barsSpace: 4,
          );
        }),
      ),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
    );
  }
}
