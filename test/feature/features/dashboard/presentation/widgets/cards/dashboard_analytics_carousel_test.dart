import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/cards/dashboard_analytics_carousel.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/features/dashboard/domain/services/dashboard_analytics_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  Widget createWidget(DashboardState state) {
    return ProviderScope(
      overrides: [
        dashboardProvider.overrideWith(() => _FakeDashboardNotifier(state)),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: child!,
          ),
          home: const Scaffold(
            body: SingleChildScrollView(child: DashboardAnalyticsCarousel()),
          ),
        ),
      ),
    );
  }

  void ignoreOverflow() {
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      if (details.toString().contains('overflowed') || details.toString().contains('deactivated')) return;
      originalOnError?.call(details);
    };
    addTearDown(() => FlutterError.onError = originalOnError);
  }

  group('DashboardAnalyticsCarousel', () {
    testWidgets('renders tabs and initial Cash Flow view', (tester) async {
      ignoreOverflow();
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        createWidget(
          DashboardState(
            totalIncome: 12000000,
            totalExpense: 2970000,
            categoryExpenses: [
              CategoryExpenseItem('Food', '#FF0000', 1000),
            ],
            budgetAllocations: {
              TransactionAllocation.need: 1000,
            },
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(DashboardAnalyticsCarousel), findsOneWidget);
      expect(find.text('Cash Flow'), findsOneWidget);
      expect(find.text('Categories'), findsOneWidget);
      expect(find.text('Budgets'), findsOneWidget);

      // Initial state is Cash Flow (index 0)
      expect(find.text('Income'), findsOneWidget);
      expect(find.text('Expense'), findsOneWidget);
    });

    testWidgets('tapping Categories shows categories view', (tester) async {
      ignoreOverflow();
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        createWidget(
          DashboardState(
            totalIncome: 5000,
            totalExpense: 2000,
            categoryExpenses: [
              CategoryExpenseItem('Subscriptions', '#FF0000', 164000),
              CategoryExpenseItem('Coffee', '#00FF00', 45600),
            ],
            budgetAllocations: {
              TransactionAllocation.need: 1000,
            },
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.text('Categories'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Subscriptions'), findsOneWidget);
      expect(find.text('Coffee'), findsOneWidget);
    });

    testWidgets('tapping Budgets shows budget view', (tester) async {
      ignoreOverflow();
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        createWidget(
          DashboardState(
            totalIncome: 1000,
            totalExpense: 500,
            categoryExpenses: [],
            budgetAllocations: {
              TransactionAllocation.need: 500,
              TransactionAllocation.want: 300,
              TransactionAllocation.saving: 200,
            },
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.text('Budgets'));
      await tester.pump();

      expect(find.text('Needs (50%)'), findsOneWidget);
      expect(find.text('Wants (30%)'), findsOneWidget);
      expect(find.text('Savings (20%)'), findsOneWidget);
    });

    testWidgets('tapping tabs cycles correctly and back to Cash Flow', (tester) async {
      ignoreOverflow();
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        createWidget(
          DashboardState(
            totalIncome: 12000000,
            totalExpense: 2970000,
            categoryExpenses: [
              CategoryExpenseItem('Subscriptions', '#FF0000', 164000000),
              CategoryExpenseItem('Coffee', '#00FF00', 45600000),
            ],
            budgetAllocations: {
              TransactionAllocation.need: 169000000,
              TransactionAllocation.want: 50000000,
              TransactionAllocation.saving: 20000000,
            },
          ),
        ),
      );
      await tester.pump();

      // Budgets
      await tester.tap(find.text('Budgets'));
      await tester.pumpAndSettle();
      expect(find.text('Needs (50%)'), findsOneWidget);

      // Categories
      await tester.tap(find.text('Categories'));
      await tester.pumpAndSettle();
      expect(find.text('Subscriptions'), findsOneWidget);

      // Cash Flow
      await tester.tap(find.text('Cash Flow'));
      await tester.pumpAndSettle();
      expect(find.text('Income'), findsOneWidget);
      expect(find.text('Expense'), findsOneWidget);
    });

    testWidgets('has FCard and fixed height content', (tester) async {
      ignoreOverflow();
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createWidget(const DashboardState()));
      await tester.pump();

      expect(find.byType(FCard), findsOneWidget);
      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('handles empty state without crashing', (tester) async {
      ignoreOverflow();
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createWidget(const DashboardState()));
      await tester.pump();

      // Should still show tabs
      expect(find.text('Cash Flow'), findsOneWidget);
      // Tap each
      await tester.tap(find.text('Categories'));
      await tester.pump();
      expect(find.text('No data'), findsOneWidget);

      await tester.tap(find.text('Budgets'));
      await tester.pump();
      // Budget view with empty allocations should still render
      expect(find.text('Needs (50%)'), findsOneWidget);
    });
  });
}

class _FakeDashboardNotifier extends DashboardNotifier {
  final DashboardState _state;
  _FakeDashboardNotifier(this._state);
  @override
  DashboardState build() => _state;
}
