import 'package:flutter/material.dart';
import 'package:poka_ce/theme/theme.dart';

/// Segmented tab pill toggle switching between Expense and Income views.
class ReportCategoryTabToggle extends StatelessWidget {
  /// Creates a [ReportCategoryTabToggle].
  const new({
    required this.isExpense,
    required this.onExpenseTap,
    required this.onIncomeTap,
    required this.expenseLabel,
    required this.incomeLabel,
    super.key,
  });

  /// Whether the Expense tab is currently selected.
  final bool isExpense;

  /// Callback when Expense tab is tapped.
  final VoidCallback onExpenseTap;

  /// Callback when Income tab is tapped.
  final VoidCallback onIncomeTap;

  /// Label for the Expense segment.
  final String expenseLabel;

  /// Label for the Income segment.
  final String incomeLabel;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: theme.colors.muted,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colors.border.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          _TabItem(
            label: expenseLabel,
            isSelected: isExpense,
            onTap: onExpenseTap,
            activeColor: theme.colors.app.expense,
          ),
          _TabItem(
            label: incomeLabel,
            isSelected: !isExpense,
            onTap: onIncomeTap,
            activeColor: theme.colors.app.income,
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const new({required this.label, required this.isSelected, required this.onTap, required this.activeColor});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              label,
              style: theme.typography.bodySecondary.copyWith(
                color: isSelected ? theme.colors.primaryForeground : theme.colors.mutedForeground,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
