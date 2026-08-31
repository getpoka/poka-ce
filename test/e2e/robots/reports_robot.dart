import 'package:flutter_test/flutter_test.dart';

import 'robot_base.dart';

import 'package:poka_ce/features/reports/presentation/widgets/report_budget_utilization.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_spending_allocation.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_summary_card.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_cashflow_chart.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_category_chart.dart';
import 'package:poka_ce/features/reports/presentation/widgets/report_period_selector.dart';

class ReportsRobot extends RobotBase {
  const ReportsRobot(super.tester);

  void verifyCashflowTabComponents() {
    expect(find.byType(ReportPeriodSelector), findsOneWidget);
    expect(find.byType(ReportSummaryCard), findsOneWidget);
    expect(find.byType(ReportCashflowChart), findsOneWidget);
    expect(find.byType(ReportCategoryChart), findsOneWidget);
  }

  Future<void> navigateToBudgetsTab() async {
    final budgetsTab = find.text('Budgets & Goals').first;
    await tester.tap(budgetsTab);
    await settle();
  }

  void verifyBudgetsTabComponents() {
    expect(find.byType(ReportBudgetUtilization), findsOneWidget);
    expect(find.byType(ReportSpendingAllocation), findsOneWidget);
  }
}
