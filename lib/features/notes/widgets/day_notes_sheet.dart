import 'package:flutter/material.dart';
import '../../../../utils/app_colors.dart';
import '../note_model.dart';
import 'note_editor_sheet.dart';
import '../../../../core/error/error_hooks.dart';

class DayNotesSheet extends StatefulWidget {
  final DateTime day;
  final List<Note> notes;

  const DayNotesSheet({super.key, required this.day, required this.notes});

  @override
  State<DayNotesSheet> createState() => _DayNotesSheetState();
}

class _DayNotesSheetState extends State<DayNotesSheet> {
  static const Color _primary = Color(0xFFF59E0B);
  static const Color _secondary = Color(0xFFEF4444);

  late List<Note> _notes;

  @override
  void initState() {
    super.initState();
    _notes = List.from(widget.notes);
  }

  Future<void> _addNote() async {
    final result = await showModalBottomSheet<Note>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => NoteEditorSheet(date: widget.day),
    );
    if (result != null) {
      setState(() => _notes.add(result));
          // 📤 إشعار صامت
    Errors.note(
      title: result.title,
      body: result.content,
    );
    }
  }

  Future<void> _editNote(Note n) async {
    final result = await showModalBottomSheet<Note>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => NoteEditorSheet(date: widget.day, note: n),
    );
    if (result != null) {
      final i = _notes.indexWhere((e) => e.id == result.id);
      if (i != -1) setState(() => _notes[i] = result);
    }
  }

  Future<void> _deleteNote(Note n) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('حذف الملاحظة'),
        content: Text('هل تريد حذف "${n.title}"؟'),
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
      setState(() => _notes.removeWhere((e) => e.id == n.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    const days = [
      'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس',
      'الجمعة', 'السبت', 'الأحد'
    ];
    const months = [
      'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
    ];

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (ctx, scrollCtrl) => Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // المقبض
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 6),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // الرأس
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [_primary, _secondary],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${widget.day.day}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          days[widget.day.weekday - 1],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${widget.day.day} ${months[widget.day.month - 1]} ${widget.day.year}',
                          style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textLight),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_notes.length} ملاحظة',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: _primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // القائمة
            Expanded(
              child: _notes.isEmpty
                  ? _buildEmpty()
                  : ListView.builder(
                      controller: scrollCtrl,
                      padding: const EdgeInsets.all(16),
                      itemCount: _notes.length,
                      itemBuilder: (ctx, i) => _noteCard(_notes[i]),
                    ),
            ),
            // أزرار
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, _notes),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: const Text('إغلاق',
                          style: TextStyle(color: AppColors.textDark)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: _addNote,
                      icon: const Icon(Icons.add_rounded),
                      label: const Text('ملاحظة جديدة',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Text('📝', style: TextStyle(fontSize: 38)),
            ),
            const SizedBox(height: 14),
            const Text('لا توجد ملاحظات في هذا اليوم',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark)),
            const SizedBox(height: 6),
            const Text('أضف ملاحظة لتذكير نفسك بشيء مهم',
                style: TextStyle(
                    fontSize: 12.5, color: AppColors.textLight),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _noteCard(Note n) {
    final color = Color(int.parse('FF${n.colorHex}', radix: 16));
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 22,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  n.title,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              if (n.time != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time_rounded,
                          size: 11, color: color),
                      const SizedBox(width: 3),
                      Text(n.time!,
                          style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                              color: color)),
                    ],
                  ),
                ),
            ],
          ),
          if (n.content.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              n.content,
              style: const TextStyle(
                  fontSize: 13,
                  height: 1.65,
                  color: AppColors.textDark),
            ),
          ],
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined,
                    size: 18, color: AppColors.textLight),
                onPressed: () => _editNote(n),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded,
                    size: 18, color: AppColors.textLight),
                onPressed: () => _deleteNote(n),
              ),
            ],
          ),
        ],
      ),
    );
  }
}