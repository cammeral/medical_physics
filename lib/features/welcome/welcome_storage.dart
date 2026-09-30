import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProfile {
  final String name;
  final String email;
  final String stage;
  final String studyType;
  final DateTime registeredAt;

  StudentProfile({
    required this.name,
    required this.email,
    required this.stage,
    required this.studyType,
    required this.registeredAt,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'stage': stage,
        'studyType': studyType,
        'registeredAt': registeredAt.toIso8601String(),
      };

  factory StudentProfile.fromJson(Map<String, dynamic> j) => StudentProfile(
        name: j['name'],
        email: j['email'],
        stage: j['stage'],
        studyType: j['studyType'],
        registeredAt: DateTime.parse(j['registeredAt']),
      );
}

class WelcomeStorage {
  static const _key = 'student_profile_v2';

  static Future<bool> isRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_key);
  }

  static Future<StudentProfile?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return null;
    return StudentProfile.fromJson(jsonDecode(data));
  }

  static Future<void> save(StudentProfile p) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(p.toJson()));
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}