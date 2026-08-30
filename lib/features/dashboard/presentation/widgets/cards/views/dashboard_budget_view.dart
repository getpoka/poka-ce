import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/cards/views/carousel_shared.dart';
import 'package:poka_ce/i18n/strings.g.dart';
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
        SizedBox(
          width: 100,
          height: 100,
          child: CustomPaint(
            painter: DonutChartPainter(
              proportions: total == 1.0 && needAmt == 0 && wantAmt == 0 && saveAmt == 0
                  ? [1.0]
                  : [needAmt / total, wantAmt / total, saveAmt / total],
              colors: total == 1.0 && needAmt == 0 && wantAmt == 0 && saveAmt == 0
                  ? [theme.colors.border]
                  : [theme.colors.primary, theme.colors.app.warning, theme.colors.border],
            ),
          ),
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
