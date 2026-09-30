import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import 'class_model.dart';
import 'study_schedule_storage.dart';
import 'add_class_screen.dart';
import 'widgets/class_card.dart';
import 'schedule_notifier.dart';
import '../../../core/error/error_hooks.dart';

class StudyScheduleScreen extends StatefulWidget {
  const StudyScheduleScreen({super.key});

  @override
  State<StudyScheduleScreen> createState() => _StudyScheduleScreenState();
}

class _StudyScheduleScreenState extends State<StudyScheduleScreen> {
  static const Color _primary = Color(0xFF4A6CF7);
  static const Color _secondary = Color(0xFF7C3AED);

  List<ClassItem> _classes = [];
  bool _loading = true;
  late WeekDay _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = todayWeekDay() ?? WeekDay.saturday;
    _load();
  }

  Future<void> _load() async {
    final classes = await StudyScheduleStorage.load();
    setState(() {
      _classes = classes;
      _loading = false;
    });
  }

  List<ClassItem> get _dayClasses {
    final list =
        _classes.where((c) => c.day == _selectedDay).toList();
    list.sort((a, b) => a.startTime.compareTo(b.startTime));
    return list;
  }

  int _countFor(WeekDay d) =>
      _classes.where((c) => c.day == d).length;

  Future<void> _addClass() async {
    final result = await Navigator.push<ClassItem>(
      context,
      MaterialPageRoute(
        builder: (_) => AddClassScreen(initialDay: _selectedDay),
      ),
    );
    if (result != null) {
      setState(() => _classes.add(result));
      await StudyScheduleStorage.save(_classes);
      bumpScheduleVersion(); 
          // 📤 إشعار صامت
    Errors.lecture(
      subject: result.subject,
      day: result.day.arabic,
      time: result.timeRange,
      location: result.location,
      professor: result.professor,
    );// ← إعلام الرئيسية
    }
  }

  Future<void> _editClass(ClassItem item) async {
    final result = await Navigator.push<ClassItem>(
      context,
      MaterialPageRoute(
        builder: (_) => AddClassScreen(item: item),
      ),
    );
    if (result != null) {
      final i = _classes.indexWhere((e) => e.id == result.id);
      if (i != -1) {
        setState(() => _classes[i] = result);
        await StudyScheduleStorage.save(_classes);
        bumpScheduleVersion(); // ← إعلام الرئيسية
      }
    }
  }

  Future<void> _deleteClass(ClassItem item) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('حذف المحاضرة'),
        content: Text(
            'هل تريد حذف "${item.subject}" من يوم ${item.day.arabic}؟'),
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
      setState(() => _classes.removeWhere((e) => e.id == item.id));
      await StudyScheduleStorage.save(_classes);
      bumpScheduleVersion(); // ← إعلام الرئيسية
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        title: const Text('📅 جدول الدراسة',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'اليوم',
            icon: const Icon(Icons.today_rounded),
            onPressed: () {
              final t = todayWeekDay();
              if (t != null) setState(() => _selectedDay = t);
            },
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              color: _primary,
              child: Column(
                children: [
                  _buildStats(),
                  _buildDaysSelector(),
                  const Divider(height: 1),
                  Expanded(child: _buildDayContent()),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addClass,
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('محاضرة جديدة',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  // ─── الإحصائيات ───
  Widget _buildStats() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_primary, _secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: _statItem(
              '${_classes.length}',
              'إجمالي المحاضرات',
              Icons.menu_book_rounded,
            ),
          ),
          Container(
              width: 1,
              height: 44,
              color: Colors.white.withValues(alpha: 0.3)),
          Expanded(
            child: _statItem(
              '${_classes.where((c) => c.professor != null && c.professor!.isNotEmpty).map((c) => c.professor).toSet().length}',
              'عدد الأساتذة',
              Icons.person_rounded,
            ),
          ),
          Container(
              width: 1,
              height: 44,
              color: Colors.white.withValues(alpha: 0.3)),
          Expanded(
            child: _statItem(
              '${_classes.where((c) => c.location != null && c.location!.isNotEmpty).map((c) => c.location).toSet().length}',
              'عدد القاعات',
              Icons.location_on_rounded,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.85), size: 18),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 10.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // ─── اختيار اليوم ───
  Widget _buildDaysSelector() {
    final today = todayWeekDay();
    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: WeekDay.values.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (ctx, i) {
          final d = WeekDay.values[i];
          final selected = d == _selectedDay;
          final isToday = d == today;
          final count = _countFor(d);

          return InkWell(
            onTap: () => setState(() => _selectedDay = d),
            borderRadius: BorderRadius.circular(14),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 72,
              decoration: BoxDecoration(
                color: selected ? _primary : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected
                      ? _primary
                      : isToday
                          ? _primary.withValues(alpha: 0.5)
                          : Colors.grey.shade200,
                  width: isToday && !selected ? 2 : 1,
                ),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: _primary.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : null,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // ← مهم
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      d.emoji,
                      style: const TextStyle(fontSize: 16), // ← من 18 إلى 16
                    ),
                    const SizedBox(height: 3),
                    Text(
                      d.short,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color:
                            selected ? Colors.white : AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    if (count > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: selected
                              ? Colors.white.withValues(alpha: 0.25)
                              : _primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$count',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: selected ? Colors.white : _primary,
                          ),
                        ),
                      )
                    else
                      const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ─── محتوى اليوم ───
  Widget _buildDayContent() {
    if (_dayClasses.isEmpty) return _buildEmpty();

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      itemCount: _dayClasses.length,
      itemBuilder: (ctx, i) => ClassCard(
        item: _dayClasses[i],
        index: i + 1,
        isToday: _selectedDay == todayWeekDay(),
        onTap: () => _editClass(_dayClasses[i]),
        onDelete: () => _deleteClass(_dayClasses[i]),
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
              child: Text(_selectedDay.emoji,
                  style: const TextStyle(fontSize: 44)),
            ),
            const SizedBox(height: 16),
            Text(
              'لا توجد محاضرات يوم ${_selectedDay.arabic}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            const Text(
              'أضف أول محاضرة لهذا اليوم',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textLight,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _addClass,
              icon: const Icon(Icons.add_rounded),
              label: const Text('إضافة محاضرة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}