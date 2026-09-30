import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import 'grade_model.dart';
import 'grades_storage.dart';
import 'subject_detail_screen.dart';
import 'add_subject_screen.dart';
import 'report_card_screen.dart';

class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  static const Color _primary = Color(0xFF7C3AED);
  static const Color _secondary = Color(0xFFA855F7);

  List<Subject> _subjects = [];
  StudentProfile _profile = StudentProfile();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final subjects = await GradesStorage.loadSubjects();
    final profile = await GradesStorage.loadProfile();
    setState(() {
      _subjects = subjects;
      _profile = profile;
      _loading = false;
    });
  }

  Future<void> _addSubject() async {
    final result = await Navigator.push<Subject>(
      context,
      MaterialPageRoute(builder: (_) => const AddSubjectScreen()),
    );
    if (result != null) {
      setState(() => _subjects.add(result));
      await GradesStorage.saveSubjects(_subjects);
    }
  }

  Future<void> _openSubject(Subject s) async {
    final updated = await Navigator.push<Subject>(
      context,
      MaterialPageRoute(
        builder: (_) => SubjectDetailScreen(subject: s),
      ),
    );
    if (updated != null) {
      final i = _subjects.indexWhere((e) => e.id == updated.id);
      if (i != -1) {
        setState(() => _subjects[i] = updated);
        await GradesStorage.saveSubjects(_subjects);
      }
    }
  }

  Future<void> _deleteSubject(Subject s) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('حذف المادة'),
        content: Text('هل تريد حذف "${s.name}" وجميع درجاتها؟'),
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
      setState(() => _subjects.removeWhere((e) => e.id == s.id));
      await GradesStorage.saveSubjects(_subjects);
    }
  }

  double? get _overallGPA {
    final withGrades =
        _subjects.where((s) => s.weightedAverage != null).toList();
    if (withGrades.isEmpty) return null;
    double sum = 0;
    for (final s in withGrades) {
      sum += s.weightedAverage!;
    }
    return sum / withGrades.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        title: const Text('📊 الدرجات',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'الإعدادات',
            icon: const Icon(Icons.settings_rounded),
            onPressed: _openSettings,
          ),
          IconButton(
            tooltip: 'تصدير PDF',
            icon: const Icon(Icons.picture_as_pdf_rounded),
            onPressed: _subjects.isEmpty ? null : _openReportCard,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _subjects.isEmpty
              ? _buildEmpty()
              : RefreshIndicator(
                  onRefresh: _load,
                  color: _primary,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildStatsCard(),
                      const SizedBox(height: 16),
                      ..._subjects.map(_buildSubjectCard),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addSubject,
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('إضافة مادة',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  // ─── الإحصائيات ───
  Widget _buildStatsCard() {
    final gpa = _overallGPA;
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
          Expanded(
            child: _statItem('${_subjects.length}', 'مواد'),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          Expanded(
            child: _statItem(
              gpa == null ? '—' : '${gpa.toStringAsFixed(1)}%',
              'المعدل العام',
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          Expanded(
            child: _statItem(
              gpa == null ? '—' : _textFromPercent(gpa),
              'التقدير',
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 11.5,
          ),
        ),
      ],
    );
  }

  String _textFromPercent(double p) {
    if (p >= 90) return 'ممتاز';
    if (p >= 80) return 'جيد جداً';
    if (p >= 70) return 'جيد';
    if (p >= 60) return 'متوسط';
    if (p >= 50) return 'مقبول';
    return 'راسب';
  }

  // ─── بطاقة المادة ───
  Widget _buildSubjectCard(Subject s) {
    final avg = s.weightedAverage;
    final color = _colorForGrade(avg);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => _openSubject(s),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${s.grades.length}',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${s.grades.length} درجة مسجّلة',
                            style: const TextStyle(
                              fontSize: 11.5,
                              color: AppColors.textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          avg == null ? '—' : '${avg.toStringAsFixed(1)}%',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        Text(
                          s.displayTextGrade,
                          style: TextStyle(
                            fontSize: 11,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline_rounded,
                          size: 18, color: AppColors.textLight),
                      onPressed: () => _deleteSubject(s),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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

  // ─── شاشة فارغة ───
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
              child: const Text('📊', style: TextStyle(fontSize: 42)),
            ),
            const SizedBox(height: 16),
            const Text(
              'ابدأ بتسجيل درجاتك',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'أضف موادك ودرجاتك لحساب معدلك تلقائياً',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textLight,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _addSubject,
              icon: const Icon(Icons.add_rounded),
              label: const Text('إضافة مادة'),
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

  Future<void> _openSettings() async {
    final result = await Navigator.push<StudentProfile>(
      context,
      MaterialPageRoute(
        builder: (_) => _ProfileSettingsScreen(profile: _profile),
      ),
    );
    if (result != null) {
      setState(() => _profile = result);
      await GradesStorage.saveProfile(_profile);
    }
  }

  Future<void> _openReportCard() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReportCardScreen(
          subjects: _subjects,
          profile: _profile,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
//  إعدادات الملف الشخصي
// ═══════════════════════════════════════════════════
class _ProfileSettingsScreen extends StatefulWidget {
  final StudentProfile profile;
  const _ProfileSettingsScreen({required this.profile});

  @override
  State<_ProfileSettingsScreen> createState() =>
      _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<_ProfileSettingsScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _uniCtrl;
  late TextEditingController _depCtrl;
  late TextEditingController _yearCtrl;
  late TextEditingController _msgCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.profile.name);
    _uniCtrl = TextEditingController(text: widget.profile.university);
    _depCtrl = TextEditingController(text: widget.profile.department);
    _yearCtrl = TextEditingController(text: widget.profile.academicYear);
    _msgCtrl = TextEditingController(
        text: widget.profile.motivationalMessage ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _uniCtrl.dispose();
    _depCtrl.dispose();
    _yearCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  void _save() {
    final p = StudentProfile(
      name: _nameCtrl.text.trim(),
      university: _uniCtrl.text.trim(),
      department: _depCtrl.text.trim(),
      academicYear: _yearCtrl.text.trim(),
      motivationalMessage: _msgCtrl.text.trim().isEmpty
          ? null
          : _msgCtrl.text.trim(),
    );
    Navigator.pop(context, p);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: const Color(0xFF7C3AED),
        foregroundColor: Colors.white,
        title: const Text('الملف الشخصي'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _field('الاسم الكامل', _nameCtrl, 'مثال: أحمد محمد'),
          _field('الجامعة', _uniCtrl, 'مثال: جامعة بغداد'),
          _field('القسم', _depCtrl, 'مثال: الفيزياء الطبية'),
          _field('السنة الدراسية', _yearCtrl, 'مثال: 2026/2027'),
          _field(
            'رسالة تحفيزية (اختياري)',
            _msgCtrl,
            'مثال: النجاح رحلة، لا محطة',
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C3AED),
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

  Widget _field(String label, TextEditingController ctrl, String hint,
      {int maxLines = 1}) {
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
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: ctrl,
            maxLines: maxLines,
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