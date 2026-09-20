import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/reports/presentation/widgets/budgets/report_budget_status_chip.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget wrap({required String label, required Color color}) {
    return MaterialApp(
      builder: (context, child) => FTheme(data: lightTheme, child: child!),
      home: Scaffold(
        body: Center(
          child: ReportBudgetStatusChip(label: label, color: color),
        ),
      ),
    );
  }

  group('ReportBudgetStatusChip', () {
    testWidgets('renders label and uses specified color', (tester) async {
      await tester.pumpWidget(wrap(label: 'Over Budget', color: Colors.red));

      expect(find.text('Over Budget'), findsOneWidget);
    });
  });
}
