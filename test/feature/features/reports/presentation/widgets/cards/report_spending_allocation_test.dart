import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/controllers/report_notifier.dart';
import 'package:poka_ce/features/reports/presentation/widgets/cards/report_spending_allocation.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.en));

  Widget wrap(ReportBudgetAllocation allocation) {
    return ProviderScope(
      overrides: [
        reportProvider.overrideWithValue(
          ReportState(
            isLoading: false,
            data: ReportData(budgetAllocation: allocation),
          ),
        ),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: const Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: ReportSpendingAllocation(),
            ),
          ),
        ),
      ),
    );
  }

  group('ReportSpendingAllocation', () {
    testWidgets('shows empty guidance when there is no allocation data', (tester) async {
      await tester.pumpWidget(wrap(const ReportBudgetAllocation()));
      await tester.pumpAndSettle();

      expect(find.text('50/30/20'), findsOneWidget);
      expect(find.text('No data for this period'), findsOneWidget);
      expect(find.textContaining('Total'), findsNothing);
    });

    testWidgets('renders total and three allocation rows when data exists', (tester) async {
      await tester.pumpWidget(
        wrap(const ReportBudgetAllocation(need: 500, want: 300, saving: 200)),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('Total'), findsOneWidget);
      expect(find.text('Needs'), findsOneWidget);
      expect(find.text('Wants'), findsOneWidget);
      expect(find.text('Savings'), findsOneWidget);
      expect(find.text('50%'), findsOneWidget);
      expect(find.text('30%'), findsOneWidget);
      expect(find.text('20%'), findsOneWidget);
      expect(find.text('500'), findsWidgets);
      expect(find.text('300'), findsWidgets);
      expect(find.text('200'), findsWidgets);
    });
  });
}
