import 'package:flutter_test/flutter_test.dart';
import 'package:poka_ce/core/services/notification_service.dart';
import 'package:poka_ce/core/services/preferences_service.dart';
import 'package:poka_ce/features/backup/domain/backup_reminder_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeNotificationService extends NotificationService {
  FakeNotificationService({this.permissionGranted = true}) : super.internal();

  bool permissionGranted;
  int testNotificationCount = 0;
  int reminderNotificationCount = 0;

  @override
  Future<bool> hasNotificationPermission() async => permissionGranted;

  @override
  Future<bool> requestNotificationPermission() async => permissionGranted;

  @override
  Future<void> showBackupReminderNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    reminderNotificationCount++;
    testNotificationCount++;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences sharedPreferences;
  late PreferencesService preferencesService;
  late FakeNotificationService fakeNotificationService;
  late BackupReminderService reminderService;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    preferencesService = PreferencesService(sharedPreferences);
    fakeNotificationService = FakeNotificationService();
    reminderService = BackupReminderService(
      prefs: preferencesService,
      notificationService: fakeNotificationService,
    );
  });

  group('BackupReminderService', () {
    test('default interval is weekly', () {
      expect(reminderService.getInterval(), BackupReminderInterval.weekly);
    });

    test('updates and persists reminder interval', () async {
      await reminderService.setInterval(BackupReminderInterval.monthly);
      expect(reminderService.getInterval(), BackupReminderInterval.monthly);

      await reminderService.setInterval(BackupReminderInterval.off);
      expect(reminderService.getInterval(), BackupReminderInterval.off);
    });

    test('delegates hasNotificationPermission and requestNotificationPermission', () async {
      fakeNotificationService.permissionGranted = true;
      expect(await reminderService.hasNotificationPermission(), isTrue);
      expect(await reminderService.requestNotificationPermission(), isTrue);

      fakeNotificationService.permissionGranted = false;
      expect(await reminderService.hasNotificationPermission(), isFalse);
      expect(await reminderService.requestNotificationPermission(), isFalse);
    });

    test('triggerTestReminder dispatches notification immediately', () async {
      expect(fakeNotificationService.testNotificationCount, 0);
      await reminderService.triggerTestReminder();
      expect(fakeNotificationService.testNotificationCount, 1);
    });

    test('checkAndNotify does not notify when interval is off', () async {
      await reminderService.setInterval(BackupReminderInterval.off);
      final notified = await reminderService.checkAndNotify();
      expect(notified, isFalse);
      expect(fakeNotificationService.reminderNotificationCount, 0);
    });

    test('checkAndNotify initializes lastBackup on first run without notifying', () async {
      final now = DateTime.now();
      final notified = await reminderService.checkAndNotify(now);
      expect(notified, isFalse);
      expect(reminderService.getLastBackupDate(), isNotNull);
    });

    test('checkAndNotify dispatches notification when threshold is exceeded', () async {
      final start = DateTime(2026, 1, 1);
      await reminderService.recordBackupCompleted(start);

      // 8 days later for weekly
      final due = start.add(const Duration(days: 8));
      final notified = await reminderService.checkAndNotify(due);

      expect(notified, isTrue);
      expect(fakeNotificationService.reminderNotificationCount, 1);
    });
  });
}
