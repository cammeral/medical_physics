import '../clinical_section.dart';

const List<ClinicalSection> mammographyClinical = [
  ClinicalSection(
    icon: '🎯',
    title: 'الدواعي (Indications)',
    blocks: [
      ClinicalBlock.text(
        'Mammography هو الفحص الأساسي للكشف المبكر عن سرطان الثدي. '
        'يُقلل الوفيات بنسبة 30% للنساء 50-69 سنة.',
      ),
      ClinicalBlock.bullets([
        '🔍 الفحص الدوري (Screening): للنساء 40-74 سنة كل 1-2 سنة.',
        '🩺 التشخيص (Diagnostic): كتلة محسوسة، إفرازات حلمة، ألم، تغير '
            'جلدي.',
        '📊 المتابعة: بعد علاج سرطان ثدي، كل 6-12 شهر.',
        '🧬 عالي الخطورة: BRCA1/2، تاريخ عائلي، بدء من 30 سنة (مع MRI).',
        '👶 الرضاعة: آمن، يُفضل بعد 3 أشهر من الفطام.',
        '💊 العلاج الهرموني: متابعة سنوية.',
      ]),
      ClinicalBlock.note(
        'الفحص الدوري يُكتشف السرطان قبل أن يُلمس — حجم 5 mm. '
        'معدل البقاء على قيد الحياة > 99% في المراحل المبكرة.',
      ),
    ],
  ),

  ClinicalSection(
    icon: '🚫',
    title: 'الموانع (Contraindications)',
    blocks: [
      ClinicalBlock.text('Mammography آمن — لا موانع مطلقة. لكن:'),
      ClinicalBlock.bullets([
        '🤰 الحمل: يُؤجَّل إن أمكن (الثدي حساس للإشعاع).',
        '🍼 الرضاعة: يمكن، لكن يُفضل بعد 3 أشهر (الثدي كثيف).',
        '🩹 جروح/التهابات نشطة: انتظر الشفاء.',
        '💉 حقن سيليكون/تكبير: يحتاج تقنية خاصة (Implant Displacement).',
        '🩺 بعد خزعة: انتظر 2 أسابيع للشفاء.',
        '🌡️ حلمة متشققة: تجنب الضغط المباشر.',
      ]),
      ClinicalBlock.note(
        'الجرعة منخفضة جداً — فائدة الفحص تفوق بكثير خطر الإشعاع. '
        'MGD ~0.4 mSv.',
      ),
    ],
  ),

  ClinicalSection(
    icon: '🩺',
    title: 'تحضير المريض',
    blocks: [
      ClinicalBlock.bullets([
        '📅 التوقيت: بعد الدورة بأسبوع (الثدي أقل حساسية).',
        '🧴 لا مزيل عرق أو بودرة أو كريم في يوم الفحص.',
        '👕 ملابس مريحة بقطعة واحدة (سهولة التغيير).',
        '💊 إبلاغ التقني عن: الحمل، الرضاعة، عمليات سابقة، زرعات.',
        '🔍 إحضار صور سابقة للمقارنة (مهم جداً).',
        '😌 الاسترخاء: الضغط قد يكون مؤلماً قليلاً لكنه ضروري.',
        '📋 إبلاغ التقني عن أي كتلة أو ألم.',
      ]),
      ClinicalBlock.text('خطوات الفحص:'),
      ClinicalBlock.bullets([
        '① التسجيل والاستبيان.',
        '② تغيير الملابس (رداء المستشفى).',
        '③ تصوير كل ثدي في وضعين (CC, MLO).',
        '④ ضغط لمدة 10-15 ثانية لكل صورة.',
        '⑤ إعادة التصوير إذا لزم.',
        '⑥ الطبيب يقرأ النتائج في 24-48 ساعة.',
      ]),
      ClinicalBlock.note(
        'التصوير الشامل ~20 دقيقة. إذا احتاج تصوير إضافي (Ultrasound/DBT)، '
        'قد يمتد لساعة.',
      ),
    ],
  ),

  ClinicalSection(
    icon: '📊',
    title: 'مقارنة مع الفحوصات الأخرى',
    blocks: [
      ClinicalBlock.table(
        ClinicalTable(
          headers: ['الفحص', 'الإشعاع', 'الحساسية', 'الاستخدام'],
          rows: [
            ['Mammography', 'منخفض جداً', '70-85%', 'الفحص الأول'],
            ['DBT', 'منخفض جداً', '85-90%', 'الأفضل حالياً'],
            ['Ultrasound', 'صفر', 'مكمل', 'الثدي الكثيف'],
            ['MRI', 'صفر', '90-95%', 'عالي الخطورة'],
            ['Biopsy', 'صفر', 'نهائي', 'التشخيص المؤكد'],
          ],
        ),
      ),
      ClinicalBlock.note(
        'للفحص الدوري: Mammography + DBT. للنساء ذوات الثدي الكثيف: '
        '+ Ultrasound. لعالي الخطورة: + MRI.',
      ),
    ],
  ),

  ClinicalSection(
    icon: '🏥',
    title: 'حالات سريرية نموذجية',
    blocks: [
      ClinicalBlock.caseStudy(
        ClinicalCase(
          title: 'سرطان ثدي مبكر',
          patient: 'امرأة 48 سنة، فحص دوري روتيني.',
          presentation: 'لا أعراض، فحص سريري طبيعي.',
          finding:
              'Mammography: تجمّع تكلّسات دقيقة (Microcalcifications) '
              'غير منتظمة في الثدي الأيمن.',
          diagnosis:
              'DCIS (سرطان قنوي لابدي). العلاج: استئصال الكتلة + '
              'علاج إشعاعي. البقاء 99%.',
        ),
      ),
      ClinicalBlock.caseStudy(
        ClinicalCase(
          title: 'كتلة محسوسة',
          patient: 'امرأة 55 سنة، لاحظت كتلة في الثدي الأيسر.',
          presentation: 'كتلة 2 cm، صلبة، غير مؤلمة، ثابتة.',
          finding:
              'Mammography + Ultrasound: كتلة مشبوهة، تصنيف BI-RADS 5، '
              'خزعة أكدت سرطان قنوي غازي.',
          diagnosis:
              'سرطان ثدي مرحلة IIA. العلاج: جراحة تحفظية + علاج إشعاعي '
              '+ كيميائي + هرموني.',
        ),
      ),
      ClinicalBlock.caseStudy(
        ClinicalCase(
          title: 'عالي الخطورة',
          patient: 'امرأة 32 سنة، أمها وأختها مريضتان بسرطان ثدي.',
          presentation: 'بدون أعراض، لكن تاريخ عائلي قوي.',
          finding:
              'فحص جيني: BRCA1 موجب. Mammography + MRI: طبيعي.',
          diagnosis:
              'عالي الخطورة. المتابعة: Mammography + MRI سنوياً من عمر '
              '30. دراسة استئصال وقائي.',
        ),
      ),
      ClinicalBlock.caseStudy(
        ClinicalCase(
          title: 'تكلّسات حميدة',
          patient: 'امرأة 42 سنة، فحص دوري.',
          presentation: 'لا أعراض.',
          finding:
              'Mammography: تكلّسات منتظمة ناعمة (Popcorn). BI-RADS 2.',
          diagnosis:
              'تكلّسات حميدة. لا تحتاج تدخل. متابعة سنوية عادية.',
        ),
      ),
      ClinicalBlock.caseStudy(
        ClinicalCase(
          title: 'كيس بسيط',
          patient: 'امرأة 46 سنة، كتلة مؤلمة تتغير مع الدورة.',
          presentation: 'كتلة مؤلمة، تتغير في الحجم مع الدورة.',
          finding:
              'Ultrasound: كيس بسيط (Simple Cyst)، جدار رقيق، سائل صافٍ.',
          diagnosis:
              'كيس حميد. لا يحتاج علاج. إذا كان كبيراً ومؤلماً → '
              'شفط بالإبرة.',
        ),
      ),
      ClinicalBlock.note(
        'الفحص الدوري يُنقذ الأرواح. أي شك → تصوير إضافي، ثم خزعة إن لزم.',
      ),
    ],
  ),
];