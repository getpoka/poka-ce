import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/category_item_tile.dart';
import 'package:poka_ce/features/reports/presentation/widgets/charts/report_category_pie_chart.dart';
import 'package:poka_ce/features/reports/presentation/widgets/charts/report_category_tab_toggle.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/theme/theme.dart';

/// Category breakdown card with Expense / Income tab toggle, donut chart, and ranked list.
class ReportCategoryChart extends HookConsumerWidget {
  /// Creates a [ReportCategoryChart].
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(reportProvider);
    final t = context.t.reports;
    final isExpenseTab = useState(true);

    final items = isExpenseTab.value ? state.data.expenseCategoryItems : state.data.incomeCategoryItems;

    // Top 5 + "Others"
    const maxCategories = 5;
    final List<ReportCategoryItem> topItems;
    ReportCategoryItem? othersItem;
    if (items.length > maxCategories) {
      topItems = items.take(maxCategories).toList();
      final othersAmount = items.skip(maxCategories).fold<double>(0, (a, b) => a + b.amount);
      final othersRatio = items.skip(maxCategories).fold<double>(0, (a, b) => a + b.ratio);
      final othersTx = items.skip(maxCategories).fold<int>(0, (a, b) => a + b.txCount);
      othersItem = ReportCategoryItem(
        name: t.other,
        color: '#9CA3AF',
        amount: othersAmount,
        ratio: othersRatio,
        txCount: othersTx,
      );
    } else {
      topItems = items;
    }

    final displayItems = [...topItems, ?othersItem];
    final isEmpty = items.isEmpty;

    return FCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Tab toggle ──────────────────────────────────────────────
            ReportCategoryTabToggle(
              isExpense: isExpenseTab.value,
              onExpenseTap: () => isExpenseTab.value = true,
              onIncomeTap: () => isExpenseTab.value = false,
              expenseLabel: t.expense,
              incomeLabel: t.income,
            ),
            const SizedBox(height: 16),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(begin: const Offset(0.02, 0), end: Offset.zero).animate(animation),
                    child: child,
                  ),
                );
              },
              child: KeyedSubtree(
                key: ValueKey(isExpenseTab.value),
                child: Column(
                  children: [
                    if (isEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Column(
                            children: [
                              const PokaIcon(icon: FPhosphorIcons.chartPieSlice, shape: PokaIconShape.circle),
                              const SizedBox(height: 12),
                              Text(
                                t.noData,
                                style: theme.typography.bodyPrimary.copyWith(color: theme.colors.mutedForeground),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ] else ...[
                      // ── Pie chart ─────────────────────────────────────────────
                      ReportCategoryPieChart(items: displayItems, theme: theme),
                      const SizedBox(height: 16),

                      // ── Ranked list ───────────────────────────────────────────
                      ...List.generate(displayItems.length, (index) {
                        final item = displayItems[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: index < displayItems.length - 1 ? 10 : 0),
                          child: CategoryItemTile(item: item, rank: index + 1),
                        );
                      }),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
