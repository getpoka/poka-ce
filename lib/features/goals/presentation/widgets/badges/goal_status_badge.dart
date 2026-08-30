import 'package:flutter/material.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:intl/intl.dart';
import 'package:poka_ce/theme/theme.dart';

class GoalStatusBadge extends StatelessWidget {
  const GoalStatusBadge({required this.label, required this.color, super.key});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: theme.style.borderRadius.sm,
      ),
      child: Text(
        label.toUpperCase(),
        style: theme.typography.labelBadge.copyWith(color: color),
      ),
    );
  }
}

class GoalDeadlineBadge extends StatelessWidget {
  const GoalDeadlineBadge({required this.targetDate, super.key});

  final DateTime targetDate;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final daysLeft = targetDate.difference(DateTime.now()).inDays;
    final isUrgent = daysLeft <= 30;
    final urgentColor = theme.colors.app.warning;

    final color = isUrgent ? urgentColor : theme.colors.mutedForeground;
    final label = daysLeft <= 0 ? 'Due today' : DateFormat.MMMd().format(targetDate);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isUrgent ? color.withValues(alpha: 0.12) : theme.colors.muted,
        borderRadius: theme.style.borderRadius.sm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FPhosphorIcons.calendarBlank, size: 9, color: color),
          const SizedBox(width: 3),
          Text(
            label.toUpperCase(),
            style: theme.typography.labelBadge.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
