import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/services/notification_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NotificationService', () {
    test('singleton instance exists and has expected interface', () {
      final instance1 = NotificationService();
      final instance2 = NotificationService();
      expect(identical(instance1, instance2), isTrue);
      expect(identical(instance1, notificationService), isTrue);
    });

    test('hasNotificationPermission handles uninitialized/mocked environment without crash', () async {
      // In flutter_test, platform channels return null or default values safely
      final result = await notificationService.hasNotificationPermission();
      expect(result, isA<bool>());
    });

    test('requestNotificationPermission handles uninitialized/mocked environment without crash', () async {
      final result = await notificationService.requestNotificationPermission();
      expect(result, isA<bool>());
    });
  });
}
