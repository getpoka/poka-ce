import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/category_item_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/theme/theme.dart';

/// Category breakdown with Expense / Income tab toggle.
/// Uses fl_chart PieChart donut + ranked list.
/// Section label lives OUTSIDE this card on the parent page.
class ReportCategoryChart extends HookConsumerWidget {
  const ReportCategoryChart({super.key});

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
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Tab toggle ──────────────────────────────────────────────
            _TabToggle(
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
                    position: Tween<Offset>(
                      begin: const Offset(0.02, 0),
                      end: Offset.zero,
                    ).animate(animation),
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
                              const PokaIcon(
                                icon: FPhosphorIcons.chartPieSlice,
                                shape: PokaIconShape.circle,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                t.noData,
                                style: theme.typography.bodyPrimary.copyWith(
                                  color: theme.colors.mutedForeground,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ] else ...[
                      // ── Pie chart ─────────────────────────────────────────────
                      _CategoryPieChart(items: displayItems, theme: theme),
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

// ─────────────────────────────────────────────────────────────────────────────

class _TabToggle extends StatelessWidget {
  const _TabToggle({
    required this.isExpense,
    required this.onExpenseTap,
    required this.onIncomeTap,
    required this.expenseLabel,
    required this.incomeLabel,
  });

  final bool isExpense;
  final VoidCallback onExpenseTap;
  final VoidCallback onIncomeTap;
  final String expenseLabel;
  final String incomeLabel;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: theme.colors.muted,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colors.border.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          _TabItem(
            label: expenseLabel,
            isSelected: isExpense,
            onTap: onExpenseTap,
            activeColor: theme.colors.app.expense,
          ),
          _TabItem(
            label: incomeLabel,
            isSelected: !isExpense,
            onTap: onIncomeTap,
            activeColor: theme.colors.app.income,
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.activeColor,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              label,
              style: theme.typography.bodySecondary.copyWith(
                color: isSelected ? Colors.white : theme.colors.mutedForeground,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _CategoryPieChart extends StatelessWidget {
  const _CategoryPieChart({required this.items, required this.theme});

  final List<ReportCategoryItem> items;
  final FThemeData theme;

  Color _parseColor(BuildContext context, String hex) {
    try {
      final cleaned = hex.replaceAll('#', '');
      return Color(int.parse('FF$cleaned', radix: 16));
    } on FormatException {
      return context.theme.colors.mutedForeground;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Row(
        children: [
          // Pie chart
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 36,
                startDegreeOffset: -90,
                sections: items.map((item) {
                  return PieChartSectionData(
                    value: item.ratio,
                    color: _parseColor(context, item.color),
                    radius: 30,
                    showTitle: false,
                  );
                }).toList(),
              ),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
            ),
          ),
          const SizedBox(width: 16),

          // Legend
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.take(5).map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _parseColor(context, item.color),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          item.name,
                          style: theme.typography.labelBadge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${(item.ratio * 100).toStringAsFixed(0)}%',
                        style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
