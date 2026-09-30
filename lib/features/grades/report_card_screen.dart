import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../../utils/app_colors.dart';
import 'grade_model.dart';

class ReportCardScreen extends StatefulWidget {
  final List<Subject> subjects;
  final StudentProfile profile;

  const ReportCardScreen({
    super.key,
    required this.subjects,
    required this.profile,
  });

  @override
  State<ReportCardScreen> createState() => _ReportCardScreenState();
}

class _ReportCardScreenState extends State<ReportCardScreen> {
  static const Color _primary = Color(0xFF7C3AED);

  pw.Font? _regular;
  pw.Font? _bold;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadFonts();
  }

  Future<void> _loadFonts() async {
    try {
      final reg = await rootBundle.load('assets/fonts/Cairo-Regular.ttf');
      final bld = await rootBundle.load('assets/fonts/Cairo-Bold.ttf');
      _regular = pw.Font.ttf(reg);
      _bold = pw.Font.ttf(bld);
    } catch (e) {
      // تجاهل الخطأ واستخدم الخط الافتراضي
    }
    setState(() => _loading = false);
  }

  double? get _overallGPA {
    final withGrades =
        widget.subjects.where((s) => s.weightedAverage != null).toList();
    if (withGrades.isEmpty) return null;
    double sum = 0;
    for (final s in withGrades) {
      sum += s.weightedAverage!;
    }
    return sum / withGrades.length;
  }

  String _textFromPercent(double p) {
    if (p >= 90) return 'ممتاز';
    if (p >= 80) return 'جيد جداً';
    if (p >= 70) return 'جيد';
    if (p >= 60) return 'متوسط';
    if (p >= 50) return 'مقبول';
    return 'راسب';
  }

  Future<pw.Document> _buildPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        theme: _bold != null
            ? pw.ThemeData.withFont(base: _regular, bold: _bold)
            : null,
        margin: const pw.EdgeInsets.all(32),
        header: (ctx) => _pdfHeader(),
        footer: (ctx) => _pdfFooter(ctx),
        build: (ctx) => [
          pw.SizedBox(height: 20),
          _pdfStudentInfo(),
          pw.SizedBox(height: 20),
          _pdfGradesTable(),
          pw.SizedBox(height: 20),
          _pdfSummary(),
          if (widget.profile.motivationalMessage != null &&
              widget.profile.motivationalMessage!.isNotEmpty) ...[
            pw.SizedBox(height: 24),
            _pdfMotivational(),
          ],
        ],
      ),
    );

    return pdf;
  }

  pw.Widget _pdfHeader() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.symmetric(vertical: 14),
          decoration: pw.BoxDecoration(
            color: PdfColor.fromInt(0xFF7C3AED),
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: pw.Column(
            children: [
              pw.Text(
                widget.profile.university.isEmpty
                    ? 'الجامعة'
                    : widget.profile.university,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                ),
              ),
              if (widget.profile.department.isNotEmpty) ...[
                pw.SizedBox(height: 4),
                pw.Text(
                  'قسم ${widget.profile.department}',
                  style: const pw.TextStyle(
                    fontSize: 13,
                    color: PdfColors.white,
                  ),
                ),
              ],
            ],
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          'كشف الدرجات',
          style: pw.TextStyle(
            fontSize: 20,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromInt(0xFF4C1D95),
          ),
        ),
        if (widget.profile.academicYear.isNotEmpty) ...[
          pw.SizedBox(height: 4),
          pw.Text(
            'العام الدراسي: ${widget.profile.academicYear}',
            style: const pw.TextStyle(fontSize: 11),
          ),
        ],
      ],
    );
  }

  pw.Widget _pdfFooter(pw.Context ctx) {
    return pw.Container(
      alignment: pw.Alignment.center,
      margin: const pw.EdgeInsets.only(top: 12),
      child: pw.Text(
        'صفحة ${ctx.pageNumber} من ${ctx.pagesCount}  •  تم إنشاء الكشف بواسطة تطبيق الفيزياء الطبية',
        style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
      ),
    );
  }

  pw.Widget _pdfStudentInfo() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromInt(0xFFEDE9FE),
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'الاسم: ${widget.profile.name.isEmpty ? "______________" : widget.profile.name}',
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            'التاريخ: ${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}',
            style: const pw.TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }

  pw.Widget _pdfGradesTable() {
    final headers = ['#', 'المادة', 'الدرجات', 'المعدل', 'التقدير'];

    return pw.Table(
      border: pw.TableBorder.all(
        color: PdfColor.fromInt(0xFFCCCCCC),
        width: 0.5,
      ),
      columnWidths: {
        0: const pw.FixedColumnWidth(28),
        1: const pw.FlexColumnWidth(2.5),
        2: const pw.FlexColumnWidth(1.2),
        3: const pw.FlexColumnWidth(1),
        4: const pw.FlexColumnWidth(1.2),
      },
      children: [
        // الرأس
        pw.TableRow(
          decoration: pw.BoxDecoration(
            color: PdfColor.fromInt(0xFF7C3AED),
          ),
          children: headers
              .map((h) => pw.Padding(
                    padding: const pw.EdgeInsets.all(6),
                    child: pw.Text(
                      h,
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ))
              .toList(),
        ),
        // الصفوف
        ...widget.subjects.asMap().entries.map((entry) {
          final i = entry.key + 1;
          final s = entry.value;
          final avg = s.weightedAverage;
          return pw.TableRow(
            decoration: pw.BoxDecoration(
              color: i.isEven
                  ? PdfColor.fromInt(0xFFF5F3FF)
                  : PdfColors.white,
            ),
            children: [
              _cell('$i'),
              _cell(s.name),
              _cell('${s.grades.length}'),
              _cell(avg == null ? '—' : '${avg.toStringAsFixed(1)}%'),
              _cell(s.displayTextGrade),
            ],
          );
        }),
      ],
    );
  }

  pw.Widget _cell(String text, {bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontSize: 10.5,
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  pw.Widget _pdfSummary() {
    final gpa = _overallGPA;
    return pw.Container(
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromInt(0xFF7C3AED),
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
        children: [
          pw.Column(
            children: [
              pw.Text('عدد المواد',
                  style: const pw.TextStyle(
                      fontSize: 11, color: PdfColors.white)),
              pw.SizedBox(height: 4),
              pw.Text(
                '${widget.subjects.length}',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                ),
              ),
            ],
          ),
          pw.Container(
            width: 1,
            height: 40,
            color: PdfColor.fromInt(0x88FFFFFF),
          ),
          pw.Column(
            children: [
              pw.Text('المعدل العام',
                  style: const pw.TextStyle(
                      fontSize: 11, color: PdfColors.white)),
              pw.SizedBox(height: 4),
              pw.Text(
                gpa == null ? '—' : '${gpa.toStringAsFixed(1)}%',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                ),
              ),
            ],
          ),
          pw.Container(
            width: 1,
            height: 40,
            color: PdfColor.fromInt(0x88FFFFFF),
          ),
          pw.Column(
            children: [
              pw.Text('التقدير',
                  style: const pw.TextStyle(
                      fontSize: 11, color: PdfColors.white)),
              pw.SizedBox(height: 4),
              pw.Text(
                gpa == null ? '—' : _textFromPercent(gpa),
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _pdfMotivational() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromInt(0xFFFEF3C7),
        borderRadius: pw.BorderRadius.circular(6),
        border: pw.Border.all(
          color: PdfColor.fromInt(0xFFF59E0B),
          width: 1,
        ),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Text('✨ رسالة تحفيزية ✨',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromInt(0xFF78350F),
              )),
          pw.SizedBox(height: 8),
          pw.Text(
            widget.profile.motivationalMessage!,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 12,
              fontStyle: pw.FontStyle.italic,
              color: PdfColor.fromInt(0xFF78350F),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        title: const Text('كشف الدرجات'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : PdfPreview(
              build: (format) => _buildPdf().then((d) => d.save()),
              canChangeOrientation: false,
              canChangePageFormat: false,
              canDebug: false,
              allowPrinting: true,
              allowSharing: true,
              useActions: true,
              loadingWidget: const Center(child: CircularProgressIndicator()),
            ),
    );
  }
}