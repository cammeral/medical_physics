import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../procedure_model.dart';
import 'procedure_badges.dart';

class ProcedureCard extends StatelessWidget {
  final Procedure procedure;
  final Color color;
  final VoidCallback onTap;

  const ProcedureCard({
    super.key,
    required this.procedure,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الرأس: أيقونة + الاسم + النوع
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(procedure.icon,
                          style: const TextStyle(fontSize: 22)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            procedure.nameAr,
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            procedure.nameEn,
                            style: TextStyle(
                              fontSize: 11.5,
                              color: AppColors.textLight,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // شارة النوع
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(procedure.type.emoji,
                              style: const TextStyle(fontSize: 10)),
                          const SizedBox(width: 3),
                          Text(
                            procedure.type.label,
                            style: TextStyle(
                              fontSize: 10.5,
                              color: color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // الوصف
                Text(
                  procedure.shortDesc,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.6,
                    color: AppColors.textDark,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                // الشارات
                ProcedureBadges(procedure: procedure, color: color, compact: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}