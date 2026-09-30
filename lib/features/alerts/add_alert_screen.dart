import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import 'alert_model.dart';

class AddAlertScreen extends StatefulWidget {
  final Alert? alert;
  const AddAlertScreen({super.key, this.alert});

  @override
  State<AddAlertScreen> createState() => _AddAlertScreenState();
}

class _AddAlertScreenState extends State<AddAlertScreen> {
  static const Color _primary = Color(0xFFEF4444);

  final _titleCtrl = TextEditingController();
  final _detailsCtrl = TextEditingController();

  AlertType _type = AlertType.exam;
  AlertRepeat _repeat = AlertRepeat.once;
  ReminderWhen _when = ReminderWhen.atTime;
  DateTime _date = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _time = const TimeOfDay(hour: 9, minute: 0);
  bool _sound = true;
  bool _vibrate = true;

  @override
  void initState() {
    super.initState();
    if (widget.alert != null) {
      final a = widget.alert!;
      _titleCtrl.text = a.title;
      _detailsCtrl.text = a.details ?? '';
      _type = a.type;
      _repeat = a.repeat;
      _when = a.when;
      _date = a.dateTime;
      _time = TimeOfDay(hour: a.dateTime.hour, minute: a.dateTime.minute);
      _sound = a.soundEnabled;
      _vibrate = a.vibrate;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _detailsCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
    );
    if (d != null) setState(() => _date = d);
  }

  Future<void> _pickTime() async {
    final t = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (t != null) setState(() => _time = t);
  }

  void _save() {
    if (_titleCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال عنوان التنبيه')),
      );
      return;
    }

    final dt = DateTime(
      _date.year,
      _date.month,
      _date.day,
      _time.hour,
      _time.minute,
    );

    if (dt.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الموعد يجب أن يكون في المستقبل')),
      );
      return;
    }

    final alert = Alert(
      id: widget.alert?.id ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      title: _titleCtrl.text.trim(),
      details:
          _detailsCtrl.text.trim().isEmpty ? null : _detailsCtrl.text.trim(),
      type: _type,
      dateTime: dt,
      repeat: _repeat,
      when: _when,
      soundEnabled: _sound,
      vibrate: _vibrate,
      notificationId: widget.alert?.notificationId,
    );

    Navigator.pop(context, alert);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        title: Text(
          widget.alert == null ? '🔔 تنبيه جديد' : 'تعديل التنبيه',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _field('عنوان التنبيه *', _titleCtrl,
              'مثال: امتحان الفيزياء الطبية'),
          _field('التفاصيل (اختياري)', _detailsCtrl,
              'مثال: الفصل الثالث - قاعة 101',
              maxLines: 2),

          // النوع
          _label('النوع'),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: AlertType.values.map((t) {
              final selected = _type == t;
              final color = Color(t.color);
              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => setState(() => _type = t),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? color : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected ? color : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(t.emoji, style: const TextStyle(fontSize: 13)),
                      const SizedBox(width: 4),
                      Text(
                        t.label,
                        style: TextStyle(
                          fontSize: 12.5,
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

          // التاريخ والوقت
          _label('التاريخ والوقت'),
          Row(
            children: [
              Expanded(
                child: _picker(
                  icon: Icons.calendar_today_rounded,
                  label: '${_date.year}/${_date.month}/${_date.day}',
                  onTap: _pickDate,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _picker(
                  icon: Icons.access_time_rounded,
                  label:
                      '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}',
                  onTap: _pickTime,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // وقت التنبيه
          _label('موعد الإشعار'),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: ReminderWhen.values.map((w) {
              final selected = _when == w;
              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => setState(() => _when = w),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: selected ? _primary : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected ? _primary : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    w.label,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: selected ? Colors.white : AppColors.textDark,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // التكرار
          _label('التكرار'),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: AlertRepeat.values.map((r) {
              final selected = _repeat == r;
              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => setState(() => _repeat = r),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? _primary : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected ? _primary : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    r.label,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: selected ? Colors.white : AppColors.textDark,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // الصوت والاهتزاز
          _label('الصوت والاهتزاز'),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  SwitchListTile(
                    value: _sound,
                    onChanged: (v) => setState(() => _sound = v),
                    title: const Text('صوت التنبيه',
                        style: TextStyle(fontSize: 14)),
                    secondary: const Icon(Icons.volume_up_rounded,
                        color: _primary),
                    activeThumbColor: _primary,
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    value: _vibrate,
                    onChanged: (v) => setState(() => _vibrate = v),
                    title: const Text('اهتزاز',
                        style: TextStyle(fontSize: 14)),
                    secondary: const Icon(Icons.vibration_rounded,
                        color: _primary),
                    activeThumbColor: _primary,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

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
                widget.alert == null ? 'حفظ التنبيه' : 'حفظ التعديلات',
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

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark)),
    );
  }

  Widget _field(String label, TextEditingController ctrl, String hint,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(label),
          TextField(
            controller: ctrl,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
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

  Widget _picker({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
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
        child: Row(
          children: [
            Icon(icon, size: 18, color: _primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}