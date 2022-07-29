import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

initializeNotification() async {
  final fcm = FirebaseMessaging.instance;

  try {
    if (Platform.isIOS) {
      await fcm.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      await fcm.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((_onMessage) {});
      FirebaseMessaging.onBackgroundMessage((_onBackgroundMessage) async {});
      FirebaseMessaging.onMessageOpenedApp.listen((_onOpened) {});
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  void _onMessage(RemoteMessage message) {
    debugPrint("Kamu menerima pesan! ${message.notification?.title}");
    debugPrint("${message.notification?.body}");
  }

  Future<void> _onBackgroundMessage(RemoteMessage message) async {
    debugPrint("Kamu menerima pesan! ${message.notification?.title}");
    debugPrint("${message.notification?.body}");
  }

  void _onOpened(RemoteMessage message) async {
    final message = await fcm.getInitialMessage();
    if (message != null) {
      final data = message.data;
      debugPrint("Kamu bisa melakukan apapun pada data! $data");
    }
  }
  debugPrint("Token: ${(await FirebaseMessaging.instance.getToken()).toString()}");
}
