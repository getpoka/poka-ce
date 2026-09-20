import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_budget_utilization.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_spending_allocation.dart';
import 'package:poka_ce/features/reports/presentation/widgets/tabs/report_budgets_tab.dart';
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
          home: const Scaffold(body: ReportBudgetsTab()),
        ),
      ),
    );
  }

  testWidgets('ReportBudgetsTab renders budget utilization and spending allocation', (tester) async {
    const state = ReportState(
      isLoading: false,
      data: ReportData(budgetAllocation: ReportBudgetAllocation(need: 500000, want: 300000, saving: 200000)),
    );

    await tester.pumpWidget(buildTestableWidget(state));
    await tester.pumpAndSettle();

    expect(find.byType(ReportBudgetUtilization), findsOneWidget);
    expect(find.byType(ReportSpendingAllocation), findsOneWidget);
  });
}
