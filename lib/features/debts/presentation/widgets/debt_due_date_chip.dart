import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class DebtDueDateChip extends StatelessWidget {
  const new({required this.dueDate, super.key});

  final String dueDate;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final parsed = DateTime.parse(dueDate);
    final now = DateTime.now();
    final todayMidnight = DateTime(now.year, now.month, now.day);
    final dueMidnight = DateTime(parsed.year, parsed.month, parsed.day);
    final daysLeft = dueMidnight.difference(todayMidnight).inDays;
    final isOverdue = daysLeft < 0;
    final isUrgent = daysLeft >= 0 && daysLeft <= 7;

    final overdueColor = theme.colors.destructive;
    final urgentColor = theme.colors.app.warning;

    final color = isOverdue ? overdueColor : (isUrgent ? urgentColor : theme.colors.mutedForeground);
    final label = isOverdue
        ? t.common.overdue
        : daysLeft == 0
        ? t.common.dueToday
        : DateFormat.MMMd().format(parsed);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: (isOverdue || isUrgent) ? color.withValues(alpha: 0.12) : theme.colors.muted,
        borderRadius: theme.style.borderRadius.sm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FPhosphorIcons.calendarBlank, size: 9, color: color),
          const SizedBox(width: 3),
          Text(label.toUpperCase(), style: theme.typography.labelBadge.copyWith(color: color)),
        ],
      ),
    );
  }
}
