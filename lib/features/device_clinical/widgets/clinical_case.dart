import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../clinical_section.dart';

class ClinicalCaseCard extends StatelessWidget {
  final ClinicalCase clinicalCase;
  final Color color;

  const ClinicalCaseCard({
    super.key,
    required this.clinicalCase,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // رأس الحالة
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Text('🏥', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    clinicalCase.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // المحتوى
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _row('🧑‍🦱', 'المريض', clinicalCase.patient),
                const SizedBox(height: 8),
                _row('🩺', 'الأعراض', clinicalCase.presentation),
                const SizedBox(height: 8),
                _row('🔍', 'النتيجة', clinicalCase.finding),
                const SizedBox(height: 8),
                _row('🎯', 'التشخيص', clinicalCase.diagnosis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String emoji, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.55,
              color: AppColors.textDark,
            ),
          ),
        ),
      ],
    );
  }
}