import 'package:flutter/material.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/theme/theme.dart';

class DebtStatusChip extends StatelessWidget {
  const DebtStatusChip({required this.status, super.key});

  final DebtStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isPaid = status == DebtStatus.paid;
    final paidColor = theme.colors.app.success;
    final activeColor = theme.colors.app.warning;

    final color = isPaid ? paidColor : activeColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: theme.style.borderRadius.sm,
      ),
      child: Text(
        status.name.toUpperCase(),
        style: theme.typography.labelBadge.copyWith(
          color: color,
        ),
      ),
    );
  }
}
