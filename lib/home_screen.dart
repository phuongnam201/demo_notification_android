import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learning_firebase/service/notification_service.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NotificationService
      notificationService; // Declare but don't initialize here

  bool isConnectedToInternet = false;
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    subscription = InternetConnection().onStatusChange.listen((event) {
      switch (event) {
        case InternetStatus.connected:
          setState(() {
            isConnectedToInternet = true;
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            isConnectedToInternet = false;
          });
          break;
        default:
          setState(() {
            isConnectedToInternet = false;
          });
          break;
      }
    });
    notificationService = NotificationService(); // Initialize here

    //notificationService.openNotifySetting();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isConnectedToInternet
          ? Center(
              child: ElevatedButton(
                child: Text("Setting notifications"),
                onPressed: () async {
                  await notificationService.openNotifySetting();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[600],
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                ),
              ),
            )
          : Center(
              child: Text("No internet"),
            ),
    );
  }
}
