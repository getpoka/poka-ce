import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/tiles/allocation_row_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

/// 50/30/20 rule spending allocation (Need / Want / Save).
/// Section label lives OUTSIDE this card on the parent page.
class ReportSpendingAllocation extends ConsumerWidget {
  const ReportSpendingAllocation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(reportProvider);
    final alloc = state.data.budgetAllocation;
    final t = context.t.reports;

    final hasData = alloc.total > 0;
    final needColor = theme.colors.primary;
    final wantColor = theme.colors.app.warning;
    final savingColor = theme.colors.app.success;

    return FCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Rule badge & Total ─────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (hasData)
                  Text(
                    '${t.total}: ${alloc.total.toCompactFormat()}',
                    style: theme.typography.bodySecondary.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else
                  const SizedBox.shrink(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: theme.colors.muted,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: theme.colors.border.withValues(alpha: 0.5)),
                  ),
                  child: Text(
                    t.rule503020,
                    style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ── Stacked Horizontal Bar ─────────────────────────────────────
            if (hasData)
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  height: 12,
                  child: Row(
                    children: [
                      if (alloc.needRatio > 0)
                        Expanded(
                          flex: (alloc.needRatio * 1000).toInt(),
                          child: Container(color: needColor),
                        ),
                      if (alloc.wantRatio > 0)
                        Expanded(
                          flex: (alloc.wantRatio * 1000).toInt(),
                          child: Container(color: wantColor),
                        ),
                      if (alloc.savingRatio > 0)
                        Expanded(
                          flex: (alloc.savingRatio * 1000).toInt(),
                          child: Container(color: savingColor),
                        ),
                    ],
                  ),
                ),
              ),
            if (hasData) const SizedBox(height: 16),

            // ── Allocation rows ─────────────────────────────────────
            if (hasData)
              Column(
                children: [
                  AllocationRowTile(
                    label: t.needs,
                    hint: t.percent50,
                    amount: alloc.need,
                    color: needColor,
                    ratio: alloc.needRatio,
                  ),
                  const SizedBox(height: 10),
                  AllocationRowTile(
                    label: t.wants,
                    hint: t.percent30,
                    amount: alloc.want,
                    color: wantColor,
                    ratio: alloc.wantRatio,
                  ),
                  const SizedBox(height: 10),
                  AllocationRowTile(
                    label: t.savings,
                    hint: t.percent20,
                    amount: alloc.saving,
                    color: savingColor,
                    ratio: alloc.savingRatio,
                  ),
                ],
              ),

            // ── Empty state guidance ────────────────────────────────────
            if (!hasData)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colors.muted,
                  borderRadius: theme.style.borderRadius.sm,
                  border: Border.all(color: theme.colors.border.withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    Icon(FPhosphorIcons.info, size: 14, color: theme.colors.mutedForeground),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        t.noData,
                        style: theme.typography.bodySecondary.copyWith(
                          color: theme.colors.mutedForeground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
