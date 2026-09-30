enum ClinicalBlockType { text, bullets, table, caseStudy, note, danger }

class ClinicalTable {
  final List<String> headers;
  final List<List<String>> rows;

  const ClinicalTable({required this.headers, required this.rows});
}

class ClinicalCase {
  final String title;
  final String patient;
  final String presentation;
  final String finding;
  final String diagnosis;

  const ClinicalCase({
    required this.title,
    required this.patient,
    required this.presentation,
    required this.finding,
    required this.diagnosis,
  });
}

class ClinicalBlock {
  final ClinicalBlockType type;
  final String? text;
  final List<String>? items;
  final ClinicalTable? table;
  final ClinicalCase? caseStudy;

  const ClinicalBlock.text(this.text)
      : type = ClinicalBlockType.text,
        items = null,
        table = null,
        caseStudy = null;

  const ClinicalBlock.bullets(this.items)
      : type = ClinicalBlockType.bullets,
        text = null,
        table = null,
        caseStudy = null;

  const ClinicalBlock.table(this.table)
      : type = ClinicalBlockType.table,
        text = null,
        items = null,
        caseStudy = null;

  const ClinicalBlock.caseStudy(this.caseStudy)
      : type = ClinicalBlockType.caseStudy,
        text = null,
        items = null,
        table = null;

  const ClinicalBlock.note(this.text)
      : type = ClinicalBlockType.note,
        items = null,
        table = null,
        caseStudy = null;

  const ClinicalBlock.danger(this.text)
      : type = ClinicalBlockType.danger,
        items = null,
        table = null,
        caseStudy = null;
}

class ClinicalSection {
  final String icon;
  final String title;
  final List<ClinicalBlock> blocks;

  const ClinicalSection({
    required this.icon,
    required this.title,
    required this.blocks,
  });
}