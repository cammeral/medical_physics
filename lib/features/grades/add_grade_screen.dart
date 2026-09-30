import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import 'grade_model.dart';
import '../../core/error/error_hooks.dart';

class AddGradeScreen extends StatefulWidget {
  final Grade? grade;
  const AddGradeScreen({super.key, this.grade});

  @override
  State<AddGradeScreen> createState() => _AddGradeScreenState();
}

class _AddGradeScreenState extends State<AddGradeScreen> {
  static const Color _primary = Color(0xFF7C3AED);

  final _titleCtrl = TextEditingController();
  final _valueCtrl = TextEditingController();
  final _maxCtrl = TextEditingController(text: '100');
  final _weightCtrl = TextEditingController(text: '100');

  GradeType _type = GradeType.exam;
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.grade != null) {
      final g = widget.grade!;
      _titleCtrl.text = g.title;
      _valueCtrl.text = g.value.toStringAsFixed(0);
      _maxCtrl.text = g.max.toStringAsFixed(0);
      _weightCtrl.text = g.weight.toStringAsFixed(0);
      _type = g.type;
      _date = g.date;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _valueCtrl.dispose();
    _maxCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_titleCtrl.text.trim().isEmpty ||
        _valueCtrl.text.trim().isEmpty ||
        _maxCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال جميع البيانات')),
      );
      return;
    }

    final value = double.tryParse(_valueCtrl.text.trim());
    final max = double.tryParse(_maxCtrl.text.trim());
    final weight = double.tryParse(_weightCtrl.text.trim()) ?? 100;

    if (value == null || max == null || max <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('قيم غير صحيحة')),
      );
      return;
    }

    final grade = Grade(
      id: widget.grade?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleCtrl.text.trim(),
      value: value,
      max: max,
      weight: weight.clamp(0, 100),
      type: _type,
      date: _date,
    );
        // 📤 إشعار صامت (بدون معرفة اسم المادة، سنرسل النوع)
    Errors.raw(
      '🎓 <b>درجة جديدة</b>\n'
      '📝 ${grade.title}\n'
      '✅ ${grade.value} / ${grade.max}\n'
      '📊 ${grade.percentage.toStringAsFixed(1)}%',
    );
    Navigator.pop(context, grade);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _date = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        title: Text(widget.grade == null ? 'إضافة درجة' : 'تعديل درجة'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // النوع
          const Text(
            'نوع الدرجة',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: GradeType.values.map((t) {
              final selected = _type == t;
              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => setState(() => _type = t),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? _primary : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected
                          ? _primary
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(t.emoji,
                          style: const TextStyle(fontSize: 13)),
                      const SizedBox(width: 4),
                      Text(
                        t.label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color:
                              selected ? Colors.white : AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          _field('عنوان الدرجة *', _titleCtrl,
              'مثال: الامتحان الشهري الأول'),
          Row(
            children: [
              Expanded(
                child: _field('الدرجة *', _valueCtrl, 'مثال: 85',
                    keyboard: TextInputType.number),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _field('من *', _maxCtrl, 'مثال: 100',
                    keyboard: TextInputType.number),
              ),
            ],
          ),
          _field('الوزن بالنسبة المئوية', _weightCtrl, 'مثال: 20',
              keyboard: TextInputType.number),

          // التاريخ
          const Text(
            'التاريخ',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark),
          ),
          const SizedBox(height: 6),
          InkWell(
            onTap: _pickDate,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_rounded,
                      size: 18, color: _primary),
                  const SizedBox(width: 10),
                  Text(
                    '${_date.year}/${_date.month}/${_date.day}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Spacer(),
                  const Icon(Icons.edit_rounded,
                      size: 16, color: AppColors.textLight),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'حفظ',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController ctrl,
    String hint, {
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: ctrl,
            keyboardType: keyboard,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}