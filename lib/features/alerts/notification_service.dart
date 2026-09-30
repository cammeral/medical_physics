import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'alert_model.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> init() async {
    if (kIsWeb) return;
    if (_initialized) return;

    tz.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(initSettings);
    _initialized = true;

    // طلب الأذونات
    await _requestPermissions();
  }

  static Future<void> _requestPermissions() async {
    if (kIsWeb) return;
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await android?.requestNotificationsPermission();
    await android?.requestExactAlarmsPermission();
  }

  static Future<bool> scheduleAlert(Alert alert) async {
    if (kIsWeb) return false;

    try {
      final when = alert.notifyAt;
      if (when.isBefore(DateTime.now())) return false;

      final id = alert.notificationId ??
          (alert.id.hashCode & 0x7fffffff) % 100000;

      final tzTime = tz.TZDateTime.from(when, tz.local);

      DateTimeComponents? components;
      if (alert.repeat == AlertRepeat.daily) {
        components = DateTimeComponents.time;
      } else if (alert.repeat == AlertRepeat.weekly) {
        components = DateTimeComponents.dayOfWeekAndTime;
      }

      await _plugin.zonedSchedule(
        id,
        '${alert.type.emoji} ${alert.title}',
        alert.details ?? alert.type.label,
        tzTime,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'alerts_channel',
            'التنبيهات',
            channelDescription: 'تنبيهات التطبيق',
            importance: Importance.max,
            priority: Priority.high,
            playSound: alert.soundEnabled,
            enableVibration: alert.vibrate,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentSound: alert.soundEnabled,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: components,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      return true;
    } catch (e) {
      debugPrint('Schedule error: $e');
      return false;
    }
  }

  static Future<void> cancelAlert(Alert alert) async {
    if (kIsWeb) return;
    final id = alert.notificationId ??
        (alert.id.hashCode & 0x7fffffff) % 100000;
    await _plugin.cancel(id);
  }

  static Future<void> cancelAll() async {
    if (kIsWeb) return;
    await _plugin.cancelAll();
  }
}