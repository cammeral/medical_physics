import '../how_section.dart';

const List<HowSection> spectHow = [
  HowSection(
    icon: '🌟',
    title: 'من النظير إلى الصورة المقطعية',
    intro:
        'SPECT يلتقط فوتون غاما واحد لكل اضمحلال (عكس PET). الكاميرا تدور '
        'حول المريض لبناء صورة مقطعية.',
    steps: [
      HowStep(
        icon: '💉',
        title: 'حقن النظير',
        description:
            'عادة Tc-99m مرتبط بجزيء حيوي (MDP للعظام، Sestamibi للقلب). '
            'يُحقن وريدياً.',
      ),
      HowStep(
        icon: '⏱️',
        title: 'الانتظار والتراكم',
        description:
            'المادة تتراكم في العضو المستهدف حسب خصائصها الحيوية. '
            'ينتظر المريض 1-3 ساعات.',
      ),
      HowStep(
        icon: '⚛️',
        title: 'اضمحلال غاما',
        description:
            'Tc-99m يضمحل بإصدار فوتون غاما بطاقة 140 keV. الفوتونات '
            'تنطلق من العضو في كل الاتجاهات.',
      ),
      HowStep(
        icon: '🔲',
        title: 'الترشيح بالكوليماتور',
        description:
            'الكوليماتور يقبل فقط الفوتونات العمودية. هذا يحدّد موقع '
            'الفوتون في الصورة.',
      ),
      HowStep(
        icon: '💎',
        title: 'التحويل إلى ضوء',
        description:
            'البلورة الوميضية NaI(Tl) تحوّل غاما إلى وميض ضوئي. '
            'PMT تحوّل الضوء إلى إشارة كهربائية.',
      ),
      HowStep(
        icon: '🔄',
        title: 'الدوران وإعادة البناء',
        description:
            'الكاميرا تدور حول المريض 180°-360°. الفوتونات من كل زاوية '
            'تُعاد بناؤها لصورة مقطعية 3D.',
      ),
    ],
    notes: [
      'Tc-99m هو الأكثر استخداماً (80%).',
      'الفحص الكامل: 20-45 دقيقة حسب النوع.',
      'Dual-Head camera يقلل الوقت للنصف.',
    ],
    video: HowVideo(
      title: 'كيف يعمل SPECT',
      assetPath: 'assets/videos/spect_how.mp4',
      description: 'شرح SPECT scan',
    ),
  ),
];