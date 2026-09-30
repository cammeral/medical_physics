import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'tool_detail_screen.dart';
import '../features/physics_principle/physics_principle_screen.dart';
import '../features/device_components/device_components_screen.dart';
import '../features/device_how/device_how_screen.dart';
import '../features/device_clinical/device_clinical_screen.dart';
import '../features/device_usage/device_usage_screen.dart';
import '../features/procedures/procedures_screen.dart';
import '../features/radiation_safety/safety_screen.dart';
import '../features/errors/errors_screen.dart';
import '../features/terms/terms_screen.dart';


class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
final tools = [
  _ToolData('physics', '⚙️', 'المبدأ الفيزيائي',
      'الأساس الفيزيائي لعمل الأجهزة الطبية', AppColors.subject1),
  _ToolData('components', '🔧', 'مكونات الأجهزة',
      'الأجزاء الرئيسية لكل جهاز', AppColors.subject2),
  _ToolData('how', '🔬', 'كيف يعمل الجهاز',
      'شرح خطوات العمل خطوة بخطوة', AppColors.subject3),
  _ToolData('clinical', '🏥', 'الاستخدامات السريرية',
      'الاستخدامات الطبية العملية', AppColors.subject4),
  _ToolData('steps', '👨‍⚕️', 'خطوات الاستخدام',
      'طريقة تشغيل الجهاز بأمان', AppColors.subject5),
  _ToolData('types', '🎯', 'أنواع الفحوصات/العلاجات',
      'تصنيفات الفحوصات والعلاجات', AppColors.subject1),
  _ToolData('safety', '☢️', 'Radiation Safety',
      'قواعد الحماية الإشعاعية', AppColors.subject2),
  _ToolData('errors', '⚠️', 'الأخطاء والمشاكل',
      'الأعطال الشائعة وحلولها', AppColors.subject3),
  _ToolData('terms', '📚', 'المصطلحات',
      'قاموس المصطلحات الطبية الفيزيائية', AppColors.subject4),
];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text(
          'الأدوات التعليمية',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: tools.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (context, i) => _buildToolCard(context, tools[i]),
      ),
    );
  }

  Widget _buildToolCard(BuildContext context, _ToolData tool) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
onTap: () {
  if (tool.id == 'physics') {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const PhysicsPrincipleScreen()));
  } else if (tool.id == 'components') {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const DeviceComponentsScreen()));
  } else if (tool.id == 'how') {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const DeviceHowScreen()));
  } else if (tool.id == 'clinical') {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const DeviceClinicalScreen()));
  } else if (tool.id == 'steps') {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const DeviceUsageScreen()));
  } else if (tool.id == 'types') {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const ProceduresScreen()));
  } else if (tool.id == 'safety') {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const SafetyScreen()));
  } else if (tool.id == 'errors') {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const ErrorsScreen()));
  } else if (tool.id == 'terms') {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const TermsScreen()));
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ToolDetailScreen(
          emoji: tool.emoji,
          title: tool.title,
          subtitle: tool.subtitle,
          color: tool.color,
        ),
      ),
    );
  }
},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: tool.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(tool.emoji, style: const TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tool.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tool.subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 14, color: AppColors.textLight),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToolData {
  final String id;
  final String emoji;
  final String title;
  final String subtitle;
  final Color color;
  _ToolData(this.id, this.emoji, this.title, this.subtitle, this.color);
}