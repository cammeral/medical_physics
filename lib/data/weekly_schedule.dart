import '../models/subject.dart';

class WeeklySchedule {
  // 0 = الاثنين، 1 = الثلاثاء، ... 6 = الأحد
  static const Map<int, List<Subject>> schedule = {
    0: [ // الاثنين
      Subject(name: 'فيزياء طبية', time: '8:00 - 9:30', teacher: 'د. أحمد', room: 'قاعة 101'),
      Subject(name: 'تشريح', time: '10:00 - 11:30', teacher: 'د. سارة', room: 'قاعة 205'),
      Subject(name: 'كيمياء حيوية', time: '12:00 - 1:30', teacher: 'د. علي', room: 'مختبر 3'),
    ],
    1: [ // الثلاثاء
      Subject(name: 'رياضيات', time: '9:00 - 10:30', teacher: 'د. محمد', room: 'قاعة 302'),
      Subject(name: 'فسيولوجي', time: '11:00 - 12:30', teacher: 'د. هدى', room: 'قاعة 105'),
    ],
    2: [ // الأربعاء
      Subject(name: 'فيزياء طبية', time: '8:00 - 9:30', teacher: 'د. أحمد', room: 'قاعة 101'),
      Subject(name: 'إحصاء', time: '10:00 - 11:30', teacher: 'د. ليلى', room: 'قاعة 210'),
      Subject(name: 'أحياء دقيقة', time: '1:00 - 2:30', teacher: 'د. كريم', room: 'مختبر 1'),
    ],
    3: [ // الخميس
      Subject(name: 'تشريح', time: '9:00 - 10:30', teacher: 'د. سارة', room: 'قاعة 205'),
      Subject(name: 'مصطلحات طبية', time: '11:00 - 12:00', teacher: 'د. رنا', room: 'قاعة 108'),
    ],
    4: [ // الجمعة - عطلة
    ],
    5: [ // السبت
      Subject(name: 'رياضيات', time: '8:30 - 10:00', teacher: 'د. محمد', room: 'قاعة 302'),
      Subject(name: 'فيزياء طبية', time: '10:30 - 12:00', teacher: 'د. أحمد', room: 'مختبر 2'),
    ],
    6: [ // الأحد
      Subject(name: 'فسيولوجي', time: '9:00 - 10:30', teacher: 'د. هدى', room: 'قاعة 105'),
      Subject(name: 'كيمياء حيوية', time: '11:00 - 12:30', teacher: 'د. علي', room: 'مختبر 3'),
    ],
  };

  static const List<String> dayNames = [
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد',
  ];

  /// يعيد رقم اليوم الحالي بصيغة تبدأ من الاثنين (0) إلى الأحد (6)
  static int todayIndex() {
    final weekday = DateTime.now().weekday; // 1=الاثنين...7=الأحد
    return weekday - 1;
  }

  static List<Subject> todaySubjects() {
    return schedule[todayIndex()] ?? [];
  }

  static String todayName() => dayNames[todayIndex()];
}