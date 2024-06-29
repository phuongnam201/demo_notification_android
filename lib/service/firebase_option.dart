// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'your_api_key',
    appId: 'your_app_id',
    messagingSenderId: 'your_project_number',
    projectId: 'your_project_id',
    //storageBucket: ,
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'your_api_key',
    appId: 'your_app_id',
    messagingSenderId: 'your_project_number',
    projectId: 'your_project_id',
    storageBucket: 'your_storageBucket',
    iosClientId: 'your_ios_clientID',
    iosBundleId: 'your_ioss_Bundle',
  );
}