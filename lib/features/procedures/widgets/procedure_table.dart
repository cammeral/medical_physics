import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class ProcedureTableView extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> rows;
  final Color color;

  const ProcedureTableView({
    super.key,
    required this.headers,
    required this.rows,
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
            inside: BorderSide(color: color.withValues(alpha: 0.15)),
          ),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration:
                  BoxDecoration(color: color.withValues(alpha: 0.15)),
              children: headers.map((h) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 10),
                  child: Text(
                    h,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                );
              }).toList(),
            ),
            ...rows.map((row) {
              return TableRow(
                children: row.map((cell) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 9),
                    child: Text(
                      cell,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
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