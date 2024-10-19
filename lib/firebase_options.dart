// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBAXm6vcoPqGzUAfrlf5n5TCwbBkhFZBTo',
    appId: '1:79112729497:web:12ba3dceb611addb285908',
    messagingSenderId: '79112729497',
    projectId: 'task-management-95d50',
    authDomain: 'task-management-95d50.firebaseapp.com',
    storageBucket: 'task-management-95d50.appspot.com',
    measurementId: 'G-DNHJ2FBZYQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBiCuN69gxb0L5p9LBDhDcGdDiCg9tNEEk',
    appId: '1:79112729497:android:c7d93b75f0667af8285908',
    messagingSenderId: '79112729497',
    projectId: 'task-management-95d50',
    storageBucket: 'task-management-95d50.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7OpX7gxIj_8KS672nGL1qOemKQSyFoIs',
    appId: '1:79112729497:ios:a8f237a12db4d3c1285908',
    messagingSenderId: '79112729497',
    projectId: 'task-management-95d50',
    storageBucket: 'task-management-95d50.appspot.com',
    iosBundleId: 'com.example.taskManagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA7OpX7gxIj_8KS672nGL1qOemKQSyFoIs',
    appId: '1:79112729497:ios:a8f237a12db4d3c1285908',
    messagingSenderId: '79112729497',
    projectId: 'task-management-95d50',
    storageBucket: 'task-management-95d50.appspot.com',
    iosBundleId: 'com.example.taskManagement',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBAXm6vcoPqGzUAfrlf5n5TCwbBkhFZBTo',
    appId: '1:79112729497:web:98eb1a7d8381f035285908',
    messagingSenderId: '79112729497',
    projectId: 'task-management-95d50',
    authDomain: 'task-management-95d50.firebaseapp.com',
    storageBucket: 'task-management-95d50.appspot.com',
    measurementId: 'G-CJ92KGF7GX',
  );
}
