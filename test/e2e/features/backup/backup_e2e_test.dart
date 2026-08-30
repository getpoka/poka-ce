import 'package:flutter_test/flutter_test.dart';

import '../../test_setup.dart';
import '../../robots/navigation_robot.dart';
import '../../robots/settings_robot.dart';
import '../../robots/backup_robot.dart';

void main() {
  testWidgets('Backup E2E operations', (tester) async {
    await pumpAppForTesting(tester);

    final navRobot = NavigationRobot(tester);
    final settingsRobot = SettingsRobot(tester);
    final backupRobot = BackupRobot(tester);

    // 1. Navigate to Settings
    await navRobot.navigateToSettings();

    // 2. Scroll and Tap Backup & Restore
    await settingsRobot.scrollAndTapBackupRestore();

    // 3. Verify Action Sheet is open
    backupRobot.verifyBackupActionSheetOpen();

    // 4. Close the sheet
    await backupRobot.closeActionSheet();
  });
}
