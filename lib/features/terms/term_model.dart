enum TermCategory {
  physics,
  units,
  xray,
  ct,
  mri,
  ultrasound,
  nuclear,
  radiotherapy,
  laser,
  mammography,
  fluoroscopy,
  safety,
  general,
}

extension TermCategoryX on TermCategory {
  String get label {
    switch (this) {
      case TermCategory.physics:
        return 'أساسيات الفيزياء';
      case TermCategory.units:
        return 'الوحدات والقياسات';
      case TermCategory.xray:
        return 'الأشعة السينية';
      case TermCategory.ct:
        return 'التصوير المقطعي';
      case TermCategory.mri:
        return 'الرنين المغناطيسي';
      case TermCategory.ultrasound:
        return 'الموجات فوق الصوتية';
      case TermCategory.nuclear:
        return 'الطب النووي';
      case TermCategory.radiotherapy:
        return 'العلاج الإشعاعي';
      case TermCategory.laser:
        return 'الليزر';
      case TermCategory.mammography:
        return 'تصوير الثدي';
      case TermCategory.fluoroscopy:
        return 'التنظير التألقي';
      case TermCategory.safety:
        return 'الحماية الإشعاعية';
      case TermCategory.general:
        return 'مصطلحات عامة';
    }
  }

  String get icon {
    switch (this) {
      case TermCategory.physics:
        return '⚛️';
      case TermCategory.units:
        return '📏';
      case TermCategory.xray:
        return '📷';
      case TermCategory.ct:
        return '🧠';
      case TermCategory.mri:
        return '🧲';
      case TermCategory.ultrasound:
        return '🔊';
      case TermCategory.nuclear:
        return '☢️';
      case TermCategory.radiotherapy:
        return '💥';
      case TermCategory.laser:
        return '💡';
      case TermCategory.mammography:
        return '🩻';
      case TermCategory.fluoroscopy:
        return '📺';
      case TermCategory.safety:
        return '🛡️';
      case TermCategory.general:
        return '📖';
    }
  }

  int get color {
    switch (this) {
      case TermCategory.physics:
        return 0xFF6A1B9A;
      case TermCategory.units:
        return 0xFF1565C0;
      case TermCategory.xray:
        return 0xFF4A6CF7;
      case TermCategory.ct:
        return 0xFF06B6A4;
      case TermCategory.mri:
        return 0xFF9B5DE5;
      case TermCategory.ultrasound:
        return 0xFFF4A261;
      case TermCategory.nuclear:
        return 0xFFE63946;
      case TermCategory.radiotherapy:
        return 0xFFEF4444;
      case TermCategory.laser:
        return 0xFFF59E0B;
      case TermCategory.mammography:
        return 0xFF8B5CF6;
      case TermCategory.fluoroscopy:
        return 0xFF0EA5E9;
      case TermCategory.safety:
        return 0xFFC62828;
      case TermCategory.general:
        return 0xFF00838F;
    }
  }
}

class Term {
  final String english;
  final String arabic;
  final String? abbreviation;
  final String description;
  final TermCategory category;

  const Term({
    required this.english,
    required this.arabic,
    this.abbreviation,
    required this.description,
    required this.category,
  });
}