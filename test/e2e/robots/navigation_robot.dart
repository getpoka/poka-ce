import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'robot_base.dart';

/// Robot responsible for handling main navigation via BottomNavigationBar.
class NavigationRobot extends RobotBase {
  const NavigationRobot(super.tester);

  Future<void> navigateToHome() async {
    final navKey = find.byKey(const Key('nav_home'));
    await tester.tap(navKey);
    await settle();
  }

  Future<void> navigateToTransactions() async {
    final navKey = find.byKey(const Key('nav_transactions'));
    await tester.tap(navKey);
    await settle();
  }

  Future<void> navigateToReports() async {
    final navKey = find.byKey(const Key('nav_reports'));
    await tester.tap(navKey);
    await settle();
  }

  Future<void> navigateToAccounts() async {
    final navKey = find.byKey(const Key('nav_accounts'));
    await tester.tap(navKey);
    await settle();
  }

  Future<void> navigateToSettings() async {
    final navKey = find.byKey(const Key('nav_settings'));
    await tester.tap(navKey);
    await settle();
  }
}
