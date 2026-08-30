import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/shell/main_shell_page.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_runner_notifier.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class _FakeRecurringRunner extends RecurringRunnerNotifier {
  @override
  RecurringRunnerState build() => const RecurringRunnerIdle();
}

class _FakeDashboardNotifier extends DashboardNotifier {
  @override
  DashboardState build() => const DashboardState(isLoading: false);
}

class _FakeCategoryNotifier extends CategoryListNotifier {
  @override
  Future<List<CategoryModel>> build() => Future.value(const []);
}

class _FakeSettingsNotifier extends SettingsNotifier {
  @override
  SettingsState build() => const SettingsState(isLoading: false);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late GoRouter router;

  setUp(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
    router = GoRouter(
      initialLocation: '/home',
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) => MainShellPage(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/home',
                  builder: (_, __) => const Scaffold(body: Text('HomePage')),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/transactions',
                  builder: (_, __) => const Scaffold(body: Text('TransactionsPage')),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/reports',
                  builder: (_, __) => const Scaffold(body: Text('ReportsPage')),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/accounts',
                  builder: (_, __) => const Scaffold(body: Text('AccountsPage')),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/settings',
                  builder: (_, __) => const Scaffold(body: Text('SettingsPage')),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  });

  Widget buildSubject() {
    return ProviderScope(
      overrides: [
        recurringRunnerProvider.overrideWith(() => _FakeRecurringRunner()),
        dashboardProvider.overrideWith(() => _FakeDashboardNotifier()),
        categoryListProvider.overrideWith(() => _FakeCategoryNotifier()),
        settingsProvider.overrideWith(() => _FakeSettingsNotifier()),
      ],
      child: TranslationProvider(
        child: MaterialApp.router(
          routerConfig: router,
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: child!,
          ),
        ),
      ),
    );
  }

  group('MainShellPage', () {
    testWidgets('renders shell with bottom nav bar', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.byType(FBottomNavigationBar), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Transactions'), findsOneWidget);
    });

    testWidgets('tapping nav item navigates branch', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Transactions'));
      await tester.pumpAndSettle();

      expect(find.text('TransactionsPage'), findsOneWidget);
    });

    testWidgets('FAB is visible on Home and Transactions tabs, hidden on Reports', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();
      expect(find.byIcon(FPhosphorIcons.plus), findsOneWidget);

      await tester.tap(find.text('Transactions'));
      await tester.pumpAndSettle();
      expect(find.byIcon(FPhosphorIcons.plus), findsOneWidget);

      await tester.tap(find.text('Reports'));
      await tester.pumpAndSettle();
      expect(find.byIcon(FPhosphorIcons.plus), findsNothing);
    });

    testWidgets('Scroll down hides FAB', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.byIcon(FPhosphorIcons.plus), findsOneWidget);

      final BuildContext context = tester.element(find.byIcon(FPhosphorIcons.plus));

      ScrollUpdateNotification(
        metrics: FixedScrollMetrics(
          minScrollExtent: 0,
          maxScrollExtent: 1000,
          pixels: 100,
          viewportDimension: 500,
          axisDirection: AxisDirection.down,
          devicePixelRatio: 1.0,
        ),
        context: context,
        scrollDelta: 60.0,
      ).dispatch(context);

      await tester.pumpAndSettle();
      // FAB is animated out: its AnimatedOpacity reaches opacity 0.
      final opacityFinder = find.ancestor(
        of: find.byIcon(FPhosphorIcons.plus),
        matching: find.byType(AnimatedOpacity),
      );
      expect(opacityFinder, findsOneWidget);
      final fade = tester.widget<AnimatedOpacity>(opacityFinder.first);
      expect(fade.opacity, 0.0);
    });

    testWidgets('FAB tap opens transaction sheet', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(FPhosphorIcons.plus));
      await tester.pumpAndSettle();

      expect(find.text('New Transaction'), findsOneWidget);
    });
  });
}
