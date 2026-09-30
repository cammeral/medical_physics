import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../models/reminder.dart';
import '../services/storage_service.dart';
import 'add_reminder_screen.dart';
import 'tools_screen.dart';
import '../features/news/widgets/news_bar.dart';
import '../features/study_schedule/class_model.dart';
import '../features/study_schedule/study_schedule_storage.dart';
import '../features/study_schedule/schedule_notifier.dart';
import '../features/alerts/alert_model.dart';
import '../core/error/error_hooks.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState(); // ← بدون underscore
}

class HomeScreenState extends State<HomeScreen> {
  List<Reminder> _reminders = [];
  List<ClassItem> _todayClasses = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
    scheduleVersion.addListener(_onScheduleChanged);
  }

  @override
  void dispose() {
    scheduleVersion.removeListener(_onScheduleChanged);
    super.dispose();
  }

  void _onScheduleChanged() {
    _loadTodayClasses();
  }

  Alert? _nextAlert;

  Future<void> _load() async {
    try {
      final data = await StorageService.loadReminders();
      await _loadTodayClasses();
      if (!mounted) return;
      setState(() {
        _reminders = data;
        _loading = false;
      });
    } catch (e, st) {
      debugPrint('❌ _load error: $e');
      debugPrint('$st');
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  // ⭐ دالة عامة لتحميل محاضرات اليوم من جدول الدراسة
  Future<void> reload() async {
    await _loadTodayClasses();
  }

  Future<void> _loadTodayClasses() async {
    try {
      final classes = await StudyScheduleStorage.load();
      final today = todayWeekDay();

      if (today == null) {
        if (mounted) {
          setState(() => _todayClasses = []);
        }
        return;
      }

      final filtered = classes
          .where((c) => c.day == today)
          .toList()
        ..sort((a, b) => a.startTime.compareTo(b.startTime));

      if (mounted) {
        setState(() => _todayClasses = filtered);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _todayClasses = []);
      }
    }
  }

  Future<void> _addReminder() async {
    final result = await Navigator.push<Reminder>(
      context,
      MaterialPageRoute(builder: (_) => const AddReminderScreen()),
    );
    if (result != null) {
      setState(() => _reminders.add(result));
      await StorageService.saveReminders(_reminders);
    }
  }

  Future<void> _toggleDone(Reminder r) async {
    final i = _reminders.indexWhere((e) => e.id == r.id);
    if (i == -1) return;
    setState(() => _reminders[i] = _reminders[i].copyWith(done: !r.done));
    await StorageService.saveReminders(_reminders);
  }

  Future<void> _delete(Reminder r) async {
    setState(() => _reminders.removeWhere((e) => e.id == r.id));
    await StorageService.saveReminders(_reminders);
  }

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'صباح الخير';
    if (h < 18) return 'مساء الخير';
    return 'مساء الخير';
  }

  String get _emoji {
    final h = DateTime.now().hour;
    if (h < 12) return '🌅';
    if (h < 18) return '☀️';
    return '🌆';
  }

  String get _arabicDate {
    final n = DateTime.now();
    const m = [
      'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
    ];
    const d = [
      'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس',
      'الجمعة', 'السبت', 'الأحد'
    ];
    return '${d[n.weekday - 1]}، ${n.day} ${m[n.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final active = _reminders.where((e) => !e.done).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: _load,
        color: AppColors.primary,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(active)),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            const SliverToBoxAdapter(child: NewsBar()),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // جدول اليوم
            // جدول اليوم
            SliverToBoxAdapter(
              child: _sectionTitle(
                'جدول اليوم',
                trailing: _todayClasses.isEmpty
                    ? 'عطلة'
                    : '${_todayClasses.length} محاضرة',
              ),
            ),
            SliverToBoxAdapter(
              child: _buildTodaySchedule(),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            if (_nextAlert != null) ...[
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverToBoxAdapter(child: _buildNextAlertBanner()),
            ],

            // التذكيرات
            SliverToBoxAdapter(
              child: _sectionTitle(
                'التذكيرات',
                trailing: active > 0 ? '$active نشط' : 'لا جديد',
              ),
            ),
            SliverToBoxAdapter(child: _buildReminders()),
            const SliverToBoxAdapter(child: SizedBox(height: 90)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addReminder,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 6,
        icon: const Icon(Icons.add_rounded, size: 24),
        label: const Text(
          'تذكير جديد',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ),
    );
  }

  Widget _buildNextAlertBanner() {
    final a = _nextAlert!;
    final color = Color(a.type.color);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(a.type.emoji,
                style: const TextStyle(fontSize: 20)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(a.title,
                    style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: color)),
                const SizedBox(height: 3),
                Text(
                  '${a.timeLeftLabel} • ${a.dateTime.hour.toString().padLeft(2, '0')}:${a.dateTime.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 11.5, color: color),
                ),
              ],
            ),
          ),
          Icon(Icons.notifications_active_rounded,
              color: color, size: 22),
        ],
      ),
    );
  }

  // ─── الهيدر ───
  // ─── الهيدر ───
  Widget _buildHeader(int active) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(Icons.school_rounded,
                      color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$_greeting $_emoji',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _arabicDate,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ),


                // 🔲 زر الأدوات (الموجود)
                Container(
                  margin: const EdgeInsets.only(left: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    tooltip: 'الأدوات',
                    icon: const Icon(Icons.grid_view_rounded,
                        color: Colors.white, size: 20),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ToolsScreen()),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _miniBadge(
                  Icons.menu_book_rounded,
                  '${_todayClasses.length} محاضرات',
                ),
                const SizedBox(width: 8),
                _miniBadge(
                  Icons.notifications_active_rounded,
                  '$active نشط',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _miniBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ─── عنوان قسم ───
  Widget _sectionTitle(String title, {String? trailing}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 18,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const Spacer(),
          if (trailing != null)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                trailing,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ─── جدول اليوم ───
  // ⭐ جدول اليوم (من جدول الدراسة)
  Widget _buildTodaySchedule() {
    if (_todayClasses.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF06B6A4).withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Text('🎉', style: TextStyle(fontSize: 30)),
            ),
            const SizedBox(height: 12),
            const Text(
              'لا توجد محاضرات اليوم',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'استمتع بيومك! ☕',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textLight,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: List.generate(_todayClasses.length, (i) {
          final c = _todayClasses[i];
          final color = Color(int.parse('FF${c.colorHex}', radix: 16));

          return Padding(
            padding: EdgeInsets.only(
                bottom: i == _todayClasses.length - 1 ? 0 : 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.subject,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          _infoChip(
                            Icons.access_time_rounded,
                            c.timeRange,
                            color,
                          ),
                          if (c.location != null && c.location!.isNotEmpty)
                            _infoChip(
                              Icons.location_on_rounded,
                              c.location!,
                              const Color(0xFF06B6A4),
                            ),
                          if (c.professor != null &&
                              c.professor!.isNotEmpty)
                            _infoChip(
                              Icons.person_rounded,
                              c.professor!,
                              const Color(0xFF9B5DE5),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _infoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 3),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
  // ─── التذكيرات ───
  Widget _buildReminders() {
    if (_reminders.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.notifications_none_rounded,
                  size: 30, color: AppColors.primary),
            ),
            const SizedBox(height: 12),
            const Text('لا توجد تذكيرات',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark)),
            const SizedBox(height: 4),
            const Text('أضف واجباً أو امتحاناً أو تقريراً',
                style: TextStyle(
                    fontSize: 13, color: AppColors.textLight)),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: _reminders.map(_buildReminderTile).toList(),
      ),
    );
  }

  Widget _buildReminderTile(Reminder r) {
    final (c, icon, label) = _typeInfo(r.type);
    final diff = r.dueDate.difference(DateTime.now()).inDays;
    final txt = diff < 0
        ? 'انتهى'
        : diff == 0
            ? 'اليوم'
            : diff == 1
                ? 'غداً'
                : 'بعد $diff يوم';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: r.done
              ? Colors.grey.shade200
              : c.withValues(alpha: 0.25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: c.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: c, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      decoration:
                          r.done ? TextDecoration.lineThrough : null,
                      color: r.done
                          ? AppColors.textLight
                          : AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: c.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(label,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: c)),
                      ),
                      const SizedBox(width: 8),
                      Text(txt,
                          style: TextStyle(
                              fontSize: 11.5,
                              color: diff < 0
                                  ? Colors.red
                                  : AppColors.textLight,
                              fontWeight:
                                  diff <= 1 && diff >= 0
                                      ? FontWeight.bold
                                      : FontWeight.normal)),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                r.done
                    ? Icons.check_circle_rounded
                    : Icons.check_circle_outline_rounded,
                color: r.done
                    ? const Color(0xFF06B6A4)
                    : AppColors.textLight,
              ),
              onPressed: () => _toggleDone(r),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded,
                  color: AppColors.textLight, size: 20),
              onPressed: () => _confirmDelete(r),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(Reminder r) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: const Text('حذف التذكير'),
        content: Text('هل تريد حذف "${r.title}"؟'),
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
    if (ok == true) _delete(r);
  }

  (Color, IconData, String) _typeInfo(ReminderType type) {
    switch (type) {
      case ReminderType.homework:
        return (AppColors.homework, Icons.assignment_rounded, 'واجب');
      case ReminderType.exam:
        return (AppColors.exam, Icons.quiz_rounded, 'امتحان');
      case ReminderType.report:
        return (AppColors.report, Icons.description_rounded, 'تقرير');
    }
  }
}