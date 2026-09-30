import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../class_model.dart';

class ClassCard extends StatelessWidget {
  final ClassItem item;
  final int index;
  final bool isToday;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ClassCard({
    super.key,
    required this.item,
    required this.index,
    required this.isToday,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse('FF${item.colorHex}', radix: 16));

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // شريط جانبي برقم المحاضرة
                Container(
                  width: 46,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '$index',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Text(
                        'رقم',
                        style: TextStyle(
                          fontSize: 9,
                          color: color.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // العنوان + زر الحذف
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.subject,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                          if (isToday)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.star_rounded,
                                      size: 11, color: color),
                                  const SizedBox(width: 3),
                                  Text(
                                    'اليوم',
                                    style: TextStyle(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.bold,
                                      color: color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // الوقت
                      Row(
                        children: [
                          _chip(
                            icon: Icons.access_time_rounded,
                            text: item.timeRange,
                            color: color,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // المكان + الأستاذ
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          if (item.location != null &&
                              item.location!.isNotEmpty)
                            _chip(
                              icon: Icons.location_on_rounded,
                              text: item.location!,
                              color: const Color(0xFF06B6A4),
                            ),
                          if (item.professor != null &&
                              item.professor!.isNotEmpty)
                            _chip(
                              icon: Icons.person_rounded,
                              text: item.professor!,
                              color: const Color(0xFF9B5DE5),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                // زر الحذف
                IconButton(
                  icon: const Icon(Icons.delete_outline_rounded,
                      size: 20, color: AppColors.textLight),
                  onPressed: onDelete,
                  tooltip: 'حذف',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _chip({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11.5,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}