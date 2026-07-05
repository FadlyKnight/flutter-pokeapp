// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// [FirebaseOptions] for use with your Firebase apps, sourced from the
/// `.env` file (see `.env.example`) so secrets never end up hardcoded in
/// version-controlled Dart source.
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for this platform.',
        );
    }
  }

  static String _env(String key) {
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      throw StateError('Missing $key in .env — copy .env.example to .env and fill in your Firebase credentials.');
    }
    return value;
  }

  static FirebaseOptions get web => FirebaseOptions(
        apiKey: _env('FIREBASE_API_KEY'),
        appId: _env('FIREBASE_APP_ID_WEB'),
        messagingSenderId: _env('FIREBASE_MESSAGING_SENDER_ID'),
        projectId: _env('FIREBASE_PROJECT_ID'),
        authDomain: _env('FIREBASE_AUTH_DOMAIN'),
        storageBucket: _env('FIREBASE_STORAGE_BUCKET'),
      );

  static FirebaseOptions get android => FirebaseOptions(
        apiKey: _env('FIREBASE_API_KEY'),
        appId: _env('FIREBASE_APP_ID_ANDROID'),
        messagingSenderId: _env('FIREBASE_MESSAGING_SENDER_ID'),
        projectId: _env('FIREBASE_PROJECT_ID'),
        storageBucket: _env('FIREBASE_STORAGE_BUCKET'),
      );

  static FirebaseOptions get ios => FirebaseOptions(
        apiKey: _env('FIREBASE_API_KEY_IOS'),
        appId: _env('FIREBASE_APP_ID_IOS'),
        messagingSenderId: _env('FIREBASE_MESSAGING_SENDER_ID'),
        projectId: _env('FIREBASE_PROJECT_ID'),
        storageBucket: _env('FIREBASE_STORAGE_BUCKET'),
        iosBundleId: _env('FIREBASE_IOS_BUNDLE_ID'),
      );

  static FirebaseOptions get macos => FirebaseOptions(
        apiKey: _env('FIREBASE_API_KEY_IOS'),
        appId: _env('FIREBASE_APP_ID_MACOS'),
        messagingSenderId: _env('FIREBASE_MESSAGING_SENDER_ID'),
        projectId: _env('FIREBASE_PROJECT_ID'),
        storageBucket: _env('FIREBASE_STORAGE_BUCKET'),
        iosBundleId: _env('FIREBASE_IOS_BUNDLE_ID'),
      );

  static FirebaseOptions get windows => FirebaseOptions(
        apiKey: _env('FIREBASE_API_KEY'),
        appId: _env('FIREBASE_APP_ID_WINDOWS'),
        messagingSenderId: _env('FIREBASE_MESSAGING_SENDER_ID'),
        projectId: _env('FIREBASE_PROJECT_ID'),
        authDomain: _env('FIREBASE_AUTH_DOMAIN'),
        storageBucket: _env('FIREBASE_STORAGE_BUCKET'),
      );
}
