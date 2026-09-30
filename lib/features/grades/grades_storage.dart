import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'grade_model.dart';

class GradesStorage {
  static const _subjectsKey = 'subjects_v1';
  static const _profileKey = 'student_profile_v1';

  // ─── المواد ───
  static Future<List<Subject>> loadSubjects() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_subjectsKey);
    if (data == null) return [];
    final list = jsonDecode(data) as List;
    return list.map((e) => Subject.fromJson(e)).toList();
  }

  static Future<void> saveSubjects(List<Subject> subjects) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(subjects.map((e) => e.toJson()).toList());
    await prefs.setString(_subjectsKey, data);
  }

  // ─── الملف الشخصي ───
  static Future<StudentProfile> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_profileKey);
    if (data == null) return StudentProfile();
    return StudentProfile.fromJson(jsonDecode(data));
  }

  static Future<void> saveProfile(StudentProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileKey, jsonEncode(profile.toJson()));
  }
}