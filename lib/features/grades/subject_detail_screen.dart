import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import 'grade_model.dart';
import 'add_grade_screen.dart';

class SubjectDetailScreen extends StatefulWidget {
  final Subject subject;
  const SubjectDetailScreen({super.key, required this.subject});

  @override
  State<SubjectDetailScreen> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends State<SubjectDetailScreen> {
  static const Color _primary = Color(0xFF7C3AED);

  late Subject _subject;

  @override
  void initState() {
    super.initState();
    _subject = widget.subject;
  }

  Future<void> _addGrade() async {
    final result = await Navigator.push<Grade>(
      context,
      MaterialPageRoute(builder: (_) => const AddGradeScreen()),
    );
    if (result != null) {
      setState(() => _subject = _subject.copyWith(
            grades: [..._subject.grades, result],
          ));
    }
  }

  Future<void> _editGrade(Grade g) async {
    final result = await Navigator.push<Grade>(
      context,
      MaterialPageRoute(builder: (_) => AddGradeScreen(grade: g)),
    );
    if (result != null) {
      final list = [..._subject.grades];
      final i = list.indexWhere((e) => e.id == result.id);
      if (i != -1) list[i] = result;
      setState(() => _subject = _subject.copyWith(grades: list));
    }
  }

  Future<void> _deleteGrade(Grade g) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Color(0xFFF59E0B), size: 24),
            SizedBox(width: 8),
            Text('حذف الدرجة'),
          ],
        ),
        content: Text(
          'هل تريد حذف "${g.title}"؟\n\nلا يمكن التراجع عن هذا الإجراء.',
          style: const TextStyle(fontSize: 13, height: 1.6),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text(
              'حذف',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    if (ok == true) {
      setState(() => _subject = _subject.copyWith(
            grades: _subject.grades.where((e) => e.id != g.id).toList(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final avg = _subject.weightedAverage;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _subject);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          title: Text(_subject.name),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, _subject),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit_rounded),
              onPressed: _editSubject,
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSummary(avg),
            const SizedBox(height: 16),
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
                const Text(
                  'الدرجات',
                  style: TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_subject.grades.length}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (_subject.grades.isEmpty)
              _emptyGrades()
            else
              ..._subject.grades.map(_buildGradeTile),
            if (_subject.notes != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ملاحظات',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _subject.notes!,
                      style: const TextStyle(
                          fontSize: 13,
                          height: 1.6,
                          color: AppColors.textDark),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 80),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _addGrade,
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add_rounded),
          label: const Text('إضافة درجة',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildSummary(double? avg) {
    final color = _colorForGrade(avg);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.75)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'المعدل الموزون',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  avg == null ? '—' : '${avg.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 50,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'التقدير',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _subject.displayTextGrade,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _colorForGrade(double? avg) {
    if (avg == null) return const Color(0xFF9CA3AF);
    if (avg >= 90) return const Color(0xFF10B981);
    if (avg >= 80) return const Color(0xFF06B6A4);
    if (avg >= 70) return const Color(0xFF4A6CF7);
    if (avg >= 60) return const Color(0xFFF59E0B);
    if (avg >= 50) return const Color(0xFFF97316);
    return const Color(0xFFEF4444);
  }

  Widget _emptyGrades() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(Icons.grade_rounded,
              size: 42, color: Colors.grey.shade400),
          const SizedBox(height: 10),
          const Text(
            'لا توجد درجات بعد',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark),
          ),
          const SizedBox(height: 4),
          const Text(
            'أضف أول درجة لهذه المادة',
            style: TextStyle(fontSize: 12, color: AppColors.textLight),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeTile(Grade g) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(g.type.emoji,
                  style: const TextStyle(fontSize: 20)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    g.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          g.type.label,
                          style: const TextStyle(
                              fontSize: 10, color: _primary),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'الوزن: ${g.weight.toStringAsFixed(0)}%',
                        style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textLight),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${g.value.toStringAsFixed(0)} / ${g.max.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  '${g.percentage.toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: _colorForGrade(g.percentage),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.edit_outlined,
                  size: 18, color: AppColors.textLight),
              onPressed: () => _editGrade(g),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded,
                  size: 18, color: AppColors.textLight),
              onPressed: () => _deleteGrade(g),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editSubject() async {
    final nameCtrl = TextEditingController(text: _subject.name);
    final textGradeCtrl = TextEditingController(
        text: _subject.manualTextGrade ?? '');
    final notesCtrl = TextEditingController(text: _subject.notes ?? '');

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('تعديل المادة'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'اسم المادة'),
              ),
              TextField(
                controller: textGradeCtrl,
                decoration: const InputDecoration(
                    labelText: 'نتيجة رمزية (اختياري)'),
              ),
              TextField(
                controller: notesCtrl,
                maxLines: 2,
                decoration: const InputDecoration(
                    labelText: 'ملاحظات (اختياري)'),
              ),
            ],
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

    if (ok == true) {
      setState(() => _subject = _subject.copyWith(
            name: nameCtrl.text.trim(),
            manualTextGrade: textGradeCtrl.text.trim().isEmpty
                ? null
                : textGradeCtrl.text.trim(),
            notes: notesCtrl.text.trim().isEmpty
                ? null
                : notesCtrl.text.trim(),
          ));
    }
  }
}