import 'dart:async';
import 'package:flutter/material.dart';
import '../news_facts.dart';

class NewsBar extends StatefulWidget {
  const NewsBar({super.key});

  @override
  State<NewsBar> createState() => _NewsBarState();
}

class _NewsBarState extends State<NewsBar> {
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), (_) => _advance());
  }

  void _advance() {
    if (!mounted) return;
    setState(() => _index = (_index + 1) % newsFacts.length);
  }

  void _onTap() {
    _advance();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE0F2FE), Color(0xFFEDE9FE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFF7C3AED).withValues(alpha: 0.15),
          ),
        ),
        child: Row(
          children: [
            // الأيقونة
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7C3AED), Color(0xFFA855F7)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('📢', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(width: 10),

            // النص المتحرك
            Expanded(
              child: SizedBox(
                height: 40,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.15, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: Align(
                    key: ValueKey(_index),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      newsFacts[_index],
                      style: const TextStyle(
                        fontSize: 12.5,
                        height: 1.5,
                        color: Color(0xFF4C1D95),
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 6),

            // مؤشر التقدم
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.touch_app_rounded,
                  size: 14,
                  color: const Color(0xFF7C3AED).withValues(alpha: 0.5),
                ),
                const SizedBox(height: 2),
                Text(
                  '${_index + 1}',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF7C3AED).withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}