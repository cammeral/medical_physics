import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/reminder.dart';

class StorageService {
  static const String _key = 'reminders';

  static Future<List<Reminder>> loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];
    final List list = jsonDecode(data);
    return list.map((e) => Reminder.fromJson(e)).toList();
  }

  static Future<void> saveReminders(List<Reminder> reminders) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(reminders.map((e) => e.toJson()).toList());
    await prefs.setString(_key, data);
  }
}