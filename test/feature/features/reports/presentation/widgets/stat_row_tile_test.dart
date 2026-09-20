import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/reports/presentation/widgets/stat_row_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.en));

  Widget wrap({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required double delta,
    required String prevLabel,
    required bool positiveIsGood,
  }) {
    return TranslationProvider(
      child: MaterialApp(
        builder: (context, child) => FTheme(data: lightTheme, child: child!),
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: StatRowTile(
              icon: icon,
              iconColor: iconColor,
              label: label,
              value: value,
              delta: delta,
              prevLabel: prevLabel,
              positiveIsGood: positiveIsGood,
            ),
          ),
        ),
      ),
    );
  }

  group('StatRowTile', () {
    testWidgets('renders label, value, and comparison delta text', (tester) async {
      await tester.pumpWidget(
        wrap(
          icon: FPhosphorIcons.arrowDownLeft,
          iconColor: Colors.green,
          label: 'Income',
          value: 'Rp 10.000.000',
          delta: 15.0,
          prevLabel: 'Last month',
          positiveIsGood: true,
        ),
      );

      expect(find.text('Income'), findsOneWidget);
      expect(find.text('Rp 10.000.000'), findsOneWidget);
      expect(find.text('15.0%'), findsOneWidget);
      expect(find.text(t.reports.comparedTo(period: 'Last month')), findsOneWidget);
    });

    testWidgets('hides delta row visibility when delta is 0', (tester) async {
      await tester.pumpWidget(
        wrap(
          icon: FPhosphorIcons.arrowUpRight,
          iconColor: Colors.red,
          label: 'Expense',
          value: 'Rp 5.000.000',
          delta: 0.0,
          prevLabel: 'Last month',
          positiveIsGood: false,
        ),
      );

      expect(find.text('Expense'), findsOneWidget);
      expect(find.text('Rp 5.000.000'), findsOneWidget);

      final opacityWidget = tester.widget<Opacity>(find.byType(Opacity));
      expect(opacityWidget.opacity, 0.0);
    });
  });
}
