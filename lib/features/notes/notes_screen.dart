import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import 'note_model.dart';
import 'notes_storage.dart';
import 'widgets/day_notes_sheet.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  static const Color _primary = Color(0xFFF59E0B);
  static const Color _secondary = Color(0xFFEF4444);

  List<Note> _notes = [];
  bool _loading = true;
  DateTime _currentMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final notes = await NotesStorage.load();
    setState(() {
      _notes = notes;
      _loading = false;
    });
  }

  // ─── التنقل بين الشهور ───
  void _prevMonth() => setState(() {
        _currentMonth = DateTime(
            _currentMonth.year, _currentMonth.month - 1, 1);
      });

  void _nextMonth() => setState(() {
        _currentMonth = DateTime(
            _currentMonth.year, _currentMonth.month + 1, 1);
      });

  void _today() => setState(() => _currentMonth = DateTime.now());

  // ─── عدد الملاحظات في يوم ───
  int _countForDay(DateTime day) {
    return _notes.where((n) =>
        n.date.year == day.year &&
        n.date.month == day.month &&
        n.date.day == day.day).length;
  }

  // ─── فتح نافذة اليوم ───
  Future<void> _openDay(DateTime day) async {
    final result = await showModalBottomSheet<List<Note>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DayNotesSheet(
        day: day,
        notes: _notes.where((n) =>
            n.date.year == day.year &&
            n.date.month == day.month &&
            n.date.day == day.day).toList(),
      ),
    );

    if (result != null) {
      setState(() {
        _notes.removeWhere((n) =>
            n.date.year == day.year &&
            n.date.month == day.month &&
            n.date.day == day.day);
        _notes.addAll(result);
      });
      await NotesStorage.save(_notes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        title: const Text('📝 ملاحظاتي',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'اليوم',
            icon: const Icon(Icons.today_rounded),
            onPressed: _today,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              color: _primary,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildStats(),
                  const SizedBox(height: 16),
                  _buildCalendar(),
                  const SizedBox(height: 16),
                  _buildUpcomingList(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }

  // ─── الإحصائيات ───
  Widget _buildStats() {
    final now = DateTime.now();
    final today = _countForDay(now);
    final month = _notes
        .where((n) =>
            n.date.year == now.year && n.date.month == now.month)
        .length;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_primary, _secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(child: _stat('${_notes.length}', 'إجمالي')),
          Container(
              width: 1,
              height: 40,
              color: Colors.white.withValues(alpha: 0.3)),
          Expanded(child: _stat('$month', 'هذا الشهر')),
          Container(
              width: 1,
              height: 40,
              color: Colors.white.withValues(alpha: 0.3)),
          Expanded(child: _stat('$today', 'اليوم')),
        ],
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 11.5)),
      ],
    );
  }

  // ─── التقويم ───
  Widget _buildCalendar() {
    final days = _daysInMonth(_currentMonth);
    final firstWeekday = DateTime(_currentMonth.year, _currentMonth.month, 1)
            .weekday %
        7; // 0 = السبت
    final today = DateTime.now();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // رأس الشهر
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_right_rounded,
                    color: _primary),
                onPressed: _prevMonth,
              ),
              Expanded(
                child: Text(
                  _monthName(_currentMonth),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_left_rounded,
                    color: _primary),
                onPressed: _nextMonth,
              ),
            ],
          ),
          const SizedBox(height: 8),
          // أيام الأسبوع
          Row(
            children: ['سبت', 'أحد', 'اثنين', 'ثلاثاء', 'أربعاء', 'خميس', 'جمعة']
                .map((d) => Expanded(
                      child: Center(
                        child: Text(
                          d,
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            color: _primary.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 6),
          const Divider(height: 1),
          const SizedBox(height: 6),
          // الشبكة
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 0.92,
            ),
            itemCount: firstWeekday + days,
            itemBuilder: (ctx, i) {
              if (i < firstWeekday) return const SizedBox.shrink();
              final day = i - firstWeekday + 1;
              final date = DateTime(
                  _currentMonth.year, _currentMonth.month, day);
              final isToday = date.year == today.year &&
                  date.month == today.month &&
                  date.day == today.day;
              final count = _countForDay(date);

              return _dayCell(date, day, isToday, count);
            },
          ),
        ],
      ),
    );
  }

  Widget _dayCell(DateTime date, int day, bool isToday, int count) {
    final hasNotes = count > 0;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => _openDay(date),
      child: Container(
        decoration: BoxDecoration(
          color: isToday
              ? _primary.withValues(alpha: 0.15)
              : hasNotes
                  ? _primary.withValues(alpha: 0.06)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isToday
              ? Border.all(color: _primary, width: 1.5)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$day',
              style: TextStyle(
                fontSize: 13,
                fontWeight: isToday || hasNotes
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: isToday
                    ? _primary
                    : hasNotes
                        ? AppColors.textDark
                        : AppColors.textLight,
              ),
            ),
            const SizedBox(height: 3),
            if (hasNotes)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: _primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$count',
                  style: const TextStyle(
                    fontSize: 8.5,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else
              const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ─── قائمة الملاحظات القادمة ───
  Widget _buildUpcomingList() {
    final upcoming = _notes
        .where((n) => !n.date.isBefore(
            DateTime.now().subtract(const Duration(days: 1))))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    if (upcoming.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            const Text('الملاحظات القادمة',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark)),
          ],
        ),
        const SizedBox(height: 10),
        ...upcoming.take(5).map(_upcomingTile),
      ],
    );
  }

  Widget _upcomingTile(Note n) {
    final color = Color(int.parse('FF${n.colorHex}', radix: 16));
    final daysAway = n.date
        .difference(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day))
        .inDays;

    final label = daysAway == 0
        ? 'اليوم'
        : daysAway == 1
            ? 'غداً'
            : 'بعد $daysAway يوم';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 38,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(n.title,
                    style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(
                  '${n.date.year}/${n.date.month}/${n.date.day}${n.time != null ? " • ${n.time}" : ""}',
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textLight),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(label,
                style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    color: color)),
          ),
        ],
      ),
    );
  }

  // ─── مساعدات ───
  int _daysInMonth(DateTime m) =>
      DateTime(m.year, m.month + 1, 0).day;

  String _monthName(DateTime m) {
    const months = [
      'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
    ];
    return '${months[m.month - 1]} ${m.year}';
  }
}