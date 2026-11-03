import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

/// Jaza thamani kutoka Firebase Console:
/// Project settings -> Your apps -> Web app -> firebaseConfig
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    throw UnsupportedError('Toleo hili linafanya kazi kwenye web tu.');
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'WEKA_apiKey_HAPA',
    authDomain: 'WEKA_authDomain_HAPA',
    projectId: 'WEKA_projectId_HAPA',
    storageBucket: 'WEKA_storageBucket_HAPA',
    messagingSenderId: 'WEKA_messagingSenderId_HAPA',
    appId: 'WEKA_appId_HAPA',
  );
}
