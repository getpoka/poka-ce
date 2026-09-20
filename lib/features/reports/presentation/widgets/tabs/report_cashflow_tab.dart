import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_cashflow_chart.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_category_chart.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_summary_card.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_section_label.dart';

/// Cashflow overview tab displaying summary cards, cashflow trends, and top categories.
class ReportCashflowTab extends ConsumerWidget {
  /// Creates a [ReportCashflowTab].
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
            // 1. Cashflow Summary
            const ReportSummaryCard().animate().fade(duration: 300.ms).slideY(begin: 0.05, end: 0),
            const SizedBox(height: 20),

            // 2. Cashflow Trend
            PokaSectionLabel(title: t.cashflowTrend),
            const SizedBox(height: 8),
            const ReportCashflowChart().animate().fade(duration: 350.ms, delay: 50.ms).slideY(begin: 0.05, end: 0),
            const SizedBox(height: 20),

            // 3. Top Categories
            PokaSectionLabel(title: t.topCategories),
            const SizedBox(height: 8),
            const ReportCategoryChart().animate().fade(duration: 350.ms, delay: 100.ms).slideY(begin: 0.05, end: 0),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
