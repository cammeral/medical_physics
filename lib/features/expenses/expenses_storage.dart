import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'expense_model.dart';

class ExpensesStorage {
  static const _installmentsKey = 'installments_v1';
  static const _dailyKey = 'daily_expenses_v1';

  // ─── التقسيط ───
  static Future<List<Installment>> loadInstallments() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_installmentsKey);
    if (data == null) return [];
    final list = jsonDecode(data) as List;
    return list.map((e) => Installment.fromJson(e)).toList();
  }

  static Future<void> saveInstallments(List<Installment> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _installmentsKey,
      jsonEncode(items.map((e) => e.toJson()).toList()),
    );
  }

  // ─── المصاريف اليومية ───
  static Future<List<DailyExpense>> loadDaily() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_dailyKey);
    if (data == null) return [];
    final list = jsonDecode(data) as List;
    return list.map((e) => DailyExpense.fromJson(e)).toList();
  }

  static Future<void> saveDaily(List<DailyExpense> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _dailyKey,
      jsonEncode(items.map((e) => e.toJson()).toList()),
    );
  }
}

// ═══════════════════════════════════════════════════
//  تنسيق الأرقام
// ═══════════════════════════════════════════════════
String formatMoney(double amount) {
  final str = amount.toStringAsFixed(0);
  final buffer = StringBuffer();
  final len = str.length;
  for (int i = 0; i < len; i++) {
    if (i > 0 && (len - i) % 3 == 0) buffer.write(',');
    buffer.write(str[i]);
  }
  return buffer.toString();
}