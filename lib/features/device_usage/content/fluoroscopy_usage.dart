import '../usage_section.dart';

const UsageContent fluoroscopyUsage = UsageContent(
  intro:
      'خطوات Fluoroscopy معقدة — قد يكون إجراءً تشخيصياً بسيطاً أو تداخلياً '
      'معقداً. الجرعة قد تكون عالية، والالتزام بقواعد الحماية إلزامي.',
  stages: [
    UsageStage(
      icon: '📋',
      title: 'قبل الإجراء',
      duration: '15 دقيقة',
      steps: [
        UsageStep(icon: '📄', text: 'راجع الطلب: نوع الإجراء (بسيط أم تداخلي؟).'),
        UsageStep(icon: '🪪', text: 'تحقق من هوية المريض.'),
        UsageStep(icon: '🧪', text: 'إذا كان هناك تباين: راجع الكرياتينين.'),
        UsageStep(icon: '🤰', text: 'اسأل عن الحمل — إلزامي.'),
        UsageStep(icon: '💊', text: 'راجع الأدوية: مضادات التخثر قد تحتاج إيقافاً.'),
        UsageStep(icon: '🍽️', text: 'تحقق من الصيام (6 ساعات عادة).'),
        UsageStep(icon: '🦺', text: 'أعطِ الطاقم مآزر رصاصية (0.5 mm Pb).'),
        UsageStep(icon: '📊', text: 'ركّب Dosimeters على المآزر.'),
      ],
      checklist: [
        'تم التحقق من هوية المريض',
        'تم قياس الكرياتينين (إن لزم)',
        'تم السؤال عن الحمل',
        'تم الصيام 6 ساعات',
        'تم لبس المآزر الرصاصية',
        'تم تركيب Dosimeters',
      ],
      expertTips: [
        'المئزر الرصاصي يُفحص سنوياً بالفلوروسكوبي (وجود شقوق = خطر).',
        'الطبيب يقف في جهة الكاشف (المستقبل) — ليس الأنبوب.',
      ],
    ),

    UsageStage(
      icon: '🛏️',
      title: 'وضع المريض',
      duration: '5 دقائق',
      steps: [
        UsageStep(icon: '🛏️', text: 'المريض على الطاولة حسب نوع الإجراء.'),
        UsageStep(icon: '🎯', text: 'اضبط C-Arm على الزاوية الأولى (AP عادة).'),
        UsageStep(icon: '🧊', text: 'استخدم حاجزاً رصاصياً على البطن/الحوض إن أمكن.'),
        UsageStep(icon: '💉', text: 'ركّب كانيولا وريدية للحقن.'),
        UsageStep(icon: '📺', text: 'اضبط الشاشات لتكون مرئية للطبيب.'),
        UsageStep(icon: '💬', text: 'اشرح للمريض: "ستشعر بحرارة عند حقن التباين" (طبيعي).'),
      ],
      expertTips: [
        'الوضعية الجيدة = إجراء أسرع = جرعة أقل.',
        'قلّل المسافة بين المريض والكاشف قدر الإمكان.',
      ],
    ),

    UsageStage(
      icon: '🎛️',
      title: 'ضبط الجهاز والجرعة',
      duration: '3 دقائق',
      steps: [
        UsageStep(icon: '💻', text: 'اختر البروتوكول المناسب على لوحة التحكم.'),
        UsageStep(icon: '⚡', text: 'اضبط kVp (70-120 حسب الحالة).'),
        UsageStep(icon: '⏱️', text: 'اختر Pulsed Fluoroscopy (3-15 نبضة/ث) بدلاً من Continuous.'),
        UsageStep(icon: '🔊', text: 'فعّل Last-Image Hold — تقنية مهمة لتقليل الجرعة.'),
        UsageStep(icon: '📊', text: 'ابدأ تسجيل Dose (DAP, Air Kerma).'),
        UsageStep(icon: '⏱️', text: 'راقب زمن Fluoroscopy — سجّله في الملف.'),
      ],
      commonMistake:
          'استخدام Continuous Fluoroscopy دائماً — جرعة عالية دون داعٍ.',
      mistakeFix:
          'Pulsed Fluoroscopy و Last-Image Hold — قواعد ذهبية.',
      expertTips: [
        'قاعدة: "كل ثانية إضافية = جرعة إضافية".',
        'الحد الأقصى لزمن Fluoroscopy: 5 دقائق (إلا في الإجراءات المعقدة).',
      ],
    ),

    UsageStage(
      icon: '📺',
      title: 'الإجراء',
      duration: '5-60 دقيقة',
      steps: [
        UsageStep(icon: '💉', text: 'حقن التباين عند الحاجة (حسب التوقيت).'),
        UsageStep(icon: '👀', text: 'راقب الصورة الحية — اتخذ قرارات فورية.'),
        UsageStep(icon: '🎯', text: 'في الإجراءات التداخلية: توجيه القسطرة/الإبرة.'),
        UsageStep(icon: '🔄', text: 'تدوير C-Arm للزوايا المختلفة عند الحاجة.'),
        UsageStep(icon: '🎯', text: 'Last-Image Hold عند التفكير — لا تُشعّ باستمرار.'),
        UsageStep(icon: '📊', text: 'راقب DAP و Air Kerma — إذا اقترب من الحدود، توقف.'),
        UsageStep(icon: '🩺', text: 'راقب المريض: التنفس، ضغط الدم، الوعي.'),
      ],
      commonMistake:
          'عدم مراقبة الجرعة التراكمية — قد تصل لحدود الحرق (2 Gy على الجلد).',
      mistakeFix:
          'راقب Dose Monitor باستمرار. دوّن الجرعة النهائية.',
      expertTips: [
        'في قسطرة القلب: Biplane يُقلّل الجرعة مقارنة بـ Single Plane.',
        'في الأطفال: قلّل الجرعة إلى النصف.',
        'الأطباء الجدد: تدرّب على Phantom قبل المريض.',
      ],
    ),

    UsageStage(
      icon: '✅',
      title: 'بعد الإجراء',
      duration: '10 دقائق',
      steps: [
        UsageStep(icon: '🩹', text: 'إذا كان هناك بزل: ضع ضمادة ضاغطة.'),
        UsageStep(icon: '🛏️', text: 'راحة 4-6 ساعات حسب الإجراء.'),
        UsageStep(icon: '💧', text: 'أنصح بشرب سوائل كثيرة (لطرد التباين).'),
        UsageStep(icon: '🩺', text: 'راقب موضع البزل: نزيف، تورم، ألم.'),
        UsageStep(icon: '📸', text: 'راجع صور النهاية — إرسالها إلى PACS.'),
        UsageStep(icon: '📊', text: 'سجّل الجرعة النهائية (DAP, Air Kerma, Fluoroscopy Time).'),
        UsageStep(icon: '📝', text: 'وثّق كل التفاصيل في التقرير.'),
      ],
      checklist: [
        'تم مراقبة موضع البزل',
        'تم توجيه المريض للراحة',
        'تم تسجيل الجرعة النهائية',
        'تم إرسال الصور إلى PACS',
        'تم توثيق التقرير',
        'تم فحص المآزر الرصاصية بـ Fluoroscopy',
      ],
      expertTips: [
        'Dosimeter الشخصي يُقرأ شهرياً — أي زيادة مفاجئة تحتاج مراجعة.',
        'المرضى الذين أخذوا جرعة عالية: متابعة جلدية بعد أسبوع.',
        'احتفظ بسجل الجرعات التراكمية لكل طبيب.',
      ],
    ),
  ],
);