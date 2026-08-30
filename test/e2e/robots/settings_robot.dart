import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'robot_base.dart';

import 'package:poka_ce/features/settings/presentation/widgets/sections/data_management_section.dart';
import 'package:poka_ce/features/settings/presentation/widgets/sections/preferences_section.dart';
import 'package:poka_ce/features/settings/presentation/widgets/sections/security_section.dart';
import 'package:poka_ce/features/settings/presentation/widgets/sections/support_section.dart';

class SettingsRobot extends RobotBase {
  const SettingsRobot(super.tester);

  void verifySettingsSectionsRendered() {
    expect(find.byType(PreferencesSection), findsOneWidget);
    expect(find.byType(SecuritySection), findsOneWidget);
    expect(find.byType(DataManagementSection), findsOneWidget);
    expect(find.byType(SupportSection), findsOneWidget);
  }

  Future<void> scrollAndTapBackupRestore() async {
    final scrollable = find.byType(Scrollable).first;
    await tester.drag(scrollable, const Offset(0, -500));
    await settle();

    final backupRestoreItem = find.text('Backup & Restore').first;
    await tester.tap(backupRestoreItem);
    await settle();
  }
}
