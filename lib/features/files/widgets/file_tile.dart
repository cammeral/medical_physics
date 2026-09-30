import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../file_model.dart';

class FileTile extends StatelessWidget {
  final StoredFile file;
  final bool isUnlocked;
  final VoidCallback onTap;
  final VoidCallback onLock;
  final VoidCallback onDelete;
  final VoidCallback onRename;

  const FileTile({
    super.key,
    required this.file,
    required this.isUnlocked,
    required this.onTap,
    required this.onLock,
    required this.onDelete,
    required this.onRename,
  });

  bool get _showDetails => !file.isLocked || isUnlocked;

  @override
  Widget build(BuildContext context) {
    final color = Color(file.kind.color);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: file.isLocked
              ? const Color(0xFF7C3AED).withValues(alpha: 0.4)
              : color.withValues(alpha: 0.2),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // الأيقونة
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: file.isLocked
                        ? const Color(0xFF7C3AED).withValues(alpha: 0.12)
                        : color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    file.isLocked ? '🔒' : file.kind.emoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 12),

                // التفاصيل
                Expanded(
                  child: _showDetails
                      ? _buildDetails(color)
                      : _buildLockedDetails(),
                ),

                // القائمة
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert_rounded,
                      color: AppColors.textLight, size: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onSelected: (v) {
                    switch (v) {
                      case 'lock':
                        onLock();
                        break;
                      case 'rename':
                        onRename();
                        break;
                      case 'delete':
                        onDelete();
                        break;
                    }
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: 'lock',
                      child: Row(
                        children: [
                          Icon(
                            file.isLocked
                                ? Icons.lock_open_rounded
                                : Icons.lock_rounded,
                            size: 18,
                            color: const Color(0xFF7C3AED),
                          ),
                          const SizedBox(width: 10),
                          Text(file.isLocked ? 'فتح القفل' : 'قفل'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'rename',
                      child: Row(
                        children: [
                          Icon(Icons.edit_rounded,
                              size: 18, color: Color(0xFF4A6CF7)),
                          SizedBox(width: 10),
                          Text('إعادة التسمية'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline_rounded,
                              size: 18, color: Colors.red),
                          SizedBox(width: 10),
                          Text('حذف',
                              style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          file.name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(file.kind.label,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: color)),
            ),
            const SizedBox(width: 6),
            Text(file.sizeLabel,
                style: const TextStyle(
                    fontSize: 11, color: AppColors.textLight)),
            if (file.isLocked) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C3AED).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.lock_rounded,
                        size: 10, color: Color(0xFF7C3AED)),
                    SizedBox(width: 3),
                    Text('مفتوح',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7C3AED))),
                  ],
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildLockedDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ملف مقفل',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7C3AED),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.lock_rounded,
                size: 12,
                color: const Color(0xFF7C3AED).withValues(alpha: 0.7)),
            const SizedBox(width: 4),
            Text(
              'اضغط لفتح القفل',
              style: TextStyle(
                fontSize: 11,
                color: const Color(0xFF7C3AED).withValues(alpha: 0.8),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ],
    );
  }
}