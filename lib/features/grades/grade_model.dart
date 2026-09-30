enum GradeType { exam, quiz, homework, project, participation, other }

extension GradeTypeX on GradeType {
  String get label {
    switch (this) {
      case GradeType.exam:
        return 'امتحان';
      case GradeType.quiz:
        return 'اختبار قصير';
      case GradeType.homework:
        return 'واجب';
      case GradeType.project:
        return 'مشروع';
      case GradeType.participation:
        return 'مشاركة';
      case GradeType.other:
        return 'أخرى';
    }
  }

  String get emoji {
    switch (this) {
      case GradeType.exam:
        return '📝';
      case GradeType.quiz:
        return '⚡';
      case GradeType.homework:
        return '📚';
      case GradeType.project:
        return '🎨';
      case GradeType.participation:
        return '🙋';
      case GradeType.other:
        return '📌';
    }
  }
}

class Grade {
  final String id;
  final String title;
  final double value;
  final double max;
  final double weight;
  final GradeType type;
  final DateTime date;

  Grade({
    required this.id,
    required this.title,
    required this.value,
    required this.max,
    required this.weight,
    required this.type,
    required this.date,
  });

  double get percentage => max == 0 ? 0 : (value / max) * 100;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'value': value,
        'max': max,
        'weight': weight,
        'type': type.name,
        'date': date.toIso8601String(),
      };

  factory Grade.fromJson(Map<String, dynamic> j) => Grade(
        id: j['id'],
        title: j['title'],
        value: (j['value'] as num).toDouble(),
        max: (j['max'] as num).toDouble(),
        weight: (j['weight'] as num).toDouble(),
        type: GradeType.values.firstWhere(
          (e) => e.name == j['type'],
          orElse: () => GradeType.other,
        ),
        date: DateTime.parse(j['date']),
      );
}

class Subject {
  final String id;
  final String name;
  final List<Grade> grades;
  final String? manualTextGrade;
  final String? notes;

  Subject({
    required this.id,
    required this.name,
    required this.grades,
    this.manualTextGrade,
    this.notes,
  });

  double? get weightedAverage {
    if (grades.isEmpty) return null;
    double sum = 0;
    double totalWeight = 0;
    for (final g in grades) {
      sum += g.percentage * g.weight;
      totalWeight += g.weight;
    }
    if (totalWeight == 0) return null;
    return sum / totalWeight;
  }

  String get autoTextGrade {
    final avg = weightedAverage;
    if (avg == null) return '—';
    if (avg >= 90) return 'ممتاز';
    if (avg >= 80) return 'جيد جداً';
    if (avg >= 70) return 'جيد';
    if (avg >= 60) return 'متوسط';
    if (avg >= 50) return 'مقبول';
    return 'راسب';
  }

  String get displayTextGrade =>
      manualTextGrade ?? autoTextGrade;

  Subject copyWith({
    String? name,
    List<Grade>? grades,
    String? manualTextGrade,
    String? notes,
  }) {
    return Subject(
      id: id,
      name: name ?? this.name,
      grades: grades ?? this.grades,
      manualTextGrade: manualTextGrade ?? this.manualTextGrade,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'grades': grades.map((e) => e.toJson()).toList(),
        'manualTextGrade': manualTextGrade,
        'notes': notes,
      };

  factory Subject.fromJson(Map<String, dynamic> j) => Subject(
        id: j['id'],
        name: j['name'],
        grades: (j['grades'] as List)
            .map((e) => Grade.fromJson(e))
            .toList(),
        manualTextGrade: j['manualTextGrade'],
        notes: j['notes'],
      );
}

class StudentProfile {
  String name;
  String university;
  String department;
  String academicYear;
  String? motivationalMessage;

  StudentProfile({
    this.name = '',
    this.university = '',
    this.department = '',
    this.academicYear = '',
    this.motivationalMessage,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'university': university,
        'department': department,
        'academicYear': academicYear,
        'motivationalMessage': motivationalMessage,
      };

  factory StudentProfile.fromJson(Map<String, dynamic> j) => StudentProfile(
        name: j['name'] ?? '',
        university: j['university'] ?? '',
        department: j['department'] ?? '',
        academicYear: j['academicYear'] ?? '',
        motivationalMessage: j['motivationalMessage'],
      );
}