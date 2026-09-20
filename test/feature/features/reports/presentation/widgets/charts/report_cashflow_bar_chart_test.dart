import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/widgets/charts/report_cashflow_bar_chart.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ReportCashflowBarChart renders bar chart with given points', (tester) async {
    const points = [
      ReportTrendPoint(label: 'W1', income: 100000, expense: 50000),
      ReportTrendPoint(label: 'W2', income: 80000, expense: 40000),
    ];

    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => FTheme(data: lightTheme, child: child!),
        home: Scaffold(
          body: SizedBox(
            height: 200,
            width: 300,
            child: ReportCashflowBarChart(
              points: points,
              incomeColor: Colors.green,
              expenseColor: Colors.red,
              theme: lightTheme,
              isBalanceVisible: true,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(BarChart), findsOneWidget);
    expect(find.text('W1'), findsOneWidget);
    expect(find.text('W2'), findsOneWidget);
  });
}
