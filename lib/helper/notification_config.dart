import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../constant/global_functions.dart';

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

initialFireBaseMessages() async {
  securePrint(PayloadData().toJson().toString());
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.instance.getInitialMessage().then((value) {
    handlePayLoad(json.encode(value?.data ?? {}));
  });

  FirebaseMessaging.onMessage.listen(showFlutterNotification);

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    handlePayLoad(json.encode(message.data));
  });
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  channel = const AndroidNotificationChannel(
    'Sulok', // id
    'Sulok', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings(
    'mipmap/ic_launcher',
  );
  final DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          defaultPresentAlert: true,
          defaultPresentBadge: true,
          defaultPresentSound: true,
          onDidReceiveLocalNotification: (
            int id,
            String? title,
            String? body,
            String? payload,
          ) async {});
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: selectNotification);
  isFlutterLocalNotificationsInitialized = true;
  initialFireBaseMessages();
}

void selectNotification(NotificationResponse notificationResponse) async {
  String? payload = notificationResponse.payload;
  await handlePayLoad(payload);
}

Future<void> handlePayLoad(String? payload) async {
  securePrint('CLICK NOTIFICATION $payload');
  // if (payload != null && payload != '') {
  //   SharedPreferences ref = await SharedPreferences.getInstance();
  //   ref.setString(StorageKeys.lastNotification, payload);
  //   if(Get.isRegistered<MainController>()){
  //     var mainController=Get.find<MainController>();
  //     mainController.checkLastNotification();
  //   }
  ///TODO: Handel When Click
  // }
}

void showFlutterNotification(RemoteMessage message) {
  securePrint("NOTIFICATION THNEEBAT ${message.toMap().toString()}");
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      payload: json.encode(message.data),
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          fullScreenIntent: true,
          channel.name,
          channelDescription: channel.description,
          icon: 'mipmap/ic_launcher',
        ),
      ),
    );
  }
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class PayloadData {
  String? postId;
  String? action;
  String? clickAction;

  PayloadData({
    this.postId,
    this.action,
    this.clickAction,
  });

  factory PayloadData.fromJson(Map<String, dynamic> json) => PayloadData(
        postId: json["post_id"],
        action: json["action"],
        clickAction: json["click_action"],
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "action": action,
        "click_action": clickAction,
      };
}
