import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../physics_principle/device_model.dart';
import 'usage_section.dart';
import 'widgets/usage_timeline.dart';
import 'widgets/usage_stage_card.dart';
import 'content/xray_usage.dart';
import 'content/ct_usage.dart';
import 'content/mri_usage.dart';
import 'content/ultrasound_usage.dart';
import 'content/pet_usage.dart';
import 'content/spect_usage.dart';
import 'content/radiotherapy_usage.dart';
import 'content/laser_usage.dart';
import 'content/mammography_usage.dart';
import 'content/fluoroscopy_usage.dart';

class UsageDetailScreen extends StatelessWidget {
  final Device device;
  const UsageDetailScreen({super.key, required this.device});

  UsageContent? _getContent() {
    switch (device.id) {
      case 'xray':
        return xrayUsage;
      case 'ct':
        return ctUsage;
      case 'mri':
        return mriUsage;
      case 'us':
        return ultrasoundUsage;
      case 'pet':
        return petUsage;
      case 'spect':
        return spectUsage;
      case 'rt':
        return radiotherapyUsage;
      case 'laser':
        return laserUsage;
      case 'mammo':
        return mammographyUsage;
      case 'fluoro':
        return fluoroscopyUsage;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = _getContent();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: device.color,
        foregroundColor: Colors.white,
        title: Text('👨‍⚕️ ${device.name}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: content == null
          ? _buildComingSoon()
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                // Timeline
                UsageTimeline(stages: content.stages, color: device.color),
                const SizedBox(height: 16),
                // المقدمة
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline,
                          color: device.color, size: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          content.intro,
                          style: const TextStyle(
                            fontSize: 13,
                            height: 1.7,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    'المراحل التفصيلية',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // المراحل
                ...content.stages.asMap().entries.map((e) => UsageStageCard(
                      stage: e.value,
                      index: e.key + 1,
                      color: device.color,
                      initiallyExpanded: e.key == 0,
                    )),
                const SizedBox(height: 24),
              ],
            ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [device.color, device.color.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(device.emoji, style: const TextStyle(fontSize: 52)),
          const SizedBox(height: 8),
          Text(device.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          const Text('خطوات الاستخدام العملية',
              style: TextStyle(color: Colors.white70, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildComingSoon() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.construction, size: 64, color: device.color),
            const SizedBox(height: 12),
            const Text(
              'المحتوى قادم قريباً',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}