import 'package:flutter/material.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class DebtTypeSelector extends StatelessWidget {
  const DebtTypeSelector({required this.selected, required this.onChanged, super.key});

  final DebtType selected;
  final ValueChanged<DebtType>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final debtColor = theme.colors.app.expense;
    final loanColor = theme.colors.app.income;

    final items = [
      (type: DebtType.debt, label: t.debts.iOwe, icon: FPhosphorIcons.arrowUpRight, color: debtColor),
      (type: DebtType.loan, label: t.debts.theyOwe, icon: FPhosphorIcons.arrowDownLeft, color: loanColor),
    ];

    return Row(
      children: items.map((item) {
        final isSelected = item.type == selected;
        final disabled = onChanged == null;

        return Expanded(
          child: GestureDetector(
            onTap: disabled ? null : () => onChanged!(item.type),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              padding: const EdgeInsets.symmetric(vertical: 11),
              decoration: BoxDecoration(
                color: isSelected ? item.color.withValues(alpha: 0.12) : Colors.transparent,
                borderRadius: theme.style.borderRadius.sm,
                border: Border.all(
                  color: isSelected ? item.color : theme.colors.border,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.icon,
                    size: 15,
                    color: isSelected ? item.color : theme.colors.mutedForeground,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    item.label,
                    style: theme.typography.bodyPrimary.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? item.color : theme.colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
