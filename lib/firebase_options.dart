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
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDHfj5xJ17mukPiaPrKu0Q5AUiu6F2FtRU',
    appId: '1:25670120802:web:b90945b6b807dabb82283b',
    messagingSenderId: '25670120802',
    projectId: 'flutter-kanban-board',
    authDomain: 'flutter-kanban-board.firebaseapp.com',
    databaseURL: 'https://flutter-kanban-board-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutter-kanban-board.appspot.com',
    measurementId: 'G-ZRNBKF7F88',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdmoghSzBHsVMKCUb5Em_USIIeMotbVws',
    appId: '1:25670120802:android:25032a789e16f08e82283b',
    messagingSenderId: '25670120802',
    projectId: 'flutter-kanban-board',
    databaseURL: 'https://flutter-kanban-board-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutter-kanban-board.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNx6g0MgiszTSJuLN29-gvM9EAv2EHVQk',
    appId: '1:25670120802:ios:711aafbff593e05b82283b',
    messagingSenderId: '25670120802',
    projectId: 'flutter-kanban-board',
    databaseURL: 'https://flutter-kanban-board-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutter-kanban-board.appspot.com',
    iosClientId: '25670120802-phnvjrja177f4lqild2pp0c65rk6i2t5.apps.googleusercontent.com',
    iosBundleId: 'com.babak.kanbanBoard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDNx6g0MgiszTSJuLN29-gvM9EAv2EHVQk',
    appId: '1:25670120802:ios:711aafbff593e05b82283b',
    messagingSenderId: '25670120802',
    projectId: 'flutter-kanban-board',
    databaseURL: 'https://flutter-kanban-board-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutter-kanban-board.appspot.com',
    iosClientId: '25670120802-phnvjrja177f4lqild2pp0c65rk6i2t5.apps.googleusercontent.com',
    iosBundleId: 'com.babak.kanbanBoard',
  );
}
