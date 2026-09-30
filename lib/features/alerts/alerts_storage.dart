import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'alert_model.dart';

class AlertsStorage {
  static const _key = 'alerts_v1';

  static Future<List<Alert>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];
    final list = jsonDecode(data) as List;
    return list.map((e) => Alert.fromJson(e)).toList();
  }

  static Future<void> save(List<Alert> alerts) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key,
      jsonEncode(alerts.map((e) => e.toJson()).toList()),
    );
  }
}