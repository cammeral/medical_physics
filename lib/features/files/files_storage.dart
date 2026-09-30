import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'file_model.dart';

class FilesStorage {
  static const _foldersKey = 'files_folders_v1';
  static const _filesKey = 'files_items_v1';
  static const _masterKey = 'files_master_v1';

  // ─── المجلدات ───
  static List<Folder> defaultFolders() => [
        Folder(id: 'books', name: 'الكتب', emoji: '📖'),
        Folder(id: 'images', name: 'الصور', emoji: '🖼️'),
        Folder(id: 'videos', name: 'الفيديوهات', emoji: '🎬'),
        Folder(id: 'audios', name: 'الصوتيات', emoji: '🎵'),
        Folder(id: 'documents', name: 'المستندات', emoji: '📄'),
      ];

  static Future<List<Folder>> loadFolders() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_foldersKey);
    if (data == null) {
      final defaults = defaultFolders();
      await saveFolders(defaults);
      return defaults;
    }
    final list = jsonDecode(data) as List;
    return list.map((e) => Folder.fromJson(e)).toList();
  }

  static Future<void> saveFolders(List<Folder> folders) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _foldersKey,
      jsonEncode(folders.map((e) => e.toJson()).toList()),
    );
  }

  // ─── الملفات ───
  static Future<List<StoredFile>> loadFiles() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_filesKey);
    if (data == null) return [];
    final list = jsonDecode(data) as List;
    return list.map((e) => StoredFile.fromJson(e)).toList();
  }

  static Future<void> saveFiles(List<StoredFile> files) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _filesKey,
      jsonEncode(files.map((e) => e.toJson()).toList()),
    );
  }

  // ─── كلمة سر الملفات ───
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  static Future<String?> loadMasterHash() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_masterKey);
  }

  static Future<void> saveMasterHash(String hash) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_masterKey, hash);   // ← أضف await
    // تأكيد إضافي: انتظر قليلاً
    await Future.delayed(const Duration(milliseconds: 100));
  }

    static Future<void> clearMasterPassword() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_masterKey);
  }

  static Future<bool> hasMasterPassword() async {
    final h = await loadMasterHash();
    return h != null && h.isNotEmpty;
  }

  // ═══════════════════════════════════════════════════
  //  تغيير كلمة السر (بالتحقق من القديمة)
  // ═══════════════════════════════════════════════════
  static Future<bool> changeMasterPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    // 1) تحقق من القديمة
    final ok = await verifyPassword(oldPassword);
    if (!ok) return false;

    // 2) احفظ الجديدة
    await saveMasterHash(hashPassword(newPassword));

    // 3) تأكد أن الحفظ نجح
    return await verifyPassword(newPassword);
  }
  
  static Future<bool> verifyPassword(String password) async {
    final stored = await loadMasterHash();
    if (stored == null) return false;
    return stored == hashPassword(password);
  }
}