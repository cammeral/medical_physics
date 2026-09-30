import 'package:flutter/material.dart';
import '../files_storage.dart';

class UnlockDialog extends StatefulWidget {
  final bool forceSetup;
  const UnlockDialog({super.key, this.forceSetup = false});

  @override
  State<UnlockDialog> createState() => _UnlockDialogState();
}

class _UnlockDialogState extends State<UnlockDialog> {
  final _ctrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  String? _error;
  bool _isSetup = false;
  bool _checking = true;   // ← حالة الانتظار
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _checkSetup();
  }

  Future<void> _checkSetup() async {
    final has = await FilesStorage.hasMasterPassword();
    if (!mounted) return;
    setState(() {
      _isSetup = !has;
      _checking = false;
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_saving) return;

    final pwd = _ctrl.text.trim();
    if (pwd.length < 4) {
      setState(() => _error = 'كلمة السر يجب أن تكون 4 أحرف على الأقل');
      return;
    }

    // ═══════════════════════════════════════════════════
    //  حالة الإنشاء (أول مرة)
    // ═══════════════════════════════════════════════════
    if (_isSetup) {
      if (pwd != _confirmCtrl.text.trim()) {
        setState(() => _error = 'كلمتا السر غير متطابقتين');
        return;
      }

      setState(() {
        _saving = true;
        _error = null;
      });

      // حفظ متزامن
      await FilesStorage.saveMasterHash(
        FilesStorage.hashPassword(pwd),
      );

      // ⭐ تحقق: تأكد أن الحفظ تم فعلاً
      final verify = await FilesStorage.verifyPassword(pwd);
      if (!mounted) return;

      if (!verify) {
        setState(() {
          _saving = false;
          _error = 'حدث خطأ في الحفظ، أعد المحاولة';
        });
        return;
      }

      if (mounted) Navigator.pop(context, true);
      return;
    }

    // ═══════════════════════════════════════════════════
    //  حالة الفتح
    // ═══════════════════════════════════════════════════
    setState(() {
      _saving = true;
      _error = null;
    });

    final ok = await FilesStorage.verifyPassword(pwd);
    if (!mounted) return;

    if (ok) {
      Navigator.pop(context, true);
    } else {
      setState(() {
        _saving = false;
        _error = 'كلمة السر غير صحيحة';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(
            _isSetup ? Icons.lock_outline_rounded : Icons.lock_rounded,
            color: const Color(0xFF7C3AED),
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            _checking
                ? 'جاري التحميل...'
                : _isSetup
                    ? 'إنشاء كلمة سر'
                    : 'فتح القفل',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      content: _checking
          ? const SizedBox(
              height: 80,
              child: Center(child: CircularProgressIndicator()),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _isSetup
                      ? 'أدخل كلمة سر لحماية ملفاتك. ستحتاجها لفتح أي ملف مقفل.'
                      : 'أدخل كلمة السر لفتح الملف.',
                  style: const TextStyle(fontSize: 12.5, height: 1.6),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _ctrl,
                  obscureText: true,
                  autofocus: true,
                  enabled: !_saving,
                  decoration: InputDecoration(
                    labelText: 'كلمة السر',
                    border: const OutlineInputBorder(),
                    errorText: _error,
                    prefixIcon: const Icon(Icons.key_rounded),
                  ),
                ),
                if (_isSetup) ...[
                  const SizedBox(height: 10),
                  TextField(
                    controller: _confirmCtrl,
                    obscureText: true,
                    enabled: !_saving,
                    decoration: const InputDecoration(
                      labelText: 'تأكيد كلمة السر',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.key_rounded),
                    ),
                  ),
                ],
                if (_saving) ...[
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 8),
                      Text('جاري الحفظ...',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ],
            ),
      actions: [
        TextButton(
          onPressed: _checking || _saving
              ? null
              : () => Navigator.pop(context, false),
          child: const Text('إلغاء'),
        ),
        TextButton(
          onPressed: _checking || _saving ? null : _submit,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF7C3AED),
          ),
          child: Text(
            _saving
                ? '...'
                : _isSetup
                    ? 'إنشاء'
                    : 'فتح',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}