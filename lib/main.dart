import 'package:flutter/material.dart';
import 'utils/app_colors.dart';
import 'screens/main_navigation.dart';
import 'features/alerts/notification_service.dart';
import 'features/welcome/welcome_storage.dart';
import 'features/welcome/welcome_screen.dart';
import 'core/error/error_queue.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(const MedicalPhysicsApp());
}

class MedicalPhysicsApp extends StatelessWidget {
  const MedicalPhysicsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'الفيزياء الطبية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: AppColors.background,
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      home: const RootGate(),
    );
  }
}

// ═══════════════════════════════════════════════════
//  بوابة الدخول — تتحقق من التسجيل
// ═══════════════════════════════════════════════════
class RootGate extends StatefulWidget {
  const RootGate({super.key});

  @override
  State<RootGate> createState() => _RootGateState();
}

class _RootGateState extends State<RootGate> {
  bool _loading = true;
  bool _registered = false;

  @override
  void initState() {
    super.initState();
    _check();
  }

  Future<void> _check() async {
    final r = await WelcomeStorage.isRegistered();
    if (!mounted) return;
    setState(() {
      _registered = r;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0F172A),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF06B6D4)),
        ),
      );
    }
    return _registered ? const MainNavigation() : const WelcomeScreen();
  }
}