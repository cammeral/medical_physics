import 'dart:math' as math;
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════
//  ذرة متحركة (Atom Animation)
// ═══════════════════════════════════════════════════
class AtomAnimation extends StatelessWidget {
  final double progress; // 0.0 → 1.0
  final Color color;
  final double size;

  const AtomAnimation({
    super.key,
    required this.progress,
    required this.color,
    this.size = 180,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _AtomPainter(progress: progress, color: color),
      ),
    );
  }
}

class _AtomPainter extends CustomPainter {
  final double progress;
  final Color color;

  _AtomPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;

    // 3 مدارات بيضاوية بزوايا مختلفة
    for (int i = 0; i < 3; i++) {
      final angle = i * math.pi / 3;
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle);

      // المدار
      final orbitPaint = Paint()
        ..color = color.withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset.zero,
          width: r * 1.85,
          height: r * 0.55,
        ),
        orbitPaint,
      );

      // الإلكترون
      final electronAngle = progress * 2 * math.pi + i * 2 * math.pi / 3;
      final ex = math.cos(electronAngle) * r * 0.925;
      final ey = math.sin(electronAngle) * r * 0.275;

      // توهج الإلكترون
      canvas.drawCircle(
        Offset(ex, ey),
        10,
        Paint()..color = color.withValues(alpha: 0.25),
      );
      // جسم الإلكترون
      canvas.drawCircle(
        Offset(ex, ey),
        5,
        Paint()..color = Colors.white,
      );
      canvas.drawCircle(
        Offset(ex, ey),
        3.5,
        Paint()..color = color,
      );

      canvas.restore();
    }

    // النواة المتوهجة
    final nucleusGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withValues(alpha: 0.6),
          color.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: 28));
    canvas.drawCircle(center, 28, nucleusGlow);

    // النواة
    final nucleusPaint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.white, color],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: 12));
    canvas.drawCircle(center, 12, nucleusPaint);
  }

  @override
  bool shouldRepaint(covariant _AtomPainter old) =>
      old.progress != progress || old.color != color;
}

// ═══════════════════════════════════════════════════
//  نبضات إشعاعية (Radiation Pulse)
// ═══════════════════════════════════════════════════
class RadiationPulse extends StatelessWidget {
  final double progress;
  final Color color;
  final double size;

  const RadiationPulse({
    super.key,
    required this.progress,
    required this.color,
    this.size = 260,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RadiationPainter(progress: progress, color: color),
      ),
    );
  }
}

class _RadiationPainter extends CustomPainter {
  final double progress;
  final Color color;

  _RadiationPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < 3; i++) {
      final p = (progress + i / 3) % 1.0;
      final radius = size.width / 2 * p;
      final opacity = (1 - p) * 0.4;
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..color = color.withValues(alpha: opacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RadiationPainter old) =>
      old.progress != progress;
}

// ═══════════════════════════════════════════════════
//  جسيمات طافية (Floating Particles)
// ═══════════════════════════════════════════════════
class FloatingParticles extends StatelessWidget {
  final double progress;
  final Color color;
  final int count;

  const FloatingParticles({
    super.key,
    required this.progress,
    required this.color,
    this.count = 20,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ParticlesPainter(
        progress: progress,
        color: color,
        count: count,
      ),
    );
  }
}

class _ParticlesPainter extends CustomPainter {
  final double progress;
  final Color color;
  final int count;

  _ParticlesPainter({
    required this.progress,
    required this.color,
    required this.count,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);
    for (int i = 0; i < count; i++) {
      final seedX = random.nextDouble();
      final seedY = random.nextDouble();
      final speed = 0.5 + random.nextDouble();
      final radius = 1.0 + random.nextDouble() * 2.0;

      final y = (seedY - progress * speed) % 1.0;
      final x = seedX + math.sin(progress * 2 * math.pi + i) * 0.02;

      final opacity = 0.15 + (1 - (y.abs() - 0.5).abs() * 2) * 0.3;
      canvas.drawCircle(
        Offset(x * size.width, y * size.height),
        radius,
        Paint()..color = color.withValues(alpha: opacity),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlesPainter old) =>
      old.progress != progress;
}