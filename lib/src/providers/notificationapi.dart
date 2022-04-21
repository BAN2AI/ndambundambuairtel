import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/src/date_time.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static var initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/launcher_icon'); // <- default icon name is @mipmap/ic_launcher
  static var initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  static var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future ShowNotification(
          {int id = 0, String title, String body, String payload}) async =>
      {
        _notifications.initialize(initializationSettings),
        _notifications.show(id, title, body, await _notificationDetails(),
            payload: payload)
      };

  static Future ShowScheduleDailyNotification(
          {int id = 0, String title, String body, String payload}) async =>
      {
        _notifications.initialize(initializationSettings),
        _notifications.zonedSchedule(id, title, body, _scheduleDaily(Time(8)),
            await _notificationDetails(),
            payload: payload,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            matchDateTimeComponents: DateTimeComponents.time)
      };

  static Future ShowScheduleNotification(
          {int id = 0,
          String title,
          String body,
          String payload,
          DateTime dateSc}) async =>
      {
        _notifications.initialize(initializationSettings),
        _notifications.zonedSchedule(id, title, body,
            tz.TZDateTime.from(dateSc, tz.local), await _notificationDetails(),
            payload: payload,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            matchDateTimeComponents: DateTimeComponents.time)
      };

  static Future _notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max,
            styleInformation: BigTextStyleInformation('')),
        iOS: IOSNotificationDetails());
  }

  static void onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {}

  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);
    return scheduleDate.isBefore(now)
        ? scheduleDate.add(Duration(days: 1))
        : scheduleDate;
  }
}
