import 'package:flutter/material.dart';
import 'package:poka_ce/theme/theme.dart';

/// Small status chip badge displayed when a budget is exceeding its limit.
class ReportBudgetStatusChip extends StatelessWidget {
  /// Creates a [ReportBudgetStatusChip].
  const new({required this.label, required this.color, super.key});

  /// The text label displayed in the chip.
  final String label;

  /// The badge accent and border color.
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(label, style: context.theme.typography.labelBadge.copyWith(color: color)),
    );
  }
}
