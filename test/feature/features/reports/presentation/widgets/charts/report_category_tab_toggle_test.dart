import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/reports/presentation/widgets/charts/report_category_tab_toggle.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ReportCategoryTabToggle handles expense and income toggles', (tester) async {
    var expenseTapped = false;
    var incomeTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => FTheme(data: lightTheme, child: child!),
        home: Scaffold(
          body: ReportCategoryTabToggle(
            isExpense: true,
            onExpenseTap: () => expenseTapped = true,
            onIncomeTap: () => incomeTapped = true,
            expenseLabel: 'Expense',
            incomeLabel: 'Income',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Expense'), findsOneWidget);
    expect(find.text('Income'), findsOneWidget);

    await tester.tap(find.text('Income'));
    expect(incomeTapped, isTrue);

    await tester.tap(find.text('Expense'));
    expect(expenseTapped, isTrue);
  });
}
