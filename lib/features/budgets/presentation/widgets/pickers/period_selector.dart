import 'package:flutter/material.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/theme/theme.dart';

class PeriodSelector extends StatelessWidget {
  const PeriodSelector({required this.selected, required this.onChanged, super.key});

  final BudgetPeriod selected;
  final ValueChanged<BudgetPeriod> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      children: BudgetPeriod.values.map((period) {
        final isSelected = period == selected;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(period),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              padding: const EdgeInsets.symmetric(vertical: 9),
              decoration: BoxDecoration(
                color: isSelected ? theme.colors.primary : Colors.transparent,
                borderRadius: theme.style.borderRadius.sm,
                border: Border.all(
                  color: isSelected ? theme.colors.primary : theme.colors.border,
                ),
              ),
              child: Text(
                _periodLabel(period),
                textAlign: TextAlign.center,
                style: theme.typography.bodySecondary.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? theme.colors.primaryForeground : theme.colors.mutedForeground,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _periodLabel(BudgetPeriod period) => switch (period) {
    BudgetPeriod.weekly => 'Weekly',
    BudgetPeriod.monthly => 'Monthly',
    BudgetPeriod.yearly => 'Yearly',
    BudgetPeriod.custom => 'Custom',
  };
}
