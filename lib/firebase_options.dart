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
    apiKey: 'AIzaSyC0ZtvTVD8S9KeUBBrU71-eDp-MWYg4Blw',
    appId: '1:571106756266:web:1b92d721eb023804b172d3',
    messagingSenderId: '571106756266',
    projectId: 'adhd-planner-project',
    authDomain: 'adhd-planner-project.firebaseapp.com',
    storageBucket: 'adhd-planner-project.appspot.com',
    measurementId: 'G-39NQGMGS4C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDsb8pdWpSyotLC8ExDYBNT5yN2exgLF5Y',
    appId: '1:571106756266:android:513e01e65bc7cc61b172d3',
    messagingSenderId: '571106756266',
    projectId: 'adhd-planner-project',
    storageBucket: 'adhd-planner-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBYpzy2Di-8gXD5PXv41NaKYm4wlMlIoRc',
    appId: '1:571106756266:ios:f8db3a84eb6437f3b172d3',
    messagingSenderId: '571106756266',
    projectId: 'adhd-planner-project',
    storageBucket: 'adhd-planner-project.appspot.com',
    iosClientId: '571106756266-qqji7s6q338qq9hfifb2fhsk3d4ccclb.apps.googleusercontent.com',
    iosBundleId: 'com.example.adhdPlanner',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBYpzy2Di-8gXD5PXv41NaKYm4wlMlIoRc',
    appId: '1:571106756266:ios:f8db3a84eb6437f3b172d3',
    messagingSenderId: '571106756266',
    projectId: 'adhd-planner-project',
    storageBucket: 'adhd-planner-project.appspot.com',
    iosClientId: '571106756266-qqji7s6q338qq9hfifb2fhsk3d4ccclb.apps.googleusercontent.com',
    iosBundleId: 'com.example.adhdPlanner',
  );
}