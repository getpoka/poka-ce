import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/services/notification_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NotificationService', () {
    test('is a singleton', () {
      final a = NotificationService();
      final b = NotificationService();
      expect(identical(a, b), isTrue);
      expect(identical(notificationService, NotificationService()), isTrue);
    });

    test('init completes without throwing in test environment', () async {
      final service = NotificationService();
      await expectLater(service.init(), completes);
    });

    test('init is idempotent', () async {
      final service = NotificationService();
      await service.init();
      await expectLater(service.init(), completes);
    });

    test('showNotification completes without throwing', () async {
      final service = NotificationService();
      await expectLater(
        service.showNotification(id: 1, title: 'Budget Alert', body: 'You exceeded 80%', payload: 'budget-1'),
        completes,
      );
    });
  });
}
