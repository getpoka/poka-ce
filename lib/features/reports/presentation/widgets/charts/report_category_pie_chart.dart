import 'package:flutter/material.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/shared/widgets/poka_donut_chart.dart';
import 'package:poka_ce/theme/theme.dart';

/// Donut chart rendering category expense or income ratios.
class ReportCategoryPieChart extends StatelessWidget {
  /// Creates a [ReportCategoryPieChart].
  const new({required this.items, required this.theme, super.key});

  /// The list of category items with computed ratios and colors.
  final List<ReportCategoryItem> items;

  /// The active theme data.
  final FThemeData theme;

  Color _parseColor(BuildContext context, String hex) {
    try {
      final cleaned = hex.replaceAll('#', '');
      return Color(int.parse('FF$cleaned', radix: 16));
    } on FormatException {
      return context.theme.colors.mutedForeground;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PokaDonutChart(
        size: 156,
        thickness: 18,
        sections: items.map((item) {
          return PokaDonutSection(value: item.ratio, color: _parseColor(context, item.color));
        }).toList(),
      ),
    );
  }
}
