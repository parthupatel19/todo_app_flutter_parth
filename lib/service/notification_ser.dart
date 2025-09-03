import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init()async{
    AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await _notificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNoti(String title, String body)async{
    AndroidNotificationDetails androidPlatformChannelSpecifies = AndroidNotificationDetails(
      'todo_channel',
      'Todo Notifications',
      channelDescription: 'Notification for Todo App',
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails platformChannelSpecifies = NotificationDetails(android: androidPlatformChannelSpecifies);
    await _notificationsPlugin.show(
        0,
        title,
        body,
        platformChannelSpecifies,
    );
  }
}