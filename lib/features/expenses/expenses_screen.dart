import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import 'expense_model.dart';
import 'expenses_storage.dart';
import 'tabs/installments_tab.dart';
import 'tabs/daily_tab.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen>
    with SingleTickerProviderStateMixin {
  static const Color _primary = Color(0xFF10B981);
  static const Color _secondary = Color(0xFF059669);

  late TabController _tabCtrl;
  List<Installment> _installments = [];
  List<DailyExpense> _daily = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
    _load();
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final installments = await ExpensesStorage.loadInstallments();
    final daily = await ExpensesStorage.loadDaily();
    setState(() {
      _installments = installments;
      _daily = daily;
      _loading = false;
    });
  }

  double get _totalRemaining =>
      _installments.fold(0, (s, i) => s + i.remainingAmount);

  double get _totalDaily =>
      _daily.fold(0, (s, e) => s + e.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        title: const Text('💰 المصاريف',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(
              fontSize: 13.5, fontWeight: FontWeight.bold),
          tabs: const [
            Tab(icon: Icon(Icons.pie_chart_rounded, size: 20), text: 'التقسيط'),
            Tab(icon: Icon(Icons.shopping_bag_rounded, size: 20), text: 'اليومية'),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: TabBarView(
                    controller: _tabCtrl,
                    children: [
                      InstallmentsTab(
                        installments: _installments,
                        primary: _primary,
                        onChanged: (list) async {
                          setState(() => _installments = list);
                          await ExpensesStorage.saveInstallments(list);
                        },
                      ),
                      DailyTab(
                        expenses: _daily,
                        primary: _primary,
                        onChanged: (list) async {
                          setState(() => _daily = list);
                          await ExpensesStorage.saveDaily(list);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_primary, _secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: _statItem(
              Icons.account_balance_wallet_rounded,
              'متبقي التقسيط',
              formatMoney(_totalRemaining),
            ),
          ),
          Container(
              width: 1,
              height: 44,
              color: Colors.white.withValues(alpha: 0.3)),
          Expanded(
            child: _statItem(
              Icons.receipt_long_rounded,
              'مجموع اليومية',
              formatMoney(_totalDaily),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(IconData icon, String label, String amount) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.85), size: 18),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 10.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          amount,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'دينار',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.75),
            fontSize: 9.5,
          ),
        ),
      ],
    );
  }
}