import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'robot_base.dart';

import 'package:poka_ce/features/accounts/presentation/widgets/cards/account_networth_card.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/cards/dashboard_analytics_carousel.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/cards/dashboard_spending_chart.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/sections/dashboard_quick_actions.dart';
import 'package:poka_ce/features/dashboard/presentation/widgets/sections/dashboard_recent_transactions.dart';

class DashboardRobot extends RobotBase {
  const DashboardRobot(super.tester);

  void verifyTopComponentsRendered() {
    expect(find.byType(AccountNetworthCard), findsOneWidget);
    expect(find.byType(DashboardQuickActions), findsOneWidget);
  }

  Future<void> scrollAndVerifyAnalyticsCarousel() async {
    final scrollable = find.byType(Scrollable).first;
    await tester.drag(scrollable, const Offset(0, -500));
    await settle();
    expect(find.byType(DashboardAnalyticsCarousel), findsOneWidget);
  }

  Future<void> scrollAndVerifySpendingChart() async {
    final scrollable = find.byType(Scrollable).first;
    await tester.drag(scrollable, const Offset(0, -500));
    await settle();
    expect(find.byType(DashboardSpendingChart), findsOneWidget);
  }

  Future<void> scrollAndVerifyRecentTransactions() async {
    final scrollable = find.byType(Scrollable).first;
    await tester.drag(scrollable, const Offset(0, -500));
    await settle();
    expect(find.byType(DashboardRecentTransactions), findsOneWidget);
  }
}
