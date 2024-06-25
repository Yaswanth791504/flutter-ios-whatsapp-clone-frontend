import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/IOSZegoCallScreen.dart';
import '../screens/IOSZegoVideoCallScreen.dart';

class FirebaseNotifications {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  FirebaseNotifications();

  Future<String> initNotifications() async {
    await _requestPermissions();
    await _initializeAwesomeNotifications();
    final messagingToken = await _getFcmToken();
    messaging.onTokenRefresh.listen((newToken) {
      print('New FCM Token: $newToken');
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundNotification(message);
    });
    print('FCM Token: $messagingToken');
    return messagingToken ?? "";
  }

  Future<void> _requestPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> _initializeAwesomeNotifications() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'message_channel',
          channelName: 'Messages',
          channelDescription: 'Notification channel for messages',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          defaultRingtoneType: DefaultRingtoneType.Notification,
        ),
        NotificationChannel(
          channelKey: 'call_channel',
          channelName: 'Calls',
          channelDescription: 'Notification channel for calls',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          defaultRingtoneType: DefaultRingtoneType.Ringtone,
        ),
      ],
      debug: true,
    );
  }

  Future<String?> _getFcmToken() async {
    try {
      return await messaging.getToken();
    } catch (e) {
      print('Error retrieving FCM token: $e');
      return null;
    }
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
    _showNotification(message);
  }

  void _handleForegroundNotification(RemoteMessage message) {
    print('Handling a foreground message: ${message.messageId}');
    _showNotification(message);
  }

  static void _showNotification(RemoteMessage message) {
    String channelKey =
        message.data['type'] == 'message' ? 'message_channel' : 'call_channel';
    NotificationCategory category = message.data['type'] == 'message'
        ? NotificationCategory.Message
        : NotificationCategory.Call;

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: channelKey,
        title: message.notification?.title,
        body: message.data['call_id'],
        category: category,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: false,
        backgroundColor: Colors.white,
        payload: message.data.map<String, String?>(
          (key, value) => MapEntry(key, value.toString()),
        ),
      ),
      actionButtons: message.data['type'] == 'phonecall' ||
              message.data['type'] == "videocall"
          ? [
              NotificationActionButton(
                key: 'ACCEPT',
                label: 'Accept',
                color: Colors.green,
                autoDismissible: true,
              ),
              NotificationActionButton(
                key: 'REJECT',
                label: 'Reject',
                color: Colors.red,
                autoDismissible: true,
              ),
            ]
          : null,
    );
  }

  static Future<void> onActionReceivedMethod(ReceivedAction action) async {
    final payload = action.payload;
    if (payload == null) return;

    print('Button pressed: ${action.buttonKeyPressed}');
    if (action.buttonKeyPressed == 'ACCEPT') {
      if (payload['type'] == 'phonecall') {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => IOSZegoCallingScreen(
              callId: payload['call_id'] ?? '',
              userId: payload['call_id'] ?? '',
            ),
          ),
        );
      } else {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => IOSZegoVideoCallingScreen(
              callId: payload['call_id'] ?? '',
              userId: payload['call_id'] ?? '',
            ),
          ),
        );
      }
    }
  }
}
