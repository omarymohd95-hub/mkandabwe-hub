import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    throw UnsupportedError('Toleo hili linafanya kazi kwenye web tu.');
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBHGwwEVvtcmGSX7oTJhCZynLfK2EUPbM4',
    authDomain: 'mkandabwe-hub.firebaseapp.com',
    projectId: 'mkandabwe-hub',
    storageBucket: 'mkandabwe-hub.firebasestorage.app',
    messagingSenderId: '570835819387',
    appId: '1:570835819387:web:6bef64714e8d4eb51b3bde',
  );
}
