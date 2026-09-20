import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/features/reports/domain/services/report_analytics_service.dart';
import 'package:poka_ce/features/reports/presentation/widgets/charts/report_category_pie_chart.dart';
import 'package:poka_ce/shared/widgets/poka_donut_chart.dart';
import 'package:poka_ce/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ReportCategoryPieChart renders donut chart with sections', (tester) async {
    final items = [
      ReportCategoryItem(name: 'Food', color: '#FF5722', amount: 300000, ratio: 0.6, txCount: 5),
      ReportCategoryItem(name: 'Transport', color: '#2196F3', amount: 200000, ratio: 0.4, txCount: 3),
    ];

    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => FTheme(data: lightTheme, child: child!),
        home: Scaffold(
          body: ReportCategoryPieChart(items: items, theme: lightTheme),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ReportCategoryPieChart), findsOneWidget);
    expect(find.byType(PokaDonutChart), findsOneWidget);
  });
}
