import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';
import 'package:poka_ce/theme/theme.dart';

class DashboardQuickActions extends StatelessWidget {
  const DashboardQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _QuickActionItem(
              icon: FPhosphorIcons.chartPieSlice,
              label: context.t.dashboard.budgets,
              onTap: () {
                const BudgetListRoute().push<void>(context);
              },
            ).animate().fade(duration: 300.ms).slideX(begin: 0.15, end: 0),
            const SizedBox(width: 16),
            _QuickActionItem(
              icon: FPhosphorIcons.target,
              label: context.t.dashboard.goals,
              onTap: () {
                const GoalListRoute().push<void>(context);
              },
            ).animate().fade(duration: 300.ms, delay: 60.ms).slideX(begin: 0.15, end: 0),
            const SizedBox(width: 16),
            _QuickActionItem(
              icon: FPhosphorIcons.handshake,
              label: context.t.dashboard.debts,
              onTap: () {
                const DebtListRoute().push<void>(context);
              },
            ).animate().fade(duration: 300.ms, delay: 120.ms).slideX(begin: 0.15, end: 0),
            const SizedBox(width: 16),
            _QuickActionItem(
              icon: FPhosphorIcons.calendarDots,
              label: context.t.dashboard.recurring,
              onTap: () => const RecurringListRoute().push<void>(context),
            ).animate().fade(duration: 300.ms, delay: 180.ms).slideX(begin: 0.15, end: 0),
            const SizedBox(width: 16),
            _QuickActionItem(
              icon: FPhosphorIcons.tag,
              label: context.t.dashboard.categories,
              onTap: () {
                const CategoryListRoute().push<void>(context);
              },
            ).animate().fade(duration: 300.ms, delay: 240.ms).slideX(begin: 0.15, end: 0),
          ],
        ),
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PokaIcon(
            icon: icon,
            shape: PokaIconShape.circle,
            size: PokaIconSize.large,
            useThemeBorderColor: true, // As requested by user
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: theme.typography.caption.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
