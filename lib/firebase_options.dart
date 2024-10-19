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
    apiKey: 'AIzaSyAizYrm-qLa2QnaKoult3fWlOAcVKRwDwg',
    appId: '1:100196825462:web:feb23e14af9e4028d36257',
    messagingSenderId: '100196825462',
    projectId: 'habits-eef1f',
    authDomain: 'habits-eef1f.firebaseapp.com',
    storageBucket: 'habits-eef1f.appspot.com',
    measurementId: 'G-LS4LL8ZGNH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDHyPRaa7uBnZzpRvKOh-TpE9W2XkMpvGY',
    appId: '1:100196825462:android:1f83ad140e48b292d36257',
    messagingSenderId: '100196825462',
    projectId: 'habits-eef1f',
    storageBucket: 'habits-eef1f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDxfAqgTQ3hFeMmHOxG168fs8wIEOWjNw',
    appId: '1:100196825462:ios:57bb6a963aeea043d36257',
    messagingSenderId: '100196825462',
    projectId: 'habits-eef1f',
    storageBucket: 'habits-eef1f.appspot.com',
    iosBundleId: 'com.example.habitTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCDxfAqgTQ3hFeMmHOxG168fs8wIEOWjNw',
    appId: '1:100196825462:ios:57bb6a963aeea043d36257',
    messagingSenderId: '100196825462',
    projectId: 'habits-eef1f',
    storageBucket: 'habits-eef1f.appspot.com',
    iosBundleId: 'com.example.habitTracker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAizYrm-qLa2QnaKoult3fWlOAcVKRwDwg',
    appId: '1:100196825462:web:596d639c516e3641d36257',
    messagingSenderId: '100196825462',
    projectId: 'habits-eef1f',
    authDomain: 'habits-eef1f.firebaseapp.com',
    storageBucket: 'habits-eef1f.appspot.com',
    measurementId: 'G-B5CBDE8GFK',
  );

}