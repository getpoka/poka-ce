import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/cards/report_summary_card.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.setLocale(AppLocale.en);

  Widget buildTestableWidget(Widget child, {List<dynamic> overrides = const []}) {
    return ProviderScope(
      overrides: [...overrides],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: child!,
          ),
          home: Scaffold(body: child),
        ),
      ),
    );
  }

  group('ReportSummaryCard', () {
    testWidgets('renders properly with positive net cashflow', (tester) async {
      final summary = ReportSummary(totalIncome: 1000, totalExpense: 400);
      final comparison = ReportComparison(prevIncome: 800, prevExpense: 500, prevNetCashflow: 300);

      final reportState = ReportState(
        isLoading: false,
        data: ReportData(summary: summary, comparison: comparison),
      );

      await tester.pumpWidget(
        buildTestableWidget(
          const ReportSummaryCard(),
          overrides: [
            reportProvider.overrideWithValue(reportState),
            balanceVisibilityProvider.overrideWithValue(true),
            settingsProvider.overrideWithValue(const SettingsState(isLoading: false)),
          ],
        ),
      );

      expect(find.text('Cash Flow'), findsOneWidget);
      expect(find.text('60%'), findsOneWidget);
      expect(find.text('On track'), findsOneWidget);
      expect(find.textContaining('1,000'), findsOneWidget);
      expect(find.textContaining('400'), findsOneWidget);
      expect(find.textContaining('+'), findsOneWidget);
    });

    testWidgets('renders properly with negative net cashflow', (tester) async {
      final summary = ReportSummary(totalIncome: 400, totalExpense: 1000);
      final comparison = ReportComparison(prevIncome: 500, prevExpense: 400, prevNetCashflow: 100);

      final reportState = ReportState(
        isLoading: false,
        data: ReportData(summary: summary, comparison: comparison),
      );

      await tester.pumpWidget(
        buildTestableWidget(
          const ReportSummaryCard(),
          overrides: [
            reportProvider.overrideWithValue(reportState),
            balanceVisibilityProvider.overrideWithValue(true),
            settingsProvider.overrideWithValue(const SettingsState(isLoading: false)),
          ],
        ),
      );

      expect(find.text('Needs attention'), findsOneWidget);
      expect(find.textContaining('400'), findsOneWidget);
      expect(find.textContaining('1,000'), findsOneWidget);
      expect(find.textContaining('-'), findsOneWidget);
    });
  });
}
