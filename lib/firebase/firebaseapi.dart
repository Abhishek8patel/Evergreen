import 'dart:convert';

import 'package:testingevergreen/pages/dashboard/dahboard_controller.dart';
import 'package:testingevergreen/pages/dashboard/dashboard.dart';
import 'package:testingevergreen/pages/notification/notification.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../Utills/utills.dart';
import '../Utills3/utills.dart';
import '../appconstants/appconstants.dart';

class FirebaseApi {
  final util = Utills();
  final _firebaseMessaging = FirebaseMessaging.instance;
  final DashboardController dashboardController = Get.find();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final _androidChannel = const AndroidNotificationChannel(
      "high_importance_channel", "High Importance Notification",
      description: "This Channel is used for High Importance Notification",
      importance: Importance.defaultImportance);

  final _loccalNotification = FlutterLocalNotificationsPlugin();

  _handleMessage(RemoteMessage? message) {
    if (message == null) return;

    dashboardController.newNotification.value = true;
    dashboardController.newNotification.refresh();
    print('Title ${message.notification!.title.toString()}');
    print('Body ${message.notification!.body.toString()}');
    print('Payload ${message.data.toString()}');
    Get.to(() => MyNotification());
    debugPrint("clicked notification");
    // Navigafte to the notification page
  }

  sendNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(_androidChannel.id, _androidChannel.name,
            channelDescription: 'tobuu channel',
            importance: Importance.max,
            priority: Priority.max);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _loccalNotification
        .show(0, title, body, notificationDetails)
        .then((value) => {
              Get.defaultDialog(
                  title: title.capitalizeFirst!,
                  content: Text(body.capitalizeFirst!),
                  onConfirm: () {

                      Get.back();
                    Get.to(() => MyNotification());

                  },
                  onCancel: () {
                    Get.back();
                  }),
            });
  }

  Future initLocalNotifications() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = null;
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _loccalNotification.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (respose) {
      Get.to(MyNotification());
    });

    final platform = _loccalNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  void saveUserData(key, value) async {
    final sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }


  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
//forgound
    FirebaseMessaging.instance.getInitialMessage().then((value) => {
    debugPrint("nj"+"backgroung getInitialMessage ${value}"),

          _handleMessage(value),
        });
//background tap
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      debugPrint("nj"+"backgroung onMessageOpenedApp");
      _handleMessage(event);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;

      if (notification == null) return;

      dashboardController.setRedDot(true);
      sendNotification(message.notification!.title!.toString(),
          message.notification!.body.toString());

      _loccalNotification
          .show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  _androidChannel.id,
                  _androidChannel.name,
                  channelDescription: _androidChannel.description,
                  icon: '@drawable/ic_launcher',
                ),
              ),
              payload: jsonEncode(message.toMap()))
          .then((value) => {});
    });
  }
  @pragma("vm:entry-point")
  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    debugPrint("nj"+"backgroung handleBackgroundMessage");
    print('Title ${message.notification!.title.toString()}');
    print('Body ${message.notification!.body.toString()}');
    print('Payload ${message.data.toString()}');
    _handleMessage(message);
  }

  Future<void> initFirebase() async {
    await _firebaseMessaging.requestPermission(
      badge: true
    );
    final fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      saveUserData("fcm", fcmToken);
      AppConstant.setData("fcm", "${fcmToken}");
      AppConstant.save_data("fcm", "${fcmToken}");
    }
    print('MyTokenFirebase:$fcmToken');

    initPushNotification();
    initLocalNotifications();
  }
}
