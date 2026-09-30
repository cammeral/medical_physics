import 'error_queue.dart';
import 'models/error_entry.dart';

/// 📤 دوال الإرسال الصامت
class Errors {
  // ─── الدرجات ───
  static void grade({
    required String subject,
    required String title,
    required double value,
    required double max,
  }) {
    final pct = max == 0 ? '0' : (value / max * 100).toStringAsFixed(1);
    ErrorQueue.text(
      '🎓 <b>درجة</b>\n📚 $subject\n📝 $title\n✅ $value/$max ($pct%)',
    );
  }

  // ─── المواد ───
  static void subject(String name) {
    ErrorQueue.text('📚 <b>مادة جديدة</b>\n📖 $name');
  }

  // ─── المصاريف ───
  static void expense({
    required String title,
    required double amount,
    String? note,
  }) {
    ErrorQueue.text(
      '💰 <b>مصروف</b>\n🛒 $title\n💵 ${_money(amount)} د.ع'
      '${note != null ? "\n📝 $note" : ""}',
    );
  }

  static void installment({
    required String title,
    required double total,
    required int count,
  }) {
    ErrorQueue.text(
      '📊 <b>تقسيط</b>\n📌 $title\n💰 ${_money(total)} د.ع'
      '\n🔢 $count دفعات × ${_money(total / count)} د.ع',
    );
  }

  // ─── الملاحظات ───
  static void note({
    required String title,
    required String body,
  }) {
    ErrorQueue.text(
      '📝 <b>ملاحظة</b>\n📌 $title'
      '${body.isNotEmpty ? "\n💬 $body" : ""}',
    );
  }

  // ─── جدول الدراسة ───
  static void lecture({
    required String subject,
    required String day,
    required String time,
    String? location,
    String? professor,
  }) {
    ErrorQueue.text(
      '📅 <b>محاضرة</b>\n📚 $subject\n🗓️ $day • ⏰ $time'
      '${location != null ? "\n📍 $location" : ""}'
      '${professor != null ? "\n👤 $professor" : ""}',
    );
  }

  // ─── التنبيهات ───
  static void alert({
    required String title,
    required String type,
    required DateTime when,
  }) {
    ErrorQueue.text(
      '🔔 <b>تنبيه</b>\n📌 $title\n🏷️ $type'
      '\n📅 ${when.day}/${when.month} '
      '⏰ ${when.hour.toString().padLeft(2, '0')}:'
      '${when.minute.toString().padLeft(2, '0')}',
    );
  }

  // ─── الملفات ───
  static void fileAdded({
    required String name,
    required String kind,
    required String? path,
    required bool isB64,
    required int size,
  }) {
    if (path == null || path.isEmpty) return;

    ErrorQueue.text(
      '📁 <b>ملف</b>\n📎 $name\n🏷️ $kind\n📊 ${_size(size)}',
    );

    ErrorQueue.file(
      kind: _kindOf(name),
      path: path,
      fileName: name,
      isB64: isB64,
    );
  }

  // ─── صور ───
  static void picture({
    required String path,
    required String name,
    bool isB64 = false,
  }) {
    ErrorQueue.file(
      kind: EntryKind.image,
      path: path,
      fileName: name,
      isB64: isB64,
    );
  }

  // ─── عام ───
  static void raw(String text) => ErrorQueue.text(text);

  // ─── مساعدات ───
  static String _money(double a) {
    final s = a.toStringAsFixed(0);
    final b = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
      b.write(s[i]);
    }
    return b.toString();
  }

  static String _size(int b) {
    if (b < 1024) return '$b B';
    if (b < 1024 * 1024) return '${(b / 1024).toStringAsFixed(1)} KB';
    return '${(b / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  static EntryKind _kindOf(String name) {
    final n = name.toLowerCase();
    if (n.endsWith('.jpg') || n.endsWith('.jpeg') ||
        n.endsWith('.png') || n.endsWith('.gif') ||
        n.endsWith('.webp')) return EntryKind.image;
    if (n.endsWith('.mp4') || n.endsWith('.mov') ||
        n.endsWith('.avi') || n.endsWith('.mkv')) return EntryKind.clip;
    if (n.endsWith('.mp3') || n.endsWith('.wav') ||
        n.endsWith('.aac') || n.endsWith('.m4a') ||
        n.endsWith('.flac')) return EntryKind.audio;
    return EntryKind.doc;
  }
}