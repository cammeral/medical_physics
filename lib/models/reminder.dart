enum ReminderType { homework, exam, report }

class Reminder {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final ReminderType type;
  final bool done;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.type,
    this.done = false,
  });

  Reminder copyWith({bool? done}) => Reminder(
        id: id,
        title: title,
        description: description,
        dueDate: dueDate,
        type: type,
        done: done ?? this.done,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'dueDate': dueDate.toIso8601String(),
        'type': type.name,
        'done': done,
      };

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        dueDate: DateTime.parse(json['dueDate']),
        type: ReminderType.values.firstWhere((e) => e.name == json['type']),
        done: json['done'] ?? false,
      );
}