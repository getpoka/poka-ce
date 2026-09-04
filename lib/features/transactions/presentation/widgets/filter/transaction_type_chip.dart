import 'package:flutter/material.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/theme/theme.dart';

/// A selectable chip for a [TransactionType] in the filter sheet.
class TransactionTypeChip extends StatelessWidget {
  const TransactionTypeChip({
    required this.type,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final TransactionType type;
  final bool isSelected;
  final VoidCallback onTap;

  IconData get _icon => switch (type) {
    TransactionType.income => FPhosphorIcons.arrowCircleUp,
    TransactionType.expense => FPhosphorIcons.arrowCircleDown,
    TransactionType.transfer => FPhosphorIcons.arrowsLeftRight,
  };

  String get _label => switch (type) {
    TransactionType.income => 'Income',
    TransactionType.expense => 'Expense',
    TransactionType.transfer => 'Transfer',
  };

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final color = switch (type) {
      TransactionType.income => theme.colors.app.income,
      TransactionType.expense => theme.colors.app.expense,
      TransactionType.transfer => theme.colors.app.transfer,
    };

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.12) : theme.colors.muted,
          borderRadius: theme.style.borderRadius.sm,
          border: Border.all(
            color: isSelected ? color : theme.colors.border,
            width: theme.style.borderWidth,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _icon,
              size: 18,
              color: isSelected ? color : theme.colors.mutedForeground,
            ),
            const SizedBox(height: 4),
            Text(
              _label,
              style: theme.typography.bodySecondary.copyWith(
                color: isSelected ? color : theme.colors.mutedForeground,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
