import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/services/notification_service.dart';
import 'package:poka_ce/core/services/preferences_service.dart';
import 'package:poka_ce/features/backup/domain/backup_reminder_service.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockNotificationService extends Mock implements NotificationService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late PreferencesService prefsService;
  late MockNotificationService mockNotificationService;
  late BackupReminderService reminderService;

  setUp(() async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    SharedPreferences.setMockInitialValues({});
    final sharedPrefs = await SharedPreferences.getInstance();
    prefsService = PreferencesService(sharedPrefs);
    mockNotificationService = MockNotificationService();

    when(
      () => mockNotificationService.showBackupReminderNotification(
        title: any(named: 'title'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async {});

    reminderService = BackupReminderService(
      prefs: prefsService,
      notificationService: mockNotificationService,
    );
  });

  group('BackupReminderService', () {
    test('defaults to weekly interval', () {
      expect(reminderService.getInterval(), BackupReminderInterval.weekly);
    });

    test('persists interval changes', () async {
      await reminderService.setInterval(BackupReminderInterval.monthly);
      expect(reminderService.getInterval(), BackupReminderInterval.monthly);

      await reminderService.setInterval(BackupReminderInterval.off);
      expect(reminderService.getInterval(), BackupReminderInterval.off);
    });

    test('records and retrieves last backup date', () async {
      expect(reminderService.getLastBackupDate(), isNull);

      final testDate = DateTime(2026, 9, 1, 10, 0);
      await reminderService.recordBackupCompleted(testDate);

      expect(reminderService.getLastBackupDate(), testDate);
    });

    test('initializes last backup date on first checkAndNotify', () async {
      final now = DateTime(2026, 9, 8, 12, 0);
      final notified = await reminderService.checkAndNotify(now);

      expect(notified, isFalse);
      expect(reminderService.getLastBackupDate(), now);
      verifyNever(
        () => mockNotificationService.showBackupReminderNotification(
          title: any(named: 'title'),
          body: any(named: 'body'),
        ),
      );
    });

    test('does not notify if interval is off', () async {
      await reminderService.setInterval(BackupReminderInterval.off);
      final pastDate = DateTime(2026, 8, 1);
      await reminderService.recordBackupCompleted(pastDate);

      final now = DateTime(2026, 9, 8);
      final notified = await reminderService.checkAndNotify(now);

      expect(notified, isFalse);
      verifyNever(
        () => mockNotificationService.showBackupReminderNotification(
          title: any(named: 'title'),
          body: any(named: 'body'),
        ),
      );
    });

    test('notifies when weekly threshold has elapsed', () async {
      await reminderService.setInterval(BackupReminderInterval.weekly);
      final eightDaysAgo = DateTime(2026, 9, 1, 12, 0);
      await reminderService.recordBackupCompleted(eightDaysAgo);

      final now = DateTime(2026, 9, 9, 12, 0);
      final notified = await reminderService.checkAndNotify(now);

      expect(notified, isTrue);
      verify(
        () => mockNotificationService.showBackupReminderNotification(
          title: any(named: 'title'),
          body: any(named: 'body'),
        ),
      ).called(1);
    });

    test('does not notify if last backup is within interval', () async {
      await reminderService.setInterval(BackupReminderInterval.weekly);
      final threeDaysAgo = DateTime(2026, 9, 5, 12, 0);
      await reminderService.recordBackupCompleted(threeDaysAgo);

      final now = DateTime(2026, 9, 8, 12, 0);
      final notified = await reminderService.checkAndNotify(now);

      expect(notified, isFalse);
      verifyNever(
        () => mockNotificationService.showBackupReminderNotification(
          title: any(named: 'title'),
          body: any(named: 'body'),
        ),
      );
    });

    test('enforces 24-hour spam guard between notifications', () async {
      await reminderService.setInterval(BackupReminderInterval.weekly);
      final eightDaysAgo = DateTime(2026, 9, 1, 12, 0);
      await reminderService.recordBackupCompleted(eightDaysAgo);

      final now = DateTime(2026, 9, 9, 12, 0);
      final firstNotify = await reminderService.checkAndNotify(now);
      expect(firstNotify, isTrue);

      // Check again 2 hours later
      final twoHoursLater = DateTime(2026, 9, 9, 14, 0);
      final secondNotify = await reminderService.checkAndNotify(twoHoursLater);
      expect(secondNotify, isFalse);

      verify(
        () => mockNotificationService.showBackupReminderNotification(
          title: any(named: 'title'),
          body: any(named: 'body'),
        ),
      ).called(1);
    });

    test('delegates hasNotificationPermission and requestNotificationPermission', () async {
      when(() => mockNotificationService.hasNotificationPermission()).thenAnswer((_) async => true);
      when(() => mockNotificationService.requestNotificationPermission()).thenAnswer((_) async => true);

      expect(await reminderService.hasNotificationPermission(), isTrue);
      expect(await reminderService.requestNotificationPermission(), isTrue);

      when(() => mockNotificationService.hasNotificationPermission()).thenAnswer((_) async => false);
      when(() => mockNotificationService.requestNotificationPermission()).thenAnswer((_) async => false);

      expect(await reminderService.hasNotificationPermission(), isFalse);
      expect(await reminderService.requestNotificationPermission(), isFalse);
    });

    test('triggerTestReminder dispatches test notification immediately', () async {
      await reminderService.triggerTestReminder();

      verify(
        () => mockNotificationService.showBackupReminderNotification(
          title: any(named: 'title'),
          body: any(named: 'body'),
        ),
      ).called(1);
    });
  });
}
