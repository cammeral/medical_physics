import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../utils/app_colors.dart';
import '../expense_model.dart';
import '../expenses_storage.dart';
import '../../../../core/error/error_hooks.dart';

class DailyTab extends StatefulWidget {
  final List<DailyExpense> expenses;
  final Color primary;
  final ValueChanged<List<DailyExpense>> onChanged;

  const DailyTab({
    super.key,
    required this.expenses,
    required this.primary,
    required this.onChanged,
  });

  @override
  State<DailyTab> createState() => _DailyTabState();
}

class _DailyTabState extends State<DailyTab> {
  ExpensePeriod _period = ExpensePeriod.today;

  List<DailyExpense> get _filtered =>
      widget.expenses.where((e) => _period.matches(e.date)).toList()
        ..sort((a, b) => b.date.compareTo(a.date));

  double get _total => _filtered.fold(0, (s, e) => s + e.amount);

  Future<void> _add() async {
    final result = await showModalBottomSheet<DailyExpense>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddExpenseSheet(primary: widget.primary),
    );
    if (result != null) {
      widget.onChanged([...widget.expenses, result]);
          // 📤 إشعار صامت
    Errors.expense(
      title: result.title,
      amount: result.amount,
      note: result.note,
    );
    }
  }

  Future<void> _delete(DailyExpense e) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('حذف المصروف'),
        content: Text('هل تريد حذف "${e.title}"؟'),
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
      widget.onChanged(
          widget.expenses.where((x) => x.id != e.id).toList());
    }
  }

  String _dayName(DateTime d) {
    const days = [
      'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس',
      'الجمعة', 'السبت', 'الأحد'
    ];
    return days[d.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;

    return Stack(
      children: [
        Column(
          children: [
            _buildTotalCard(),
            _buildFilters(),
            Expanded(
              child: filtered.isEmpty
                  ? _buildEmpty()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                      itemCount: filtered.length,
                      itemBuilder: (ctx, i) =>
                          _buildTile(filtered[i]),
                    ),
            ),
          ],
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: FloatingActionButton.extended(
            onPressed: _add,
            backgroundColor: widget.primary,
            foregroundColor: Colors.white,
            icon: const Icon(Icons.add_rounded),
            label: const Text('مصروف جديد',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildTotalCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: widget.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(_period.emoji,
                style: const TextStyle(fontSize: 22)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('مجموع ${_period.label}',
                    style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textLight,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 3),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatMoney(_total),
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: widget.primary),
                    ),
                    const SizedBox(width: 4),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 3),
                      child: Text('دينار',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textLight)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: widget.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${_filtered.length} مصروف',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: widget.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: ExpensePeriod.values.map((p) {
          final selected = _period == p;
          return Padding(
            padding: const EdgeInsets.only(left: 6),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => setState(() => _period = p),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: selected ? widget.primary : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selected
                        ? widget.primary
                        : Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(p.emoji,
                        style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    Text(
                      p.label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: selected
                            ? Colors.white
                            : AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Text('🛒', style: TextStyle(fontSize: 40)),
            ),
            const SizedBox(height: 14),
            Text('لا توجد مصاريف ${_period.label}',
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark)),
            const SizedBox(height: 6),
            const Text('أضف مصروفاً لتتبعه',
                style: TextStyle(
                    fontSize: 12.5, color: AppColors.textLight)),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(DailyExpense e) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text('🛒', style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e.title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark)),
                const SizedBox(height: 3),
                Text(
                  '${_dayName(e.date)} • ${e.date.day}/${e.date.month}/${e.date.year}',
                  style: const TextStyle(
                      fontSize: 10.5, color: AppColors.textLight),
                ),
                if (e.note != null) ...[
                  const SizedBox(height: 2),
                  Text(e.note!,
                      style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textLight,
                          fontStyle: FontStyle.italic)),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatMoney(e.amount),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: widget.primary,
                ),
              ),
              const Text('دينار',
                  style: TextStyle(
                      fontSize: 9.5, color: AppColors.textLight)),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded,
                size: 18, color: AppColors.textLight),
            onPressed: () => _delete(e),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
//  نافذة إضافة مصروف
// ═══════════════════════════════════════════════════
class _AddExpenseSheet extends StatefulWidget {
  final Color primary;
  const _AddExpenseSheet({required this.primary});

  @override
  State<_AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends State<_AddExpenseSheet> {
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  DateTime _date = DateTime.now();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (d != null) setState(() => _date = d);
  }

  void _save() {
    if (_titleCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال عنوان المصروف')),
      );
      return;
    }
    final amount = double.tryParse(_amountCtrl.text.trim());
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال مبلغ صحيح')),
      );
      return;
    }

    final e = DailyExpense(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: _titleCtrl.text.trim(),
      amount: amount,
      date: _date,
      note: _noteCtrl.text.trim().isEmpty
          ? null
          : _noteCtrl.text.trim(),
    );
    Navigator.pop(context, e);
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
              const Text('🛒 مصروف جديد',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark)),
              const SizedBox(height: 14),

              const Text('عنوان المصروف *',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark)),
              const SizedBox(height: 6),
              TextField(
                controller: _titleCtrl,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'مثال: حذاء رياضي',
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

              const Text('المبلغ (دينار) *',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark)),
              const SizedBox(height: 6),
              TextField(
                controller: _amountCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: '5000',
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

              const Text('التاريخ',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark)),
              const SizedBox(height: 6),
              InkWell(
                onTap: _pickDate,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_rounded,
                          size: 18, color: widget.primary),
                      const SizedBox(width: 10),
                      Text(
                        '${_date.day}/${_date.month}/${_date.year}',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      const Icon(Icons.edit_rounded,
                          size: 16, color: AppColors.textLight),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              const Text('ملاحظة (اختياري)',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark)),
              const SizedBox(height: 6),
              TextField(
                controller: _noteCtrl,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'مثال: من السوق الرئيسي',
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
              const SizedBox(height: 20),

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
                  child: const Text('حفظ المصروف',
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