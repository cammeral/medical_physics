import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import 'file_model.dart';
import 'files_storage.dart';
import 'folder_detail_screen.dart';
import 'widgets/add_folder_dialog.dart';
import 'widgets/setup_password_dialog.dart';
import 'widgets/manage_password_dialog.dart';


class FilesScreen extends StatefulWidget {
  const FilesScreen({super.key});

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  static const Color _primary = Color(0xFFEC4899);
  static const Color _secondary = Color(0xFFF97316);

  List<Folder> _folders = [];
  List<StoredFile> _files = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final folders = await FilesStorage.loadFolders();
    final files = await FilesStorage.loadFiles();
    setState(() {
      _folders = folders;
      _files = files;
      _loading = false;
    });
  }

  int _countIn(String folderId) =>
      _files.where((f) => f.folderId == folderId).length;

  Future<void> _addFolder() async {
    final result = await showDialog<Folder>(
      context: context,
      builder: (_) => const AddFolderDialog(),
    );
    if (result != null) {
      setState(() => _folders.add(result));
      await FilesStorage.saveFolders(_folders);
    }
  }

  Future<void> _deleteFolder(Folder f) async {
    final hasFiles = _countIn(f.id) > 0;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('حذف المجلد'),
        content: Text(
          hasFiles
              ? 'المجلد يحتوي على ${_countIn(f.id)} ملف. سيتم حذفهم جميعاً!\n\nهل أنت متأكد؟'
              : 'هل تريد حذف "${f.name}"؟',
          style: const TextStyle(height: 1.6),
        ),
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
    if (ok != true) return;

    setState(() {
      _folders.removeWhere((e) => e.id == f.id);
      _files.removeWhere((e) => e.folderId == f.id);
    });
    await FilesStorage.saveFolders(_folders);
    await FilesStorage.saveFiles(_files);
  }

  Future<void> _openFolder(Folder f) async {
    final result = await Navigator.push<List<StoredFile>>(
      context,
      MaterialPageRoute(
        builder: (_) => FolderDetailScreen(
          folder: f,
          files: _files.where((e) => e.folderId == f.id).toList(),
        ),
      ),
    );
    if (result != null) {
      setState(() {
        _files.removeWhere((e) => e.folderId == f.id);
        _files.addAll(result);
      });
      await FilesStorage.saveFiles(_files);
    }
  }

  Future<void> _openMasterPassword() async {
    final has = await FilesStorage.hasMasterPassword();
    if (!mounted) return;

    // ─── الحالة 1: لا توجد كلمة سر → إنشاء ───
    if (!has) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (_) => const SetupPasswordDialog(),
      );
      if (ok == true && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ تم إنشاء كلمة السر'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
    // ─── الحالة 2: توجد كلمة سر → إدارة ───
    else {
      final result = await showDialog<String>(
        context: context,
        builder: (_) => const ManagePasswordDialog(),
      );

      if (!mounted || result == null) return;

      if (result == 'changed') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ تم تغيير كلمة السر'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
      } else if (result == 'deleted') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🗑️ تم حذف كلمة السر'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        title: const Text('📁 ملفاتي',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'كلمة سر الملفات',
            icon: const Icon(Icons.lock_rounded),
            onPressed: _openMasterPassword,
          ),
          IconButton(
            tooltip: 'مجلد جديد',
            icon: const Icon(Icons.create_new_folder_rounded),
            onPressed: _addFolder,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              color: _primary,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildStats(),
                  const SizedBox(height: 18),
                  _sectionTitle('المجلدات', '${_folders.length}'),
                  const SizedBox(height: 10),
                  ..._folders.map(_buildFolderTile),
                  const SizedBox(height: 80),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addFolder,
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.create_new_folder_rounded),
        label: const Text('مجلد جديد',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildStats() {
    final locked = _files.where((f) => f.isLocked).length;
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
          Expanded(child: _stat('${_folders.length}', 'مجلدات')),
          Container(width: 1, height: 40,
              color: Colors.white.withValues(alpha: 0.3)),
          Expanded(child: _stat('${_files.length}', 'ملفات')),
          Container(width: 1, height: 40,
              color: Colors.white.withValues(alpha: 0.3)),
          Expanded(child: _stat('$locked', 'مقفلة')),
        ],
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 11.5)),
      ],
    );
  }

  Widget _sectionTitle(String title, String count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
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
                  fontSize: 15.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(count,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: _primary)),
          ),
        ],
      ),
    );
  }

  Widget _buildFolderTile(Folder f) {
    final count = _countIn(f.id);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _primary.withValues(alpha: 0.15)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => _openFolder(f),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(f.emoji,
                      style: const TextStyle(fontSize: 26)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(f.name,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark)),
                      const SizedBox(height: 3),
                      Text(
                        count == 0 ? 'مجلد فارغ' : '$count ملف',
                        style: const TextStyle(
                            fontSize: 11.5,
                            color: AppColors.textLight),
                      ),
                    ],
                  ),
                ),
                if (!f.isCustom)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('افتراضي',
                        style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textLight)),
                  ),
                if (f.isCustom)
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded,
                        size: 18, color: AppColors.textLight),
                    onPressed: () => _deleteFolder(f),
                  ),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 14, color: _primary.withValues(alpha: 0.5)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}