import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../usage_section.dart';

class UsageStageCard extends StatefulWidget {
  final UsageStage stage;
  final int index;
  final Color color;
  final bool initiallyExpanded;

  const UsageStageCard({
    super.key,
    required this.stage,
    required this.index,
    required this.color,
    this.initiallyExpanded = false,
  });

  @override
  State<UsageStageCard> createState() => _UsageStageCardState();
}

class _UsageStageCardState extends State<UsageStageCard>
    with SingleTickerProviderStateMixin {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
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
              ? widget.color.withValues(alpha: 0.4)
              : Colors.grey.shade200,
          width: _expanded ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          // رأس البطاقة (قابل للضغط)
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${widget.index}',
                      style: const TextStyle(
                        color: Colors.white,
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
                        Row(
                          children: [
                            Text(widget.stage.icon,
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                widget.stage.title,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '⏱️ ${widget.stage.duration}  •  ${widget.stage.steps.length} خطوات',
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: widget.color,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // المحتوى القابل للطي
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _expanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: _buildContent(),
            secondChild: const SizedBox(width: double.infinity, height: 0),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1),
          const SizedBox(height: 12),

          // الخطوات
          ...widget.stage.steps.asMap().entries.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: widget.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${e.key + 1}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: widget.color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(e.value.icon, style: const TextStyle(fontSize: 14)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        e.value.text,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.65,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                  ],
                ),
              )),

          // Checklist
          if (widget.stage.checklist != null &&
              widget.stage.checklist!.isNotEmpty)
            _buildChecklist(),

          // خطأ شائع
          if (widget.stage.commonMistake != null) _buildMistake(),

          // نصائح الخبراء
          if (widget.stage.expertTips != null &&
              widget.stage.expertTips!.isNotEmpty)
            _buildExpertTips(),
        ],
      ),
    );
  }

  Widget _buildChecklist() {
    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFA5D6A7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.checklist, color: Color(0xFF2E7D32), size: 18),
              SizedBox(width: 6),
              Text(
                'قائمة التحقق (Checklist)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...widget.stage.checklist!.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_box_outline_blank,
                        color: Color(0xFF2E7D32), size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 12.5,
                          height: 1.55,
                          color: Color(0xFF1B5E20),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildMistake() {
    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEF9A9A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.cancel, color: Color(0xFFC62828), size: 18),
              SizedBox(width: 6),
              Text(
                'خطأ شائع',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC62828),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('❌', style: TextStyle(fontSize: 13)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  widget.stage.commonMistake!,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.55,
                    color: Color(0xFFB71C1C),
                  ),
                ),
              ),
            ],
          ),
          if (widget.stage.mistakeFix != null) ...[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('✅', style: TextStyle(fontSize: 13)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    widget.stage.mistakeFix!,
                    style: const TextStyle(
                      fontSize: 12.5,
                      height: 1.55,
                      color: Color(0xFF1B5E20),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExpertTips() {
    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('⭐', style: TextStyle(fontSize: 16)),
              SizedBox(width: 6),
              Text(
                'نصائح الخبراء',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B5800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...widget.stage.expertTips!.map((tip) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('•', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        tip,
                        style: TextStyle(
                          fontSize: 12.5,
                          height: 1.6,
                          color: Colors.brown.shade800,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}