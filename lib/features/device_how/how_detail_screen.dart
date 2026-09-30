import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../physics_principle/device_model.dart';
import 'how_section.dart';
import 'content/xray_how.dart';
import 'content/ct_how.dart';
import 'content/mri_how.dart';
import 'content/ultrasound_how.dart';
import 'content/pet_how.dart';
import 'content/spect_how.dart';
import 'content/radiotherapy_how.dart';
import 'content/laser_how.dart';
import 'content/mammography_how.dart';
import 'content/fluoroscopy_how.dart';
import 'widgets/local_video_card.dart';

class HowDetailScreen extends StatelessWidget {
  final Device device;
  const HowDetailScreen({super.key, required this.device});

  List<HowSection> _getContent() {
    switch (device.id) {
      case 'xray':
        return xrayHow;
      case 'ct':
        return ctHow;
      case 'mri':
        return mriHow;
      case 'us':
        return ultrasoundHow;
      case 'pet':
        return petHow;
      case 'spect':
        return spectHow;
      case 'rt':
        return radiotherapyHow;
      case 'laser':
        return laserHow;
      case 'mammo':
        return mammographyHow;
      case 'fluoro':
        return fluoroscopyHow;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final sections = _getContent();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: device.color,
        foregroundColor: Colors.white,
        title: Text('🔬 ${device.name}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          if (sections.isEmpty)
            _buildComingSoon()
          else
            ...sections.map((s) => _buildSection(s)),
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
          const Text('كيف يعمل الجهاز؟',
              style: TextStyle(color: Colors.white70, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildComingSoon() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        children: [
          Icon(Icons.construction, size: 48, color: AppColors.textLight),
          SizedBox(height: 12),
          Text('المحتوى قادم قريباً',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSection(HowSection section) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(section.icon, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  section.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: device.color,
                  ),
                ),
              ),
            ],
          ),
          if (section.intro != null) ...[
            const SizedBox(height: 10),
            Text(section.intro!,
                style: const TextStyle(
                    fontSize: 13.5, height: 1.7, color: AppColors.textDark)),
          ],
          const Divider(height: 24),
          ...section.steps.asMap().entries.map((e) =>
              _buildStep(e.key + 1, e.value)),
          if (section.notes != null && section.notes!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: section.notes!.map((n) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('💡', style: TextStyle(fontSize: 14)),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(n,
                              style: TextStyle(
                                  fontSize: 12.5,
                                  height: 1.6,
                                  color: Colors.brown.shade800,
                                  fontStyle: FontStyle.italic)),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
          // الفيديو
if (section.video != null)
  LocalVideoCard(video: section.video!, color: device.color),
        ],
      ),
    );
  }

  Widget _buildStep(int number, HowStep step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: device.color.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: device.color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('$number',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(step.icon, style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(step.title,
                          style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(step.description,
                    style: const TextStyle(
                        fontSize: 13, height: 1.65, color: AppColors.textDark)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}