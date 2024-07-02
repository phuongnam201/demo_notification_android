import 'package:flutter/material.dart';
import 'package:learning_firebase/service/notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NotificationService
      notificationService; // Declare but don't initialize here

  @override
  void initState() {
    super.initState();
    notificationService = NotificationService(); // Initialize here
    //notificationService.openNotifySetting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
      ),
    );
  }
}
