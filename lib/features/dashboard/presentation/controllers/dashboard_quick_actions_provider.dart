import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/features/dashboard/domain/dashboard_quick_action.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_quick_actions_provider.g.dart';

/// Returns the default list of quick actions for CE.
List<DashboardQuickAction> getDefaultDashboardQuickActions() {
  return [
    DashboardQuickAction(
      icon: FPhosphorIcons.chartPieSlice,
      labelBuilder: (context) => context.t.dashboard.budgets,
      onTap: (context) => const BudgetListRoute().push<void>(context),
    ),
    DashboardQuickAction(
      icon: FPhosphorIcons.target,
      labelBuilder: (context) => context.t.dashboard.goals,
      onTap: (context) => const GoalListRoute().push<void>(context),
    ),
    DashboardQuickAction(
      icon: FPhosphorIcons.handshake,
      labelBuilder: (context) => context.t.dashboard.debts,
      onTap: (context) => const DebtListRoute().push<void>(context),
    ),
    DashboardQuickAction(
      icon: FPhosphorIcons.calendarDots,
      labelBuilder: (context) => context.t.dashboard.recurring,
      onTap: (context) => const RecurringListRoute().push<void>(context),
    ),
    DashboardQuickAction(
      icon: FPhosphorIcons.tag,
      labelBuilder: (context) => context.t.dashboard.categories,
      onTap: (context) => const CategoryListRoute().push<void>(context),
    ),
  ];
}

/// Provides the default CE list of quick actions.
@riverpod
List<DashboardQuickAction> dashboardQuickActions(Ref ref) {
  return getDefaultDashboardQuickActions();
}
