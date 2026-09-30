import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'note_model.dart';

class NotesStorage {
  static const _key = 'notes_v1';

  static Future<List<Note>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];
    final list = jsonDecode(data) as List;
    return list.map((e) => Note.fromJson(e)).toList();
  }

  static Future<void> save(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key,
      jsonEncode(notes.map((e) => e.toJson()).toList()),
    );
  }
}