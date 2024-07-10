# learning_firebase

This is a demo push notification for Flutter.
however, it's only for Android because I don't have Macbook haha ^.^

## Getting Started

Download or clone this demo

=> Some steps to run this demo:

- step 1: create a project notification on Firebase(https://console.firebase.google.com/). download and replace my file google_service.json (root_project\android\app) to your file google_service.json.
- step 2: you have to run the command: flutter pub get
- step 3: open your google_service.json and go to lib\service\firebase_option.dart and fill FirebaseOption (from line 32)
- step 4: flutter run or run and debug
- step 5: test notification from Firebase cloud messaging
  - You can send notifications via token device or topic

# demo_notification_android

Good luck!
