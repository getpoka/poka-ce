import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_category_chart.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.en));

  Widget wrap(ReportData data) {
    return ProviderScope(
      overrides: [
        reportProvider.overrideWithValue(ReportState(isLoading: false, data: data)),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: const Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: ReportCategoryChart(),
            ),
          ),
        ),
      ),
    );
  }

  ReportCategoryItem item(String name, String color, double amount, double ratio) =>
      ReportCategoryItem(name: name, color: color, amount: amount, ratio: ratio, txCount: 1);

  group('ReportCategoryChart', () {
    testWidgets('shows no data when expense list is empty', (tester) async {
      await tester.pumpWidget(wrap(const ReportData()));
      await tester.pumpAndSettle();

      expect(find.text('Expense'), findsOneWidget);
      expect(find.text('Income'), findsOneWidget);
      expect(find.text('No data for this period'), findsOneWidget);
    });

    testWidgets('renders ranked expense items with legend percentages', (tester) async {
      final data = ReportData(
        expenseCategoryItems: [
          item('Food', '#FF0000', 500, 0.5),
          item('Transport', '#00FF00', 300, 0.3),
        ],
      );
      await tester.pumpWidget(wrap(data));
      await tester.pumpAndSettle();

      expect(find.text('Food'), findsWidgets);
      expect(find.text('Transport'), findsWidgets);
      expect(find.text('50.0%'), findsWidgets);
      expect(find.text('30.0%'), findsWidgets);
      expect(find.text('500'), findsOneWidget);
      expect(find.text('300'), findsOneWidget);
    });

    testWidgets('tapping Income tab switches to income items', (tester) async {
      final data = ReportData(
        expenseCategoryItems: [item('Food', '#FF0000', 500, 1.0)],
        incomeCategoryItems: [item('Salary', '#0000FF', 1000, 1.0)],
      );
      await tester.pumpWidget(wrap(data));
      await tester.pumpAndSettle();

      expect(find.text('Food'), findsWidgets);

      await tester.tap(find.text('Income'));
      await tester.pumpAndSettle();

      expect(find.text('Salary'), findsWidgets);
      expect(find.text('1.0K'), findsOneWidget);
    });

    testWidgets('collapses items beyond top 5 into an Other row', (tester) async {
      final data = ReportData(
        expenseCategoryItems: [
          item('A', '#FF0000', 100, 0.1),
          item('B', '#FF0000', 100, 0.1),
          item('C', '#FF0000', 100, 0.1),
          item('D', '#FF0000', 100, 0.1),
          item('E', '#FF0000', 100, 0.1),
          item('F', '#FF0000', 100, 0.1),
        ],
      );
      await tester.pumpWidget(wrap(data));
      await tester.pumpAndSettle();

      expect(find.text('Other'), findsWidgets);
      expect(find.text('F'), findsNothing);
    });

    testWidgets('handles invalid hex color without crashing', (tester) async {
      final data = ReportData(
        expenseCategoryItems: [item('Broken', 'not-a-color', 250, 1.0)],
      );
      await tester.pumpWidget(wrap(data));
      await tester.pumpAndSettle();

      expect(find.text('Broken'), findsWidgets);
      expect(find.text('100.0%'), findsWidgets);
    });
  });
}
