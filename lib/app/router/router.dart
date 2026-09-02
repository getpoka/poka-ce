import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/shell/main_shell_page.dart';
import 'package:poka_ce/core/logger/poka_logger.dart';
import 'package:poka_ce/features/accounts/presentation/screens/account_detail_page.dart';
import 'package:poka_ce/features/accounts/presentation/screens/account_list_page.dart';
import 'package:poka_ce/features/budgets/domain/budget_model.dart';
import 'package:poka_ce/features/budgets/presentation/screens/budget_detail_page.dart';
import 'package:poka_ce/features/budgets/presentation/screens/budget_list_page.dart';
import 'package:poka_ce/features/categories/presentation/screens/category_list_page.dart';
import 'package:poka_ce/features/dashboard/presentation/screens/dashboard_page.dart';
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/presentation/screens/debt_detail_page.dart';
import 'package:poka_ce/features/debts/presentation/screens/debt_list_page.dart';
import 'package:poka_ce/features/goals/domain/goal_model.dart';
import 'package:poka_ce/features/goals/presentation/screens/goal_detail_page.dart';
import 'package:poka_ce/features/goals/presentation/screens/goal_list_page.dart';
import 'package:poka_ce/features/onboarding/presentation/screens/onboarding_page.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';
import 'package:poka_ce/features/recurring/presentation/screens/recurring_detail_page.dart';
import 'package:poka_ce/features/recurring/presentation/screens/recurring_list_page.dart';
import 'package:poka_ce/features/reports/presentation/screens/report_list_page.dart';
import 'package:poka_ce/features/settings/presentation/controllers/app_lock_controller.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/settings/presentation/screens/about_page.dart';
import 'package:poka_ce/features/settings/presentation/screens/faq_page.dart';
import 'package:poka_ce/features/settings/presentation/screens/licenses_page.dart';
import 'package:poka_ce/features/settings/presentation/screens/lock_screen.dart';
import 'package:poka_ce/features/settings/presentation/screens/markdown_page.dart';
import 'package:poka_ce/features/settings/presentation/screens/settings_page.dart';
import 'package:poka_ce/features/transactions/presentation/screens/transaction_list_page.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'router.g.dart';

/// Navigation observer for logging route changes using Talker.
class GoRouterObserver extends NavigatorObserver {
  /// Constructor
  GoRouterObserver(this.talker);

  /// Talker instance
  final Talker talker;

  @override
  void didPush(Route<Object?> route, Route<Object?>? previousRoute) {
    talker.info('Route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route<Object?> route, Route<Object?>? previousRoute) {
    talker.info('Route popped: ${route.settings.name}');
  }
}

/// Root navigator key for the router.
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Provider for GoRouter.
final routerProvider = Provider<GoRouter>((ref) {
  final routerListenable = ValueNotifier<int>(0);

  ref
    ..listen(settingsProvider, (previous, next) {
      if (previous?.isLoading != next.isLoading || previous?.settings?.baseCurrency != next.settings?.baseCurrency) {
        routerListenable.value++;
      }
    })
    ..listen(appLockControllerProvider, (previous, next) {
      routerListenable.value++;
    });

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: const DashboardRoute().location,
    routes: $appRoutes,
    refreshListenable: routerListenable,
    redirect: (context, state) {
      final settingsState = ref.read(settingsProvider);
      final appLockState = ref.read(appLockControllerProvider);

      final isLoaded = !settingsState.isLoading && settingsState.error == null;
      if (!isLoaded) return null;

      final hasCurrency = settingsState.settings?.baseCurrency != null;
      final isGoingToOnboarding = state.matchedLocation == const OnboardingRoute().location;
      final isLockScreen = state.matchedLocation == const LockRoute().location;

      if (!appLockState.isAuthenticated) {
        return isLockScreen ? null : const LockRoute().location;
      }

      if (!hasCurrency && !isGoingToOnboarding) {
        return const OnboardingRoute().location;
      }
      if (hasCurrency && isGoingToOnboarding) {
        return const DashboardRoute().location;
      }
      return null;
    },
    observers: [
      GoRouterObserver(talker),
    ],
  );
});

@TypedGoRoute<OnboardingRoute>(path: '/onboarding')
class OnboardingRoute extends GoRouteData with $OnboardingRoute {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const OnboardingPage();
}

@TypedGoRoute<CategoryListRoute>(path: '/categories')
class CategoryListRoute extends GoRouteData with $CategoryListRoute {
  const CategoryListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const CategoryListPage();
}

@TypedGoRoute<BudgetListRoute>(path: '/budgets')
class BudgetListRoute extends GoRouteData with $BudgetListRoute {
  const BudgetListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const BudgetListPage();
}

@TypedGoRoute<BudgetDetailRoute>(path: '/budgets/:id')
class BudgetDetailRoute extends GoRouteData with $BudgetDetailRoute {
  const BudgetDetailRoute(this.id, {this.$extra});

  final String id;
  final BudgetModel? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => BudgetDetailPage(id: id, budget: $extra);
}

@TypedGoRoute<GoalListRoute>(path: '/goals')
class GoalListRoute extends GoRouteData with $GoalListRoute {
  const GoalListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const GoalListPage();
}

@TypedGoRoute<GoalDetailRoute>(path: '/goals/:id')
class GoalDetailRoute extends GoRouteData with $GoalDetailRoute {
  const GoalDetailRoute(this.id, {this.$extra});

  final String id;
  final GoalModel? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => GoalDetailPage(id: id, goal: $extra);
}

@TypedStatefulShellRoute<MainShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<DashboardRoute>(path: '/'),
      ],
    ),
    TypedStatefulShellBranch<TransactionsBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<TransactionListRoute>(path: '/transactions'),
      ],
    ),

    TypedStatefulShellBranch<ReportsBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ReportListRoute>(path: '/reports'),
      ],
    ),
    TypedStatefulShellBranch<AccountsBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<AccountListRoute>(path: '/accounts'),
      ],
    ),
    TypedStatefulShellBranch<SettingsBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SettingsRoute>(
          path: '/settings',
        ),
      ],
    ),
  ],
)
class MainShellRoute extends StatefulShellRouteData {
  const MainShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return MainShellPage(navigationShell: navigationShell);
  }
}

class HomeBranch extends StatefulShellBranchData {
  const HomeBranch();
}

class TransactionsBranch extends StatefulShellBranchData {
  const TransactionsBranch();
}

class ReportsBranch extends StatefulShellBranchData {
  const ReportsBranch();
}

class AccountsBranch extends StatefulShellBranchData {
  const AccountsBranch();
}

class SettingsBranch extends StatefulShellBranchData {
  const SettingsBranch();
}

class DashboardRoute extends GoRouteData with $DashboardRoute {
  const DashboardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const DashboardPage();
}

class TransactionListRoute extends GoRouteData with $TransactionListRoute {
  const TransactionListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const TransactionListPage();
}

class ReportListRoute extends GoRouteData with $ReportListRoute {
  const ReportListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const ReportListPage();
}

class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SettingsPage();
}

class AccountListRoute extends GoRouteData with $AccountListRoute {
  const AccountListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const AccountListPage();
}

@TypedGoRoute<AccountDetailRoute>(path: '/accounts/:accountId')
class AccountDetailRoute extends GoRouteData with $AccountDetailRoute {
  const AccountDetailRoute(this.accountId);

  final String accountId;

  @override
  Widget build(BuildContext context, GoRouterState state) => AccountDetailPage(accountId: accountId);
}

@TypedGoRoute<RecurringListRoute>(path: '/recurring')
class RecurringListRoute extends GoRouteData with $RecurringListRoute {
  const RecurringListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const RecurringListPage();
}

@TypedGoRoute<RecurringDetailRoute>(path: '/recurring/:id')
class RecurringDetailRoute extends GoRouteData with $RecurringDetailRoute {
  const RecurringDetailRoute(this.id, {this.$extra});

  final String id;
  final RecurringTransactionModel? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => RecurringDetailPage(id: id, recurring: $extra);
}

@TypedGoRoute<DebtListRoute>(path: '/debts')
class DebtListRoute extends GoRouteData with $DebtListRoute {
  const DebtListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const DebtListPage();
}

@TypedGoRoute<DebtDetailRoute>(path: '/debts/:id')
class DebtDetailRoute extends GoRouteData with $DebtDetailRoute {
  const DebtDetailRoute(this.id, {this.$extra});

  final String id;
  final DebtModel? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => DebtDetailPage(id: id, debt: $extra);
}

@TypedGoRoute<AboutRoute>(path: '/about')
class AboutRoute extends GoRouteData with $AboutRoute {
  const AboutRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const AboutPage();
}

@TypedGoRoute<SupportFaqRoute>(path: '/faq')
class SupportFaqRoute extends GoRouteData with $SupportFaqRoute {
  const SupportFaqRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const FaqPage();
}

@TypedGoRoute<SupportTermsRoute>(path: '/terms')
class SupportTermsRoute extends GoRouteData with $SupportTermsRoute {
  const SupportTermsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => MarkdownPage(
    title: t.app.termsOfService,
    assetPath: 'assets/data/tos.md',
  );
}

@TypedGoRoute<SupportPrivacyRoute>(path: '/privacy')
class SupportPrivacyRoute extends GoRouteData with $SupportPrivacyRoute {
  const SupportPrivacyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => MarkdownPage(
    title: t.app.privacyPolicy,
    assetPath: 'assets/data/privacy.md',
  );
}

@TypedGoRoute<SupportLicensesRoute>(path: '/licenses')
class SupportLicensesRoute extends GoRouteData with $SupportLicensesRoute {
  const SupportLicensesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LicensesScreen();
}

@TypedGoRoute<LockRoute>(path: '/lock')
class LockRoute extends GoRouteData with $LockRoute {
  const LockRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // import 'package:poka_ce/features/settings/presentation/screens/lock_screen.dart';
    // but we have to make sure it's imported at top
    return const LockScreen();
  }
}
