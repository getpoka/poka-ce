import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/extensions/num_extension.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/cards/views/carousel_shared.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_donut_chart.dart';
import 'package:poka_ce/theme/theme.dart';

/// Category spending carousel slide displaying top category expenses and donut breakdown.
class DashboardCategoriesView extends ConsumerWidget {
  /// Creates a [DashboardCategoriesView].
  const DashboardCategoriesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(dashboardProvider);
    final isBalanceVisible = ref.watch(balanceVisibilityProvider);
    final totalExpense = state.totalExpense > 0 ? state.totalExpense : 1.0;

    final sortedExpenses = List.of(state.categoryExpenses)..sort((a, b) => b.amount.compareTo(a.amount));

    final categoryData = <({double ratio, Color color, Widget widget})>[];
    double otherAmount = 0;

    for (var i = 0; i < sortedExpenses.length; i++) {
      if (i < 3) {
        final cat = sortedExpenses[i];
        final ratio = cat.amount / totalExpense;
        categoryData.add((
          ratio: ratio,
          color: cat.color.toColor(),
          widget: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: buildCategoryStatRow(
              context,
              cat.name,
              cat.amount.toCompactFormat(isVisible: isBalanceVisible),
              cat.color.toColor(),
              ratio,
            ),
          ),
        ));
      } else {
        otherAmount += sortedExpenses[i].amount;
      }
    }

    if (otherAmount > 0) {
      final ratio = otherAmount / totalExpense;
      categoryData.add((
        ratio: ratio,
        color: theme.colors.border, // Grey color for Other
        widget: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: buildCategoryStatRow(
            context,
            context.t.dashboard.other,
            otherAmount.toCompactFormat(isVisible: isBalanceVisible),
            theme.colors.border,
            ratio,
          ),
        ),
      ));
    }

    return Row(
      children: [
        PokaDonutChart(
          sections: categoryData.map((e) => PokaDonutSection(value: e.ratio, color: e.color)).toList(),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: categoryData.isEmpty
                  ? [Text(context.t.dashboard.noData, style: theme.typography.bodyPrimary)]
                  : categoryData.map((e) => e.widget).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
