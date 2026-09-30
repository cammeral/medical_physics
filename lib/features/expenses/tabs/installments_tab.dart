import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../utils/app_colors.dart';
import '../expense_model.dart';
import '../expenses_storage.dart';
import '../../../../core/error/error_hooks.dart';

class InstallmentsTab extends StatelessWidget {
  final List<Installment> installments;
  final Color primary;
  final ValueChanged<List<Installment>> onChanged;

  const InstallmentsTab({
    super.key,
    required this.installments,
    required this.primary,
    required this.onChanged,
  });

  Future<void> _add(BuildContext context) async {
    final result = await showModalBottomSheet<Installment>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddInstallmentSheet(primary: primary),
    );
    if (result != null) {
      onChanged([...installments, result]);
          // 📤 إشعار صامت
    Errors.installment(
      title: result.title,
      total: result.totalAmount,
      count: result.count,
    );
    }
  }

  Future<void> _togglePaid(
      BuildContext context, Installment inst, int index) async {
    final list = [...installments];
    final i = list.indexWhere((e) => e.id == inst.id);
    if (i == -1) return;
    final payments = [...list[i].payments];
    final p = payments[index];
    payments[index] = InstallmentPayment(
      number: p.number,
      amount: p.amount,
      paidDate: p.isPaid ? null : DateTime.now(),
    );
    list[i] = Installment(
      id: list[i].id,
      title: list[i].title,
      totalAmount: list[i].totalAmount,
      count: list[i].count,
      payments: payments,
      createdAt: list[i].createdAt,
    );
    onChanged(list);
  }

  Future<void> _delete(BuildContext context, Installment inst) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('حذف التقسيط'),
        content: Text('هل تريد حذف "${inst.title}"؟'),
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
      onChanged(installments.where((e) => e.id != inst.id).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (installments.isEmpty) return _buildEmpty(context);

    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
          itemCount: installments.length,
          itemBuilder: (ctx, i) => _buildCard(ctx, installments[i]),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: FloatingActionButton.extended(
            onPressed: () => _add(context),
            backgroundColor: primary,
            foregroundColor: Colors.white,
            icon: const Icon(Icons.add_rounded),
            label: const Text('تقسيط جديد',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildEmpty(BuildContext context) {
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
                color: primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Text('📊', style: TextStyle(fontSize: 44)),
            ),
            const SizedBox(height: 16),
            const Text('لا توجد تقسيطات',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark)),
            const SizedBox(height: 6),
            const Text('أضف مبلغاً وسيُقسّم على دفعات',
                style: TextStyle(
                    fontSize: 13, color: AppColors.textLight),
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _add(context),
              icon: const Icon(Icons.add_rounded),
              label: const Text('إضافة تقسيط'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
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

  Widget _buildCard(BuildContext context, Installment inst) {
    final progress = inst.progressPercent;
    final isComplete = progress >= 1.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isComplete
              ? const Color(0xFF06B6A4).withValues(alpha: 0.4)
              : primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: (isComplete
                                ? const Color(0xFF06B6A4)
                                : primary)
                            .withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isComplete ? '✅' : '💵',
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(inst.title,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark)),
                          const SizedBox(height: 2),
                          Text(
                            '${inst.paidCount} من ${inst.count} دفعات مدفوعة',
                            style: const TextStyle(
                                fontSize: 11.5,
                                color: AppColors.textLight),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline_rounded,
                          size: 20, color: AppColors.textLight),
                      onPressed: () => _delete(context, inst),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // شريط التقدم
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation(
                      isComplete ? const Color(0xFF06B6A4) : primary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // الأرقام
                Row(
                  children: [
                    _smallStat('الإجمالي', inst.totalAmount, primary),
                    const SizedBox(width: 8),
                    _smallStat('مدفوع', inst.paidAmount,
                        const Color(0xFF06B6A4)),
                    const SizedBox(width: 8),
                    _smallStat('متبقي', inst.remainingAmount,
                        const Color(0xFFE63946)),
                  ],
                ),
              ],
            ),
          ),

          // قائمة الدفعات
          Container(
            decoration: BoxDecoration(
              color: AppColors.background.withValues(alpha: 0.5),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(14),
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: inst.payments.map((p) {
                final idx = inst.payments.indexOf(p);
                return _paymentTile(context, inst, p, idx);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallStat(String label, double amount, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 9.5,
                    color: color,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text(formatMoney(amount),
                style: TextStyle(
                    fontSize: 12.5,
                    color: color,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _paymentTile(
      BuildContext context, Installment inst, InstallmentPayment p, int idx) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: p.isPaid
              ? const Color(0xFF06B6A4).withValues(alpha: 0.3)
              : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: (p.isPaid
                      ? const Color(0xFF06B6A4)
                      : AppColors.textLight)
                  .withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Text('${p.number}',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: p.isPaid
                        ? const Color(0xFF06B6A4)
                        : AppColors.textLight)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('الدفعة ${p.number}',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark)),
                if (p.paidDate != null)
                  Text(
                    'تاريخ الدفع: ${p.paidDate!.day}/${p.paidDate!.month}/${p.paidDate!.year}',
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.textLight),
                  ),
              ],
            ),
          ),
          Text(
            formatMoney(p.amount),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: p.isPaid
                  ? const Color(0xFF06B6A4)
                  : AppColors.textDark,
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () => _togglePaid(context, inst, idx),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: (p.isPaid
                        ? const Color(0xFF06B6A4)
                        : Colors.grey.shade200)
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                p.isPaid
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
                color: p.isPaid
                    ? const Color(0xFF06B6A4)
                    : AppColors.textLight,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
//  نافذة إضافة تقسيط
// ═══════════════════════════════════════════════════
class _AddInstallmentSheet extends StatefulWidget {
  final Color primary;
  const _AddInstallmentSheet({required this.primary});

  @override
  State<_AddInstallmentSheet> createState() => _AddInstallmentSheetState();
}

class _AddInstallmentSheetState extends State<_AddInstallmentSheet> {
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  int _count = 2;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  double get _amount =>
      double.tryParse(_amountCtrl.text.trim()) ?? 0;

  double get _perPayment =>
      _amount > 0 ? _amount / _count : 0;

  void _save() {
    if (_titleCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال عنوان التقسيط')),
      );
      return;
    }
    if (_amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال مبلغ صحيح')),
      );
      return;
    }

    final perPayment = _amount / _count;
    final payments = List.generate(_count, (i) {
      return InstallmentPayment(
        number: i + 1,
        amount: perPayment,
      );
    });

    final inst = Installment(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: _titleCtrl.text.trim(),
      totalAmount: _amount,
      count: _count,
      payments: payments,
    );
    Navigator.pop(context, inst);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Text('📊 تقسيط جديد',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark)),
              const SizedBox(height: 14),

              // العنوان
              const Text('عنوان التقسيط *',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark)),
              const SizedBox(height: 6),
              TextField(
                controller: _titleCtrl,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'مثال: لابتوب جديد',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // المبلغ
              const Text('المبلغ الإجمالي (دينار) *',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark)),
              const SizedBox(height: 6),
              TextField(
                controller: _amountCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (_) => setState(() {}),
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: '3000000',
                  filled: true,
                  fillColor: Colors.white,
                  suffixText: 'دينار',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // عدد الدفعات
              const Text('عدد الدفعات',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark)),
              const SizedBox(height: 8),
              Row(
                children: [2, 3, 4, 5].map((n) {
                  final selected = _count == n;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: InkWell(
                        onTap: () => setState(() => _count = n),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: selected
                                ? widget.primary
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selected
                                  ? widget.primary
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '$n',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: selected
                                      ? Colors.white
                                      : AppColors.textDark,
                                ),
                              ),
                              Text(
                                'دفعات',
                                style: TextStyle(
                                  fontSize: 9.5,
                                  color: selected
                                      ? Colors.white70
                                      : AppColors.textLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // معاينة القسمة
              if (_amount > 0)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.primary.withValues(alpha: 0.12),
                        widget.primary.withValues(alpha: 0.06),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: widget.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('💰 ',
                              style: TextStyle(fontSize: 18)),
                          const Text('المبلغ الكلي: ',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600)),
                          Text(
                            '${formatMoney(_amount)} دينار',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: widget.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 1,
                        color: widget.primary.withValues(alpha: 0.2),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('📊 ',
                              style: TextStyle(fontSize: 18)),
                          Text('$_count دفعات × ',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600)),
                          Text(
                            '${formatMoney(_perPayment)} دينار',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: widget.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),

              // زر الحفظ
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('إنشاء التقسيط',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}