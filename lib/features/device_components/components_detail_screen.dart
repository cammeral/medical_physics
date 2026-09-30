import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../physics_principle/device_model.dart';
import 'component_section.dart';
import 'widgets/component_image.dart';
import 'content/xray_components.dart';
import 'content/ct_components.dart';
import 'content/mri_components.dart';
import 'content/ultrasound_components.dart';
import 'content/pet_components.dart';
import 'content/spect_components.dart';
import 'content/radiotherapy_components.dart';
import 'content/laser_components.dart';
import 'content/mammography_components.dart';
import 'content/fluoroscopy_components.dart';

class ComponentsDetailScreen extends StatelessWidget {
  final Device device;
  const ComponentsDetailScreen({super.key, required this.device});

  List<ComponentSection> _getContent() {
    switch (device.id) {
      case 'xray':
        return xrayComponents;
      case 'ct':
        return ctComponents;
      case 'mri':
        return mriComponents;
      case 'us':
        return ultrasoundComponents;
      case 'pet':
        return petComponents;
      case 'spect':
        return spectComponents;
      case 'rt':
        return radiotherapyComponents;
      case 'laser':
        return laserComponents;
      case 'mammo':
        return mammographyComponents;
      case 'fluoro':
        return fluoroscopyComponents;
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
          '🔧 ${device.name}',
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
            'مكونات الجهاز',
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
        ],
      ),
    );
  }

  Widget _buildSection(ComponentSection section) {
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

          // صورة القسم (إن وُجدت)
          if (section.imageUrl != null) ...[
            const SizedBox(height: 12),
            ComponentImage(
              url: section.imageUrl,
              fallbackIcon: section.icon,
              color: device.color,
              height: 180,
            ),
          ],

          // مقدمة
          if (section.intro != null) ...[
            const SizedBox(height: 10),
            Text(
              section.intro!,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.7,
                color: AppColors.textDark,
              ),
            ),
          ],

          const Divider(height: 24),

          // قائمة المكونات
          ...section.items.map((item) => _buildComponentItem(item)),

          // ملاحظات
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
                          child: Text(
                            n,
                            style: TextStyle(
                              fontSize: 12.5,
                              height: 1.6,
                              color: Colors.brown.shade800,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildComponentItem(ComponentItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: device.color.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: device.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(item.icon, style: const TextStyle(fontSize: 16)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.description,
            style: const TextStyle(
              fontSize: 13,
              height: 1.65,
              color: AppColors.textDark,
            ),
          ),

          // صورة المكوّن (إن وجدت)
          if (item.imageUrl != null) ...[
            const SizedBox(height: 10),
            ComponentImage(
              url: item.imageUrl,
              fallbackIcon: item.icon,
              color: device.color,
              height: 140,
            ),
          ],
        ],
      ),
    );
  }
}