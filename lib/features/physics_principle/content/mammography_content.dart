import '../principle_section.dart';

const List<PrincipleSection> mammographyPrincipleContent = [
  PrincipleSection(
    icon: '💡',
    title: 'الفكرة المبسطة',
    blocks: [
      Block.text(
        'تصوير الثدي بالأشعة السينية (Mammography) هو تصوير متخصص للثدي '
        'بأشعة سينية منخفضة الطاقة (25-35 kVp) لاكتشاف سرطان الثدي في مراحله المبكرة '
        '(حتى قبل أن يُلمس)، بما في ذلك التكلّسات الدقيقة (Microcalcifications).',
      ),
      Block.bullets([
        'أشعة سينية عادة لكن مخصصة للأنسجة الرخوة.',
        'طاقة منخفضة (25-35 kVp) بدلاً من 120 kVp للتصوير العام.',
        'هدف معدني مختلف: Mo (موليبدينوم) أو Rh (روديوم) أو W (تنغستن).',
        'ضغط قوي للثدي (Compression) — ضروري.',
        'فحص الفحص الدوري (Screening) يقلل الوفيات ~30%.',
      ]),
      Block.note(
        'سرطان الثدي هو الأكثر شيوعاً بين النساء عالمياً. الكشف المبكر = شفاء ~99%.',
      ),
    ],
  ),

  PrincipleSection(
    icon: '⚡',
    title: 'كيف يعمل Mammography؟',
    blocks: [
      Block.bullets([
        '① أنبوب أشعة سينية بهدف Mo أو Rh (لإنتاج طيف مناسب للأنسجة الرخوة).',
        '② ترشيح خاص (Mo, Rh, Ag) لإزالة الفوتونات منخفضة الطاقة جداً.',
        '③ ضغط الثدي بين صفيحتين (Compression Paddle) — يقلل السماكة والجرعة.',
        '④ كاشف رقمي (Digital) أو فيلم تقليدي.',
        '⑤ صورتان على الأقل: CC (Craniocaudal) و MLO (Mediolateral Oblique).',
        '⑥ الحاسوب يعالج الصورة ويُظهرها على شاشة عالية الدقة.',
      ]),
      Block.note(
        'الضغط مهم جداً: تقليل السماكة = تقليل الجرعة والانتشار (Scatter) = صورة أوضح.',
      ),
    ],
  ),

  PrincipleSection(
    icon: '📐',
    title: 'المعادلات الأساسية',
    blocks: [
      Block.text('طاقة الفوتون:'),
      Block.equation(
        'E = h · c / λ',
        note: 'نحتاج طاقة ~17-20 keV للتباين الأمثل في الثدي',
      ),
      Block.text('التباين (Contrast):'),
      Block.equation(
        'Contrast = (μ_lesion - μ_tissue) / μ_tissue',
        note: 'التباين يعتمد على الفرق في معامل الامتصاص',
      ),
      Block.text('التباين الأمثل عند:'),
      Block.equation(
        'E(optimal) = Z_eff(target) × 2 keV',
        note: 'مثال: هدف Mo (Z=42) → طاقة مثالية ~18-20 keV',
      ),
      Block.text('الجرعة:'),
      Block.equation(
        'MGD ≈ 0.3-0.6 mGy لكل صورة',
        note: 'MGD = Mean Glandular Dose (الجرعة على النسيج الغدي)',
      ),
    ],
  ),

  PrincipleSection(
    icon: '🎛️',
    title: 'العوامل المؤثرة والميزات الخاصة',
    blocks: [
      Block.bullets([
        'الهدف (Target): Mo, Rh, W — كل هدف له طيف مميز.',
        'الترشيح (Filter): Mo/Mo, Mo/Rh, Rh/Rh, W/Rh, W/Ag.',
        'kVp: 25-35 kVp (أقل من التصوير العام).',
        'mAs: يُضبط حسب كثافة الثدي.',
        'AEC (Automatic Exposure Control): لضبط تلقائي للتعرض.',
        'Compression: يدوي أو تلقائي.',
      ]),
      Block.text('الميزات التي تميّز Mammography عن X-ray العادي:'),
      Block.bullets([
        'هدف وترشيح خاصان.',
        'طاقة منخفضة للتباين العالي في الأنسجة الرخوة.',
        'ضغط قوي.',
        'دقة مكانية عالية جداً (50-100 μm بكسل).',
        'كاشف متخصص للثدي.',
      ]),
    ],
  ),

  PrincipleSection(
    icon: '🔬',
    title: 'أنواع Mammography',
    blocks: [
      Block.bullets([
        '① Film-Screen Mammography: التقليدي (نادر الآن).',
        '② Full-Field Digital Mammography (FFDM): رقمي عادي.',
        '③ Digital Breast Tomosynthesis (DBT): مقطعي ثلاثي الأبعاد — يقلل التداخل.',
        '④ Contrast-Enhanced Mammography: مع مادة تباين يودية.',
        '⑤ Computer-Aided Detection (CAD): ذكاء اصطناعي للكشف.',
        '⑥ MRI للثدي: للنساء المعرّضات وراثياً (BRCA).',
        '⑦ Ultrasound: مكمّل للنساء ذوات الثدي الكثيف.',
      ]),
      Block.note(
        'DBT (Tomosynthesis) هو المعيار الحديث — يحسّن الكشف ويقلل النداءات الكاذبة.',
      ),
    ],
  ),

  PrincipleSection(
    icon: '🏥',
    title: 'الاستخدامات السريرية',
    blocks: [
      Block.text('الفحص الدوري (Screening):'),
      Block.bullets([
        'للنساء 40-74 سنة، كل 1-2 سنة.',
        'الهدف: اكتشاف السرطان قبل ظهور العلامات.',
        'يكشف الأورام بحجم 5-10 mm والتكلّسات الدقيقة.',
      ]),
      Block.text('التشخيص (Diagnostic):'),
      Block.bullets([
        'بعد اكتشاف كتلة باليد.',
        'بعد إفرازات حلمة غير طبيعية.',
        'متابعة بعد جراحة سرطان الثدي.',
        'تقييم قبل الخزعة.',
      ]),
      Block.text('BI-RADS (مستويات التقارير):'),
      Block.bullets([
        '0: يحتاج تصوير إضافي.',
        '1: طبيعي.',
        '2: حميد (Benign).',
        '3: يحتمل الحميد (< 2% خطر).',
        '4: مشتبه به (يحتاج خزعة).',
        '5: سرطان محتمل جداً (≥ 95%).',
        '6: سرطان مؤكد بالخزعة.',
      ]),
    ],
  ),

  PrincipleSection(
    icon: '☢️',
    title: 'الجرعة والأمان',
    blocks: [
      Block.bullets([
        'MGD لكل صورة: 0.3-0.6 mGy.',
        'الفحص الكامل (4 صور): ~1.5-2 mGy (أي ~0.4 mSv).',
        'مقارنة: X-ray صدر = 0.1 mSv، جرعة سنوية طبيعية = 2-3 mSv.',
        'الجرعة منخفضة جداً — فائدة الفحص الدوري تفوق المخاطر بكثير.',
        'الحوامل: يُؤجَّل إن أمكن (الثدي حساس للإشعاع).',
        'المرضعات: يمكن إجراء الفحص بأمان.',
      ]),
      Block.note(
        'فائدة الفحص الدوري لسرطان الثدي: تقليل الوفيات 30% للنساء 50-69 سنة.',
      ),
      Block.text('تحسين الجرعة:'),
      Block.bullets([
        'استخدام DBT يقلل الحاجة لإعادة التصوير.',
        'تقليل عدد الصور للحد الأدنى.',
        'ضبط AEC بدقة.',
        'استخدام الترشيح المناسب.',
      ]),
    ],
  ),
];