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
    apiKey: 'AIzaSyDOvywChofZXZY1MFfPFtOImYLRwmL6nFU',
    appId: '1:862893196057:web:a59e1b8ab38f352156bb88',
    messagingSenderId: '862893196057',
    projectId: 'voice-assistant-1678f',
    authDomain: 'voice-assistant-1678f.firebaseapp.com',
    storageBucket: 'voice-assistant-1678f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBf_SxwAMseiTpr9DieZsSa0mC-Y7TopGU',
    appId: '1:862893196057:android:22c744082556c9c356bb88',
    messagingSenderId: '862893196057',
    projectId: 'voice-assistant-1678f',
    storageBucket: 'voice-assistant-1678f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQydX9CsxopsNX6IQ-2BSPH3ZtwEDkkIM',
    appId: '1:862893196057:ios:978bdcfd2f9bf10156bb88',
    messagingSenderId: '862893196057',
    projectId: 'voice-assistant-1678f',
    storageBucket: 'voice-assistant-1678f.appspot.com',
    iosBundleId: 'com.example.voiceAssistant',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCQydX9CsxopsNX6IQ-2BSPH3ZtwEDkkIM',
    appId: '1:862893196057:ios:978bdcfd2f9bf10156bb88',
    messagingSenderId: '862893196057',
    projectId: 'voice-assistant-1678f',
    storageBucket: 'voice-assistant-1678f.appspot.com',
    iosBundleId: 'com.example.voiceAssistant',
  );
}
