import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'device_model.dart';
import 'principle_section.dart';
import 'content/xray_content.dart';
import 'content/ct_content.dart';
import 'content/mri_content.dart';
import 'content/ultrasound_content.dart';
import 'content/pet_content.dart';
import 'content/spect_content.dart';
import 'content/radiotherapy_content.dart';
import 'content/laser_content.dart';
import 'content/mammography_content.dart';
import 'content/fluoroscopy_content.dart';

class DevicePrincipleScreen extends StatelessWidget {
  final Device device;
  const DevicePrincipleScreen({super.key, required this.device});

  List<PrincipleSection> _getContent() {
    switch (device.id) {
      case 'xray':
        return xrayPrincipleContent;
      case 'ct':
        return ctPrincipleContent;
      case 'mri':
        return mriPrincipleContent;
      case 'us':
        return ultrasoundPrincipleContent;
      case 'pet':
        return petPrincipleContent;
      case 'spect':
        return spectPrincipleContent;
      case 'rt':
        return radiotherapyPrincipleContent;
      case 'laser':
        return laserPrincipleContent;
      case 'mammo':
        return mammographyPrincipleContent;
      case 'fluoro':
        return fluoroscopyPrincipleContent;
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
        title: Text(
          '${device.emoji} ${device.name}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
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
          Text(
            device.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            device.arabic,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
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
          Text(
            'المحتوى قادم قريباً',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'سنبني هذا القسم خطوة بخطوة',
            style: TextStyle(color: AppColors.textLight, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(PrincipleSection section) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان القسم
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
          const Divider(height: 20),
          // محتوى القسم
          ...section.blocks.map(_buildBlock),
        ],
      ),
    );
  }

  Widget _buildBlock(Block block) {
    switch (block.type) {
      case BlockType.text:
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            block.text ?? '',
            style: const TextStyle(
              fontSize: 14,
              height: 1.7,
              color: AppColors.textDark,
            ),
          ),
        );

      case BlockType.bullets:
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (block.items ?? []).map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8, right: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: device.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );

      case BlockType.equation:
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: device.color.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: device.color.withValues(alpha: 0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                block.text ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: device.color,
                  fontFamily: 'monospace',
                ),
              ),
              if (block.note != null) ...[
                const SizedBox(height: 8),
                Text(
                  block.note!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textLight,
                    height: 1.5,
                  ),
                ),
              ],
            ],
          ),
        );

      case BlockType.note:
        return Container(
          margin: const EdgeInsets.only(top: 4, bottom: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('💡', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  block.text ?? '',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.6,
                    color: Colors.brown.shade800,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }
}