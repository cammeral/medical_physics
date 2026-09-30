import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../error_model.dart';

class ErrorCard extends StatefulWidget {
  final MedicalError error;
  final Color color;
  final int index;

  const ErrorCard({
    super.key,
    required this.error,
    required this.color,
    required this.index,
  });

  @override
  State<ErrorCard> createState() => _ErrorCardState();
}

class _ErrorCardState extends State<ErrorCard> {
  bool _expanded = false;

  Color get _severityColor {
    switch (widget.error.severity) {
      case ErrorSeverity.low:
        return const Color(0xFF2E7D32);
      case ErrorSeverity.medium:
        return const Color(0xFFF59E0B);
      case ErrorSeverity.high:
        return const Color(0xFFC62828);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _expanded
              ? _severityColor.withValues(alpha: 0.5)
              : Colors.grey.shade200,
          width: _expanded ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          // الرأس
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _severityColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(widget.error.icon,
                        style: const TextStyle(fontSize: 24)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.error.title,
                                style: const TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ),
                            // شارة الخطورة
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 3),
                              decoration: BoxDecoration(
                                color: _severityColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Text(widget.error.severity.emoji,
                                      style: const TextStyle(fontSize: 9)),
                                  const SizedBox(width: 3),
                                  Text(
                                    widget.error.severity.label,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _severityColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.error.subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textLight,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: widget.color,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // المحتوى
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _expanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 1),
                  const SizedBox(height: 12),
                  _section(
                    icon: '❌',
                    label: 'العرض (Symptom)',
                    text: widget.error.symptom,
                    color: const Color(0xFFC62828),
                  ),
                  const SizedBox(height: 10),
                  _section(
                    icon: '🎯',
                    label: 'السبب (Cause)',
                    text: widget.error.cause,
                    color: const Color(0xFFF59E0B),
                  ),
                  const SizedBox(height: 10),
                  _section(
                    icon: '✅',
                    label: 'الحل (Solution)',
                    text: widget.error.solution,
                    color: const Color(0xFF2E7D32),
                  ),
                  const SizedBox(height: 10),
                  _section(
                    icon: '🛡️',
                    label: 'الوقاية (Prevention)',
                    text: widget.error.prevention,
                    color: widget.color,
                  ),
                ],
              ),
            ),
            secondChild: const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }

  Widget _section({
    required String icon,
    required String label,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.65,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}