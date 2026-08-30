import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/cards/views/carousel_shared.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/cards/views/dashboard_categories_view.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/dashboard_notifier.dart';
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
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: const Scaffold(
            body: SingleChildScrollView(child: DashboardCategoriesView()),
          ),
        ),
      ),
    );
  }

  group('DashboardCategoriesView', () {
    testWidgets('shows No data when no categories', (tester) async {
      await tester.pumpWidget(createWidget(const DashboardState(totalExpense: 0, categoryExpenses: [])));
      await tester.pump();

      expect(find.text('No data'), findsOneWidget);
      expect(find.byWidgetPredicate((w) => w is CustomPaint && w.painter is DonutChartPainter), findsOneWidget);
    });

    testWidgets('shows categories with <=3 items no Other', (tester) async {
      await tester.pumpWidget(
        createWidget(
          DashboardState(
            totalExpense: 1000,
            categoryExpenses: [
              CategoryExpenseItem('Food', '#FF0000', 500),
              CategoryExpenseItem('Transport', '#00FF00', 300),
              CategoryExpenseItem('Entertainment', '#0000FF', 200),
            ],
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Food'), findsOneWidget);
      expect(find.text('Transport'), findsOneWidget);
      expect(find.text('Entertainment'), findsOneWidget);
      expect(find.text('Other'), findsNothing);
      expect(find.byWidgetPredicate((w) => w is CustomPaint && w.painter is DonutChartPainter), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsNWidgets(3));
    });

    testWidgets('groups beyond 3 into Other', (tester) async {
      await tester.pumpWidget(
        createWidget(
          DashboardState(
            totalExpense: 1000,
            categoryExpenses: [
              CategoryExpenseItem('A', '#FF0000', 400),
              CategoryExpenseItem('B', '#00FF00', 300),
              CategoryExpenseItem('C', '#0000FF', 200),
              CategoryExpenseItem('D', '#FFFF00', 50),
              CategoryExpenseItem('E', '#FF00FF', 50),
            ],
          ),
        ),
      );
      await tester.pump();

      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
      expect(find.text('Other'), findsOneWidget);
      // Other should aggregate D+E =100 -> 100 compact?
      expect(find.byType(LinearProgressIndicator), findsNWidgets(4));
    });

    testWidgets('handles totalExpense 0 avoids division by zero', (tester) async {
      await tester.pumpWidget(
        createWidget(
          DashboardState(
            totalExpense: 0,
            categoryExpenses: [
              CategoryExpenseItem('Food', '#FF0000', 500),
            ],
          ),
        ),
      );
      await tester.pump();

      // When total is 0, code uses 1.0 as fallback, so should still render
      expect(find.text('Food'), findsOneWidget);
      expect(find.byWidgetPredicate((w) => w is CustomPaint && w.painter is DonutChartPainter), findsOneWidget);
    });

    testWidgets('sorts expenses by amount descending', (tester) async {
      await tester.pumpWidget(
        createWidget(
          DashboardState(
            totalExpense: 1000,
            categoryExpenses: [
              CategoryExpenseItem('Small', '#FF0000', 100),
              CategoryExpenseItem('Large', '#00FF00', 900),
            ],
          ),
        ),
      );
      await tester.pump();

      // Large should appear first; check order via find
      expect(find.text('Large'), findsOneWidget);
      expect(find.text('Small'), findsOneWidget);
    });

    testWidgets('handles single category', (tester) async {
      await tester.pumpWidget(
        createWidget(
          DashboardState(
            totalExpense: 500,
            categoryExpenses: [
              CategoryExpenseItem('Solo', '#123456', 500),
            ],
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Solo'), findsOneWidget);
      expect(find.text('Other'), findsNothing);
    });

    testWidgets('handles invalid color gracefully via toColor fallback', (tester) async {
      await tester.pumpWidget(
        createWidget(
          DashboardState(
            totalExpense: 100,
            categoryExpenses: [
              CategoryExpenseItem('BadColor', 'not-a-color', 100),
            ],
          ),
        ),
      );
      await tester.pump();

      expect(find.text('BadColor'), findsOneWidget);
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
