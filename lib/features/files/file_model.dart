enum FileKind { book, image, video, audio, document, archive, other }

extension FileKindX on FileKind {
  String get label {
    switch (this) {
      case FileKind.book: return 'كتاب';
      case FileKind.image: return 'صورة';
      case FileKind.video: return 'فيديو';
      case FileKind.audio: return 'صوت';
      case FileKind.document: return 'مستند';
      case FileKind.archive: return 'أرشيف';
      case FileKind.other: return 'ملف';
    }
  }

  String get emoji {
    switch (this) {
      case FileKind.book: return '📖';
      case FileKind.image: return '🖼️';
      case FileKind.video: return '🎬';
      case FileKind.audio: return '🎵';
      case FileKind.document: return '📄';
      case FileKind.archive: return '📦';
      case FileKind.other: return '📎';
    }
  }

  int get color {
    switch (this) {
      case FileKind.book: return 0xFF9B5DE5;
      case FileKind.image: return 0xFF06B6A4;
      case FileKind.video: return 0xFFE63946;
      case FileKind.audio: return 0xFFF59E0B;
      case FileKind.document: return 0xFF4A6CF7;
      case FileKind.archive: return 0xFF6B7280;
      case FileKind.other: return 0xFF7C3AED;
    }
  }
}

FileKind kindFromExtension(String ext) {
  final e = ext.toLowerCase();
  if (['pdf', 'epub', 'mobi', 'djvu'].contains(e)) return FileKind.book;
  if (['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp', 'heic'].contains(e)) {
    return FileKind.image;
  }
  if (['mp4', 'mov', 'avi', 'mkv', 'webm', 'flv'].contains(e)) {
    return FileKind.video;
  }
  if (['mp3', 'wav', 'aac', 'ogg', 'm4a', 'flac'].contains(e)) {
    return FileKind.audio;
  }
  if (['doc', 'docx', 'txt', 'rtf', 'odt', 'xls', 'xlsx', 'ppt', 'pptx']
      .contains(e)) {
    return FileKind.document;
  }
  if (['zip', 'rar', '7z', 'tar', 'gz'].contains(e)) {
    return FileKind.archive;
  }
  return FileKind.other;
}

class Folder {
  final String id;
  final String name;
  final String emoji;
  final bool isCustom;
  final DateTime createdAt;

  Folder({
    required this.id,
    required this.name,
    required this.emoji,
    this.isCustom = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'emoji': emoji,
        'isCustom': isCustom,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Folder.fromJson(Map<String, dynamic> j) => Folder(
        id: j['id'],
        name: j['name'],
        emoji: j['emoji'] ?? '📁',
        isCustom: j['isCustom'] ?? false,
        createdAt: DateTime.parse(j['createdAt']),
      );
}

class StoredFile {
  final String id;
  final String name;
  final String extension;
  final int size;
  final FileKind kind;
  final String folderId;
  final String? storedPath; // مسار محلي (أو base64 على الويب)
  final bool isBase64;
  final bool isLocked;
  final DateTime createdAt;
  final String? note;

  StoredFile({
    required this.id,
    required this.name,
    required this.extension,
    required this.size,
    required this.kind,
    required this.folderId,
    this.storedPath,
    this.isBase64 = false,
    this.isLocked = false,
    DateTime? createdAt,
    this.note,
  }) : createdAt = createdAt ?? DateTime.now();

  StoredFile copyWith({
    String? name,
    bool? isLocked,
    String? folderId,
    String? note,
  }) {
    return StoredFile(
      id: id,
      name: name ?? this.name,
      extension: extension,
      size: size,
      kind: kind,
      folderId: folderId ?? this.folderId,
      storedPath: storedPath,
      isBase64: isBase64,
      isLocked: isLocked ?? this.isLocked,
      createdAt: createdAt,
      note: note ?? this.note,
    );
  }

  String get sizeLabel {
    if (size < 1024) return '$size B';
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(1)} KB';
    if (size < 1024 * 1024 * 1024) {
      return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(size / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'extension': extension,
        'size': size,
        'kind': kind.name,
        'folderId': folderId,
        'storedPath': storedPath,
        'isBase64': isBase64,
        'isLocked': isLocked,
        'createdAt': createdAt.toIso8601String(),
        'note': note,
      };

  factory StoredFile.fromJson(Map<String, dynamic> j) => StoredFile(
        id: j['id'],
        name: j['name'],
        extension: j['extension'],
        size: j['size'],
        kind: FileKind.values.firstWhere(
          (e) => e.name == j['kind'],
          orElse: () => FileKind.other,
        ),
        folderId: j['folderId'],
        storedPath: j['storedPath'],
        isBase64: j['isBase64'] ?? false,
        isLocked: j['isLocked'] ?? false,
        createdAt: DateTime.parse(j['createdAt']),
        note: j['note'],
      );
}