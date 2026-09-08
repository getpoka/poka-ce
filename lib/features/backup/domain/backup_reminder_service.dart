import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/services/notification_service.dart';
import 'package:poka_ce/core/services/preferences_service.dart';
import 'package:poka_ce/i18n/strings.g.dart';

/// Supported frequency intervals for periodic backup reminders.
enum BackupReminderInterval {
  off('off'),
  weekly('weekly'),
  monthly('monthly');

  const BackupReminderInterval(this.value);
  final String value;

  /// Parses a raw string into [BackupReminderInterval]. Defaults to [weekly].
  static BackupReminderInterval fromValue(String? value) {
    return switch (value) {
      'off' => BackupReminderInterval.off,
      'monthly' => BackupReminderInterval.monthly,
      _ => BackupReminderInterval.weekly,
    };
  }
}

/// Provider for [BackupReminderService].
final backupReminderServiceProvider = Provider<BackupReminderService>((ref) {
  final prefs = ref.watch(preferencesServiceProvider);
  return BackupReminderService(prefs: prefs, notificationService: notificationService);
});

/// Notifier managing reactive reminder interval state.
class BackupReminderNotifier extends Notifier<BackupReminderInterval> {
  @override
  BackupReminderInterval build() {
    return ref.watch(backupReminderServiceProvider).getInterval();
  }

  /// Sets a new interval and updates reactive state.
  Future<void> setInterval(BackupReminderInterval interval) async {
    await ref.read(backupReminderServiceProvider).setInterval(interval);
    state = interval;
  }
}

/// Provider for [BackupReminderNotifier].
final backupReminderNotifierProvider = NotifierProvider<BackupReminderNotifier, BackupReminderInterval>(
  BackupReminderNotifier.new,
);

/// Service responsible for managing periodic backup reminders and notifying
/// the user when an offline backup has not been performed within their configured interval.
class BackupReminderService {
  /// Creates a [BackupReminderService].
  const BackupReminderService({
    required this._prefs,
    required this._notificationService,
  });

  final PreferencesService _prefs;
  final NotificationService _notificationService;

  static const String keyInterval = 'backup_reminder_interval';
  static const String keyLastBackupDate = 'backup_last_backup_date';
  static const String keyLastNotificationDate = 'backup_last_notification_date';

  /// Returns the current reminder interval configured by the user.
  BackupReminderInterval getInterval() {
    return BackupReminderInterval.fromValue(_prefs.getString(keyInterval));
  }

  /// Updates the user's chosen reminder interval.
  Future<void> setInterval(BackupReminderInterval interval) async {
    await _prefs.saveString(keyInterval, interval.value);
  }

  /// Returns the date of the most recently completed backup, if any.
  DateTime? getLastBackupDate() {
    final millis = _prefs.getInt(keyLastBackupDate);
    return millis != null ? DateTime.fromMillisecondsSinceEpoch(millis) : null;
  }

  /// Records that a backup has completed successfully at [date] (defaults to now).
  Future<void> recordBackupCompleted([DateTime? date]) async {
    final timestamp = (date ?? DateTime.now()).millisecondsSinceEpoch;
    await _prefs.saveInt(keyLastBackupDate, timestamp);
  }

  /// Checks if a backup reminder notification should be displayed, and dispatches it if due.
  /// Returns `true` if a notification was dispatched, `false` otherwise.
  Future<bool> checkAndNotify([DateTime? currentTime]) async {
    final interval = getInterval();
    if (interval == BackupReminderInterval.off) {
      return false;
    }

    final now = currentTime ?? DateTime.now();

    // Guard against spam: don't notify more than once in 24 hours
    final lastNotifiedMillis = _prefs.getInt(keyLastNotificationDate);
    if (lastNotifiedMillis != null) {
      final lastNotified = DateTime.fromMillisecondsSinceEpoch(lastNotifiedMillis);
      if (now.difference(lastNotified).inHours < 24) {
        return false;
      }
    }

    // Determine threshold days
    final thresholdDays = interval == BackupReminderInterval.weekly ? 7 : 30;

    final lastBackupMillis = _prefs.getInt(keyLastBackupDate);
    if (lastBackupMillis == null) {
      // Initialize to current time on first check so new users are not prompted immediately
      await recordBackupCompleted(now);
      return false;
    }

    final lastBackup = DateTime.fromMillisecondsSinceEpoch(lastBackupMillis);
    if (now.difference(lastBackup).inDays >= thresholdDays) {
      await _notificationService.showBackupReminderNotification(
        title: t.backup.reminderNotificationTitle,
        body: t.backup.reminderNotificationBody,
      );
      await _prefs.saveInt(keyLastNotificationDate, now.millisecondsSinceEpoch);
      return true;
    }

    return false;
  }
}
