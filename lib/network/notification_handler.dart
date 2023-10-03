import 'package:daniel_dean/utils/common_methods.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_filex/open_filex.dart';
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  LocalNotificationService();

  //instance of FlutterLocalNotificationsPlugin
  final _localNotificationsPluginSerevice = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
        requestSoundPermission: true, requestBadgePermission: true, requestAlertPermission: true, onDidReceiveLocalNotification: _onDidReceiveLocalNotification);

    final InitializationSettings settings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await _localNotificationsPluginSerevice.initialize(settings, onSelectNotification: onSelectNotification);
  }

  onSelectNotification(String? payload) async {
    showLog('payload : $payload');
    if (payload != null) {
      OpenFilex.open(payload);
    }
    //Navigate to wherever you want
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('channel_id', 'channel_name',
        channelDescription: 'description', importance: Importance.max, priority: Priority.max, ticker: 'ticker', playSound: true);

    const IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    return const NotificationDetails(android: androidNotificationDetails, iOS: iosNotificationDetails);
  }

  // requestIOSPermissions() {

  Future<void> showNotifications({
    required int id,
    required String title,
    required String body,
    required String payLoad,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationsPluginSerevice.show(id, title, body, details, payload: payLoad);
  }

  void _onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
    showLog('id: $id');
  }
}
