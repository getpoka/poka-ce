import 'package:flutter/material.dart';
import 'package:poka_ce/features/reports/presentation/widgets/summary/report_delta_badge.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

/// Row widget displaying a metric icon, label, value, and comparison percentage delta.
class StatRowTile extends StatelessWidget {
  /// Creates a [StatRowTile].
  const new({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.delta,
    required this.prevLabel,
    required this.positiveIsGood,
    super.key,
  });

  /// The icon representing this stat.
  final IconData icon;

  /// The accent color of the icon and icon container background.
  final Color iconColor;

  /// The label for the metric (e.g. Income, Expense).
  final String label;

  /// The formatted string value.
  final String value;

  /// The percentage delta compared to the previous period.
  final double delta;

  /// The text label for the previous period (e.g. "Last month").
  final String prevLabel;

  /// Whether a positive delta should be considered good/favorable.
  final bool positiveIsGood;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 16, color: iconColor),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.typography.caption.copyWith(
                  color: theme.colors.mutedForeground,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: theme.typography.bodyPrimary.copyWith(fontWeight: FontWeight.w700),
                overflow: TextOverflow.ellipsis,
              ),
              // Always reserve the delta row height to prevent layout shift
              // when switching between periods with and without comparison data.
              Opacity(
                opacity: delta != 0 ? 1.0 : 0.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Row(
                    children: [
                      ReportDeltaBadge(delta: delta, positiveIsGood: positiveIsGood),
                      const SizedBox(width: 4),
                      Text(
                        context.t.reports.comparedTo(period: prevLabel),
                        style: theme.typography.labelBadge.copyWith(color: theme.colors.mutedForeground),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
