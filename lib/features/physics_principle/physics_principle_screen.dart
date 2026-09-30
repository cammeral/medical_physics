import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'device_principle_screen.dart';
import 'devices_data.dart';
import 'device_model.dart';

class PhysicsPrincipleScreen extends StatelessWidget {
  const PhysicsPrincipleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text(
          '⚙️ المبدأ الفيزيائي',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int columns = 2;
          if (constraints.maxWidth > 1100) {
            columns = 5;
          } else if (constraints.maxWidth > 800) {
            columns = 4;
          } else if (constraints.maxWidth > 500) {
            columns = 3;
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.95,
            ),
            itemCount: devices.length,
            itemBuilder: (context, i) => _buildDeviceCard(context, devices[i]),
          );
        },
      ),
    );
  }

  Widget _buildDeviceCard(BuildContext context, Device device) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DevicePrincipleScreen(device: device),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: device.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(device.emoji,
                    style: const TextStyle(fontSize: 28)),
              ),
              const SizedBox(height: 10),
              Text(
                device.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                device.arabic,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textLight,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}