import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyABCDEFGHIJKLMNOPQRSTUVWXYZ123456789',
    appId: '1:123456789012:web:1234567890123456789012',
    messagingSenderId: '123456789012',
    projectId: 'medical-app-base',
    authDomain: 'medical-app-base.firebaseapp.com',
    storageBucket: 'medical-app-base.appspot.com',
    measurementId: 'G-ABCDEFGHIJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyABCDEFGHIJKLMNOPQRSTUVWXYZ123456789',
    appId: '1:123456789012:android:1234567890123456789012',
    messagingSenderId: '123456789012',
    projectId: 'medical-app-base',
    storageBucket: 'medical-app-base.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyABCDEFGHIJKLMNOPQRSTUVWXYZ123456789',
    appId: '1:123456789012:ios:1234567890123456789012',
    messagingSenderId: '123456789012',
    projectId: 'medical-app-base',
    storageBucket: 'medical-app-base.appspot.com',
    iosClientId: '123456789012-abcdefghijklmnopqrstuvwxyz123456.apps.googleusercontent.com',
    iosBundleId: 'com.example.medicalAppBase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyABCDEFGHIJKLMNOPQRSTUVWXYZ123456789',
    appId: '1:123456789012:ios:1234567890123456789012',
    messagingSenderId: '123456789012',
    projectId: 'medical-app-base',
    storageBucket: 'medical-app-base.appspot.com',
    iosClientId: '123456789012-abcdefghijklmnopqrstuvwxyz123456.apps.googleusercontent.com',
    iosBundleId: 'com.example.medicalAppBase',
  );
} 