// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $onboardingRoute,
  $categoryListRoute,
  $budgetListRoute,
  $budgetDetailRoute,
  $goalListRoute,
  $goalDetailRoute,
  $mainShellRoute,
  $accountDetailRoute,
  $recurringListRoute,
  $recurringDetailRoute,
  $debtListRoute,
  $debtDetailRoute,
  $aboutRoute,
  $supportFaqRoute,
  $supportTermsRoute,
  $supportPrivacyRoute,
  $supportLicensesRoute,
  $lockRoute,
];

RouteBase get $onboardingRoute => GoRouteData.$route(
  path: '/onboarding',
  hasOverriddenOnExit: false,
  factory: $OnboardingRoute._fromState,
);

mixin $OnboardingRoute on GoRouteData {
  static OnboardingRoute _fromState(GoRouterState state) =>
      const OnboardingRoute();

  @override
  String get location => GoRouteData.$location('/onboarding');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $categoryListRoute => GoRouteData.$route(
  path: '/categories',
  hasOverriddenOnExit: false,
  factory: $CategoryListRoute._fromState,
);

mixin $CategoryListRoute on GoRouteData {
  static CategoryListRoute _fromState(GoRouterState state) =>
      const CategoryListRoute();

  @override
  String get location => GoRouteData.$location('/categories');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $budgetListRoute => GoRouteData.$route(
  path: '/budgets',
  hasOverriddenOnExit: false,
  factory: $BudgetListRoute._fromState,
);

mixin $BudgetListRoute on GoRouteData {
  static BudgetListRoute _fromState(GoRouterState state) =>
      const BudgetListRoute();

  @override
  String get location => GoRouteData.$location('/budgets');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $budgetDetailRoute => GoRouteData.$route(
  path: '/budgets/:id',
  hasOverriddenOnExit: false,
  factory: $BudgetDetailRoute._fromState,
);

mixin $BudgetDetailRoute on GoRouteData {
  static BudgetDetailRoute _fromState(GoRouterState state) => BudgetDetailRoute(
    state.pathParameters['id']!,
    $extra: state.extra as BudgetModel?,
  );

  BudgetDetailRoute get _self => this as BudgetDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/budgets/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $goalListRoute => GoRouteData.$route(
  path: '/goals',
  hasOverriddenOnExit: false,
  factory: $GoalListRoute._fromState,
);

mixin $GoalListRoute on GoRouteData {
  static GoalListRoute _fromState(GoRouterState state) => const GoalListRoute();

  @override
  String get location => GoRouteData.$location('/goals');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $goalDetailRoute => GoRouteData.$route(
  path: '/goals/:id',
  hasOverriddenOnExit: false,
  factory: $GoalDetailRoute._fromState,
);

mixin $GoalDetailRoute on GoRouteData {
  static GoalDetailRoute _fromState(GoRouterState state) => GoalDetailRoute(
    state.pathParameters['id']!,
    $extra: state.extra as GoalModel?,
  );

  GoalDetailRoute get _self => this as GoalDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/goals/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $mainShellRoute => StatefulShellRouteData.$route(
  factory: $MainShellRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/',
          hasOverriddenOnExit: false,
          factory: $DashboardRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/transactions',
          hasOverriddenOnExit: false,
          factory: $TransactionListRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/reports',
          hasOverriddenOnExit: false,
          factory: $ReportListRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/accounts',
          hasOverriddenOnExit: false,
          factory: $AccountListRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/settings',
          hasOverriddenOnExit: false,
          factory: $SettingsRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $MainShellRouteExtension on MainShellRoute {
  static MainShellRoute _fromState(GoRouterState state) =>
      const MainShellRoute();
}

mixin $DashboardRoute on GoRouteData {
  static DashboardRoute _fromState(GoRouterState state) =>
      const DashboardRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $TransactionListRoute on GoRouteData {
  static TransactionListRoute _fromState(GoRouterState state) =>
      const TransactionListRoute();

  @override
  String get location => GoRouteData.$location('/transactions');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ReportListRoute on GoRouteData {
  static ReportListRoute _fromState(GoRouterState state) =>
      const ReportListRoute();

  @override
  String get location => GoRouteData.$location('/reports');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AccountListRoute on GoRouteData {
  static AccountListRoute _fromState(GoRouterState state) =>
      const AccountListRoute();

  @override
  String get location => GoRouteData.$location('/accounts');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $accountDetailRoute => GoRouteData.$route(
  path: '/accounts/:accountId',
  hasOverriddenOnExit: false,
  factory: $AccountDetailRoute._fromState,
);

mixin $AccountDetailRoute on GoRouteData {
  static AccountDetailRoute _fromState(GoRouterState state) =>
      AccountDetailRoute(state.pathParameters['accountId']!);

  AccountDetailRoute get _self => this as AccountDetailRoute;

  @override
  String get location => GoRouteData.$location(
    '/accounts/${Uri.encodeComponent(_self.accountId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $recurringListRoute => GoRouteData.$route(
  path: '/recurring',
  hasOverriddenOnExit: false,
  factory: $RecurringListRoute._fromState,
);

mixin $RecurringListRoute on GoRouteData {
  static RecurringListRoute _fromState(GoRouterState state) =>
      const RecurringListRoute();

  @override
  String get location => GoRouteData.$location('/recurring');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $recurringDetailRoute => GoRouteData.$route(
  path: '/recurring/:id',
  hasOverriddenOnExit: false,
  factory: $RecurringDetailRoute._fromState,
);

mixin $RecurringDetailRoute on GoRouteData {
  static RecurringDetailRoute _fromState(GoRouterState state) =>
      RecurringDetailRoute(
        state.pathParameters['id']!,
        $extra: state.extra as RecurringTransactionModel?,
      );

  RecurringDetailRoute get _self => this as RecurringDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/recurring/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $debtListRoute => GoRouteData.$route(
  path: '/debts',
  hasOverriddenOnExit: false,
  factory: $DebtListRoute._fromState,
);

mixin $DebtListRoute on GoRouteData {
  static DebtListRoute _fromState(GoRouterState state) => const DebtListRoute();

  @override
  String get location => GoRouteData.$location('/debts');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $debtDetailRoute => GoRouteData.$route(
  path: '/debts/:id',
  hasOverriddenOnExit: false,
  factory: $DebtDetailRoute._fromState,
);

mixin $DebtDetailRoute on GoRouteData {
  static DebtDetailRoute _fromState(GoRouterState state) => DebtDetailRoute(
    state.pathParameters['id']!,
    $extra: state.extra as DebtModel?,
  );

  DebtDetailRoute get _self => this as DebtDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/debts/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $aboutRoute => GoRouteData.$route(
  path: '/about',
  hasOverriddenOnExit: false,
  factory: $AboutRoute._fromState,
);

mixin $AboutRoute on GoRouteData {
  static AboutRoute _fromState(GoRouterState state) => const AboutRoute();

  @override
  String get location => GoRouteData.$location('/about');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $supportFaqRoute => GoRouteData.$route(
  path: '/faq',
  hasOverriddenOnExit: false,
  factory: $SupportFaqRoute._fromState,
);

mixin $SupportFaqRoute on GoRouteData {
  static SupportFaqRoute _fromState(GoRouterState state) =>
      const SupportFaqRoute();

  @override
  String get location => GoRouteData.$location('/faq');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $supportTermsRoute => GoRouteData.$route(
  path: '/terms',
  hasOverriddenOnExit: false,
  factory: $SupportTermsRoute._fromState,
);

mixin $SupportTermsRoute on GoRouteData {
  static SupportTermsRoute _fromState(GoRouterState state) =>
      const SupportTermsRoute();

  @override
  String get location => GoRouteData.$location('/terms');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $supportPrivacyRoute => GoRouteData.$route(
  path: '/privacy',
  hasOverriddenOnExit: false,
  factory: $SupportPrivacyRoute._fromState,
);

mixin $SupportPrivacyRoute on GoRouteData {
  static SupportPrivacyRoute _fromState(GoRouterState state) =>
      const SupportPrivacyRoute();

  @override
  String get location => GoRouteData.$location('/privacy');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $supportLicensesRoute => GoRouteData.$route(
  path: '/licenses',
  hasOverriddenOnExit: false,
  factory: $SupportLicensesRoute._fromState,
);

mixin $SupportLicensesRoute on GoRouteData {
  static SupportLicensesRoute _fromState(GoRouterState state) =>
      const SupportLicensesRoute();

  @override
  String get location => GoRouteData.$location('/licenses');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $lockRoute => GoRouteData.$route(
  path: '/lock',
  hasOverriddenOnExit: false,
  factory: $LockRoute._fromState,
);

mixin $LockRoute on GoRouteData {
  static LockRoute _fromState(GoRouterState state) => const LockRoute();

  @override
  String get location => GoRouteData.$location('/lock');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
