import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:poka_ce/core/utils/logger.dart';

/// Service managing native local notification initialization and dispatching.
class NotificationService {
  /// Returns the singleton [NotificationService] instance.
  factory NotificationService() => _instance;
  NotificationService.internal({FlutterLocalNotificationsPlugin? plugin})
    : _flutterLocalNotificationsPlugin = plugin ?? FlutterLocalNotificationsPlugin();
  static final NotificationService _instance = NotificationService.internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
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

  /// Checks whether notification permission is granted by the host OS.
  Future<bool> hasNotificationPermission() async {
    try {
      final android = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      if (android != null) {
        return await android.areNotificationsEnabled() ?? false;
      }

      final ios = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
      if (ios != null) {
        final permissions = await ios.checkPermissions();
        return permissions?.isEnabled ?? false;
      }

      final macos = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>();
      if (macos != null) {
        final permissions = await macos.checkPermissions();
        return permissions?.isEnabled ?? false;
      }

      return true;
    } on Object catch (e, st) {
      talker.handle(e, st, 'NotificationService.hasNotificationPermission');
      return false;
    }
  }

  /// Requests notification runtime permissions from the host OS (Android 13+ and iOS).
  Future<bool> requestNotificationPermission() async {
    try {
      final android = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      if (android != null) {
        return await android.requestNotificationsPermission() ?? false;
      }

      final ios = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
      if (ios != null) {
        return await ios.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            ) ??
            false;
      }

      final macos = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>();
      if (macos != null) {
        return await macos.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            ) ??
            false;
      }

      return true;
    } on Object catch (e, st) {
      talker.handle(e, st, 'NotificationService.requestNotificationPermission');
      return false;
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
