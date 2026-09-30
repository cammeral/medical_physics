import 'package:flutter/material.dart';
import '../files_storage.dart';

class SetupPasswordDialog extends StatefulWidget {
  const SetupPasswordDialog({super.key});

  @override
  State<SetupPasswordDialog> createState() => _SetupPasswordDialogState();
}

class _SetupPasswordDialogState extends State<SetupPasswordDialog> {
  final _ctrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _ctrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final pwd = _ctrl.text.trim();
    if (pwd.length < 4) {
      setState(() => _error = 'كلمة السر يجب أن تكون 4 أحرف على الأقل');
      return;
    }
    if (pwd != _confirmCtrl.text.trim()) {
      setState(() => _error = 'كلمتا السر غير متطابقتين');
      return;
    }
    await FilesStorage.saveMasterHash(FilesStorage.hashPassword(pwd));
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Row(
        children: [
          Icon(Icons.lock_rounded, color: Color(0xFF7C3AED), size: 24),
          SizedBox(width: 8),
          Text('إنشاء كلمة سر', style: TextStyle(fontSize: 16)),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'ستُستخدم كلمة السر لقفل وفتح ملفاتك الحساسة.',
            style: TextStyle(fontSize: 12.5, height: 1.6),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _ctrl,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'كلمة السر',
              border: const OutlineInputBorder(),
              errorText: _error,
              prefixIcon: const Icon(Icons.key_rounded),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _confirmCtrl,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'تأكيد كلمة السر',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.key_rounded),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('لاحقاً'),
        ),
        TextButton(
          onPressed: _save,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF7C3AED),
          ),
          child: const Text('إنشاء',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}