import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/theme/theme.dart';

/// Row widget rendering an allocation category (e.g. 50% Needs), ratio, and compact amount.
class AllocationRowTile extends ConsumerWidget {
  /// Creates an [AllocationRowTile].
  const AllocationRowTile({
    required this.label,
    required this.hint,
    required this.amount,
    required this.color,
    required this.ratio,
    this.isVisible,
    super.key,
  });

  /// The category label.
  final String label;

  /// Subtitle hint (e.g. "50%").
  final String hint;

  /// Monetary amount allocated.
  final double amount;

  /// The accent color of the allocation bar and dot.
  final Color color;

  /// The ratio of this allocation against the total budget.
  final double ratio;

  /// Optional explicit visibility override. Defaults to [balanceVisibilityProvider].
  final bool? isVisible;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final pct = '${(ratio * 100).toStringAsFixed(1)}%';
    final effectiveVisible = isVisible ?? ref.watch(balanceVisibilityProvider) ?? true;

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
          amount.toCompactFormat(isVisible: effectiveVisible),
          style: theme.typography.bodySecondary.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
