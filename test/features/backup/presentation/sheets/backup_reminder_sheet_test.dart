import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poka_ce/core/services/notification_service.dart';
import 'package:poka_ce/core/services/preferences_service.dart';
import 'package:poka_ce/features/backup/domain/backup_reminder_service.dart';
import 'package:poka_ce/features/backup/presentation/sheets/backup_reminder_sheet.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeNotificationService extends NotificationService {
  FakeNotificationService({this.permissionGranted = true}) : super.internal();

  bool permissionGranted;
  int testNotificationCount = 0;

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
    testNotificationCount++;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.setLocale(AppLocale.en);

  late SharedPreferences sharedPreferences;
  late PreferencesService preferencesService;
  late FakeNotificationService fakeNotificationService;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    preferencesService = PreferencesService(sharedPreferences);
    fakeNotificationService = FakeNotificationService(permissionGranted: true);
  });

  Widget buildApp(Widget child) {
    return ProviderScope(
      overrides: [
        preferencesServiceProvider.overrideWithValue(preferencesService),
        backupReminderServiceProvider.overrideWith(
          (ref) => BackupReminderService(
            prefs: preferencesService,
            notificationService: fakeNotificationService,
          ),
        ),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(
            data: lightTheme,
            child: FToaster(child: child!),
          ),
          home: Scaffold(body: child),
        ),
      ),
    );
  }

  group('BackupReminderSheet', () {
    testWidgets('renders all interval options and test notification action', (tester) async {
      await tester.pumpWidget(
        buildApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showBackupReminderSheet(
                context,
                currentInterval: BackupReminderInterval.weekly,
              ),
              child: const Text('Open Reminder Sheet'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Reminder Sheet'));
      await tester.pumpAndSettle();

      expect(find.text(t.backup.reminder), findsOneWidget);
      expect(find.text(t.backup.reminderOff), findsOneWidget);
      expect(find.text(t.backup.reminderWeekly), findsOneWidget);
      expect(find.text(t.backup.reminderMonthly), findsOneWidget);
      expect(find.text(t.backup.sendTestNotification), findsOneWidget);
    });

    testWidgets('selecting off pops immediately with BackupReminderInterval.off', (tester) async {
      BackupReminderInterval? selected;

      await tester.pumpWidget(
        buildApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                selected = await showBackupReminderSheet(
                  context,
                  currentInterval: BackupReminderInterval.weekly,
                );
              },
              child: const Text('Open Reminder Sheet'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Reminder Sheet'));
      await tester.pumpAndSettle();

      await tester.tap(find.text(t.backup.reminderOff));
      await tester.pumpAndSettle();

      expect(selected, BackupReminderInterval.off);
    });

    testWidgets('selecting weekly when permission is granted returns weekly', (tester) async {
      BackupReminderInterval? selected;

      await tester.pumpWidget(
        buildApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                selected = await showBackupReminderSheet(
                  context,
                  currentInterval: BackupReminderInterval.off,
                );
              },
              child: const Text('Open Reminder Sheet'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Reminder Sheet'));
      await tester.pumpAndSettle();

      await tester.tap(find.text(t.backup.reminderWeekly));
      await tester.pumpAndSettle();

      expect(selected, BackupReminderInterval.weekly);
    });

    testWidgets('triggering test notification dispatches notification and closes sheet', (tester) async {
      await tester.pumpWidget(
        buildApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showBackupReminderSheet(
                context,
                currentInterval: BackupReminderInterval.weekly,
              ),
              child: const Text('Open Reminder Sheet'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Reminder Sheet'));
      await tester.pumpAndSettle();

      await tester.tap(find.text(t.backup.sendTestNotification));
      await tester.pumpAndSettle();

      expect(fakeNotificationService.testNotificationCount, 1);
    });
  });
}
