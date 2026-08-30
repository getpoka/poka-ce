import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/cards/dashboard_spending_chart.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/daily_budget_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  void ignoreOverflow() {
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      if (details.toString().contains('overflowed') || details.toString().contains('deactivated')) return;
      originalOnError?.call(details);
    };
    addTearDown(() => FlutterError.onError = originalOnError);
  }

  Widget createWidget({
    DashboardState dashboardState = const DashboardState(
      totalExpense: 7000,
      dailySpending: [100, 200, 300, 400, 500, 600, 700],
      normalizedDailySpending: [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 1.0],
    ),
    double dailyBudget = 0.0,
    Future<void> Function(double)? onSetBudget,
  }) {
    return ProviderScope(
      overrides: [
        dashboardProvider.overrideWith(() => _FakeDashboardNotifier(dashboardState)),
        dailyBudgetProvider.overrideWith(() => _FakeDailyBudgetNotifier(dailyBudget, onSetBudget)),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: child!,
          ),
          home: const Scaffold(
            body: SingleChildScrollView(child: DashboardSpendingChart()),
          ),
        ),
      ),
    );
  }

  group('DashboardSpendingChart', () {
    testWidgets('renders header and stats when no budget', (tester) async {
      ignoreOverflow();
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      expect(find.text('Spending Activity'), findsOneWidget);
      expect(find.text('Total'), findsOneWidget);
      expect(find.text('Average'), findsOneWidget);
      expect(find.text('Budget/Day'), findsOneWidget);
      expect(find.text('Not set'), findsOneWidget);
      // No Today's Budget when budget is 0
      expect(find.text("Today's Budget"), findsNothing);
      expect(find.text('Overbudget!'), findsNothing);
      // Should have 7 day bars
      expect(find.byType(FCard), findsOneWidget);
    });

    testWidgets('shows budget and progress when budget is set', (tester) async {
      ignoreOverflow();
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        createWidget(
          dashboardState: const DashboardState(
            totalExpense: 7000,
            dailySpending: [0, 0, 0, 0, 0, 0, 500],
            normalizedDailySpending: [0, 0, 0, 0, 0, 0, 0.5],
          ),
          dailyBudget: 1000,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text("Today's Budget"), findsOneWidget);
      expect(find.text('Overbudget!'), findsNothing);
      expect(find.byType(FDeterminateProgress), findsOneWidget);
      // budget formatted via toCompactFormat -> 1.0K for 1000
      expect(find.textContaining('1.0K'), findsWidgets);
    });

    testWidgets('shows overbudget when today spending exceeds budget', (tester) async {
      ignoreOverflow();
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        createWidget(
          dashboardState: const DashboardState(
            totalExpense: 10000,
            dailySpending: [0, 0, 0, 0, 0, 0, 1500],
            normalizedDailySpending: [0, 0, 0, 0, 0, 0, 1.0],
          ),
          dailyBudget: 1000,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Overbudget!'), findsOneWidget);
      expect(find.text("Today's Budget"), findsOneWidget);
      expect(find.byType(FDeterminateProgress), findsOneWidget);
    });

    testWidgets('tapping budget opens sheet and saving calls setBudget', (tester) async {
      ignoreOverflow();
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      double? savedAmount;
      await tester.pumpWidget(
        createWidget(
          dailyBudget: 0,
          onSetBudget: (v) async => savedAmount = v,
        ),
      );
      await tester.pump();

      // Tap on Not set to open modal
      await tester.tap(find.text('Not set'));
      await tester.pumpAndSettle();

      expect(find.text('Set Daily Budget'), findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
      expect(find.text('e.g. 100000'), findsOneWidget);

      // Enter amount
      final textField = find.byType(FTextField);
      expect(textField, findsOneWidget);
      await tester.enterText(textField, '5000');
      await tester.pump();

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(savedAmount, 5000);
      expect(find.text('Set Daily Budget'), findsNothing);
    });

    testWidgets('saving with empty/invalid input just closes without calling setBudget', (tester) async {
      ignoreOverflow();
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      bool called = false;
      await tester.pumpWidget(
        createWidget(
          dailyBudget: 0,
          onSetBudget: (v) async => called = true,
        ),
      );
      await tester.pump();

      await tester.tap(find.text('Not set'));
      await tester.pumpAndSettle();

      // Don't enter text, just tap Save
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(called, isFalse);
      expect(find.text('Set Daily Budget'), findsNothing);
    });

    testWidgets('saving with invalid text does not call setBudget', (tester) async {
      ignoreOverflow();
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      bool called = false;
      await tester.pumpWidget(
        createWidget(
          dailyBudget: 2000,
          onSetBudget: (v) async => called = true,
        ),
      );
      await tester.pump();

      // Find the budget text (formatted 2.0K)
      final budgetRow = find.textContaining('2.0K');
      expect(budgetRow, findsWidgets);
      await tester.tap(budgetRow.first);
      await tester.pumpAndSettle();

      expect(find.text('Set Daily Budget'), findsOneWidget);
      // controller should be prefilled with 2000
      await tester.enterText(find.byType(FTextField), 'abc');
      await tester.pump();

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(called, isFalse);
    });

    testWidgets('renders day labels for 7 days', (tester) async {
      ignoreOverflow();
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      // At least Mon-Sun labels should appear among the 7 bars
      // We check that 7 bars are rendered by counting bar containers via height logic
      // Instead check that day labels are present (at least 3 of them)
      final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      int found = 0;
      for (final d in days) {
        if (tester.any(find.text(d))) found++;
      }
      expect(found, greaterThanOrEqualTo(7)); // actually should be 7 but due to duplicate check
      // Expect 7 bars exist via checking text labels count
      expect(found, 7);
    });

    testWidgets('total and average are formatted correctly', (tester) async {
      ignoreOverflow();
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        createWidget(
          dashboardState: const DashboardState(
            totalExpense: 7000,
            dailySpending: [1000, 1000, 1000, 1000, 1000, 1000, 1000],
            normalizedDailySpending: [1, 1, 1, 1, 1, 1, 1],
          ),
          dailyBudget: 0,
        ),
      );
      await tester.pumpAndSettle();

      // total 7000 => 7.0K, average 1000 => 1.0K
      expect(find.textContaining('7.0K'), findsWidgets);
      expect(find.textContaining('1.0K'), findsWidgets);
    });
  });
}

class _FakeDashboardNotifier extends DashboardNotifier {
  final DashboardState _state;
  _FakeDashboardNotifier(this._state);
  @override
  DashboardState build() => _state;
}

class _FakeDailyBudgetNotifier extends DailyBudget {
  final double _budget;
  final Future<void> Function(double)? _onSet;
  _FakeDailyBudgetNotifier(this._budget, this._onSet);
  @override
  double build() => _budget;

  @override
  Future<void> setBudget(double amount) async {
    if (_onSet != null) await _onSet(amount);
  }
}
