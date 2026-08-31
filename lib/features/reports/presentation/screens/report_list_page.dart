import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_budget_utilization.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_cashflow_chart.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_category_chart.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_period_selector.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_spending_allocation.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_summary_card.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';

class ReportListPage extends ConsumerWidget {
  const ReportListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reportProvider);
    final t = context.t.reports;

    return FScaffold(
      header: PokaHeader(
        title: t.title,
        subtitle: t.overview,
      ),
      child: state.isLoading
          ? const Center(child: FCircularProgress())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Sticky Period Selector ───────────────────────────────
                const ReportPeriodSelector().animate().fade(duration: 250.ms).slideY(begin: 0.04, end: 0),
                const SizedBox(height: 12),

                // ── Tabs ───────────────────────────────────────────────────
                Expanded(
                  child: FTabs(
                    expands: true,
                    children: [
                      // TAB 1: Cashflow
                      FTabEntry(
                        label: Text(t.tabCashflow),
                        child: RefreshIndicator(
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
                                // 1. Cashflow Summary (No Section Label)
                                const ReportSummaryCard().animate().fade(duration: 300.ms).slideY(begin: 0.05, end: 0),
                                const SizedBox(height: 20),

                                // 2. Cashflow Trend
                                PokaSectionLabel(title: t.cashflowTrend),
                                const SizedBox(height: 8),
                                const ReportCashflowChart()
                                    .animate()
                                    .fade(duration: 350.ms, delay: 50.ms)
                                    .slideY(begin: 0.05, end: 0),
                                const SizedBox(height: 20),

                                // 3. Top Categories
                                PokaSectionLabel(title: t.topCategories),
                                const SizedBox(height: 8),
                                const ReportCategoryChart()
                                    .animate()
                                    .fade(duration: 350.ms, delay: 100.ms)
                                    .slideY(begin: 0.05, end: 0),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // TAB 2: Budgets & Goals
                      FTabEntry(
                        label: Text(t.tabBudgets),
                        child: RefreshIndicator(
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
                                const ReportBudgetUtilization()
                                    .animate()
                                    .fade(duration: 300.ms)
                                    .slideY(begin: 0.05, end: 0),
                                const SizedBox(height: 20),

                                // 2. Spending Allocation (50/30/20)
                                PokaSectionLabel(title: t.spendingAllocation),
                                const SizedBox(height: 8),
                                const ReportSpendingAllocation()
                                    .animate()
                                    .fade(duration: 350.ms, delay: 50.ms)
                                    .slideY(begin: 0.05, end: 0),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
