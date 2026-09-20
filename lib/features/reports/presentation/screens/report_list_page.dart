import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_period_selector.dart';
import 'package:poka_ce/features/reports/presentation/widgets/tabs/report_budgets_tab.dart';
import 'package:poka_ce/features/reports/presentation/widgets/tabs/report_cashflow_tab.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/shared/widgets/poka_toast.dart';

/// Reports screen presenting cashflow trends, spending by category, budget utilization, and allocation splits.
class ReportListPage extends ConsumerWidget {
  /// Creates a [ReportListPage].
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reportProvider);
    final isBalanceVisible = ref.watch(balanceVisibilityProvider);
    final t = context.t.reports;

    return FScaffold(
      header: PokaHeader(
        title: t.title,
        subtitle: t.overview,
        suffixes: [
          FHeaderAction(
            key: const Key('report-privacy-toggle-button'),
            icon: Icon(isBalanceVisible ? FPhosphorIcons.eye : FPhosphorIcons.eyeSlash, size: 20),
            onPress: () => ref.read(balanceVisibilityProvider.notifier).toggle(),
          ),
          FHeaderAction(
            key: const Key('report-export-excel-button'),
            icon: const Icon(FPhosphorIcons.fileXls, size: 20),
            onPress: () async {
              final box = context.findRenderObject() as RenderBox?;
              final rect = box != null ? box.localToGlobal(Offset.zero) & box.size : null;

              final success = await ref.read(reportProvider.notifier).exportExcel(sharePositionOrigin: rect);
              if (context.mounted) {
                showPokaToast(context: context, title: Text(success ? t.exportExcelSuccess : t.exportExcelError));
              }
            },
          ),
        ],
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
                      FTabEntry(label: Text(t.tabCashflow), child: const ReportCashflowTab()),

                      // TAB 2: Budgets & Goals
                      FTabEntry(label: Text(t.tabBudgets), child: const ReportBudgetsTab()),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
