import 'package:flutter/material.dart';
import 'package:poka_ce/theme/theme.dart';

class RecurringStatusChip extends StatelessWidget {
  const RecurringStatusChip({required this.isActive, super.key});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final activeColor = theme.colors.app.success;
    final pausedColor = theme.colors.app.warning;
    final color = isActive ? activeColor : pausedColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: theme.style.borderRadius.sm,
      ),
      child: Text(
        isActive ? 'ACTIVE' : 'PAUSED',
        style: theme.typography.labelBadge.copyWith(color: color),
      ),
    );
  }
}
