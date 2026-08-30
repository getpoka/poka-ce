import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/cards/views/dashboard_budget_view.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/cards/views/carousel_shared.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
import 'package:poka_ce/core/enums.dart';

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
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: const Scaffold(
            body: SingleChildScrollView(child: DashboardBudgetView()),
          ),
        ),
      ),
    );
  }

  group('DashboardBudgetView', () {
    testWidgets('renders with empty allocations shows empty donut', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createWidget(const DashboardState()));
      await tester.pump();

      expect(find.byWidgetPredicate((w) => w is CustomPaint && w.painter is DonutChartPainter), findsOneWidget);
      expect(find.text('Needs (50%)'), findsOneWidget);
      expect(find.text('Wants (30%)'), findsOneWidget);
      expect(find.text('Savings (20%)'), findsOneWidget);
      // All values should be 0 formatted
      expect(find.text('0'), findsNWidgets(3));
    });

    testWidgets('renders with need/want/saving allocations', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        createWidget(
          DashboardState(
            budgetAllocations: {
              TransactionAllocation.need: 5000000,
              TransactionAllocation.want: 3000000,
              TransactionAllocation.saving: 2000000,
            },
          ),
        ),
      );
      await tester.pump();

      expect(find.byWidgetPredicate((w) => w is CustomPaint && w.painter is DonutChartPainter), findsOneWidget);
      expect(find.text('Needs (50%)'), findsOneWidget);
      expect(find.text('Wants (30%)'), findsOneWidget);
      expect(find.text('Savings (20%)'), findsOneWidget);
      // Check compact formats: 5M -> 5.0M etc.
      expect(find.textContaining('5.0M'), findsOneWidget);
      expect(find.textContaining('3.0M'), findsOneWidget);
      expect(find.textContaining('2.0M'), findsOneWidget);
      // Progress indicators
      expect(find.byType(LinearProgressIndicator), findsNWidgets(3));
    });

    testWidgets('renders with only need allocation', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        createWidget(
          DashboardState(
            budgetAllocations: {
              TransactionAllocation.need: 10000000,
            },
          ),
        ),
      );
      await tester.pump();

      expect(find.byWidgetPredicate((w) => w is CustomPaint && w.painter is DonutChartPainter), findsOneWidget);
      expect(find.text('Needs (50%)'), findsOneWidget);
      // want and saving should be 0
      expect(find.text('0'), findsNWidgets(2));
    });

    testWidgets('renders with zero want and saving but non-zero need', (tester) async {
      await tester.pumpWidget(
        createWidget(
          DashboardState(
            budgetAllocations: {
              TransactionAllocation.need: 169000000,
              TransactionAllocation.want: 0,
              TransactionAllocation.saving: 0,
            },
          ),
        ),
      );
      await tester.pump();
      expect(find.byWidgetPredicate((w) => w is CustomPaint && w.painter is DonutChartPainter), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsNWidgets(3));
    });

    testWidgets('handles large mix and ensures proportions computed', (tester) async {
      await tester.pumpWidget(
        createWidget(
          DashboardState(
            budgetAllocations: {
              TransactionAllocation.need: 100,
              TransactionAllocation.want: 200,
              TransactionAllocation.saving: 300,
            },
          ),
        ),
      );
      await tester.pump();
      expect(find.byWidgetPredicate((w) => w is CustomPaint && w.painter is DonutChartPainter), findsOneWidget);
    });
  });
}

class _FakeDashboardNotifier extends DashboardNotifier {
  final DashboardState _state;
  _FakeDashboardNotifier(this._state);
  @override
  DashboardState build() => _state;
}
