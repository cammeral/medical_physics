import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import 'class_model.dart';

class AddClassScreen extends StatefulWidget {
  final ClassItem? item;
  final WeekDay? initialDay;

  const AddClassScreen({super.key, this.item, this.initialDay});

  @override
  State<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  static const Color _primary = Color(0xFF4A6CF7);

  static const _colors = [
    '4A6CF7', // أزرق
    '06B6A4', // أخضر مزرق
    '9B5DE5', // بنفسجي
    'F59E0B', // برتقالي
    'EF4444', // أحمر
    'EC4899', // وردي
    '10B981', // أخضر
    '6B7280', // رمادي
  ];

  final _subjectCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _professorCtrl = TextEditingController();

  late WeekDay _day;
  TimeOfDay _startTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 9, minute: 30);
  String _color = '4A6CF7';

  @override
  void initState() {
    super.initState();
    _day = widget.initialDay ?? WeekDay.saturday;

    if (widget.item != null) {
      final i = widget.item!;
      _subjectCtrl.text = i.subject;
      _locationCtrl.text = i.location ?? '';
      _professorCtrl.text = i.professor ?? '';
      _day = i.day;
      _color = i.colorHex;
      _startTime = _parse(i.startTime);
      _endTime = _parse(i.endTime);
    }
  }

  TimeOfDay _parse(String t) {
    final parts = t.split(':');
    if (parts.length == 2) {
      return TimeOfDay(
        hour: int.tryParse(parts[0]) ?? 0,
        minute: int.tryParse(parts[1]) ?? 0,
      );
    }
    return const TimeOfDay(hour: 8, minute: 0);
  }

  String _fmt(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  @override
  void dispose() {
    _subjectCtrl.dispose();
    _locationCtrl.dispose();
    _professorCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickTime(bool isStart) async {
    final t = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    );
    if (t != null) {
      setState(() {
        if (isStart) {
          _startTime = t;
        } else {
          _endTime = t;
        }
      });
    }
  }

  void _save() {
    if (_subjectCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال اسم المادة')),
      );
      return;
    }

    final item = ClassItem(
      id: widget.item?.id ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      subject: _subjectCtrl.text.trim(),
      startTime: _fmt(_startTime),
      endTime: _fmt(_endTime),
      location: _locationCtrl.text.trim().isEmpty
          ? null
          : _locationCtrl.text.trim(),
      professor: _professorCtrl.text.trim().isEmpty
          ? null
          : _professorCtrl.text.trim(),
      day: _day,
      colorHex: _color,
    );
    Navigator.pop(context, item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        title: Text(
          widget.item == null ? 'محاضرة جديدة' : 'تعديل المحاضرة',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // اسم المادة
          _field(
            'اسم المادة *',
            _subjectCtrl,
            'مثال: الفيزياء الطبية',
            icon: Icons.menu_book_rounded,
          ),

          // اليوم
          const Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Text(
              'اليوم',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark),
            ),
          ),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: WeekDay.values.map((d) {
              final selected = _day == d;
              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => setState(() => _day = d),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
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
                      Text(d.emoji,
                          style: const TextStyle(fontSize: 13)),
                      const SizedBox(width: 4),
                      Text(
                        d.arabic,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: selected
                              ? Colors.white
                              : AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // الوقت
          const Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Text(
              'الوقت',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _timeButton(
                  'من',
                  _startTime,
                  () => _pickTime(true),
                  Icons.play_arrow_rounded,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _timeButton(
                  'إلى',
                  _endTime,
                  () => _pickTime(false),
                  Icons.stop_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // المكان
          _field(
            'المكان (اختياري)',
            _locationCtrl,
            'مثال: قاعة 101',
            icon: Icons.location_on_rounded,
          ),

          // الأستاذ
          _field(
            'اسم الدكتور (اختياري)',
            _professorCtrl,
            'مثال: د. أحمد محمد',
            icon: Icons.person_rounded,
          ),

          // اللون
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'اللون',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark),
            ),
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _colors.map((c) {
              final color = Color(int.parse('FF$c', radix: 16));
              final selected = _color == c;
              return InkWell(
                onTap: () => setState(() => _color = c),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                    border: selected
                        ? Border.all(color: Colors.black, width: 2.5)
                        : null,
                  ),
                  child: selected
                      ? const Icon(Icons.check,
                          color: Colors.white, size: 22)
                      : null,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 28),

          // زر الحفظ
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                widget.item == null ? 'إضافة المحاضرة' : 'حفظ التعديلات',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController ctrl,
    String hint, {
    IconData? icon,
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
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              prefixIcon: icon != null ? Icon(icon, size: 20) : null,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 14),
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

  Widget _timeButton(
    String label,
    TimeOfDay time,
    VoidCallback onTap,
    IconData icon,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 14, color: _primary),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              _fmt(time),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}