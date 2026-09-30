import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../clinical_section.dart';

class ClinicalTableView extends StatelessWidget {
  final ClinicalTable table;
  final Color color;

  const ClinicalTableView({
    super.key,
    required this.table,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Table(
          border: TableBorder.symmetric(
            inside: BorderSide(
              color: color.withValues(alpha: 0.15),
              width: 1,
            ),
          ),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            // الرأس
            TableRow(
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
              ),
              children: table.headers.map((h) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 12),
                  child: Text(
                    h,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                );
              }).toList(),
            ),
            // الصفوف
            ...table.rows.map((row) {
              return TableRow(
                children: row.map((cell) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 10),
                    child: Text(
                      cell,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: AppColors.textDark,
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}