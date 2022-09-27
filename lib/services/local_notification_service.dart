import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {

  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initializePlatformNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings(''); 

    IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotificationService.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true
    );

    const IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true
    );

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body}) async {
      final details = await _notificationDetails();
       await _localNotificationService.show(id, title, body, details);

    }

  void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  void onSelectNotification(String? payload) {
    print('payload $payload');
  }
}