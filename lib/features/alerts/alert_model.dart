enum AlertType { exam, homework, review, general }

extension AlertTypeX on AlertType {
  String get label {
    switch (this) {
      case AlertType.exam: return 'امتحان';
      case AlertType.homework: return 'واجب';
      case AlertType.review: return 'مراجعة';
      case AlertType.general: return 'تذكير';
    }
  }

  String get emoji {
    switch (this) {
      case AlertType.exam: return '📚';
      case AlertType.homework: return '📝';
      case AlertType.review: return '📖';
      case AlertType.general: return '🔔';
    }
  }

  int get color {
    switch (this) {
      case AlertType.exam: return 0xFFE63946;
      case AlertType.homework: return 0xFFF59E0B;
      case AlertType.review: return 0xFF4A6CF7;
      case AlertType.general: return 0xFF7C3AED;
    }
  }
}

enum AlertRepeat { once, daily, weekly }

extension AlertRepeatX on AlertRepeat {
  String get label {
    switch (this) {
      case AlertRepeat.once: return 'مرة واحدة';
      case AlertRepeat.daily: return 'يومياً';
      case AlertRepeat.weekly: return 'أسبوعياً';
    }
  }
}

enum ReminderWhen { atTime, m5, m15, m30, h1, h6, d1 }

extension ReminderWhenX on ReminderWhen {
  String get label {
    switch (this) {
      case ReminderWhen.atTime: return 'في الموعد';
      case ReminderWhen.m5: return 'قبل 5 دقائق';
      case ReminderWhen.m15: return 'قبل 15 دقيقة';
      case ReminderWhen.m30: return 'قبل 30 دقيقة';
      case ReminderWhen.h1: return 'قبل ساعة';
      case ReminderWhen.h6: return 'قبل 6 ساعات';
      case ReminderWhen.d1: return 'قبل يوم';
    }
  }

  Duration get offset {
    switch (this) {
      case ReminderWhen.atTime: return Duration.zero;
      case ReminderWhen.m5: return const Duration(minutes: 5);
      case ReminderWhen.m15: return const Duration(minutes: 15);
      case ReminderWhen.m30: return const Duration(minutes: 30);
      case ReminderWhen.h1: return const Duration(hours: 1);
      case ReminderWhen.h6: return const Duration(hours: 6);
      case ReminderWhen.d1: return const Duration(days: 1);
    }
  }
}

class Alert {
  final String id;
  final String title;
  final String? details;
  final AlertType type;
  final DateTime dateTime;
  final AlertRepeat repeat;  
  final ReminderWhen when;
  final bool soundEnabled;
  final bool vibrate;
  final int? notificationId;

  Alert({
    required this.id,
    required this.title,
    this.details,
    required this.type,
    required this.dateTime,
    this.repeat = AlertRepeat.once,
    this.when = ReminderWhen.atTime,
    this.soundEnabled = true,
    this.vibrate = true,
    this.notificationId,
  });

  DateTime get notifyAt => dateTime.subtract(when.offset);

  bool get isPast => dateTime.isBefore(DateTime.now());

  Duration get timeLeft => dateTime.difference(DateTime.now());

  String get timeLeftLabel {
    if (isPast) return 'انتهى';
    final d = timeLeft;
    if (d.inDays > 0) return 'بعد ${d.inDays} يوم';
    if (d.inHours > 0) return 'بعد ${d.inHours} ساعة';
    if (d.inMinutes > 0) return 'بعد ${d.inMinutes} دقيقة';
    return 'قريباً';
  }

  Alert copyWith({
    String? title,
    String? details,
    AlertType? type,
    DateTime? dateTime,
    AlertRepeat? repeat,
    ReminderWhen? when,
    bool? soundEnabled,
    bool? vibrate,
    int? notificationId,
  }) {
    return Alert(
      id: id,
      title: title ?? this.title,
      details: details ?? this.details,
      type: type ?? this.type,
      dateTime: dateTime ?? this.dateTime,
      repeat: repeat ?? this.repeat,
      when: when ?? this.when,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrate: vibrate ?? this.vibrate,
      notificationId: notificationId ?? this.notificationId,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'details': details,
        'type': type.name,
        'dateTime': dateTime.toIso8601String(),
        'repeat': repeat.name,
        'when': when.name,
        'soundEnabled': soundEnabled,
        'vibrate': vibrate,
        'notificationId': notificationId,
      };

  factory Alert.fromJson(Map<String, dynamic> j) => Alert(
        id: j['id'],
        title: j['title'],
        details: j['details'],
        type: AlertType.values.firstWhere(
          (e) => e.name == j['type'],
          orElse: () => AlertType.general,
        ),
        dateTime: DateTime.parse(j['dateTime']),
        repeat: AlertRepeat.values.firstWhere(
          (e) => e.name == j['repeat'],
          orElse: () => AlertRepeat.once,
        ),
        when: ReminderWhen.values.firstWhere(
          (e) => e.name == j['when'],
          orElse: () => ReminderWhen.atTime,
        ),
        soundEnabled: j['soundEnabled'] ?? true,
        vibrate: j['vibrate'] ?? true,
        notificationId: j['notificationId'],
      );
}