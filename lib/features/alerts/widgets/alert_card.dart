import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../alert_model.dart';

class AlertCard extends StatelessWidget {
  final Alert alert;
  final VoidCallback onDelete;
  final bool isPast;

  const AlertCard({
    super.key,
    required this.alert,
    required this.onDelete,
    this.isPast = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(alert.type.color);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isPast
              ? Colors.grey.shade200
              : color.withValues(alpha: 0.3),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(alert.type.emoji,
                  style: const TextStyle(fontSize: 22)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alert.title,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      color:
                          isPast ? AppColors.textLight : AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_rounded,
                          size: 11, color: color),
                      const SizedBox(width: 4),
                      Text(
                        '${alert.dateTime.day}/${alert.dateTime.month}',
                        style: TextStyle(
                            fontSize: 11.5,
                            color: color,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.access_time_rounded,
                          size: 11, color: color),
                      const SizedBox(width: 4),
                      Text(
                        '${alert.dateTime.hour.toString().padLeft(2, '0')}:${alert.dateTime.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(
                            fontSize: 11.5,
                            color: color,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  if (!isPast) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        alert.timeLeftLabel,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded,
                  size: 20, color: AppColors.textLight),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}