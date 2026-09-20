import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/reports/presentation/widgets/summary/report_delta_badge.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget wrap({required double delta, required bool positiveIsGood}) {
    return MaterialApp(
      builder: (context, child) => FTheme(data: lightTheme, child: child!),
      home: Scaffold(
        body: Center(
          child: ReportDeltaBadge(delta: delta, positiveIsGood: positiveIsGood),
        ),
      ),
    );
  }

  group('ReportDeltaBadge', () {
    testWidgets('renders positive delta formatted with percent', (tester) async {
      await tester.pumpWidget(wrap(delta: 12.5, positiveIsGood: true));

      expect(find.text('12.5%'), findsOneWidget);
      expect(find.byIcon(FPhosphorIcons.arrowUp), findsOneWidget);
    });

    testWidgets('renders negative delta formatted with percent', (tester) async {
      await tester.pumpWidget(wrap(delta: -8.3, positiveIsGood: true));

      expect(find.text('8.3%'), findsOneWidget);
      expect(find.byIcon(FPhosphorIcons.arrowDown), findsOneWidget);
    });
  });
}
