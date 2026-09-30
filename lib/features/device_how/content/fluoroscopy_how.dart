import '../how_section.dart';

const List<HowSection> fluoroscopyHow = [
  HowSection(
    icon: '📺',
    title: 'من الفحص إلى "الأشعة الحية"',
    intro:
        'Fluoroscopy يُنتج فيديو بالأشعة. يُستخدم لمتابعة الحركة والإجراءات '
        'التداخلية.',
    steps: [
      HowStep(
        icon: '🩺',
        title: 'التحضير',
        description:
            'المريض يُوضع على الطاولة. الطاقم يرتدي المآزر الرصاصية. '
            'إذا احتاج تباين، يُحضّر الحاقن.',
      ),
      HowStep(
        icon: '🔄',
        title: 'ضبط C-Arm',
        description:
            'الطبيب يضبط C-Arm على الزاوية المناسبة (AP, Lateral, '
            'Oblique). الجهاز جاهز للتصوير.',
      ),
      HowStep(
        icon: '📡',
        title: 'التصوير المستمر أو النابض',
        description:
            'التشغيل يبدأ: الأنبوب يعمل بتيار منخفض. الصورة تظهر فورية '
            'على الشاشة. Pulsed mode يقلل الجرعة.',
      ),
      HowStep(
        icon: '💉',
        title: 'إجراءات التدخل',
        description:
            'الطبيب يوجّه القسطرة، البالون، أو الإبرة بمشاهدة الصورة الحية. '
            'التباين يوضّح الأوعية.',
      ),
      HowStep(
        icon: '🎯',
        title: 'Last-Image Hold',
        description:
            'عند التفكير أو الفحص، يُستخدم Last-Image Hold: آخر صورة '
            'تبقى على الشاشة بدون تعرض إضافي.',
      ),
      HowStep(
        icon: '📹',
        title: 'التسجيل والإنهاء',
        description:
            'الإجراء يُسجَّل كـ DICOM Cine. الصور تُرسل إلى PACS. '
            'يُوقف التشغيل ويُزال القسطرة.',
      ),
    ],
    notes: [
      'Fluoroscopy يمكن أن يُعطي جرعة عالية — تسجيل زمن التعرض ضروري.',
      'الطبيب يقف في جهة الكاشف (المستقبل) لتقليل جرعته 10 أضعاف.',
      'Last-Image Hold ميزة أساسية لتقليل الجرعة.',
    ],
    video: HowVideo(
      title: 'كيف يعمل الفلوروسكوبي',
      assetPath: 'assets/videos/fluoroscopy_how.mp4',
      description: 'شرح Fluoroscopy',
    ),
  ),
];