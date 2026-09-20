import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/budgets/presentation/controllers/budget_progress_provider.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/budget_item_tile.dart';
import 'package:poka_ce/features/reports/presentation/widgets/budgets/report_budget_overall_bar.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_empty_view.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_budget_utilization.g.dart';

@riverpod
Future<int> reportBudgetTotalSpent(Ref ref) async {
  final state = ref.watch(reportProvider);
  final budgets = state.budgets;
  var total = 0;
  for (final b in budgets) {
    // Awaiting in a loop is supported by Riverpod inside async providers
    final spent = await ref.watch(budgetProgressProvider(b).future);
    total += spent;
  }
  return total;
}

/// Budget utilization section — shows each budget's progress and overall utilization.
/// Section label lives OUTSIDE this card on the parent page.
class ReportBudgetUtilization extends ConsumerWidget {
  /// Creates a [ReportBudgetUtilization].
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reportProvider);
    final budgets = state.budgets;
    final t = context.t.reports;

    if (budgets.isEmpty) {
      return PokaEmptyView(
        icon: FPhosphorIcons.chartPieSlice,
        title: t.noBudgets,
        subtitle: t.noBudgetsDesc,
        hasBorder: true,
      );
    }

    final totalSpentAsync = ref.watch(reportBudgetTotalSpentProvider);
    final totalSpent = totalSpentAsync.value ?? 0;

    final totalLimit = budgets.fold<int>(0, (sum, b) => sum + b.amount);
    final overallProgress = totalLimit > 0 ? (totalSpent / totalLimit).clamp(0.0, 1.0) : 0.0;

    return FCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Overall utilization bar ──────────────────────────────────
            ReportBudgetOverallBar(totalSpent: totalSpent, totalLimit: totalLimit, overallProgress: overallProgress),
            const SizedBox(height: 16),

            // ── Individual budgets ──────────────────────────────────────
            ...List.generate(budgets.length, (index) {
              final budget = budgets[index];
              return Padding(
                padding: EdgeInsets.only(bottom: index < budgets.length - 1 ? 14 : 0),
                child: BudgetItemTile(budget: budget),
              );
            }),
          ],
        ),
      ),
    );
  }
}
