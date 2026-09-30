import 'package:flutter/material.dart';
import '../../../../utils/app_colors.dart';
import '../note_model.dart';

class NoteEditorSheet extends StatefulWidget {
  final DateTime date;
  final Note? note;

  const NoteEditorSheet({super.key, required this.date, this.note});

  @override
  State<NoteEditorSheet> createState() => _NoteEditorSheetState();
}

class _NoteEditorSheetState extends State<NoteEditorSheet> {
  static const Color _primary = Color(0xFFF59E0B);

  static const _colors = [
    'F59E0B', // برتقالي
    'EF4444', // أحمر
    'EC4899', // وردي
    '7C3AED', // بنفسجي
    '4A6CF7', // أزرق
    '06B6A4', // أخضر مزرق
    '10B981', // أخضر
    '6B7280', // رمادي
  ];

  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();
  String _color = 'F59E0B';
  TimeOfDay? _time;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleCtrl.text = widget.note!.title;
      _contentCtrl.text = widget.note!.content;
      _color = widget.note!.colorHex;
      if (widget.note!.time != null) {
        final parts = widget.note!.time!.split(':');
        if (parts.length == 2) {
          _time = TimeOfDay(
            hour: int.tryParse(parts[0]) ?? 0,
            minute: int.tryParse(parts[1]) ?? 0,
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final t = await showTimePicker(
      context: context,
      initialTime: _time ?? TimeOfDay.now(),
    );
    if (t != null) setState(() => _time = t);
  }

  void _save() {
    if (_titleCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال عنوان الملاحظة')),
      );
      return;
    }

    final time = _time != null
        ? '${_time!.hour.toString().padLeft(2, '0')}:${_time!.minute.toString().padLeft(2, '0')}'
        : null;

    final note = Note(
      id: widget.note?.id ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      title: _titleCtrl.text.trim(),
      content: _contentCtrl.text.trim(),
      colorHex: _color,
      time: time,
      date: widget.date,
    );
    Navigator.pop(context, note);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // المقبض
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                widget.note == null ? 'ملاحظة جديدة' : 'تعديل الملاحظة',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 14),

              // العنوان
              TextField(
                controller: _titleCtrl,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'عنوان الملاحظة *',
                  hintText: 'مثال: مراجعة الفصل الثالث',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // المحتوى
              TextField(
                controller: _contentCtrl,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'التفاصيل (اختياري)',
                  hintText: 'اكتب تفاصيل ملاحظتك هنا...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // الوقت
              const Text('الوقت (اختياري)',
                  style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark)),
              const SizedBox(height: 6),
              InkWell(
                onTap: _pickTime,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time_rounded,
                          size: 18, color: _primary),
                      const SizedBox(width: 10),
                      Text(
                        _time == null
                            ? 'لم يُحدد'
                            : '${_time!.hour.toString().padLeft(2, '0')}:${_time!.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 14,
                          color: _time == null
                              ? AppColors.textLight
                              : AppColors.textDark,
                          fontWeight: _time != null
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      const Spacer(),
                      if (_time != null)
                        IconButton(
                          icon: const Icon(Icons.clear_rounded,
                              size: 18, color: AppColors.textLight),
                          onPressed: () => setState(() => _time = null),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // الألوان
              const Text('اللون',
                  style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _colors.map((c) {
                  final color = Color(int.parse('FF$c', radix: 16));
                  final selected = _color == c;
                  return InkWell(
                    onTap: () => setState(() => _color = c),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12),
                        border: selected
                            ? Border.all(color: Colors.black, width: 2.5)
                            : null,
                      ),
                      child: selected
                          ? const Icon(Icons.check,
                              color: Colors.white, size: 20)
                          : null,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // أزرار
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: const Text('إلغاء',
                          style: TextStyle(color: AppColors.textDark)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        widget.note == null ? 'إضافة' : 'حفظ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}