import 'package:flutter/material.dart';
import 'package:poka_ce/theme/theme.dart';

/// Single selectable period pill chip for the report period selector.
class ReportPeriodChip extends StatelessWidget {
  /// Creates a [ReportPeriodChip].
  const new({required this.label, required this.isSelected, required this.onTap, super.key});

  /// Display text on the chip.
  final String label;

  /// Whether this period is currently selected.
  final bool isSelected;

  /// Callback when the chip is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colors.primary
              : (theme.colors.brightness == Brightness.light
                    ? theme.colors.secondary
                    : theme.colors.muted.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: theme.typography.caption.copyWith(
            color: isSelected ? theme.colors.primaryForeground : theme.colors.foreground,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
