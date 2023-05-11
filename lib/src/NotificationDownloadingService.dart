import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/launcher_icon");

    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true,
            onDidReceiveLocalNotification: (id, title, body, payload) {
              selectNotification(payload);
            });

    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveNotificationResponse);
    flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future onDidReceiveNotificationResponse(
      NotificationResponse response) async {
    var payload = response.payload;
    //Handle notification tapped logic here
    // if(payload != null) {
    //   NotificationsController.openNotification(NotificationsModel.fromJson(json.decode(payload)));
    // }
  }

  Future selectNotification(String? payload) async {
    //Handle notification tapped logic here
    // if(payload != null) {
    //   NotificationsController.openNotification(NotificationsModel.fromJson(json.decode(payload)));
    // }
  }

  Future<void> showNotification({
    int pp = 0,
    int max = 0,
    int? id,
    String? title,
    String? body,
    bool? showProgress,
    Importance importance = Importance.max,
    Priority priority = Priority.max,
    bool ongoing = false,
    String? payload,
    int badgeCount = 0,
    bool autoCancel = false,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '${Random().nextInt(1000)}',
      'اشعارات التطبيق',
      channelDescription: 'اشعارات التطبيق',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      autoCancel: autoCancel,
      showProgress: showProgress ?? true,
      ongoing: ongoing,
      progress: pp,
      maxProgress: max,
      onlyAlertOnce: true,
      sound: const RawResourceAndroidNotificationSound("action"),
      icon: "@mipmap/launcher_icon",
      number: badgeCount,
    );
    DarwinNotificationDetails iosPlatformChannelSpecifics =
        DarwinNotificationDetails(
      threadIdentifier: '12345',
      badgeNumber: badgeCount,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      id ?? 12345,
      title ?? "طلبات الاعلان",
      body ?? "جارى رفع مرفقات طلبكم....",
      platformChannelSpecifics,
      payload: payload,
    );
  }

  void cancelNotification({int? id}) {
    flutterLocalNotificationsPlugin.cancel(id ?? 12345);
  }
}
