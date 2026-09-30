import '../how_section.dart';

const List<HowSection> ctHow = [
  HowSection(
    icon: '🔄',
    title: 'التصوير الحلزوني — من الدوران إلى الصورة',
    intro:
        'CT يأخذ مئات الصور من زوايا مختلفة، ثم يستخدم الرياضيات لإعادة بناء '
        'شرائح دقيقة. العملية تستغرق ثوانٍ فقط.',
    steps: [
      HowStep(
        icon: '🎯',
        title: 'تحديد الموقع (Localizers)',
        description:
            'صورة أولية (Scout) للمنطقة كاملة. المشغّل يحدد على الصورة نطاق '
            'الفحص (بداية ونهاية) — من الرقبة إلى الحوض مثلاً.',
      ),
      HowStep(
        icon: '🌀',
        title: 'بدء الدوران',
        description:
            'الأنبوب والكواشف يبدآن الدوران حول المريض بسرعة 0.3-1 ثانية '
            'للدورة الكاملة. الطاولة تتحرك ببطء داخل الهيكل.',
      ),
      HowStep(
        icon: '📡',
        title: 'جمع البيانات',
        description:
            'في كل درجة دوران، تُطلق الحزمة وتمر عبر المريض. الكواشف تسجّل '
            'شدة الأشعة النافذة. تُخزَّن آلاف القياسات في Raw Data.',
      ),
      HowStep(
        icon: '🧮',
        title: 'إعادة البناء الرياضية',
        description:
            'الحاسوب يستخدم Filtered Back Projection أو Iterative Reconstruction '
            'لتحويل البيانات الخام إلى صورة مقطعية. العملية تستغرق 1-30 ثانية.',
      ),
      HowStep(
        icon: '🖼️',
        title: 'العرض والدمج',
        description:
            'الصورة تُعرض كنافذة Axial. الطبيب يمكنه إعادة البناء بـ MPR '
            '(Coronal, Sagittal) أو 3D. تُرسل إلى PACS.',
      ),
    ],
    notes: [
      'Multi-Slice CT يأخذ 64-320 شريحة في الدورة الواحدة.',
      'الفحص الكامل للصدر = 5-10 ثوان فقط.',
    ],
    video: HowVideo(
      title: 'كيف يعمل جهاز CT Scan',
      assetPath: 'assets/videos/ct_how.mp4',
      description: 'شرح خطوة بخطوة',
    ),
  ),
];