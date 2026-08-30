import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poka_ce/theme/theme.dart';

class RecurringNextDateChip extends StatelessWidget {
  const RecurringNextDateChip({required this.nextDate, super.key});

  final DateTime nextDate;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final now = DateTime.now();
    final daysLeft = nextDate.difference(now).inDays;
    final isOverdue = daysLeft < 0;
    final isDueToday = daysLeft == 0;

    final overdueColor = theme.colors.destructive;
    final todayColor = theme.colors.app.warning;

    final color = isOverdue
        ? overdueColor
        : isDueToday
        ? todayColor
        : theme.colors.mutedForeground;

    final label = isOverdue
        ? 'Overdue'
        : isDueToday
        ? 'Due today'
        : 'Next: ${DateFormat.MMMd().format(nextDate)}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (isOverdue || isDueToday) ? color.withValues(alpha: 0.1) : theme.colors.muted,
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
