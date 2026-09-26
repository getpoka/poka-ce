import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/theme/theme.dart';

/// Row widget rendering a category rank, dot, title, compact amount, and percentage.
class CategoryItemTile extends ConsumerWidget {
  /// Creates a [CategoryItemTile].
  const new({required this.item, required this.rank, this.isVisible, super.key});

  /// The category item analytics data.
  final ReportCategoryItem item;

  /// The numeric rank (1-indexed).
  final int rank;

  /// Optional explicit visibility override. Defaults to [balanceVisibilityProvider].
  final bool? isVisible;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final color = item.color.toColor(theme.colors.mutedForeground);
    final v = ref.watch(balanceVisibilityProvider);
    final effectiveVisible = isVisible ?? v;

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
            style: theme.typography.bodyPrimary.copyWith(fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Amount + ratio
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              item.amount.toCompactFormat(isVisible: effectiveVisible),
              style: theme.typography.bodySecondary.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              '${(item.ratio * 100).toStringAsFixed(1)}%',
              style: theme.typography.caption.copyWith(color: theme.colors.mutedForeground),
            ),
          ],
        ),
      ],
    );
  }
}
