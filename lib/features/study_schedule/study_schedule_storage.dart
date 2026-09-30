import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'class_model.dart';

class StudyScheduleStorage {
  static const _key = 'study_schedule_v1';

  static Future<List<ClassItem>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];
    final list = jsonDecode(data) as List;
    return list.map((e) => ClassItem.fromJson(e)).toList();
  }

  static Future<void> save(List<ClassItem> classes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key,
      jsonEncode(classes.map((e) => e.toJson()).toList()),
    );
  }
}