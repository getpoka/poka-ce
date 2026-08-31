import 'package:flutter/material.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/theme/theme.dart';

class RecurringPeriodChip extends StatelessWidget {
  const RecurringPeriodChip({required this.period, super.key});

  final RecurringPeriod period;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final label = switch (period) {
      RecurringPeriod.daily => 'Daily',
      RecurringPeriod.weekly => 'Weekly',
      RecurringPeriod.monthly => 'Monthly',
      RecurringPeriod.yearly => 'Yearly',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: theme.colors.muted,
        borderRadius: theme.style.borderRadius.sm,
      ),
      child: Text(
        label.toUpperCase(),
        style: theme.typography.labelBadge.copyWith(color: theme.colors.mutedForeground),
      ),
    );
  }
}
