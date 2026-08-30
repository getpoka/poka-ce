import 'package:flutter_test/flutter_test.dart';

/// Base class for all Robot objects.
abstract class RobotBase {
  const RobotBase(this.tester);

  final WidgetTester tester;

  /// Custom settle to overcome infinite animations when running E2E via `testWidgets`.
  Future<void> settle() async {
    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 200));
    }
  }
}
