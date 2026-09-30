enum ErrorSeverity { low, medium, high }

extension ErrorSeverityX on ErrorSeverity {
  String get label {
    switch (this) {
      case ErrorSeverity.low:
        return 'منخفضة';
      case ErrorSeverity.medium:
        return 'متوسطة';
      case ErrorSeverity.high:
        return 'عالية';
    }
  }

  String get emoji {
    switch (this) {
      case ErrorSeverity.low:
        return '🟢';
      case ErrorSeverity.medium:
        return '🟡';
      case ErrorSeverity.high:
        return '🔴';
    }
  }
}

class MedicalError {
  final String id;
  final String icon;
  final String title;
  final String subtitle;
  final ErrorSeverity severity;
  final String symptom;
  final String cause;
  final String solution;
  final String prevention;

  const MedicalError({
    required this.id,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.severity,
    required this.symptom,
    required this.cause,
    required this.solution,
    required this.prevention,
  });
}

class DeviceErrors {
  final String deviceId;
  final String intro;
  final List<MedicalError> errors;

  const DeviceErrors({
    required this.deviceId,
    required this.intro,
    required this.errors,
  });
}