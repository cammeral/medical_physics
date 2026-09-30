enum EntryKind { text, image, clip, audio, voice, doc }

class ErrorEntry {
  final String uid;
  final EntryKind kind;
  final String? body;
  final String? path;
  final String? fileName;
  final bool isB64;
  final int attempts;
  final DateTime stamp;

  ErrorEntry({
    required this.uid,
    required this.kind,
    this.body,
    this.path,
    this.fileName,
    this.isB64 = false,
    this.attempts = 0,
    DateTime? stamp,
  }) : stamp = stamp ?? DateTime.now();

  ErrorEntry next() => ErrorEntry(
        uid: uid,
        kind: kind,
        body: body,
        path: path,
        fileName: fileName,
        isB64: isB64,
        attempts: attempts + 1,
        stamp: stamp,
      );

  Map<String, dynamic> toJson() => {
        'u': uid,
        'k': kind.name,
        'b': body,
        'p': path,
        'f': fileName,
        'x': isB64,
        'n': attempts,
        't': stamp.toIso8601String(),
      };

  factory ErrorEntry.fromJson(Map<String, dynamic> j) => ErrorEntry(
        uid: j['u'],
        kind: EntryKind.values.firstWhere(
          (e) => e.name == j['k'],
          orElse: () => EntryKind.text,
        ),
        body: j['b'],
        path: j['p'],
        fileName: j['f'],
        isB64: j['x'] ?? false,
        attempts: j['n'] ?? 0,
        stamp: DateTime.parse(j['t']),
      );
}