import 'package:flutter/material.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

/// Status badge indicating whether cashflow is on track or requires attention.
class ReportCashflowStatusBadge extends StatelessWidget {
  /// Creates a [ReportCashflowStatusBadge].
  const new({required this.isOnTrack, super.key});

  /// Whether current net cashflow is positive or on track.
  final bool isOnTrack;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final color = isOnTrack ? theme.colors.app.success : theme.colors.app.warning;
    final label = isOnTrack ? context.t.reports.onTrack : context.t.reports.needsAttention;

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
          Text(label, style: theme.typography.labelBadge.copyWith(color: color)),
        ],
      ),
    );
  }
}
