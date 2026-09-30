import '../how_section.dart';

const List<HowSection> mammographyHow = [
  HowSection(
    icon: '🩻',
    title: 'من التصوير إلى التشخيص',
    intro:
        'Mammography فحص دقيق للثدي. يعتمد على طاقة منخفضة وضغط قوي '
        'لكشف أصغر التفاصيل.',
    steps: [
      HowStep(
        icon: '🪑',
        title: 'الوقوف والتحضير',
        description:
            'المريضة تقف أمام الجهاز. التقني يشرح الإجراء. يجب إزالة '
            'المجوهرات وأي معدن من المنطقة.',
      ),
      HowStep(
        icon: '🔽',
        title: 'الضغط (Compression)',
        description:
            'صفيحة تُضغط الثدي تدريجياً بقوة 10-20 kg. هذا يقلل السماكة '
            'والجرعة ويزيد الدقة. قد يكون مؤلماً قليلاً.',
      ),
      HowStep(
        icon: '📷',
        title: 'التصوير (CC, MLO)',
        description:
            'أولاً CC (من الأعلى للأسفل)، ثم MLO (زاوية 45°). كل وضع '
            'له صورته. تُكرر للثدي الآخر.',
      ),
      HowStep(
        icon: '⚡',
        title: 'التعرض بالأشعة',
        description:
            'أشعة سينية منخفضة الطاقة (25-35 kVp) تخترق الثدي. '
            'الكاشف الرقمي يلتقط الصورة في ثوانٍ.',
      ),
      HowStep(
        icon: '📊',
        title: 'التقييم (BI-RADS)',
        description:
            'الطبيب يقرأ الصورة ويعطي تصنيف BI-RADS: من 1 (طبيعي) إلى '
            '6 (سرطان مؤكد). بعض الأنظمة مع AI للمساعدة.',
      ),
      HowStep(
        icon: '🔬',
        title: 'الخطوات التالية',
        description:
            'BI-RADS 0 → تصوير إضافي. BI-RADS 4/5 → خزعة موجهة. '
            'BI-RADS 1/2/3 → متابعة سنوية.',
      ),
    ],
    notes: [
      'الجرعة منخفضة جداً — فائدة الفحص الدوري تفوق بكثير.',
      'الفحص الدوري للنساء 40-74 سنة كل 1-2 سنة.',
      'DBT (Tomosynthesis) هو المعيار الحديث.',
    ],
    video: HowVideo(
      title: 'كيف يعمل الماموغرام',
      assetPath: 'assets/videos/mammography_how.mp4',
      description: 'شرح Mammogram',
    ),
  ),
];