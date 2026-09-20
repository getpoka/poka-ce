import 'package:flutter/material.dart';
import 'package:poka_ce/theme/theme.dart';

/// Badge displaying percentage delta with directional arrow icon.
class ReportDeltaBadge extends StatelessWidget {
  /// Creates a [ReportDeltaBadge].
  const new({required this.delta, required this.positiveIsGood, super.key});

  /// The percentage delta.
  final double delta;

  /// Whether a positive delta should be considered favorable.
  final bool positiveIsGood;

  @override
  Widget build(BuildContext context) {
    final isUp = delta > 0;
    final isGood = positiveIsGood ? isUp : !isUp;
    final theme = context.theme;
    final color = isGood ? theme.colors.app.success : theme.colors.destructive;
    final icon = isUp ? FPhosphorIcons.arrowUp : FPhosphorIcons.arrowDown;
    final pctStr = '${delta.abs().toStringAsFixed(1)}%';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 9, color: color),
        Text(pctStr, style: theme.typography.labelBadge.copyWith(color: color)),
      ],
    );
  }
}
