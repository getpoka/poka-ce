import 'package:flutter/material.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class StatRowTile extends StatelessWidget {
  const StatRowTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.delta,
    required this.prevLabel,
    required this.positiveIsGood,
    super.key,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final double delta;
  final String prevLabel;
  final bool positiveIsGood;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
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
                      _DeltaBadge(delta: delta, positiveIsGood: positiveIsGood),
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

class _DeltaBadge extends StatelessWidget {
  const _DeltaBadge({required this.delta, required this.positiveIsGood});

  final double delta;
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
        Text(
          pctStr,
          style: theme.typography.labelBadge.copyWith(color: color),
        ),
      ],
    );
  }
}
