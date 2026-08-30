import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/charts/report_cashflow_chart.dart';
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
              child: ReportCashflowChart(),
            ),
          ),
        ),
      ),
    );
  }

  group('ReportCashflowChart', () {
    testWidgets('shows no data and zero average when trend is empty', (tester) async {
      await tester.pumpWidget(wrap(const ReportData()));
      await tester.pumpAndSettle();

      expect(find.text('Income'), findsOneWidget);
      expect(find.text('Expense'), findsOneWidget);
      expect(find.text('No data for this period'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('renders bar chart with labels and computed average', (tester) async {
      final data = ReportData(
        summary: const ReportSummary(totalExpense: 1200),
        trendPoints: const [
          ReportTrendPoint(label: 'W1', income: 500, expense: 400),
          ReportTrendPoint(label: 'W2', income: 700, expense: 800),
        ],
      );
      await tester.pumpWidget(wrap(data));
      await tester.pumpAndSettle();

      expect(find.text('W1'), findsOneWidget);
      expect(find.text('W2'), findsOneWidget);
      // average = 1200 / 2 = 600
      expect(find.text('600'), findsOneWidget);
    });
  });
}
