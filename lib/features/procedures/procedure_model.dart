enum ProcedureType { diagnostic, interventional, functional, therapeutic }

extension ProcedureTypeX on ProcedureType {
  String get label {
    switch (this) {
      case ProcedureType.diagnostic:
        return 'تشخيصي';
      case ProcedureType.interventional:
        return 'تداخلي';
      case ProcedureType.functional:
        return 'وظيفي';
      case ProcedureType.therapeutic:
        return 'علاجي';
    }
  }

  String get emoji {
    switch (this) {
      case ProcedureType.diagnostic:
        return '🔍';
      case ProcedureType.interventional:
        return '💉';
      case ProcedureType.functional:
        return '📊';
      case ProcedureType.therapeutic:
        return '💊';
    }
  }
}

class Procedure {
  final String id;
  final String icon;
  final String nameEn;
  final String nameAr;
  final String shortDesc;
  final ProcedureType type;
  final String duration;
  final String preparation;
  final String contrast;
  final String doseLevel;
  final List<String> indications;
  final List<String> preparationSteps;
  final String? notes;

  const Procedure({
    required this.id,
    required this.icon,
    required this.nameEn,
    required this.nameAr,
    required this.shortDesc,
    required this.type,
    required this.duration,
    required this.preparation,
    required this.contrast,
    required this.doseLevel,
    required this.indications,
    required this.preparationSteps,
    this.notes,
  });
}

class ProceduresData {
  final String deviceId;
  final String intro;
  final List<Procedure> procedures;
  final List<List<String>>? comparisonTable;
  final List<String>? comparisonHeaders;

  const ProceduresData({
    required this.deviceId,
    required this.intro,
    required this.procedures,
    this.comparisonTable,
    this.comparisonHeaders,
  });
}