import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class IOSAwesomeNotification {
  late final AwesomeNotifications notification;

  IOSAwesomeNotification() {
    print('Notification initialized');
    notification = AwesomeNotifications();
    _initializeNotification();
  }

  Future<void> _initializeNotification() async {
    await notification.initialize(
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Notification Channel',
          importance: NotificationImportance.Max,
          playSound: true,
          defaultRingtoneType: DefaultRingtoneType.Notification,
          locked: true,
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
      ],
      debug: true,
    );

    notification.setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
    );
  }

  Future<void> onActionReceivedMethod(ReceivedAction action) async {
    if (action.buttonKeyPressed == 'ACCEPT') {
      ZegoUIKitPrebuiltCallInvitationService().accept();
    } else if (action.buttonKeyPressed == 'REJECT') {
      ZegoUIKitPrebuiltCallInvitationService().reject();
    }
  }

  Future<void> onDismissActionReceivedMethod(ReceivedAction action) async {}
  Future<void> onNotificationCreatedMethod(
      ReceivedNotification message) async {}
  Future<void> onNotificationDisplayedMethod(
      ReceivedNotification message) async {}

  Future<void> backGroundMessageHandler(RemoteMessage message) async {
    String? title = message.notification?.title;
    String? body = message.notification?.body;

    print(title);
    print(
        '-----------------------------------------------------------------------------------------------------------------');

    if (title != null && body != null) {
      _createCallNotification(title, body);
    }
  }

  Future<void> _createCallNotification(String title, String body) async {
    await notification.createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: title,
        body: body,
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

  int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }
}
