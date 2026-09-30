import 'package:flutter/material.dart';
import '../file_model.dart';

class AddFolderDialog extends StatefulWidget {
  const AddFolderDialog({super.key});

  @override
  State<AddFolderDialog> createState() => _AddFolderDialogState();
}

class _AddFolderDialogState extends State<AddFolderDialog> {
  final _ctrl = TextEditingController();
  String _emoji = '📁';

  static const _emojis = [
    '📁', '📂', '📚', '📖', '🎓', '🖼️', '🎬', '🎵', '📄',
    '📝', '💡', '⭐', '🎨', '🧪', '🔬', '💼', '🏆', '❤️', '⭐',
  ];

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_ctrl.text.trim().isEmpty) return;
    final folder = Folder(
      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
      name: _ctrl.text.trim(),
      emoji: _emoji,
      isCustom: true,
    );
    Navigator.pop(context, folder);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Row(
        children: [
          Icon(Icons.create_new_folder_rounded,
              color: Color(0xFFEC4899), size: 24),
          SizedBox(width: 8),
          Text('مجلد جديد', style: TextStyle(fontSize: 16)),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _ctrl,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'اسم المجلد',
              hintText: 'مثال: كتب الفصل الأول',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 14),
          const Text('اختر أيقونة',
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
          const SizedBox(height: 8),
          SizedBox(
            height: 90,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: _emojis.length,
              itemBuilder: (ctx, i) {
                final e = _emojis[i];
                final selected = e == _emoji;
                return InkWell(
                  onTap: () => setState(() => _emoji = e),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFFEC4899).withValues(alpha: 0.15)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: selected
                            ? const Color(0xFFEC4899)
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Text(e, style: const TextStyle(fontSize: 18)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        TextButton(
          onPressed: _save,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFFEC4899),
          ),
          child: const Text('إنشاء',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}