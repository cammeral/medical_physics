import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../physics_principle/device_model.dart';
import 'error_model.dart';
import 'widgets/error_card.dart';
import 'content/xray_errors.dart';
import 'content/ct_errors.dart';
import 'content/mri_errors.dart';
import 'content/ultrasound_errors.dart';
import 'content/pet_errors.dart';
import 'content/spect_errors.dart';
import 'content/radiotherapy_errors.dart';
import 'content/laser_errors.dart';
import 'content/mammography_errors.dart';
import 'content/fluoroscopy_errors.dart';

class ErrorListScreen extends StatefulWidget {
  final Device device;
  const ErrorListScreen({super.key, required this.device});

  @override
  State<ErrorListScreen> createState() => _ErrorListScreenState();
}

class _ErrorListScreenState extends State<ErrorListScreen> {
  ErrorSeverity? _filter;

  DeviceErrors? _getContent() {
    switch (widget.device.id) {
      case 'xray':
        return xrayErrors;
      case 'ct':
        return ctErrors;
      case 'mri':
        return mriErrors;
      case 'us':
        return ultrasoundErrors;
      case 'pet':
        return petErrors;
      case 'spect':
        return spectErrors;
      case 'rt':
        return radiotherapyErrors;
      case 'laser':
        return laserErrors;
      case 'mammo':
        return mammographyErrors;
      case 'fluoro':
        return fluoroscopyErrors;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = _getContent();

    if (content == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: widget.device.color,
          foregroundColor: Colors.white,
          title: Text('⚠️ ${widget.device.name}'),
        ),
        body: const Center(
          child: Text('المحتوى قادم قريباً',
              style: TextStyle(fontSize: 16)),
        ),
      );
    }

    final filtered = _filter == null
        ? content.errors
        : content.errors.where((e) => e.severity == _filter).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: widget.device.color,
        foregroundColor: Colors.white,
        title: Text('⚠️ ${widget.device.name}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(content.errors.length),
          const SizedBox(height: 12),
          _buildFilters(),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline,
                    color: widget.device.color, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    content.intro,
                    style: const TextStyle(
                        fontSize: 12.5,
                        height: 1.65,
                        color: AppColors.textDark),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                _filter == null
                    ? 'كل الأخطاء'
                    : 'تصفية: ${_filter!.label}',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: widget.device.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${filtered.length}',
                  style: TextStyle(
                      fontSize: 11,
                      color: widget.device.color,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (filtered.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('لا توجد أخطاء في هذه الفئة',
                    style: TextStyle(color: AppColors.textLight)),
              ),
            )
          else
            ...filtered.asMap().entries.map((e) => ErrorCard(
                  error: e.value,
                  color: widget.device.color,
                  index: e.key,
                )),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHeader(int total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.device.color,
            widget.device.color.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Text(widget.device.emoji,
              style: const TextStyle(fontSize: 40)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أخطاء ${widget.device.name}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '$total خطأ/مشكلة شائعة',
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _chip(null, 'الكل', '🎯'),
          const SizedBox(width: 8),
          _chip(ErrorSeverity.high, 'عالية', '🔴'),
          const SizedBox(width: 8),
          _chip(ErrorSeverity.medium, 'متوسطة', '🟡'),
          const SizedBox(width: 8),
          _chip(ErrorSeverity.low, 'منخفضة', '🟢'),
        ],
      ),
    );
  }

  Widget _chip(ErrorSeverity? severity, String label, String emoji) {
    final selected = _filter == severity;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => setState(() => _filter = severity),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? widget.device.color : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? widget.device.color
                : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 13)),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: selected ? Colors.white : AppColors.textDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}