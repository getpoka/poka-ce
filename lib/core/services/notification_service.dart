import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:poka_ce/core/utils/logger.dart';

class NotificationService {
  factory NotificationService() => _instance;
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

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
}

final notificationService = NotificationService();
