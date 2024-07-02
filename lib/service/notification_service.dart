import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:learning_firebase/service/local_notification.dart';
// Import your helper file

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
    handleOpenedAppMessages();
    handleForegroundMessages();
    handleNotificationTap();
    LocalNotification.setupLocalNotifications(); // Use helper method
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
        LocalNotification.showNotification(
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
}
