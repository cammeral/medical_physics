import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../features/grades/grades_screen.dart';
import '../features/files/files_screen.dart';
import '../features/notes/notes_screen.dart';
import '../features/study_schedule/study_schedule_screen.dart';
import '../features/alerts/alerts_screen.dart';
import '../features/expenses/expenses_screen.dart';

class MySpaceScreen extends StatelessWidget {
  const MySpaceScreen({super.key});

  static const Color _primary = Color(0xFF7C3AED);
  static const Color _secondary = Color(0xFFA855F7);

  @override
  Widget build(BuildContext context) {
    final tools = [
_SpaceTool(
  '📊', 'الدرجات',
  'سجّل درجاتك واحسب معدلك',
  const Color(0xFF7C3AED),
  Icons.grade_rounded,
  page: () => const GradesScreen(),   // ← أضف هذا
),
_SpaceTool(
  '📁', 'الملفات',
  'ارفع ملفاتك وملخصاتك',
  const Color(0xFFEC4899),
  Icons.folder_rounded,
  page: () => const FilesScreen(),
),
_SpaceTool(
  '📝', 'الملاحظات',
  'دوّن ملاحظاتك على تقويم',
  const Color(0xFFF59E0B),
  Icons.edit_note_rounded,
  page: () => const NotesScreen(),
),
_SpaceTool(
  '🔔', 'التنبيهات',
  'تنبيهات بالمواعيد المهمة',
  const Color(0xFFEF4444),
  Icons.notifications_active_rounded,
  page: () => const AlertsScreen(),
),
_SpaceTool(
  '⏰', 'جدول الدراسة',
  'خطّط محاضراتك الأسبوعية',
  const Color(0xFF4A6CF7),
  Icons.schedule_rounded,
  page: () => const StudyScheduleScreen(),
),
_SpaceTool(
  '💰', 'المصاريف',
  'تقسيط ومصاريف يومية',
  const Color(0xFF10B981),
  Icons.account_balance_wallet_rounded,
  page: () => const ExpensesScreen(),
),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // الهيدر البنفسجي
          SliverToBoxAdapter(child: _buildHeader()),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
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
                    'أدواتي',
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 155,
              ),
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => _buildToolCard(context, tools[i]),
                childCount: tools.length,
              ),
            ),
          ),
                    const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_primary, _secondary],
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: const Icon(Icons.person_rounded,
                      color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'مساحتي الشخصية 👤',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'أدواتك الخاصة في مكان واحد',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // شريط ترحيبي
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                ),
              ),
              child: const Row(
                children: [
                  Text('✨', style: TextStyle(fontSize: 18)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'قريباً: سنبني كل أداة من هذه الأدوات خطوة بخطوة',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
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

  Widget _buildToolCard(BuildContext context, _SpaceTool tool) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
onTap: () {
  if (tool.page != null) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => tool.page!()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${tool.title} قادم قريباً 🚧'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
},
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: tool.color.withValues(alpha: 0.15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: tool.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(tool.emoji,
                        style: const TextStyle(fontSize: 24)),
                  ),
                  Icon(
                    tool.icon,
                    color: tool.color.withValues(alpha: 0.3),
                    size: 24,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                tool.title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: tool.color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                tool.subtitle,
                style: const TextStyle(
                  fontSize: 11.5,
                  height: 1.4,
                  color: AppColors.textLight,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpaceTool {
  final String emoji;
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final Widget Function()? page;   // ← أضف هذا
  _SpaceTool(this.emoji, this.title, this.subtitle, this.color, this.icon, {this.page});
}