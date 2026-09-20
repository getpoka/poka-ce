import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/reports/presentation/widgets/budgets/report_budget_overall_bar.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.en));

  Widget wrap({required int totalSpent, required int totalLimit, required double overallProgress}) {
    return ProviderScope(
      overrides: [settingsProvider.overrideWith(() => _FakeSettingsNotifier())],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: ReportBudgetOverallBar(
                totalSpent: totalSpent,
                totalLimit: totalLimit,
                overallProgress: overallProgress,
              ),
            ),
          ),
        ),
      ),
    );
  }

  group('ReportBudgetOverallBar', () {
    testWidgets('renders spent percentage and remaining amount', (tester) async {
      await tester.pumpWidget(wrap(totalSpent: 4000, totalLimit: 10000, overallProgress: 0.4));

      expect(find.text('40.0% ${t.reports.spent}'), findsOneWidget);
      expect(find.text(t.reports.remaining), findsOneWidget);
    });
  });
}

class _FakeSettingsNotifier extends SettingsNotifier {
  @override
  SettingsState build() => const SettingsState();
}
