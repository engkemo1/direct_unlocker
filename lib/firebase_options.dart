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
///
///


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
    apiKey: 'AIzaSyCgkuOVUsBNgl8Db42-UnRXn8DpYXUxzDY',
    appId: '1:688097497174:web:bbf750a9ae8c5019fcabf7',
    messagingSenderId: '688097497174',
    projectId: 'directunlockerye-3bd6a',
    authDomain: 'directunlockerye-3bd6a.firebaseapp.com',
    storageBucket: 'directunlockerye-3bd6a.appspot.com',
    measurementId: 'G-STYHEMZFTV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyALXQI5FgoT1hWQKhrh-Alg-P3QXaVY5rg',
    appId: '1:688097497174:android:145739556834e84efcabf7',
    messagingSenderId: '688097497174',
    projectId: 'directunlockerye-3bd6a',
    storageBucket: 'directunlockerye-3bd6a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDkojAdH7IVPUSyLYBya69moSHPzgoi2q4',
    appId: '1:688097497174:ios:abb463366fef527bfcabf7',
    messagingSenderId: '688097497174',
    projectId: 'directunlockerye-3bd6a',
    storageBucket: 'directunlockerye-3bd6a.appspot.com',
    iosBundleId: 'com.example.directUnlocker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDkojAdH7IVPUSyLYBya69moSHPzgoi2q4',
    appId: '1:688097497174:ios:abb463366fef527bfcabf7',
    messagingSenderId: '688097497174',
    projectId: 'directunlockerye-3bd6a',
    storageBucket: 'directunlockerye-3bd6a.appspot.com',
    iosBundleId: 'com.example.directUnlocker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCgkuOVUsBNgl8Db42-UnRXn8DpYXUxzDY',
    appId: '1:688097497174:web:0b466b0c4d3c8463fcabf7',
    messagingSenderId: '688097497174',
    projectId: 'directunlockerye-3bd6a',
    authDomain: 'directunlockerye-3bd6a.firebaseapp.com',
    storageBucket: 'directunlockerye-3bd6a.appspot.com',
    measurementId: 'G-PZYV10TBY7',
  );
}
