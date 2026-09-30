import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../physics_principle/device_model.dart';
import 'procedure_model.dart';
import 'procedure_detail_screen.dart';
import 'widgets/procedure_card.dart';
import 'widgets/procedure_table.dart';
import 'content/xray_procedures.dart';
import 'content/ct_procedures.dart';
import 'content/mri_procedures.dart';
import 'content/ultrasound_procedures.dart';
import 'content/pet_procedures.dart';
import 'content/spect_procedures.dart';
import 'content/radiotherapy_procedures.dart';
import 'content/laser_procedures.dart';
import 'content/mammography_procedures.dart';
import 'content/fluoroscopy_procedures.dart';

class ProcedureListScreen extends StatefulWidget {
  final Device device;
  const ProcedureListScreen({super.key, required this.device});

  @override
  State<ProcedureListScreen> createState() => _ProcedureListScreenState();
}

class _ProcedureListScreenState extends State<ProcedureListScreen> {
  ProcedureType? _filter;

  ProceduresData? _getContent() {
    switch (widget.device.id) {
      case 'xray':
        return xrayProcedures;
      case 'ct':
        return ctProcedures;
      case 'mri':
        return mriProcedures;
      case 'us':
        return ultrasoundProcedures;
      case 'pet':
        return petProcedures;
      case 'spect':
        return spectProcedures;
      case 'rt':
        return radiotherapyProcedures;
      case 'laser':
        return laserProcedures;
      case 'mammo':
        return mammographyProcedures;
      case 'fluoro':
        return fluoroscopyProcedures;
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
          title: Text('🎯 ${widget.device.name}'),
        ),
        body: const Center(
          child: Text('المحتوى قادم قريباً',
              style: TextStyle(fontSize: 16)),
        ),
      );
    }

    final filtered = _filter == null
        ? content.procedures
        : content.procedures.where((p) => p.type == _filter).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: widget.device.color,
        foregroundColor: Colors.white,
        title: Text('🎯 ${widget.device.name}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // رأس مختصر
          _buildHeader(content.procedures.length),
          const SizedBox(height: 12),

          // الفلاتر
          _buildFilters(),

          const SizedBox(height: 12),

          // المقدمة
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

          // العنوان
          Row(
            children: [
              Text(
                _filter == null ? 'كل الفحوصات' : 'تصفية: ${_filter!.label}',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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

          // البطاقات
          if (filtered.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('لا توجد فحوصات في هذه الفئة',
                    style: TextStyle(color: AppColors.textLight)),
              ),
            )
          else
            ...filtered.map((p) => ProcedureCard(
                  procedure: p,
                  color: widget.device.color,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProcedureDetailScreen(
                        procedure: p,
                        deviceColor: widget.device.color,
                        deviceName: widget.device.name,
                      ),
                    ),
                  ),
                )),

          // جدول المقارنة
          if (content.comparisonTable != null &&
              content.comparisonHeaders != null) ...[
            const SizedBox(height: 8),
            const Text(
              '📊 جدول المقارنة السريع',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark),
            ),
            const SizedBox(height: 6),
            ProcedureTableView(
              headers: content.comparisonHeaders!,
              rows: content.comparisonTable!,
              color: widget.device.color,
            ),
          ],
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
                  'أنواع فحوصات ${widget.device.name}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '$total فحص/إجراء مختلف',
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
          _filterChip(null, 'الكل', '🎯'),
          const SizedBox(width: 8),
          _filterChip(ProcedureType.diagnostic, 'تشخيصي', '🔍'),
          const SizedBox(width: 8),
          _filterChip(ProcedureType.interventional, 'تداخلي', '💉'),
          const SizedBox(width: 8),
          _filterChip(ProcedureType.functional, 'وظيفي', '📊'),
          const SizedBox(width: 8),
          _filterChip(ProcedureType.therapeutic, 'علاجي', '💊'),
        ],
      ),
    );
  }

  Widget _filterChip(ProcedureType? type, String label, String emoji) {
    final selected = _filter == type;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => setState(() => _filter = type),
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