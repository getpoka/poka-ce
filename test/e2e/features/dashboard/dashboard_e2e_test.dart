import 'package:flutter_test/flutter_test.dart';

import '../../test_setup.dart';
import '../../robots/dashboard_robot.dart';

void main() {
  testWidgets('Dashboard E2E operations', (tester) async {
    await pumpAppForTesting(tester);

    final dashboardRobot = DashboardRobot(tester);

    // 1. App starts on the Dashboard
    await dashboardRobot.settle();

    // Verify all major dashboard components are rendered
    dashboardRobot.verifyTopComponentsRendered();

    // We might need to scroll down to see the others
    await dashboardRobot.scrollAndVerifyAnalyticsCarousel();
    await dashboardRobot.scrollAndVerifySpendingChart();
    await dashboardRobot.scrollAndVerifyRecentTransactions();
  });
}
