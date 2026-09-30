import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'procedure_model.dart';
import 'widgets/procedure_badges.dart';

class ProcedureDetailScreen extends StatelessWidget {
  final Procedure procedure;
  final Color deviceColor;
  final String deviceName;

  const ProcedureDetailScreen({
    super.key,
    required this.procedure,
    required this.deviceColor,
    required this.deviceName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: deviceColor,
        foregroundColor: Colors.white,
        title: Text('${procedure.icon} ${procedure.nameAr}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildBadges(),
          const SizedBox(height: 16),
          _section(
            icon: '🎯',
            title: 'الدواعي (Indications)',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: procedure.indications
                  .map((i) => _bulletItem(i, deviceColor))
                  .toList(),
            ),
          ),
          _section(
            icon: '🩺',
            title: 'التحضير',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: procedure.preparationSteps
                  .asMap()
                  .entries
                  .map((e) => _numberedItem(e.key + 1, e.value, deviceColor))
                  .toList(),
            ),
          ),
          if (procedure.notes != null)
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('💡', style: TextStyle(fontSize: 15)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      procedure.notes!,
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
            ),
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
          colors: [deviceColor, deviceColor.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(procedure.icon, style: const TextStyle(fontSize: 52)),
          const SizedBox(height: 8),
          Text(
            procedure.nameAr,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            procedure.nameEn,
            style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${procedure.type.emoji} ${procedure.type.label}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadges() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            procedure.shortDesc,
            style: const TextStyle(
                fontSize: 13,
                height: 1.7,
                color: AppColors.textDark),
          ),
          const SizedBox(height: 12),
          ProcedureBadges(procedure: procedure, color: deviceColor),
        ],
      ),
    );
  }

  Widget _section({
    required String icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
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
              Text(icon, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: deviceColor),
              ),
            ],
          ),
          const Divider(height: 18),
          child,
        ],
      ),
    );
  }

  Widget _bulletItem(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                  color: color, shape: BoxShape.circle),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.65,
                    color: AppColors.textDark)),
          ),
        ],
      ),
    );
  }

  Widget _numberedItem(int n, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '$n',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: color),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.65,
                    color: AppColors.textDark)),
          ),
        ],
      ),
    );
  }
}