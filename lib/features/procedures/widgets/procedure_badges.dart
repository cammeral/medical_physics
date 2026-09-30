import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../procedure_model.dart';

class ProcedureBadges extends StatelessWidget {
  final Procedure procedure;
  final Color color;
  final bool compact;

  const ProcedureBadges({
    super.key,
    required this.procedure,
    required this.color,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        _badge('🕐', procedure.duration, AppColors.textLight),
        _badge('🍽️', procedure.preparation, const Color(0xFF7B5800)),
        _badge('💉', procedure.contrast, const Color(0xFF6A1B9A)),
        _badge('☢️', procedure.doseLevel, _doseColor()),
      ],
    );
  }

  Color _doseColor() {
    if (procedure.doseLevel.contains('صفر')) return const Color(0xFF2E7D32);
    if (procedure.doseLevel.contains('منخفض')) return const Color(0xFF06B6A4);
    if (procedure.doseLevel.contains('متوسط')) return const Color(0xFFF4A261);
    return const Color(0xFFE63946);
  }

  Widget _badge(String icon, String text, Color c) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 6 : 8,
        vertical: compact ? 3 : 4,
      ),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: TextStyle(fontSize: compact ? 10 : 11)),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: compact ? 10 : 11,
              color: c,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}