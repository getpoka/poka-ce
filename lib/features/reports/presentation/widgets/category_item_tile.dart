import 'package:flutter/material.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/theme/theme.dart';

class CategoryItemTile extends StatelessWidget {
  const CategoryItemTile({required this.item, required this.rank, super.key});

  final ReportCategoryItem item;
  final int rank;

  Color _parseColor(BuildContext context, String hex) {
    try {
      final cleaned = hex.replaceAll('#', '');
      return Color(int.parse('FF$cleaned', radix: 16));
    } on FormatException {
      return context.theme.colors.mutedForeground;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final color = _parseColor(context, item.color);

    return Row(
      children: [
        // Rank
        SizedBox(
          width: 18,
          child: Text(
            '$rank',
            style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 8),

        // Color dot
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),

        // Name
        Expanded(
          child: Text(
            item.name,
            style: theme.typography.titleItem,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Amount + ratio
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              item.amount.toCompactFormat(),
              style: theme.typography.bodySecondary.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              '${(item.ratio * 100).toStringAsFixed(1)}%',
              style: theme.typography.labelBadge.copyWith(color: theme.colors.mutedForeground),
            ),
          ],
        ),
      ],
    );
  }
}
