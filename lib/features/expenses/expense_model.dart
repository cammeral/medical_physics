// ═══════════════════════════════════════════════════
//  التقسيط (Installments)
// ═══════════════════════════════════════════════════
class InstallmentPayment {
  final int number;
  final double amount;
  DateTime? paidDate;

  InstallmentPayment({
    required this.number,
    required this.amount,
    this.paidDate,
  });

  bool get isPaid => paidDate != null;

  Map<String, dynamic> toJson() => {
        'number': number,
        'amount': amount,
        'paidDate': paidDate?.toIso8601String(),
      };

  factory InstallmentPayment.fromJson(Map<String, dynamic> j) =>
      InstallmentPayment(
        number: j['number'],
        amount: (j['amount'] as num).toDouble(),
        paidDate: j['paidDate'] != null
            ? DateTime.parse(j['paidDate'])
            : null,
      );
}

class Installment {
  final String id;
  final String title;
  final double totalAmount;
  final int count;
  final List<InstallmentPayment> payments;
  final DateTime createdAt;

  Installment({
    required this.id,
    required this.title,
    required this.totalAmount,
    required this.count,
    required this.payments,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  double get paidAmount =>
      payments.where((p) => p.isPaid).fold(0, (s, p) => s + p.amount);

  double get remainingAmount => totalAmount - paidAmount;

  double get progressPercent =>
      totalAmount == 0 ? 0 : paidAmount / totalAmount;

  int get paidCount => payments.where((p) => p.isPaid).length;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'totalAmount': totalAmount,
        'count': count,
        'payments': payments.map((e) => e.toJson()).toList(),
        'createdAt': createdAt.toIso8601String(),
      };

  factory Installment.fromJson(Map<String, dynamic> j) => Installment(
        id: j['id'],
        title: j['title'],
        totalAmount: (j['totalAmount'] as num).toDouble(),
        count: j['count'],
        payments: (j['payments'] as List)
            .map((e) => InstallmentPayment.fromJson(e))
            .toList(),
        createdAt: DateTime.parse(j['createdAt']),
      );
}

// ═══════════════════════════════════════════════════
//  المصاريف اليومية (Daily Expenses)
// ═══════════════════════════════════════════════════
class DailyExpense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String? note;

  DailyExpense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    this.note,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'amount': amount,
        'date': date.toIso8601String(),
        'note': note,
      };

  factory DailyExpense.fromJson(Map<String, dynamic> j) => DailyExpense(
        id: j['id'],
        title: j['title'],
        amount: (j['amount'] as num).toDouble(),
        date: DateTime.parse(j['date']),
        note: j['note'],
      );
}

// ═══════════════════════════════════════════════════
//  فلتر الفترة
// ═══════════════════════════════════════════════════
enum ExpensePeriod { today, week, month, all }

extension ExpensePeriodX on ExpensePeriod {
  String get label {
    switch (this) {
      case ExpensePeriod.today: return 'اليوم';
      case ExpensePeriod.week: return 'الأسبوع';
      case ExpensePeriod.month: return 'الشهر';
      case ExpensePeriod.all: return 'الكل';
    }
  }

  String get emoji {
    switch (this) {
      case ExpensePeriod.today: return '📅';
      case ExpensePeriod.week: return '📆';
      case ExpensePeriod.month: return '🗓️';
      case ExpensePeriod.all: return '📊';
    }
  }

  bool matches(DateTime d) {
    final now = DateTime.now();
    switch (this) {
      case ExpensePeriod.today:
        return d.year == now.year &&
            d.month == now.month &&
            d.day == now.day;
      case ExpensePeriod.week:
        final startOfWeek = now.subtract(Duration(days: now.weekday));
        return d.isAfter(startOfWeek.subtract(const Duration(days: 1)));
      case ExpensePeriod.month:
        return d.year == now.year && d.month == now.month;
      case ExpensePeriod.all:
        return true;
    }
  }
}