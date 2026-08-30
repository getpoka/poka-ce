import 'package:flutter_test/flutter_test.dart';

import '../../test_setup.dart';
import '../../robots/navigation_robot.dart';
import '../../robots/reports_robot.dart';

void main() {
  testWidgets('Reports E2E operations', (tester) async {
    await pumpAppForTesting(tester);

    final navRobot = NavigationRobot(tester);
    final reportsRobot = ReportsRobot(tester);

    // 1. Navigate to Reports
    await navRobot.navigateToReports();

    // Verify Tab 1 components
    reportsRobot.verifyCashflowTabComponents();

    // Navigate to Tab 2
    await reportsRobot.navigateToBudgetsTab();

    // Verify Tab 2 components
    reportsRobot.verifyBudgetsTabComponents();
  });
}
