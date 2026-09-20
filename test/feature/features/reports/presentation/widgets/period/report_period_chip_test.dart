import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/reports/presentation/widgets/period/report_period_chip.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget buildHarness({required String label, required bool isSelected, required VoidCallback onTap}) {
    return MaterialApp(
      builder: (context, child) => FTheme(data: lightTheme, child: child!),
      home: Scaffold(
        body: Center(
          child: ReportPeriodChip(label: label, isSelected: isSelected, onTap: onTap),
        ),
      ),
    );
  }

  testWidgets('ReportPeriodChip displays label and handles tap', (tester) async {
    var tapped = false;
    await tester.pumpWidget(buildHarness(label: 'This Month', isSelected: false, onTap: () => tapped = true));
    await tester.pumpAndSettle();

    expect(find.text('This Month'), findsOneWidget);

    await tester.tap(find.text('This Month'));
    expect(tapped, isTrue);
  });

  testWidgets('ReportPeriodChip shows selected styling', (tester) async {
    await tester.pumpWidget(buildHarness(label: 'Last Month', isSelected: true, onTap: () {}));
    await tester.pumpAndSettle();

    expect(find.text('Last Month'), findsOneWidget);
  });
}
