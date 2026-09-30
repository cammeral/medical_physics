import '../component_section.dart';

const List<ComponentSection> spectComponents = [
  ComponentSection(
    icon: '📷',
    title: 'كاميرا غاما (Gamma Camera)',
    imageUrl: 'assets/images/spect_camera.png',
    intro:
        'القلب الكامل لجهاز SPECT. تُسمّى أيضاً Anger Camera نسبة لمخترعها. '
        'تلتقط فوتونات غاما الصادرة من المريض وتحوّلها إلى صورة.',
    items: [
      ComponentItem(
        icon: '🥞',
        name: 'الهيكل (Gantry)',
        description:
            'هيكل على شكل حرف U أو حلقة. يحتوي على كاميرا واحدة أو اثنتين '
            '(Dual-Head) للتصوير الأسرع. تدور 180° أو 360° حول المريض.',
      ),
      ComponentItem(
        icon: '🛏️',
        name: 'طاولة المريض',
        description:
            'طاولة متحركة ببطء ضمن مجال الكاميرا. تتحرك للأمام/الخلف وللأعلى/'
            'الأسفل للحصول على الوضع الأمثل.',
      ),
    ],
    notes: [
      'SPECT أبطأ من CT/MRI — الفحص الكامل قد يستغرق 20-45 دقيقة.',
      'الكاميرا المزدوجة (Dual-Head) تقلل الوقت للنصف.',
    ],
  ),

  ComponentSection(
    icon: '🔲',
    title: 'الكوليماتور (Collimator)',
    intro:
        'أهم مكون في كاميرا غاما. صفيحة رصاصية سميكة بثقوب متوازية تقبل فقط '
        'الفوتونات العمودية — لتحديد موقع الإشارة.',
    items: [
      ComponentItem(
        icon: '📏',
        name: 'Parallel-Hole',
        description:
            'الأكثر شيوعاً. ثقوب متوازية تُنتج صورة بحجم طبيعي (1:1). '
            'يستخدم للتصوير العام للأعضاء.',
      ),
      ComponentItem(
        icon: '🔍',
        name: 'Pinhole',
        description:
            'ثقب واحد صغير جداً. صورة مكبّرة عالي الدقة لكن منطقة صغيرة. '
            'للغدة الدرقية والمفاصل الصغيرة.',
      ),
      ComponentItem(
        icon: '🌪️',
        name: 'Fan-Beam / Converging',
        description:
            'ثقوب مائلة. تكبّر الصورة وتزيد الحساسية. للتصوير القلبي '
            'وتصوير الدماغ.',
      ),
      ComponentItem(
        icon: '💨',
        name: 'Diverging',
        description:
            'ثقوب متباعدة تصغّر الصورة. لعرض أعضاء كبيرة (الرئة) من '
            'مسافة قصيرة.',
      ),
    ],
    notes: [
      'الكوليماتور يقتل 99.9% من الفوتونات — لذلك SPECT أقل حساسية.',
      'اختيار الكوليماتور يعتمد على الطاقة، الدقة، والحساسية المطلوبة.',
    ],
  ),

  ComponentSection(
    icon: '💎',
    title: 'البلورة الوميضية (NaI(Tl) Crystal)',
    intro:
        'لوح كبير من يوديد الصوديوم المنشّط بالثاليوم. يحوّل فوتون غاما إلى '
        'وميض ضوئي يمكن قياسه.',
    items: [
      ComponentItem(
        icon: '📐',
        name: 'الأبعاد',
        description:
            'عادة 40×50 cm بسماكة 1 cm. كبيرة لتغطية أعضاء كاملة '
            '(الكبد، الرئة) بكفاءة.',
      ),
      ComponentItem(
        icon: '💡',
        name: 'كفاءة التحويل',
        description:
            'حوالي 12% من طاقة غاما تتحول إلى ضوء مرئي. مرتفعة نسبياً '
            'لكن تحتاج PMT حساسة.',
      ),
      ComponentItem(
        icon: '🛡️',
        name: 'الحماية الرطبة',
        description:
            'NaI يتحلل بالرطوبة! البلورة محفوظة في غلاف محكم من الألمنيوم.',
      ),
    ],
    notes: [
      'NaI(Tl) يعطي وميضاً أزرق عند امتصاص غاما.',
      'بدائل حديثة: CZT (Cadmium Zinc Telluride) — كفاءة أعلى لكن أغلى.',
    ],
  ),

  ComponentSection(
    icon: '📻',
    title: 'أنابيب التضخيم الضوئي (PMT Array)',
    intro:
        'مصفوفة من 50-100 PMT خلف البلورة. تحوّل كل وميض ضوئي إلى إشارة '
        'كهربائية، وتحدد موقع الوميض.',
    items: [
      ComponentItem(
        icon: '🎯',
        name: 'تحديد الموقع (Positioning)',
        description:
            'الحاسوب يقارن شدة الإشارة في PMTs المتعددة لحساب إحداثيات (X, Y) '
            'لكل وميض — عبر خوارزمية Anger Logic.',
      ),
      ComponentItem(
        icon: '⚡',
        name: 'قياس الطاقة (Energy Discrimination)',
        description:
            'مجموع شدة الإشارات يعطي طاقة الفوتون. الفوتونات خارج نافذة '
            'الطاقة (مثل Compton) تُهمل — يحسّن التباين.',
      ),
    ],
    notes: [
      'نافذة الطاقة النموذجية: ±10% حول قمة الفوتون (مثل 140 keV لـ Tc-99m).',
      'CZT detectors لا تحتاج PMT — تحوّل مباشرة.',
    ],
  ),

  ComponentSection(
    icon: '💻',
    title: 'نظام إعادة البناء (SPECT Reconstruction)',
    intro:
        'يحوّل مشاهدات الكاميرا من زوايا متعددة إلى صورة مقطعية ثلاثية الأبعاد.',
    items: [
      ComponentItem(
        icon: '🧮',
        name: 'Filtered Back Projection (FBP)',
        description:
            'الخوارزمية التقليدية. سريعة لكن ضوضاؤها عالية.',
      ),
      ComponentItem(
        icon: '🔄',
        name: 'Iterative Reconstruction',
        description:
            'OSEM أو MLEM — تُستخدم بكثرة الآن. جودة أعلى مع ضجيج أقل.',
      ),
      ComponentItem(
        icon: '🎨',
        name: 'دمج SPECT/CT',
        description:
            'أجهزة حديثة تدمج SPECT مع CT لتصحيح التوهين (Attenuation '
            'Correction) — يحسّن الجودة بشكل كبير.',
      ),
    ],
    notes: [
      'تصحيح التوهين مهم — بدون CT، التصحيح رياضي تقريبي.',
      'SPECT/CT أحدث صيحة في الطب النووي.',
    ],
  ),

  ComponentSection(
    icon: '🏭',
    title: 'مولد Mo-99 / Tc-99m',
    intro:
        'قلب إنتاج Tc-99m — الأكثر استخداماً في SPECT. يوفر Tc-99m يومياً '
        'لمدة أسبوعين.',
    items: [
      ComponentItem(
        icon: '🔋',
        name: 'العمود المولّد (Generator Column)',
        description:
            'يحتوي على Mo-99 (عمر نصف 66 ساعة) المتصل بألومينا. Mo-99 يضمحل '
            'تدريجياً إلى Tc-99m.',
      ),
      ComponentItem(
        icon: '💧',
        name: 'الاستخلاص (Elution)',
        description:
            'يُمرر محلول ملحي معقم عبر العمود ليذيب Tc-99m (يُسمى Eluate) '
            'ويُترك Mo-99. العملية تستغرق دقيقة.',
      ),
      ComponentItem(
        icon: '⏱️',
        name: 'التوقيت',
        description:
            'يُستخلص كل 6 ساعات لتحقيق أقصى نشاط. Molybdenum Breakthrough '
            'يُقاس لضمان النقاء.',
      ),
    ],
    notes: [
      'Tc-99m هو "حصان العمل" للطب النووي — ~80% من الفحوصات.',
      'Mo-99 يُنتج في مفاعلات نووية (5 مفاعلات عالمياً تسيطر على السوق).',
    ],
  ),

  ComponentSection(
    icon: '🛡️',
    title: 'الحماية الإشعاعية',
    intro:
        'SPECT يستخدم طاقة أقل من PET، لكن الحماية لا تزال ضرورية.',
    items: [
      ComponentItem(
        icon: '🧱',
        name: 'الدرع (Shielding)',
        description:
            'الرصاص للغرف. لا حاجة للبورون (لا نيوترونات). سماكة أقل من '
            'PET غرفة.',
      ),
      ComponentItem(
        icon: '📏',
        name: 'المراقبة الشخصية',
        description:
            'Dosimeter لكل طبيب/تقني. المراقبة الدورية للجرعة التراكمية.',
      ),
      ComponentItem(
        icon: '🚪',
        name: 'منطقة الانتظار',
        description:
            'المريض ينتظر 2-4 ساعات بعد الحقن (حسب الفحص). غرفة مبطنة '
            'مع حمّام خاص (البول مشع).',
      ),
    ],
    notes: [
      'Tc-99m يُطرح في البول خلال 6 ساعات — اشرب سوائل.',
      'الحوامل والمرضعات: احتياطات خاصة حسب النظير.',
    ],
  ),
];