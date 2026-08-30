import 'package:flutter/material.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:intl/intl.dart';
import 'package:poka_ce/theme/theme.dart';

class DebtDueDateChip extends StatelessWidget {
  const DebtDueDateChip({required this.dueDate, super.key});

  final DateTime dueDate;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final daysLeft = dueDate.difference(DateTime.now()).inDays;
    final isOverdue = daysLeft < 0;
    final isUrgent = daysLeft >= 0 && daysLeft <= 7;

    final overdueColor = theme.colors.destructive;
    final urgentColor = theme.colors.app.warning;

    final color = isOverdue ? overdueColor : (isUrgent ? urgentColor : theme.colors.mutedForeground);
    final label = isOverdue
        ? 'Overdue'
        : daysLeft == 0
        ? 'Due today'
        : DateFormat.MMMd().format(dueDate);

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
          Text(
            label.toUpperCase(),
            style: theme.typography.labelBadge.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
