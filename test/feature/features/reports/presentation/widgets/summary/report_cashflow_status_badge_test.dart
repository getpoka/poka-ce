import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/reports/presentation/widgets/summary/report_cashflow_status_badge.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.en));

  Widget wrap({required bool isOnTrack}) {
    return TranslationProvider(
      child: MaterialApp(
        builder: (context, child) => FTheme(data: lightTheme, child: child!),
        home: Scaffold(
          body: Center(child: ReportCashflowStatusBadge(isOnTrack: isOnTrack)),
        ),
      ),
    );
  }

  group('ReportCashflowStatusBadge', () {
    testWidgets('renders on track status when isOnTrack is true', (tester) async {
      await tester.pumpWidget(wrap(isOnTrack: true));

      expect(find.text(t.reports.onTrack), findsOneWidget);
    });

    testWidgets('renders needs attention status when isOnTrack is false', (tester) async {
      await tester.pumpWidget(wrap(isOnTrack: false));

      expect(find.text(t.reports.needsAttention), findsOneWidget);
    });
  });
}
