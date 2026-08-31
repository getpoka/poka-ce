import 'package:flutter/material.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';
import 'package:poka_ce/theme/theme.dart';

class AllocationRowTile extends StatelessWidget {
  const AllocationRowTile({
    required this.label,
    required this.hint,
    required this.amount,
    required this.color,
    required this.ratio,
    super.key,
  });

  final String label;
  final String hint;
  final double amount;
  final Color color;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final pct = '${(ratio * 100).toStringAsFixed(1)}%';

    return Row(
      children: [
        Container(
          width: 7,
          height: 7,
          margin: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Expanded(
          child: Row(
            children: [
              Text(label, style: theme.typography.bodySecondary),
              const SizedBox(width: 4),
              Text(
                hint,
                style: theme.typography.labelBadge.copyWith(color: theme.colors.mutedForeground),
              ),
            ],
          ),
        ),
        Text(
          pct,
          style: theme.typography.bodySecondary.copyWith(
            color: theme.colors.mutedForeground,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          amount.toCompactFormat(),
          style: theme.typography.bodySecondary.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
