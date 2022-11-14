import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  Future<void> intialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/ic_stat_android');

    // IOSInitializationSettings iosInitializationSettings =
    //     IOSInitializationSettings(
    //   requestAlertPermission: true,
    //   requestBadgePermission: true,
    //   requestSoundPermission: true,
    //   onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    // );

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      //iOS: iosInitializationSettings,
    );

    await _localNotificationService.initialize(
      settings,
      //onSelectNotification: onSelectNotification,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);

    // const IOSNotificationDetails iosNotificationDetails =
    //     IOSNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      // iOS: iosNotificationDetails,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }

  Future<void> showScheduledNotification(
      {required int id,
      required String title,
      required String body,
      required int seconds}) async {
    final details = await _notificationDetails();
    await _localNotificationService.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        DateTime.now().add(Duration(seconds: seconds)),
        tz.local,
      ),
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> setScheduledNotification(
      {required int id,
      required String body,
      required DateTime dateAndTime}) async {
    final details = await _notificationDetails();
    print(DateTime.now().add(Duration(seconds: 5)));
    await _localNotificationService.zonedSchedule(
      id,
      "Diabeta Activity Reminder",
      body,
      tz.TZDateTime.from(
        dateAndTime,
        tz.local,
      ),
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // Future<void> setScheduledDailyNotification(
  //     {required int id,
  //     required String body,
  //     required DateTime dateAndTime}) async {
  //   final details = await _notificationDetails();
  //   print(DateTime.now().add(Duration(seconds: 5)));
  //   await _localNotificationService.showDailyAtTime(
  //     id,
  //     "Diabeta Activity Reminder",
  //     body,
  //     Time(dateAndTime.hour,dateAndTime.minute, dateAndTime.second), 
  //     details,
  //   );
  // }

  Future<void> setScheduledDailyNotification(
      {required int id,
      required String body,
      required DateTime dateAndTime}) async {
    final details = await _notificationDetails();
    print(DateTime.now().add(Duration(seconds: 5)));
    await _localNotificationService.periodicallyShow(
      id,
      "Diabeta Activity Reminder",
      body,
      RepeatInterval.daily, 
      details,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> setScheduledWeeklyNotification(
      {required int id,
      required String body,
      required DateTime dateAndTime}) async {
    final details = await _notificationDetails();
    print(DateTime.now().add(Duration(seconds: 5)));
    await _localNotificationService.periodicallyShow(
      id,
      "Diabeta Activity Reminder",
      body,
      RepeatInterval.weekly, 
      details,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> setScheduledMinutelyNotification(
      {required int id,
      required String body,
      required DateTime dateAndTime}) async {
    final details = await _notificationDetails();
    print(DateTime.now().add(Duration(seconds: 5)));
    await _localNotificationService.periodicallyShow(
      id,
      "Diabeta Activity Reminder",
      body,
      RepeatInterval.everyMinute, 
      details,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> showNotificationWithPayload(
      {required int id,
      required String title,
      required String body,
      required String payload}) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details,
        payload: payload);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  void onSelectNotification(String? payload) {
    print('payload $payload');
    if (payload != null && payload.isNotEmpty) {
      onNotificationClick.add(payload);
    }
  }
}
