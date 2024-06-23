import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseNotifications {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<String> initNotifications() async {
    await _requestPermissions();
    await _initializeAwesomeNotifications();
    final messagingToken = await _getFcmToken();
    messaging.onTokenRefresh.listen((newToken) {
      print('New FCM Token: $newToken');
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.High,
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

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
    _showNotification(message);
  }

  void _handleForegroundNotification(RemoteMessage message) {
    print('Handling a foreground message: ${message.messageId}');
    _showNotification(message);
  }

  void _showNotification(RemoteMessage message) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: 'this is nothing',
        body: message.data['call_id'],
        category: NotificationCategory.Call,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: false,
        backgroundColor: Colors.white,
      ),
      actionButtons: [
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
      ],
    );
  }
}
