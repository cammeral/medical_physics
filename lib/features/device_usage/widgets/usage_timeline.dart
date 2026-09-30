import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../usage_section.dart';

class UsageTimeline extends StatelessWidget {
  final List<UsageStage> stages;
  final Color color;

  const UsageTimeline({
    super.key,
    required this.stages,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Icon(Icons.timeline, color: AppColors.primary, size: 18),
                SizedBox(width: 6),
                Text(
                  'نظرة عامة على الفحص',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          // الشريط الزمني
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < stages.length; i++) ...[
                  _timelineNode(stages[i], i + 1),
                  if (i < stages.length - 1)
                    Container(
                      width: 24,
                      height: 2,
                      margin: const EdgeInsets.only(bottom: 22),
                      color: color.withValues(alpha: 0.3),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _timelineNode(UsageStage stage, int number) {
    return SizedBox(
      width: 92,
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            stage.icon,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 2),
          Text(
            stage.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            stage.duration,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}