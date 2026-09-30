enum WeekDay { saturday, sunday, monday, tuesday, wednesday, thursday }

extension WeekDayX on WeekDay {
  String get arabic {
    switch (this) {
      case WeekDay.saturday: return 'السبت';
      case WeekDay.sunday: return 'الأحد';
      case WeekDay.monday: return 'الاثنين';
      case WeekDay.tuesday: return 'الثلاثاء';
      case WeekDay.wednesday: return 'الأربعاء';
      case WeekDay.thursday: return 'الخميس';
    }
  }

  String get short {
    switch (this) {
      case WeekDay.saturday: return 'سبت';
      case WeekDay.sunday: return 'أحد';
      case WeekDay.monday: return 'اثنين';
      case WeekDay.tuesday: return 'ثلاثاء';
      case WeekDay.wednesday: return 'أربعاء';
      case WeekDay.thursday: return 'خميس';
    }
  }

  String get emoji {
    switch (this) {
      case WeekDay.saturday: return '🌅';
      case WeekDay.sunday: return '☀️';
      case WeekDay.monday: return '🔥';
      case WeekDay.tuesday: return '⚡';
      case WeekDay.wednesday: return '🎯';
      case WeekDay.thursday: return '🎉';
    }
  }

  int get weekdayNumber {
    // DateTime.weekday: 1=Monday...7=Sunday
    // نحن: السبت = 6، الأحد = 7، الاثنين = 1...
    switch (this) {
      case WeekDay.saturday: return 6;
      case WeekDay.sunday: return 7;
      case WeekDay.monday: return 1;
      case WeekDay.tuesday: return 2;
      case WeekDay.wednesday: return 3;
      case WeekDay.thursday: return 4;
    }
  }
}

WeekDay? todayWeekDay() {
  final wd = DateTime.now().weekday;
  for (final d in WeekDay.values) {
    if (d.weekdayNumber == wd) return d;
  }
  return null; // الجمعة
}

class ClassItem {
  final String id;
  final String subject;
  final String startTime;
  final String endTime;
  final String? location;
  final String? professor;
  final WeekDay day;
  final String colorHex;

  ClassItem({
    required this.id,
    required this.subject,
    required this.startTime,
    required this.endTime,
    this.location,
    this.professor,
    required this.day,
    this.colorHex = '4A6CF7',
  });

  String get timeRange => '$startTime - $endTime';

  Map<String, dynamic> toJson() => {
        'id': id,
        'subject': subject,
        'startTime': startTime,
        'endTime': endTime,
        'location': location,
        'professor': professor,
        'day': day.name,
        'colorHex': colorHex,
      };

  factory ClassItem.fromJson(Map<String, dynamic> j) => ClassItem(
        id: j['id'],
        subject: j['subject'],
        startTime: j['startTime'],
        endTime: j['endTime'],
        location: j['location'],
        professor: j['professor'],
        day: WeekDay.values.firstWhere(
          (e) => e.name == j['day'],
          orElse: () => WeekDay.saturday,
        ),
        colorHex: j['colorHex'] ?? '4A6CF7',
      );

  ClassItem copyWith({
    String? subject,
    String? startTime,
    String? endTime,
    String? location,
    String? professor,
    WeekDay? day,
    String? colorHex,
  }) {
    return ClassItem(
      id: id,
      subject: subject ?? this.subject,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      location: location ?? this.location,
      professor: professor ?? this.professor,
      day: day ?? this.day,
      colorHex: colorHex ?? this.colorHex,
    );
  }
}