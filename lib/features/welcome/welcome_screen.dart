import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'widgets/welcome_animations.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _atomCtrl;
  late AnimationController _pulseCtrl;
  late AnimationController _fadeCtrl;

  static const Color _primary = Color(0xFF06B6D4);
  static const Color _secondary = Color(0xFF3B82F6);
  static const Color _accent = Color(0xFF8B5CF6);

  @override
  void initState() {
    super.initState();

    _atomCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _atomCtrl.dispose();
    _pulseCtrl.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F172A), // أزرق داكن
              Color(0xFF1E1B4B), // بنفسجي داكن
              Color(0xFF0C4A6E), // أزرق مزرق
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // جسيمات طافية في الخلفية
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _pulseCtrl,
                builder: (_, __) => FloatingParticles(
                  progress: _pulseCtrl.value,
                  color: _primary,
                  count: 30,
                ),
              ),
            ),

            // نبضات إشعاعية حول الذرة
            Positioned(
              top: size.height * 0.18,
              left: size.width / 2 - 130,
              child: AnimatedBuilder(
                animation: _pulseCtrl,
                builder: (_, __) => RadiationPulse(
                  progress: _pulseCtrl.value,
                  color: _primary,
                  size: 260,
                ),
              ),
            ),

            // الذرة في المنتصف
            Positioned(
              top: size.height * 0.18 + 40,
              left: size.width / 2 - 90,
              child: AnimatedBuilder(
                animation: _atomCtrl,
                builder: (_, __) => AtomAnimation(
                  progress: _atomCtrl.value,
                  color: _primary,
                  size: 180,
                ),
              ),
            ),

            // محتوى الصفحة (يظهر بتدريج)
            Positioned.fill(
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: _fadeCtrl,
                  curve: Curves.easeOut,
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      const Spacer(flex: 5),

                      // العناوين
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          children: [
                            // شعار صغير علوي
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: _primary.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: _primary.withValues(alpha: 0.4),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('⚛️',
                                      style: TextStyle(fontSize: 14)),
                                  SizedBox(width: 6),
                                  Text(
                                    'الفيزياء الطبية',
                                    style: TextStyle(
                                      color: _primary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 18),

                            // العنوان الرئيسي
                            ShaderMask(
                              shaderCallback: (bounds) =>
                                  const LinearGradient(
                                colors: [
                                  Colors.white,
                                  Color(0xFF93C5FD),
                                  Color(0xFFC4B5FD),
                                ],
                              ).createShader(bounds),
                              child: const Text(
                                'مرحباً بك في\nعالم الفيزياء الطبية',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  height: 1.3,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),

                            // الوصف
                            Text(
                              'تطبيقك الشامل لتعلّم الفيزياء الطبية،\nتنظيم دراستك، ومتابعة إنجازاتك.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 14,
                                height: 1.7,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(flex: 3),

                      // زر البدء
                      _buildStartButton(),
                      const SizedBox(height: 24),

                      // النقاط السفلية
                      _buildFeatureChips(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const RegistrationScreen(),
                transitionsBuilder: (_, animation, __, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.1),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOut,
                      )),
                      child: child,
                    ),
                  );
                },
                transitionDuration: const Duration(milliseconds: 500),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_primary, _secondary, _accent],
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ابدأ الآن',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
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
    );
  }

  Widget _buildFeatureChips() {
    final features = [
      ('📚', 'مصادر'),
      ('🔬', 'أدوات'),
      ('📊', 'تتبع'),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: features.map((f) {
          return Column(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
                child: Text(f.$1, style: const TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 6),
              Text(
                f.$2,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 11,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}