import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../physics_principle/device_model.dart';
import 'clinical_section.dart';
import 'widgets/clinical_table.dart';
import 'widgets/clinical_case.dart';
import 'content/xray_clinical.dart';
import 'content/ct_clinical.dart';
import 'content/mri_clinical.dart';
import 'content/ultrasound_clinical.dart';
import 'content/pet_clinical.dart';
import 'content/spect_clinical.dart';
import 'content/radiotherapy_clinical.dart';
import 'content/laser_clinical.dart';
import 'content/mammography_clinical.dart';
import 'content/fluoroscopy_clinical.dart';

class ClinicalDetailScreen extends StatelessWidget {
  final Device device;
  const ClinicalDetailScreen({super.key, required this.device});

  List<ClinicalSection> _getContent() {
    switch (device.id) {
      case 'xray':
        return xrayClinical;
      case 'ct':
        return ctClinical;
      case 'mri':
        return mriClinical;
      case 'us':
        return ultrasoundClinical;
      case 'pet':
        return petClinical;
      case 'spect':
        return spectClinical;
      case 'rt':
        return radiotherapyClinical;
      case 'laser':
        return laserClinical;
      case 'mammo':
        return mammographyClinical;
      case 'fluoro':
        return fluoroscopyClinical;
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
        title: Text('🏥 ${device.name}',
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
          const Text('الاستخدامات السريرية',
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

  Widget _buildSection(ClinicalSection section) {
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
          const Divider(height: 20),
          ...section.blocks.map(_buildBlock),
        ],
      ),
    );
  }

  Widget _buildBlock(ClinicalBlock block) {
    switch (block.type) {
      case ClinicalBlockType.text:
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(block.text ?? '',
              style: const TextStyle(
                  fontSize: 13.5, height: 1.7, color: AppColors.textDark)),
        );

      case ClinicalBlockType.bullets:
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
                      child: Text(item,
                          style: const TextStyle(
                              fontSize: 13.5,
                              height: 1.65,
                              color: AppColors.textDark)),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );

      case ClinicalBlockType.table:
        return ClinicalTableView(table: block.table!, color: device.color);

      case ClinicalBlockType.caseStudy:
        return ClinicalCaseCard(
            clinicalCase: block.caseStudy!, color: device.color);

      case ClinicalBlockType.note:
        return Container(
          margin: const EdgeInsets.only(top: 4, bottom: 8),
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
                child: Text(block.text ?? '',
                    style: TextStyle(
                        fontSize: 12.5,
                        height: 1.6,
                        color: Colors.brown.shade800,
                        fontStyle: FontStyle.italic)),
              ),
            ],
          ),
        );

      case ClinicalBlockType.danger:
        return Container(
          margin: const EdgeInsets.only(top: 4, bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('⚠️', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(block.text ?? '',
                    style: TextStyle(
                        fontSize: 12.5,
                        height: 1.6,
                        color: Colors.red.shade800,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        );
    }
  }
}