import '../usage_section.dart';

const UsageContent mammographyUsage = UsageContent(
  intro:
      'خطوات Mammography بسيطة لكن الضغط قد يكون مؤلماً قليلاً. الفحص '
      'سريع (20 دقيقة) لكنه يحتاج وضعية دقيقة وتعاون المريضة.',
  stages: [
    UsageStage(
      icon: '📋',
      title: 'قبل الفحص',
      duration: '5 دقائق',
      steps: [
        UsageStep(icon: '📄', text: 'راجع الطلب: Screening (دوري) أو Diagnostic (تشخيصي).'),
        UsageStep(icon: '🪪', text: 'تحقق من هوية المريضة.'),
        UsageStep(icon: '📅', text: 'تحقق من التوقيت: بعد الدورة بأسبوع (أقل حساسية).'),
        UsageStep(icon: '🤰', text: 'اسأل عن الحمل والرضاعة.'),
        UsageStep(icon: '📋', text: 'استبيان: تاريخ عائلي، عمليات سابقة، زرعات، هرمونات.'),
        UsageStep(icon: '🚫', text: 'أخبري المريضة: بدون مزيل عرق أو بودرة أو كريم.'),
        UsageStep(icon: '📸', text: 'اطلبي صور سابقة للمقارنة — مهم جداً.'),
        UsageStep(icon: '👗', text: 'أعطيها رداء المستشفى.'),
      ],
      checklist: [
        'تم التحقق من هوية المريضة',
        'تم السؤال عن الحمل والرضاعة',
        'تم التأكد من عدم وجود مزيل عرق',
        'تم إحضار الصور السابقة',
        'تم استبيان التاريخ الطبي',
      ],
      expertTips: [
        'الصور السابقة مهمة جداً — تُقلل النداءات الكاذبة.',
        'المريضة القلقة: اشرحي أن الضغط مؤلم قليلاً لكنه ضروري.',
      ],
    ),

    UsageStage(
      icon: '🛏️',
      title: 'وضع المريضة',
      duration: '2 دقيقة',
      steps: [
        UsageStep(icon: '🧍', text: 'المريضة واقفة أمام الجهاز.'),
        UsageStep(icon: '📐', text: 'ضبط ارتفاع الجهاز حسب طول المريضة.'),
        UsageStep(icon: '🎯', text: 'وضع الثدي على الكاشف بعناية.'),
        UsageStep(icon: '🎯', text: 'توسيط الحلمة (Nipple) في منتصف الصورة.'),
        UsageStep(icon: '💬', text: 'اشرحي: "سأضغط قليلاً، أخبريني لو ألم شديد".'),
        UsageStep(icon: '🖐️', text: 'اسحبي الجلد بلطف لتوسيع المنطقة قدر الإمكان.'),
      ],
      expertTips: [
        'الوضعية الصحيحة = 50% جودة الصورة.',
        'لا تسحبي الثدي بعنف — بلطف واحترافية.',
      ],
    ),

    UsageStage(
      icon: '🔽',
      title: 'الضغط (Compression)',
      duration: '1 دقيقة',
      steps: [
        UsageStep(icon: '🔽', text: 'ابدئي الضغط تدريجياً (10-20 kg).'),
        UsageStep(icon: '💬', text: 'أخبري المريضة: "الضغط ضروري لصورة أوضح وجرعة أقل".'),
        UsageStep(icon: '⏱️', text: 'الضغط يستمر 10-15 ثانية لكل صورة.'),
        UsageStep(icon: '👀', text: 'راقبي وجه المريضة — هل الألم محتمل؟'),
        UsageStep(icon: '🛑', text: 'إذا كان الألم شديداً: قلّلي الضغط قليلاً.'),
      ],
      commonMistake:
          'الضغط غير الكافي — الصورة تصبح غير واضحة، تحتاج إعادة.',
      mistakeFix:
          'اشرحي للمريضة أن الضغط ضروري، واستخدمي تقنية لطيفة.',
      expertTips: [
        'الضغط الجيد = تشتت أقل = تباين أعلى.',
        'بعض الأجهزة الحديثة لها ضغط تلقائي (AEC).',
      ],
    ),

    UsageStage(
      icon: '📸',
      title: 'التصوير',
      duration: '10-15 دقيقة',
      steps: [
        UsageStep(icon: '📷', text: 'أولاً: صورة CC (Craniocaudal) — من الأعلى.'),
        UsageStep(icon: '📷', text: 'ثم: صورة MLO (Mediolateral Oblique) — زاوية 45°.'),
        UsageStep(icon: '🔄', text: 'كرري للثدي الآخر (نفس الترتيب).'),
        UsageStep(icon: '🔊', text: 'التعرض: 0.3-0.6 ثانية فقط.'),
        UsageStep(icon: '📸', text: 'إذا لزم: تصوير إضافي (Magnification, Spot Compression).'),
        UsageStep(icon: '🖼️', text: 'راجعي كل صورة فوراً — جودة كافية؟'),
      ],
      commonMistake:
          'عدم رؤية كل الأنسجة (مثل الحافة الإبطية) في صورة MLO.',
      mistakeFix:
          'اضبطي زاوية MLO والوضعية بحيث تظهر كل الأنسجة.',
      expertTips: [
        'DBT (Tomosynthesis) — إذا متوفر، يقلل الحاجة لإعادة التصوير.',
        'الصورة الجيدة = 4 صور قياسية (2 لكل ثدي).',
      ],
    ),

    UsageStage(
      icon: '✅',
      title: 'بعد الفحص',
      duration: '2 دقيقة',
      steps: [
        UsageStep(icon: '🧻', text: 'امسحي الجل إن استُخدم (مناطق أخرى).'),
        UsageStep(icon: '👗', text: 'ساعدي المريضة على لبس ملابسها.'),
        UsageStep(icon: '🖼️', text: 'راجعي جميع الصور على الشاشة.'),
        UsageStep(icon: '📊', text: 'صنّفي BI-RADS (إن طُلب منك ذلك).'),
        UsageStep(icon: '💾', text: 'أرسلي الصور إلى PACS.'),
        UsageStep(icon: '📅', text: 'أخبري المريضة: "النتيجة في 24-48 ساعة".'),
      ],
      checklist: [
        'تم مراجعة كل الصور',
        'تم إرسال الصور إلى PACS',
        'تم توجيه المريضة للانتظار',
        'تم تنظيف الجهاز',
        'تم توثيق الجرعة',
      ],
      expertTips: [
        'النتيجة تُقرأ من طبيب الأشعة — وليس من التقني.',
        'إذا احتاجت المريضة تصويراً إضافياً: اشرحي السبب.',
      ],
    ),
  ],
);