class Note {
  final String id;
  final String title;
  final String content;
  final String colorHex;
  final String? time;
  final DateTime date;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.colorHex = 'F59E0B',
    this.time,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'colorHex': colorHex,
        'time': time,
        'date': date.toIso8601String(),
      };

  factory Note.fromJson(Map<String, dynamic> j) => Note(
        id: j['id'],
        title: j['title'],
        content: j['content'],
        colorHex: j['colorHex'] ?? 'F59E0B',
        time: j['time'],
        date: DateTime.parse(j['date']),
      );
}