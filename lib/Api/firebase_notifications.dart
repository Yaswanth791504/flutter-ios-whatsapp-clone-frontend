import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotifications {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<String> initNotifications() async {
    await messaging.requestPermission();
    final messagingToken = await messaging.getToken();
    return messagingToken ?? "";
  }
}
