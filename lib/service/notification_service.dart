import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional permission");
    } else {
      print("User denied permission");
    }
  }

  Future<void> openNotifySetting() async {
    await AppSettings.openNotificationSettings();
  }

  Future<void> initNotifications() async {
    await requestNotificationPermission();
    String? fcmToken = await _firebaseMessaging.getToken();
    print('Firebase Messaging Token: $fcmToken');
    handleOpenedAppMessages();
    handleForegroundMessages();
    handleNotificationTap();
    setupLocalNotifications(); // Ensure local notifications are set up
  }

  void handleOpenedAppMessages() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('handleOpenedAppMessages');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print(
            'Message also contained a notification 0: ${message.notification}');
      }
    });
  }

  void handleForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      // Show a notification using flutter_local_notifications
      if (message.notification != null) {
        showNotification(
          message.notification!.title ?? 'Notification',
          message.notification!.body ?? '',
        );
      }
    });
  }

  void handleNotificationTap() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print(
            'Message also contained a notification 2: ${message.notification}');
      }
    });
  }

  void setupLocalNotifications() {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
    );
    var iosPlatformChannelSpecifics = const DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0, // notification id
      title, // notification title
      body, // notification body
      platformChannelSpecifics,
    );
  }
}
