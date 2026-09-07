import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:poka_ce/theme/theme.dart';

/// A single slice data representation for [PokaDonutChart].
class PokaDonutSection {
  /// Creates a donut chart section.
  const PokaDonutSection({
    required this.value,
    required this.color,
    this.title,
  });

  /// Numeric value of this segment. Must be >= 0.
  final double value;

  /// Color used to render this segment.
  final Color color;

  /// Optional title string displayed on the section (hidden by default).
  final String? title;
}

/// A unified, sleek donut chart component with crisp section dividers.
///
/// Combines a slim, modern ring geometry with clean, distinct gaps between slices.
/// Can optionally host a centered widget (e.g. key metric or icon).
class PokaDonutChart extends StatelessWidget {
  /// Creates a [PokaDonutChart].
  const PokaDonutChart({
    required this.sections,
    super.key,
    this.size = 100,
    this.thickness = 14,
    this.sectionsSpace = 2.5,
    this.startDegreeOffset = -90,
    this.center,
    this.emptyColor,
    this.animationDuration = const Duration(milliseconds: 600),
  });

  /// Slices to render in the donut.
  final List<PokaDonutSection> sections;

  /// Diameter (width and height) of the donut chart bounding box.
  final double size;

  /// Thickness of the outer ring in logical pixels.
  final double thickness;

  /// Spacing in pixels between adjacent slices, creating crisp divider lines.
  final double sectionsSpace;

  /// Angle offset in degrees for the first slice. Defaults to -90 (top center).
  final double startDegreeOffset;

  /// Optional widget rendered in the center hole of the donut.
  final Widget? center;

  /// Color of the fallback ring shown when there are no valid data sections.
  final Color? emptyColor;

  /// Duration of the easeOutCubic transition animation when data changes.
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final validSections = sections.where((s) => s.value > 0).toList();
    final hasData = validSections.isNotEmpty;

    final fallbackColor = emptyColor ?? theme.colors.border;
    final centerRadius = ((size / 2) - thickness).clamp(0.0, double.infinity);

    final pieSections = hasData
        ? validSections.map((s) {
            return PieChartSectionData(
              value: s.value,
              color: s.color,
              radius: thickness,
              showTitle: s.title != null,
              title: s.title,
            );
          }).toList()
        : [
            PieChartSectionData(
              value: 1,
              color: fallbackColor,
              radius: thickness,
              showTitle: false,
            ),
          ];

    final chart = SizedBox(
      width: size,
      height: size,
      child: PieChart(
        PieChartData(
          sectionsSpace: validSections.length > 1 ? sectionsSpace : 0,
          centerSpaceRadius: centerRadius,
          startDegreeOffset: startDegreeOffset,
          sections: pieSections,
        ),
        duration: animationDuration,
        curve: Curves.easeOutCubic,
      ),
    );

    if (center != null) {
      return SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            chart,
            center!,
          ],
        ),
      );
    }

    return chart;
  }
}
