import '../component_section.dart';

const List<ComponentSection> mammographyComponents = [
  ComponentSection(
    icon: '📷',
    title: 'الماموغراف (Mammography Unit)',
    imageUrl: 'assets/images/mammo_machine.png',
    intro:
        'جهاز X-ray متخصص للثدي. تصميمه يختلف عن X-ray العام — الأنبوب '
        'والكاشف عموديان، مع ذراع قابلة للدوران.',
    items: [
      ComponentItem(
        icon: '🔄',
        name: 'الذراع الدوّار (C-Arm)',
        description:
            'يسمح بتصوير الثدي من زوايا مختلفة (CC, MLO). يدور عادة '
            '0° إلى 180°.',
      ),
      ComponentItem(
        icon: '🎯',
        name: 'حامل الأنبوب (Tube Stand)',
        description:
            'يحمل الأنبوب فوق الثدي. مثبّت بدقة لتقليل الاهتزاز.',
      ),
    ],
    notes: [
      'تصميم مضغوط — عادة ارتفاع 2 m فقط.',
      'بعض الأجهزة الحديثة لها وظيفة Biopsy موجهة.',
    ],
  ),

  ComponentSection(
    icon: '🔵',
    title: 'أنبوب الأشعة والهدف',
    intro:
        'أنبوب X-ray خاص بطاقة منخفضة (25-35 kVp). الهدف عادة Mo أو Rh '
        'بدلاً من W (لإنتاج طيف مناسب للأنسجة الرخوة).',
    items: [
      ComponentItem(
        icon: '🎯',
        name: 'الهدف (Target)',
        description:
            'Mo (Z=42) للثدي المتوسط. Rh (Z=45) للثدي الكثيف. W (Z=74) '
            'للأجهزة الحديثة (يحتاج ترشيح خاص).',
      ),
      ComponentItem(
        icon: '🧊',
        name: 'الترشيح (Filter)',
        description:
            'Mo (0.03 mm) للأجهزة التقليدية. Rh أو Ag للأجهزة الحديثة. '
            'يُزيل الفوتونات منخفضة الطاقة.',
      ),
      ComponentItem(
        icon: '🔍',
        name: 'البقعة البؤرية الصغيرة',
        description:
            '0.1-0.3 mm فقط — لدقة عالية جداً. ضرورية لكشف التكلّسات '
            'الدقيقة.',
      ),
    ],
    notes: [
      'kVp منخفض = طاقة منخفضة = تباين عالٍ.',
      'mAs يُحدد حسب كثافة الثدي (AEC).',
    ],
  ),

  ComponentSection(
    icon: '🪑',
    title: 'نظام الضغط (Compression System)',
    intro:
        'أهم ميزة في Mammography. ضغط قوي للثدي يقلل السماكة والجرعة '
        'ويحسّن التباين. قد يكون مؤلماً قليلاً لكنه ضروري.',
    items: [
      ComponentItem(
        icon: '🔽',
        name: 'صفيحة الضغط (Compression Paddle)',
        description:
            'شفافة للأشعة. تُضغط من الأعلى بقوة 10-20 kg. أشكال مختلفة '
            'لكل حجم ثدي.',
      ),
      ComponentItem(
        icon: '⚙️',
        name: 'التحكم الآلي واليدوي',
        description:
            'يضغط تلقائياً بقوة محددة. المشغّل يمكنه إيقافه أو زيادته. '
            'يجب أن يكون الضغط موحداً.',
      ),
      ComponentItem(
        icon: '📏',
        name: 'مقياس السماكة',
        description:
            'يُظهر سماكة الثدي المضغوط. يُستخدم لضبط kVp تلقائياً.',
      ),
    ],
    notes: [
      'الضغط الجيد = صورة أوضح + جرعة أقل.',
      'إذا شعرت المريضة بألم شديد → يجب إبلاغ التقني.',
    ],
  ),

  ComponentSection(
    icon: '🎯',
    title: 'نظام الكشف (Detector)',
    intro:
        'يستقبل الأشعة النافذة من الثدي. حديثاً الكاشف الرقمي هو المعيار.',
    items: [
      ComponentItem(
        icon: '📸',
        name: 'Flat Panel Detector (FPD)',
        description:
            'سيليكون لابلوري (a-Se) أو يوديد السيزيوم (CsI). دقة عالية '
            'جداً — بكسل أقل من 100 μm.',
      ),
      ComponentItem(
        icon: '🎞️',
        name: 'CR (Computed Radiography)',
        description:
            'لوح فوسفوري يُقرأ بالليزر. تقنية أقدم لا تزال مستخدمة.',
      ),
      ComponentItem(
        icon: '🖼️',
        name: 'Anti-Scatter Grid',
        description:
            'شبكة رصاصية تحجب الأشعة المشتتة — مهمة جداً في Mammography.',
      ),
    ],
    notes: [
      'FFDM (Full-Field Digital Mammography) هو المعيار الحديث.',
      'DBT (Tomosynthesis) يُضيف صوراً مقطعية.',
    ],
  ),

  ComponentSection(
    icon: '🖥️',
    title: 'نظام العرض والتشخيص',
    intro:
        'شاشات عالية الدقة لقراءة الصور. بعض الأنظمة مع AI للمساعدة في الكشف.',
    items: [
      ComponentItem(
        icon: '📺',
        name: 'شاشات 5MP+',
        description:
            'دقة 5 MegaPixel على الأقل. معتمدة من FDA. معايرة DICOM '
            'يومياً.',
      ),
      ComponentItem(
        icon: '🤖',
        name: 'CAD (Computer-Aided Detection)',
        description:
            'برنامج AI يُعلّم المناطق المشبوهة. يُسرّع التشخيص ويقلل '
            'الأخطاء البشرية.',
      ),
      ComponentItem(
        icon: '💾',
        name: 'PACS Integration',
        description:
            'إرسال الصور إلى PACS. سهولة المراجعة والمقارنة بين '
            'الفحوصات السنوية.',
      ),
    ],
    notes: [
      'AI في Mammography وصل لدقة عالية جداً.',
      'DICOM GSDF معيار عالمي لعرض الصور.',
    ],
  ),

  ComponentSection(
    icon: '🎯',
    title: 'نظام الخزعة (Biopsy System)',
    intro:
        'بعض الأجهزة الحديثة تحتوي على نظام خزعة موجه لسحب عينة من الأورام '
        'المشتبه بها — بدون جراحة.',
    items: [
      ComponentItem(
        icon: '📐',
        name: 'Stereotactic Biopsy',
        description:
            'يأخذ صورتين بزوايا مختلفة لحساب موقع الكتلة في 3D. ثم '
            'يُوجَّه إبرة دقيقة لسحب العينة.',
      ),
      ComponentItem(
        icon: '🧲',
        name: 'MRI-Guided Biopsy',
        description:
            'للأورام التي لا تظهر في Mammography. يُستخدم MRI لتحديد '
            'الموقع.',
      ),
      ComponentItem(
        icon: '💉',
        name: 'Vacuum-Assisted Biopsy (VAB)',
        description:
            'إبرة كبيرة تأخذ عينة أكبر بمساعدة فراغ. عادة كافية '
            'للتشخيص النهائي.',
      ),
    ],
    notes: [
      'الخزعة دقيقة وآمنة — تُجريها أخصائية الأشعة.',
      'النتيجة تعطي تشخيصاً نهائياً (حميد/خبيث).',
    ],
  ),
];