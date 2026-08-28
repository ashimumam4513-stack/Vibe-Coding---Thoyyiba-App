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
    apiKey: 'AIzaSyCaTfY4UGPn4OYZeA3UeGuXbLTte5UPMec',
    appId: '1:782642114424:web:5d89e528e7cb7b41d1e28d',
    messagingSenderId: '782642114424',
    projectId: 'thoyyiba-app',
    authDomain: 'thoyyiba-app.firebaseapp.com',
    storageBucket: 'thoyyiba-app.firebasestorage.app',
    measurementId: 'G-RQ3DSCNX4T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCaTfY4UGPn4OYZeA3UeGuXbLTte5UPMec',
    appId: '1:782642114424:android:5d89e528e7cb7b41d1e28d',
    messagingSenderId: '782642114424',
    projectId: 'thoyyiba-app',
    storageBucket: 'thoyyiba-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCaTfY4UGPn4OYZeA3UeGuXbLTte5UPMec',
    appId: '1:782642114424:ios:5d89e528e7cb7b41d1e28d',
    messagingSenderId: '782642114424',
    projectId: 'thoyyiba-app',
    storageBucket: 'thoyyiba-app.firebasestorage.app',
    iosBundleId: 'com.example.thoyyibaApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCaTfY4UGPn4OYZeA3UeGuXbLTte5UPMec',
    appId: '1:782642114424:ios:5d89e528e7cb7b41d1e28d',
    messagingSenderId: '782642114424',
    projectId: 'thoyyiba-app',
    storageBucket: 'thoyyiba-app.firebasestorage.app',
    iosBundleId: 'com.example.thoyyibaApp.RunnerTests',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCaTfY4UGPn4OYZeA3UeGuXbLTte5UPMec',
    appId: '1:782642114424:web:5d89e528e7cb7b41d1e28d',
    messagingSenderId: '782642114424',
    projectId: 'thoyyiba-app',
    authDomain: 'thoyyiba-app.firebaseapp.com',
    storageBucket: 'thoyyiba-app.firebasestorage.app',
    measurementId: 'G-RQ3DSCNX4T',
  );
}
