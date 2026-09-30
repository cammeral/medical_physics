import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'term_model.dart';
import 'content/terms_data.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';
  TermCategory? _filter;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Term> get _filtered {
    var list = allTerms;
    if (_filter != null) {
      list = list.where((t) => t.category == _filter).toList();
    }
    if (_query.trim().isNotEmpty) {
      final q = _query.toLowerCase().trim();
      list = list.where((t) =>
          t.english.toLowerCase().contains(q) ||
          t.arabic.contains(q) ||
          (t.abbreviation?.toLowerCase().contains(q) ?? false)).toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final results = _filtered;

    // تجميع حسب الفئة
    final grouped = <TermCategory, List<Term>>{};
    for (final t in results) {
      grouped.putIfAbsent(t.category, () => []).add(t);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text(
          '📚 المصطلحات الطبية',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilters(),
          _buildCounter(results.length),
          Expanded(
            child: results.isEmpty
                ? _buildEmpty()
                : ListView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    children: grouped.entries.map((e) {
                      return _CategoryAccordion(
                        category: e.key,
                        terms: e.value,
                        initiallyExpanded: _query.trim().isNotEmpty ||
                            _filter != null,
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: TextField(
        controller: _searchCtrl,
        onChanged: (v) => setState(() => _query = v),
        decoration: InputDecoration(
          hintText: 'ابحث بالعربية أو الإنجليزية...',
          prefixIcon: const Icon(Icons.search, color: AppColors.primary),
          suffixIcon: _query.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: () {
                    _searchCtrl.clear();
                    setState(() => _query = '');
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _chip(null, 'الكل', '📚'),
          const SizedBox(width: 8),
          ...TermCategory.values.map((c) {
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: _chip(c, c.label, c.icon),
            );
          }),
        ],
      ),
    );
  }

  Widget _chip(TermCategory? cat, String label, String icon) {
    final selected = _filter == cat;
    final color = cat == null
        ? AppColors.primary
        : Color(cat.color);
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => setState(() => _filter = cat),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? color : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? color : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 13)),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounter(int count) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Row(
        children: [
          Text(
            'النتائج: $count مصطلح',
            style: const TextStyle(
              fontSize: 12.5,
              color: AppColors.textLight,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 12),
          const Text('لا توجد نتائج مطابقة',
              style: TextStyle(
                  fontSize: 15, color: AppColors.textLight)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
//  Accordion الفئة
// ═══════════════════════════════════════════════════
class _CategoryAccordion extends StatefulWidget {
  final TermCategory category;
  final List<Term> terms;
  final bool initiallyExpanded;

  const _CategoryAccordion({
    required this.category,
    required this.terms,
    this.initiallyExpanded = false,
  });

  @override
  State<_CategoryAccordion> createState() => _CategoryAccordionState();
}

class _CategoryAccordionState extends State<_CategoryAccordion> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(widget.category.color);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _expanded
              ? color.withValues(alpha: 0.4)
              : Colors.grey.shade200,
          width: _expanded ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          // رأس الفئة
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(widget.category.icon,
                        style: const TextStyle(fontSize: 22)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.category.label,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${widget.terms.length} مصطلح',
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
                      color: color,
                      size: 26,
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
                children: [
                  const Divider(height: 1),
                  const SizedBox(height: 10),
                  ...widget.terms.asMap().entries.map((e) =>
                      _termCard(e.value, e.key + 1, color)),
                ],
              ),
            ),
            secondChild: const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }

  Widget _termCard(Term term, int index, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الاسم الإنجليزي + اختصار
          Row(
            children: [
              Expanded(
                child: Text(
                  term.english,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              if (term.abbreviation != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    term.abbreviation!,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      color: color,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          // الاسم العربي
          Row(
            children: [
              Container(
                width: 3,
                height: 14,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                term.arabic,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // الشرح
          Text(
            term.description,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.7,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}