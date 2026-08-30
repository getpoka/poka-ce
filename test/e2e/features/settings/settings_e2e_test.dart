import 'package:flutter_test/flutter_test.dart';

import '../../test_setup.dart';
import '../../robots/navigation_robot.dart';
import '../../robots/settings_robot.dart';

void main() {
  testWidgets('Settings E2E operations', (tester) async {
    await pumpAppForTesting(tester);

    final navRobot = NavigationRobot(tester);
    final settingsRobot = SettingsRobot(tester);

    // 1. Navigate to Settings
    await navRobot.navigateToSettings();

    // Verify all major settings components are rendered
    settingsRobot.verifySettingsSectionsRendered();
  });
}
