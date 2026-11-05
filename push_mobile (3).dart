import 'package:firebase_messaging/firebase_messaging.dart';

bool _started = false;

/// Android: inaomba ruhusa ya arifa na kujiunga na kundi la 'all'.
/// Admin anatuma arifa kutoka Firebase Console kwa kundi hilo.
Future<void> initPush(
  void Function(String title, String body) onForeground,
) async {
  if (_started) return;
  _started = true;
  try {
    final m = FirebaseMessaging.instance;
    final settings = await m.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.denied) return;
    await m.subscribeToTopic('all');
    FirebaseMessaging.onMessage.listen((msg) {
      final n = msg.notification;
      if (n == null) return;
      onForeground(n.title ?? '', n.body ?? '');
    });
  } catch (_) {
    // Usiangushe app kama arifa zimeshindwa.
  }
}
