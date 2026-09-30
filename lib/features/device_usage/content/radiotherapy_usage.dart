import '../usage_section.dart';

const UsageContent radiotherapyUsage = UsageContent(
  intro:
      'خطوات العلاج الإشعاعي تبدأ قبل أسابيع من الجلسة الأولى — التخطيط '
      'الدقيق هو سر النجاح. كل جلسة سريعة (10-30 دقيقة)، لكن التحضير معقد.',
  stages: [
    UsageStage(
      icon: '📋',
      title: 'التخطيط الأولي (Simulation)',
      duration: '1-2 ساعة',
      steps: [
        UsageStep(icon: '📸', text: 'تصوير CT تخطيطي (Simulation CT) — للمنطقة المستهدفة.'),
        UsageStep(icon: '🧊', text: 'تصنيع قوالب التثبيت (Mask, Mold, Vacuum bag).'),
        UsageStep(icon: '🖊️', text: 'وضع علامات وشم صغيرة على الجلد (Tattoos) — مرجعية للجلسات.'),
        UsageStep(icon: '🎯', text: 'تحديد Isocenter على جلد المريض.'),
        UsageStep(icon: '📐', text: 'تصوير إضافي: MRI/PET إن لزم لدمج الصور.'),
        UsageStep(icon: '💬', text: 'اشرح: "هذه الجلسة للتخطيط فقط، لن تشعر بأي شيء".'),
      ],
      expertTips: [
        'الوشم صغير جداً (نقطة) لكنه دقيق — لا يُمسح.',
        'القوالب ضرورية: أي حركة 2 mm = خطأ في الجرعة.',
      ],
    ),

    UsageStage(
      icon: '💻',
      title: 'التخطيط على الحاسوب',
      duration: '1-3 أيام (بين الجلسات)',
      steps: [
        UsageStep(icon: '🖼️', text: 'الطبيب يرسم: GTV (الورم)، CTV، PTV، الأعضاء الحساسة (OARs).'),
        UsageStep(icon: '💻', text: 'الفيزيائي الطبي يخطط زوايا الأشعة والجرعة.'),
        UsageStep(icon: '🧮', text: 'حساب DVH (Dose-Volume Histogram) — تقييم الخطة.'),
        UsageStep(icon: '🎛️', text: 'تحسين الخطة (Optimization) — جرعة أعلى للورم، أقل للأنسجة.'),
        UsageStep(icon: '✅', text: 'موافقة الطبيب والفيزيائي على الخطة النهائية.'),
      ],
      commonMistake:
          'خطأ في رسم PTV — يسبب جرعة زائدة للأنسجة السليمة أو نقص للورم.',
      mistakeFix:
          'المراجعة الثنائية (Double-check) إلزامية من طبيب آخر.',
      expertTips: [
        'قاعدة: "CTV = GTV + 5 mm، PTV = CTV + 5 mm" (حسب المنطقة).',
        'في IMRT، الخطة تحتاج ساعات من التحسين.',
      ],
    ),

    UsageStage(
      icon: '🧪',
      title: 'ضمان الجودة (QA)',
      duration: '1-2 ساعة',
      steps: [
        UsageStep(icon: '🧪', text: 'اختبار الخطة على Phantom قبل المريض.'),
        UsageStep(icon: '📊', text: 'قياس الجرعة الفعلية ومقارنتها بالمخطط.'),
        UsageStep(icon: '🎯', text: 'التحقق من Isocenter بدقة ± 1 mm.'),
        UsageStep(icon: '🖥️', text: 'اختبار IGRT (CBCT أو EPID) — جاهزية الصور اليومية.'),
        UsageStep(icon: '✍️', text: 'موافقة الفيزيائي الطبي — لا يُعالج المريض قبلها.'),
      ],
      expertTips: [
        'QA يومي، أسبوعي، شهري، وسنوي — إجراء إلزامي.',
        'أي تغيير في الخطة يحتاج QA جديد.',
      ],
    ),

    UsageStage(
      icon: '⚡',
      title: 'الجلسة (Fraction)',
      duration: '15-30 دقيقة',
      steps: [
        UsageStep(icon: '🪑', text: 'المريض يستلقي على الطاولة بنفس الوضع كل مرة.'),
        UsageStep(icon: '🎭', text: 'ارتداء القالب الخاص (Mask للنظام).'),
        UsageStep(icon: '📸', text: 'تصوير IGRT (CBCT أو EPIG) للتأكد من الوضع.'),
        UsageStep(icon: '🎯', text: 'تصحيح الوضع إن كان الانحراف > 2 mm (Shift).'),
        UsageStep(icon: '🚪', text: 'الطاقم يخرج من الغرفة. الباب يُغلق.'),
        UsageStep(icon: '⚡', text: 'LINAC يعمل 1-10 دقائق — VMAT/IMRT قد يستغرق أكثر.'),
        UsageStep(icon: '📺', text: 'مراقبة المريض من غرفة التحكم عبر الكاميرا.'),
        UsageStep(icon: '🔔', text: 'بعد الانتهاء: "انتهت الجلسة، يمكنك النزول".'),
      ],
      commonMistake:
          'عدم تصوير IGRT قبل الجلسة — قد يكون المريض في وضع خاطئ.',
      mistakeFix:
          'IGRT إلزامي — "لا تعالج حتى ترى".',
      expertTips: [
        'الجلسة الحقيقية = 5-10 دقائق. الباقي تحضير وتصوير.',
        'المريض وحده في الغرفة — الطمأنة الصوتية مهمة.',
        'المريض لا يشعر بأي شيء — لا ألم، لا حرارة.',
      ],
    ),

    UsageStage(
      icon: '✅',
      title: 'بعد الجلسة والمتابعة',
      duration: 'مستمر',
      steps: [
        UsageStep(icon: '📝', text: 'توثيق الجلسة: الجرعة، الوضع، أي حدث.'),
        UsageStep(icon: '📅', text: 'جدولة الجلسة التالية (عادة يومياً، ما عدا السبت/الأحد).'),
        UsageStep(icon: '🩺', text: 'متابعة أسبوعية مع الطبيب: الأعراض الجانبية، الوزن.'),
        UsageStep(icon: '🧴', text: 'العناية بالجلد: كريمات لطيفة، تجنّب الشمس.'),
        UsageStep(icon: '🍽️', text: 'تغذية جيدة: بروتين، سوائل كافية.'),
        UsageStep(icon: '🧘', text: 'راحة كافية — الآثار الجانبية تتراكم مع الوقت.'),
        UsageStep(icon: '📸', text: 'بعد انتهاء العلاج: تصوير متابعة (عادة بعد 3 شهور).'),
      ],
      checklist: [
        'تم توثيق الجلسة',
        'تم جدولة الجلسة التالية',
        'تم فحص الجلد',
        'تم مراجعة الأعراض الجانبية',
        'تم توجيه المريض للعناية الذاتية',
      ],
      expertTips: [
        'الآثار الجانبية تظهر بعد 1-2 أسبوع — لا تقلق من عدم وجودها فوراً.',
        'الصبر: التحسن يظهر بعد أسابيع من انتهاء العلاج.',
        'الدعم النفسي مهم — العلاج مرهق نفسياً.',
      ],
    ),
  ],
);