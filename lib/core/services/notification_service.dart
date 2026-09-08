import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:poka_ce/core/utils/logger.dart';

/// Service managing native local notification initialization and dispatching.
class NotificationService {
  /// Returns the singleton [NotificationService] instance.
  factory NotificationService() => _instance;
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  /// Initializes notification plugin settings for Android and iOS.
  Future<void> init() async {
    if (_initialized) return;

    try {
      const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
      const initializationSettingsDarwin = DarwinInitializationSettings();

      const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
      );

      await _flutterLocalNotificationsPlugin.initialize(
        settings: initializationSettings,
        onDidReceiveNotificationResponse: (details) async {},
      );
      _initialized = true;
      talker.info('NotificationService initialized');
    } on Object catch (e, st) {
      talker.handle(e, st, 'NotificationService.init');
    }
  }

  /// Displays a budget alert notification with high priority.
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'poka_ce_budget_alerts',
        'Budget Alerts',
        channelDescription: 'Notifications for when you exceed your budget thresholds',
        importance: Importance.high,
        priority: Priority.high,
      );
      const darwinPlatformChannelSpecifics = DarwinNotificationDetails();

      const platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: darwinPlatformChannelSpecifics,
      );

      await _flutterLocalNotificationsPlugin.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: platformChannelSpecifics,
        payload: payload,
      );
    } on Object catch (e, st) {
      talker.handle(e, st, 'NotificationService.showNotification');
    }
  }

  /// Displays a periodic offline backup reminder notification.
  Future<void> showBackupReminderNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'poka_ce_backup_reminders',
        'Backup Reminders',
        channelDescription: 'Reminders to periodically back up your financial data',
      );
      const darwinPlatformChannelSpecifics = DarwinNotificationDetails();

      const platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: darwinPlatformChannelSpecifics,
      );

      await _flutterLocalNotificationsPlugin.show(
        id: 9999,
        title: title,
        body: body,
        notificationDetails: platformChannelSpecifics,
        payload: payload,
      );
    } on Object catch (e, st) {
      talker.handle(e, st, 'NotificationService.showBackupReminderNotification');
    }
  }
}

/// Global singleton instance of [NotificationService].
final notificationService = NotificationService();
