import 'dart:math';

import 'package:aman_app/Views/Home.dart';
import 'package:aman_app/Views/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_permissions/notification_permissions.dart';

import 'chat2.dart';

class NotificationsManager {
  Map<String, dynamic> messageget;

  NotificationsManager._internal();

  static final NotificationsManager _shared = NotificationsManager._internal();
  static final List<String> notificationMessages = [
    'Test1...',
    "Test 2",
    "Test 3"
  ];

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  factory NotificationsManager() {
    return _shared;
  }

  Future<FlutterLocalNotificationsPlugin> initializeNotifications(BuildContext context) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin
        .initialize(initializationSettings)
        .then((value) => _showDailyAtTime());
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await  flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
          if (payload != null) {
            debugPrint('notification payload: ' + payload);

            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatTwoPage(messageget['data']['senderId'])),
            );

          }
        });


    return _flutterLocalNotificationsPlugin;
  }

  FlutterLocalNotificationsPlugin getCurrentNotificationPlugin() {
    return _flutterLocalNotificationsPlugin;
  }

  void cancelNotificationWith(int id) {
    _flutterLocalNotificationsPlugin.cancel(id);
  }

  void scheduleDailyNotifications() {
    _showDailyAtTime();
  }

  void showNotifications(Map<String, dynamic> message) {
    _showNotification(message);
  }

  void requestPermission() {
    NotificationPermissions.requestNotificationPermissions();
  }

  /// Checks the notification permission status
  Future<bool> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case PermissionStatus.denied:
          return false;
        case PermissionStatus.granted:
          return true;
        case PermissionStatus.unknown:
          return false;
        default:
          return null;
      }
    });
  }
  Future<void> _showDailyAtTime() async {
    var time = const Time(10, 0, 0);
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'repeatDailyAtTime channel test123',
        'repeatDailyAtTime channel test123',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.showDailyAtTime(999, 'flutter_notif',
        _getNotificationMessage(), time, platformChannelSpecifics);
  }

  Future<void> _showNotification(Map<String, dynamic> message) async {
    messageget = message;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'flutter_notif', 'flutter_notif', 'Show notification',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
if(message['notification']['title'] != null){
  await _flutterLocalNotificationsPlugin.show(
      0,
      message['notification']['title'],
      message['notification']['body'],
      platformChannelSpecifics,
      payload: 'item x');
}
  }

  String _getNotificationMessage() {
    return notificationMessages[Random().nextInt(notificationMessages.length)];
  }

}
