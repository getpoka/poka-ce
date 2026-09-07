import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/cards/views/carousel_shared.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_donut_chart.dart';
import 'package:poka_ce/theme/theme.dart';

class DashboardBudgetView extends ConsumerWidget {
  const DashboardBudgetView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(dashboardProvider);
    final allocs = state.budgetAllocations;

    final needAmt = allocs[TransactionAllocation.need] ?? 0;
    final wantAmt = allocs[TransactionAllocation.want] ?? 0;
    final saveAmt = allocs[TransactionAllocation.saving] ?? 0;
    final total = (needAmt + wantAmt + saveAmt) > 0 ? (needAmt + wantAmt + saveAmt) : 1.0;

    return Row(
      children: [
        PokaDonutChart(
          sections: [
            if (needAmt > 0) PokaDonutSection(value: needAmt, color: theme.colors.primary),
            if (wantAmt > 0) PokaDonutSection(value: wantAmt, color: theme.colors.app.warning),
            if (saveAmt > 0) PokaDonutSection(value: saveAmt, color: theme.colors.border),
          ],
        ),
        const SizedBox(width: 24),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildCategoryStatRow(
                  context,
                  context.t.dashboard.needs,
                  needAmt.toCompactFormat(),
                  theme.colors.primary,
                  needAmt / total,
                ),
                const SizedBox(height: 8),
                buildCategoryStatRow(
                  context,
                  context.t.dashboard.wants,
                  wantAmt.toCompactFormat(),
                  theme.colors.app.warning,
                  wantAmt / total,
                ),
                const SizedBox(height: 8),
                buildCategoryStatRow(
                  context,
                  context.t.dashboard.savings,
                  saveAmt.toCompactFormat(),
                  theme.colors.border,
                  saveAmt / total,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
