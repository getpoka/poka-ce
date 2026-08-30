import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/cards/views/dashboard_budget_view.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/cards/views/dashboard_cash_flow_view.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/cards/views/dashboard_categories_view.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class DashboardAnalyticsCarousel extends HookConsumerWidget {
  const DashboardAnalyticsCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = useState(0);

    return FCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTab(context, context.t.dashboard.cashFlow, tabIndex.value == 0, () => tabIndex.value = 0),
                  const SizedBox(width: 8),
                  _buildTab(context, context.t.dashboard.categories, tabIndex.value == 1, () => tabIndex.value = 1),
                  const SizedBox(width: 8),
                  _buildTab(context, context.t.dashboard.budgets, tabIndex.value == 2, () => tabIndex.value = 2),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.04),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: KeyedSubtree(
                key: ValueKey<int>(tabIndex.value),
                child: _buildContent(context, tabIndex.value, ref),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, int index, WidgetRef ref) {
    switch (index) {
      case 0:
        return const DashboardCashFlowView();
      case 1:
        return const SizedBox(height: 140, child: DashboardCategoriesView());
      case 2:
        return const SizedBox(height: 140, child: DashboardBudgetView());
      default:
        return const SizedBox();
    }
  }

  Widget _buildTab(BuildContext context, String label, bool isActive, VoidCallback onTap) {
    final theme = context.theme;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isActive ? theme.colors.primary : theme.colors.secondary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            label,
            style: theme.typography.bodySecondary.copyWith(
              color: isActive ? theme.colors.primaryForeground : theme.colors.foreground,
            ),
          ),
        ),
      ),
    );
  }
}
