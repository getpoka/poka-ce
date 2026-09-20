import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_cashflow_chart.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_category_chart.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_summary_card.dart';
import 'package:poka_ce/features/reports/presentation/widgets/tabs/report_cashflow_tab.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class _FakeReportNotifier extends ReportNotifier {
  _FakeReportNotifier(this._state);
  final ReportState _state;
  @override
  ReportState build() => _state;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.setLocale(AppLocale.en);

  Widget buildTestableWidget(ReportState reportState) {
    return ProviderScope(
      overrides: [
        reportProvider.overrideWith(() => _FakeReportNotifier(reportState)),
        balanceVisibilityProvider.overrideWithValue(true),
        settingsProvider.overrideWithValue(const SettingsState(isLoading: false)),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: const [
            ...FLocalizations.localizationsDelegates,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: FToaster(child: child!),
          ),
          home: const Scaffold(body: ReportCashflowTab()),
        ),
      ),
    );
  }

  testWidgets('ReportCashflowTab renders summary card, cashflow chart, and category chart', (tester) async {
    const state = ReportState(
      isLoading: false,
      data: ReportData(summary: ReportSummary(totalIncome: 1000000, totalExpense: 500000)),
    );

    await tester.pumpWidget(buildTestableWidget(state));
    await tester.pumpAndSettle();

    expect(find.byType(ReportSummaryCard), findsOneWidget);
    expect(find.byType(ReportCashflowChart), findsOneWidget);
    expect(find.byType(ReportCategoryChart), findsOneWidget);
  });
}
