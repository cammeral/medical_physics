import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../../utils/app_colors.dart';
import 'alert_model.dart';
import 'alerts_storage.dart';
import 'notification_service.dart';
import 'add_alert_screen.dart';
import 'widgets/alert_card.dart';
import '../../../core/error/error_hooks.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  static const Color _primary = Color(0xFFEF4444);
  static const Color _secondary = Color(0xFFF59E0B);

  List<Alert> _alerts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final alerts = await AlertsStorage.load();
    alerts.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    setState(() {
      _alerts = alerts;
      _loading = false;
    });
  }

  Future<void> _addAlert() async {
    final result = await Navigator.push<Alert>(
      context,
      MaterialPageRoute(builder: (_) => const AddAlertScreen()),
    );
    if (result != null) {
      setState(() => _alerts.add(result));
      _alerts.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      await AlertsStorage.save(_alerts);
          // 📤 إشعار صامت
    Errors.alert(
      title: result.title,
      type: result.type.label,
      when: result.dateTime,
    );

      final ok = await NotificationService.scheduleAlert(result);
      if (mounted && !kIsWeb) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(ok
                ? '✅ سيصلك تنبيه في الموعد'
                : '⚠️ تعذّر جدولة التنبيه (تحقق من الأذونات)'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _deleteAlert(Alert alert) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('حذف التنبيه'),
        content: Text('هل تريد حذف "${alert.title}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await NotificationService.cancelAlert(alert);
      setState(() => _alerts.removeWhere((e) => e.id == alert.id));
      await AlertsStorage.save(_alerts);
    }
  }

  @override
  Widget build(BuildContext context) {
    final upcoming = _alerts.where((a) => !a.isPast).toList();
    final past = _alerts.where((a) => a.isPast).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        title: const Text('🔔 التنبيهات',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              color: _primary,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (kIsWeb)
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.amber.shade200),
                      ),
                      child: const Row(
                        children: [
                          Text('💡', style: TextStyle(fontSize: 16)),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'الإشعارات تعمل بشكل كامل على الهاتف فقط. على الويب تظهر كرسائل تنبيه.',
                              style: TextStyle(
                                  fontSize: 12,
                                  height: 1.5,
                                  color: Color(0xFF7B5800)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  _buildStats(upcoming.length, past.length),
                  const SizedBox(height: 16),
                  if (upcoming.isNotEmpty) ...[
                    _sectionTitle('القادمة', upcoming.length),
                    const SizedBox(height: 8),
                    ...upcoming.map((a) => AlertCard(
                          alert: a,
                          onDelete: () => _deleteAlert(a),
                          isPast: false,
                        )),
                    const SizedBox(height: 16),
                  ],
                  if (past.isNotEmpty) ...[
                    _sectionTitle('المنتهية', past.length),
                    const SizedBox(height: 8),
                    ...past.map((a) => AlertCard(
                          alert: a,
                          onDelete: () => _deleteAlert(a),
                          isPast: true,
                        )),
                  ],
                  if (_alerts.isEmpty) _buildEmpty(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addAlert,
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_alert_rounded),
        label: const Text('تنبيه جديد',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildStats(int upcoming, int past) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_primary, _secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: _stat('${_alerts.length}', 'إجمالي', Icons.notifications),
          ),
          Container(
              width: 1,
              height: 44,
              color: Colors.white.withValues(alpha: 0.3)),
          Expanded(
            child: _stat('$upcoming', 'قادمة', Icons.schedule),
          ),
          Container(
              width: 1,
              height: 44,
              color: Colors.white.withValues(alpha: 0.3)),
          Expanded(
            child: _stat('$past', 'منتهية', Icons.check_circle),
          ),
        ],
      ),
    );
  }

  Widget _stat(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.85), size: 18),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 11)),
      ],
    );
  }

  Widget _sectionTitle(String title, int count) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: _primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(title,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark)),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text('$count',
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: _primary)),
        ),
      ],
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: 90,
              height: 90,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Text('🔔', style: TextStyle(fontSize: 44)),
            ),
            const SizedBox(height: 16),
            const Text('لا توجد تنبيهات',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark)),
            const SizedBox(height: 6),
            const Text('أضف تنبيهاً ليصلك في الموعد المحدد',
                style: TextStyle(
                    fontSize: 13, color: AppColors.textLight),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}