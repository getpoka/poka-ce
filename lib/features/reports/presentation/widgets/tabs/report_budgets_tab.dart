import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_budget_utilization.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_spending_allocation.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';

/// Budgets and spending allocation tab displaying budget progress and 50/30/20 breakdown.
class ReportBudgetsTab extends ConsumerWidget {
  /// Creates a [ReportBudgetsTab].
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.reports;

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(reportProvider);
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            // 1. Budget Utilization
            PokaSectionLabel(title: t.budgetUtilization),
            const SizedBox(height: 8),
            const ReportBudgetUtilization().animate().fade(duration: 300.ms).slideY(begin: 0.05, end: 0),
            const SizedBox(height: 20),

            // 2. Spending Allocation (50/30/20)
            PokaSectionLabel(title: t.spendingAllocation),
            const SizedBox(height: 8),
            const ReportSpendingAllocation().animate().fade(duration: 350.ms, delay: 50.ms).slideY(begin: 0.05, end: 0),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
