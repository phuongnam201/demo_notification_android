import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

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
    handleForegroundMessages();
    handleNotificationTap();
  }

  // Optional: Handle incoming messages when the app is in the foreground
  void handleForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print(
            'Message also contained a notification 1: ${message.notification}');
      }
    });
  }

  // Optional: Handle when the app is opened from a terminated state via notification
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
}
