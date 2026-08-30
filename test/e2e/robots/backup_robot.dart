import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'robot_base.dart';

class BackupRobot extends RobotBase {
  const BackupRobot(super.tester);

  void verifyBackupActionSheetOpen() {
    expect(find.text('Backup').last, findsOneWidget);
    expect(find.text('Restore').last, findsOneWidget);
  }

  Future<void> closeActionSheet() async {
    await tester.tapAt(const Offset(100, 100));
    await settle();
  }
}
