import 'package:flutter/material.dart';
import '../files_storage.dart';

class ManagePasswordDialog extends StatefulWidget {
  const ManagePasswordDialog({super.key});

  @override
  State<ManagePasswordDialog> createState() => _ManagePasswordDialogState();
}

class _ManagePasswordDialogState extends State<ManagePasswordDialog> {
  static const Color _primary = Color(0xFF7C3AED);

  // ─── وضع النافذة ───
  _Mode _mode = _Mode.menu;

  final _oldCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _deleteCtrl = TextEditingController();

  String? _error;
  bool _loading = false;

  @override
  void dispose() {
    _oldCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    _deleteCtrl.dispose();
    super.dispose();
  }

  // ═══════════════════════════════════════════════════
  //  تغيير كلمة السر
  // ═══════════════════════════════════════════════════
  Future<void> _change() async {
    final oldPwd = _oldCtrl.text.trim();
    final newPwd = _newCtrl.text.trim();
    final confirm = _confirmCtrl.text.trim();

    if (oldPwd.isEmpty) {
      setState(() => _error = 'أدخل كلمة السر الحالية');
      return;
    }
    if (newPwd.length < 4) {
      setState(() => _error = 'كلمة السر الجديدة قصيرة (4+ أحرف)');
      return;
    }
    if (newPwd != confirm) {
      setState(() => _error = 'كلمتا السر الجديدتان غير متطابقتين');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    final ok = await FilesStorage.changeMasterPassword(
      oldPassword: oldPwd,
      newPassword: newPwd,
    );

    if (!mounted) return;

    if (ok) {
      Navigator.pop(context, 'changed');
    } else {
      setState(() {
        _loading = false;
        _error = 'كلمة السر الحالية غير صحيحة';
      });
    }
  }

  // ═══════════════════════════════════════════════════
  //  حذف كلمة السر
  // ═══════════════════════════════════════════════════
  Future<void> _delete() async {
    final pwd = _deleteCtrl.text.trim();

    if (pwd.isEmpty) {
      setState(() => _error = 'أدخل كلمة السر الحالية للتأكيد');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    final ok = await FilesStorage.verifyPassword(pwd);
    if (!mounted) return;

    if (ok) {
      await FilesStorage.clearMasterPassword();
      if (!mounted) return;
      Navigator.pop(context, 'deleted');
    } else {
      setState(() {
        _loading = false;
        _error = 'كلمة السر غير صحيحة';
      });
    }
  }

  void _back() {
    setState(() {
      _mode = _Mode.menu;
      _error = null;
      _oldCtrl.clear();
      _newCtrl.clear();
      _confirmCtrl.clear();
      _deleteCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: _buildTitle(),
      content: _loading
          ? const SizedBox(
              height: 80,
              child: Center(child: CircularProgressIndicator()),
            )
          : _buildContent(),
      actions: _loading ? [] : _buildActions(),
    );
  }

  Widget _buildTitle() {
    switch (_mode) {
      case _Mode.menu:
        return const Row(
          children: [
            Icon(Icons.lock_rounded, color: _primary, size: 24),
            SizedBox(width: 8),
            Text('إدارة كلمة السر', style: TextStyle(fontSize: 16)),
          ],
        );
      case _Mode.change:
        return const Row(
          children: [
            Icon(Icons.password_rounded, color: _primary, size: 24),
            SizedBox(width: 8),
            Text('تغيير كلمة السر', style: TextStyle(fontSize: 16)),
          ],
        );
      case _Mode.delete:
        return const Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Colors.red, size: 24),
            SizedBox(width: 8),
            Text('حذف كلمة السر',
                style: TextStyle(fontSize: 16, color: Colors.red)),
          ],
        );
    }
  }

  Widget _buildContent() {
    switch (_mode) {
      case _Mode.menu:
        return _buildMenu();
      case _Mode.change:
        return _buildChangeForm();
      case _Mode.delete:
        return _buildDeleteForm();
    }
  }

  // ─── القائمة ───
  Widget _buildMenu() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Row(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'كلمة السر مضبوطة',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF1B5E20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _menuItem(
          icon: Icons.password_rounded,
          title: 'تغيير كلمة السر',
          subtitle: 'تعديل كلمة السر الحالية',
          color: _primary,
          onTap: () => setState(() => _mode = _Mode.change),
        ),
        const SizedBox(height: 8),
        _menuItem(
          icon: Icons.lock_open_rounded,
          title: 'حذف كلمة السر',
          subtitle: 'إزالة الحماية عن الملفات',
          color: Colors.red,
          onTap: () => setState(() => _mode = _Mode.delete),
        ),
      ],
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_left_rounded, color: color),
          ],
        ),
      ),
    );
  }

  // ─── نموذج التغيير ───
  Widget _buildChangeForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _oldCtrl,
            obscureText: true,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'كلمة السر الحالية',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              border: const OutlineInputBorder(),
              errorText: _error,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _newCtrl,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'كلمة السر الجديدة',
              prefixIcon: Icon(Icons.lock_rounded),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _confirmCtrl,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'تأكيد كلمة السر الجديدة',
              prefixIcon: Icon(Icons.lock_rounded),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  // ─── نموذج الحذف ───
  Widget _buildDeleteForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: const Row(
            children: [
              Text('⚠️', style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'سيتم إزالة الحماية من كل الملفات المقفلة.\nلا يمكن التراجع عن هذا الإجراء.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.6,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _deleteCtrl,
          obscureText: true,
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'أدخل كلمة السر للتأكيد',
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            border: const OutlineInputBorder(),
            errorText: _error,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildActions() {
    switch (_mode) {
      case _Mode.menu:
        return [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
        ];
      case _Mode.change:
        return [
          TextButton(
            onPressed: _back,
            child: const Text('رجوع'),
          ),
          TextButton(
            onPressed: _change,
            style: TextButton.styleFrom(foregroundColor: _primary),
            child: const Text('تغيير',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ];
      case _Mode.delete:
        return [
          TextButton(
            onPressed: _back,
            child: const Text('رجوع'),
          ),
          TextButton(
            onPressed: _delete,
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('حذف نهائياً',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ];
    }
  }
}

enum _Mode { menu, change, delete }