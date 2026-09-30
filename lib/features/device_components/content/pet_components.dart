import '../component_section.dart';

const List<ComponentSection> petComponents = [
  ComponentSection(
    icon: '🏭',
    title: 'جهاز PET/CT المدمج',
    imageUrl: 'assets/images/pet_scanner.png',
    intro:
        'جهاز PET لا يعمل وحده عادة — يُدمج مع CT (PET/CT) أو MRI (PET/MRI) '
        'للحصول على معلومة وظيفية + تشريحية في صورة واحدة.',
    items: [
      ComponentItem(
        icon: '🔄',
        name: 'الهيكل الحلقي (Gantry)',
        description:
            'يحتوي على حلقة من الكواشف تمتد 360° حول المريض. يختلف عن CT في أن '
            'الكواشف ثابتة (لا تدور) لأنها تلتقط الفوتونات من كل الاتجاهات.',
      ),
      ComponentItem(
        icon: '🔗',
        name: 'دمج PET/CT',
        description:
            'نفس الطاولة تمر عبر جهازي PET و CT بالتتابع. الحاسوب يُدمج الصورتين: '
            'CT تعطي التشريح، PET تعطي النشاط الأيضي — في صورة ملونة واحدة.',
      ),
    ],
    notes: [
      'PET/CT = 90% من الأجهزة الحديثة.',
      'PET/MRI أحدث لكن أغلى وأعقد.',
    ],
  ),

  ComponentSection(
    icon: '🔮',
    title: 'الكواشف البلورية (Scintillation Crystals)',
    intro:
        'تحوّل فوتونات غاما (511 keV) إلى ضوء مرئي يمكن قياسه. أهم مكون في PET.',
    items: [
      ComponentItem(
        icon: '💎',
        name: 'BGO (Bismuth Germanate)',
        description:
            'كثافة عالية، كفاءة عالية للتوقف، لكن بطيء نسبياً (300 ns). '
            'يُستخدم في الأجهزة القديمة.',
      ),
      ComponentItem(
        icon: '⚡',
        name: 'LSO (Lutetium Oxyorthosilicate)',
        description:
            'سريع جداً (40 ns) وساطع. الأفضل لـ TOF-PET. غالي الثمن — '
            'يحتوي على لوتيشيوم مشع طبيعياً (يُصحح برمجياً).',
      ),
      ComponentItem(
        icon: '🌟',
        name: 'LYSO (Lutetium Yttrium Oxyorthosilicate)',
        description:
            'نسخة محسّنة من LSO — أرخص قليلاً وأداء مشابه. الأكثر استخداماً '
            'في الأجهزة الحديثة.',
      ),
    ],
    notes: [
      'بلورات PET صغيرة جداً — مقطعها 4×4 mm لتحسين الدقة.',
      'كل حلقة تحتوي على آلاف البلورات (عادة 10,000-20,000).',
    ],
  ),

  ComponentSection(
    icon: '📻',
    title: 'أنابيب التضخيم الضوئي (PMT / SiPM)',
    intro:
        'تحوّل الضوء الضعيف جداً من البلورة إلى إشارة كهربائية قابلة للقياس.',
    items: [
      ComponentItem(
        icon: '📡',
        name: 'PMT (Photomultiplier Tube)',
        description:
            'أنبوب زجاجي مفرَّغ يحتوي على كاثود ضوئي وسلسلة داينودات. يضخّم '
            'الإشارة مليون مرة. حساس جداً لكن كبير الحجم وحساس للمجال المغناطيسي.',
      ),
      ComponentItem(
        icon: '🔬',
        name: 'SiPM (Silicon Photomultiplier)',
        description:
            'بديل حديث: مصفوفة من الثنائيات الدقيقة. صغير، متين، لا يتأثر '
            'بالمجال المغناطيسي — مهم لـ PET/MRI. كفاءة عالية.',
      ),
    ],
    notes: [
      'كل بلورة يلزمها PMT أو SiPM خاص — أو مجموعة مشتركة.',
      'PMT قديم لكن لا يزال يُستخدم في الأجهزة التقليدية.',
    ],
  ),

  ComponentSection(
    icon: '🧠',
    title: 'نظام التطابق (Coincidence System)',
    intro:
        'أهم ما يميّز PET. يلتقط الفوتونين المتعاكسين في نفس اللحظة لتحديد موقع الفناء.',
    items: [
      ComponentItem(
        icon: '⏱️',
        name: 'نافذة التطابق (Coincidence Window)',
        description:
            'عادة 6-12 نانوثانية. أي فوتونان يصلان في هذه النافذة يُعتبران '
            'حدثاً حقيقياً. لو أوسع → ضجيج، لو أضيق → فقدان إشارات.',
      ),
      ComponentItem(
        icon: '🎯',
        name: 'خط الاستجابة (Line of Response - LOR)',
        description:
            'الخط الواصل بين الكاشفين. موقع الفناء يقع عليه. آلاف الخطوط '
            'تُستخدم لإعادة بناء الصورة.',
      ),
      ComponentItem(
        icon: '🚀',
        name: 'TOF-PET (Time of Flight)',
        description:
            'يقيس فرق الزمن بين الفوتونين بدقة بيكوثانية لتحديد الموقع على '
            'الخط مباشرة. يحسّن SNR بـ 2-3 أضعاف.',
      ),
    ],
    notes: [
      'التقاط عشوائي (Random) = حدثان غير مرتبطان = ضجيج.',
      'التشتت (Scatter) = فوتون انحرف = خطأ في الموقع.',
    ],
  ),

  ComponentSection(
    icon: '🏭',
    title: 'السيكلوترون (Cyclotron)',
    intro:
        'مُعجّل دوراني يُنتج النظائر المشعة قصيرة العمر. عادة في نفس المستشفى.',
    items: [
      ComponentItem(
        icon: '⚡',
        name: 'مبدأ التسريع',
        description:
            'بروتونات تُسرّع في مسار حلزوني بواسطة مجال مغناطيسي + جهد متناوب. '
            'تصطدم بهدف لإنتاج النظير المطلوب (مثل F-18).',
      ),
      ComponentItem(
        icon: '🧪',
        name: 'وحدة الكيمياء (Radiochemistry)',
        description:
            'تربط النظير بجزيء حيوي (مثل الجلوكوز لإنتاج FDG). تتم في '
            'غرفة نظيفة تحت سيطرة آلية بالكامل.',
      ),
      ComponentItem(
        icon: '🚚',
        name: 'التوزيع السريع',
        description:
            'F-18 عمر نصفه 110 دقائق فقط. الحقن خلال 2-3 ساعات من الإنتاج. '
            'لذلك كل مستشفى كبير له Cyclotron خاص أو قريب.',
      ),
    ],
    notes: [
      'تكلفة Cyclotron: 2-5 مليون دولار + تشغيل عالٍ.',
      'بعض النظائر (Ga-68, Rb-82) تُنتج من مولدات (Generators).',
    ],
  ),

  ComponentSection(
    icon: '💻',
    title: 'نظام إعادة البناء والعرض',
    intro:
        'يحوّل بيانات الكواشف إلى صور مقطعية وثلاثية الأبعاد + يدمجها مع CT/MRI.',
    items: [
      ComponentItem(
        icon: '🧮',
        name: 'خوارزميات إعادة البناء',
        description:
            'OSEM (Ordered Subset EM) — الأكثر شيوعاً. Iterative مع دمج CT '
            'لتصحيح التوهين (Attenuation Correction).',
      ),
      ComponentItem(
        icon: '🎨',
        name: 'دمج الصور (Fusion)',
        description:
            'دمج PET (ملون: أصفر/برتقالي = نشاط عالٍ) مع CT (رمادي). النتيجة: '
            'صورة تُظهر السرطان بدقة في مكانه التشريحي.',
      ),
      ComponentItem(
        icon: '📊',
        name: 'SUV (Standardized Uptake Value)',
        description:
            'مقياس كمي لامتصاص FDG. SUV > 2.5 يشير للاشتباه بالسرطان. '
            'يُتابع الاستجابة للعلاج بمقارنة SUV قبل وبعد.',
      ),
    ],
    notes: [
      'إعادة البناء تستغرق 5-15 دقيقة في PET (أطول من CT/MRI).',
      'الذكاء الاصطناعي يُستخدم حديثاً لتحسين الجودة وتقليل الضجيج.',
    ],
  ),

  ComponentSection(
    icon: '🛡️',
    title: 'الحماية والتحكم بالجرعة',
    intro:
        'PET يستخدم جرعات أعلى من CT، ويحتاج إجراءات حماية صارمة.',
    items: [
      ComponentItem(
        icon: '🧱',
        name: 'الجدران الرصاصية والبورونية',
        description:
            'غرفة الفحص مبطنة بطبقات من الرصاص والبورون. البورون يمتص '
            'النيوترونات التي قد تنطلق من النظائر.',
      ),
      ComponentItem(
        icon: '📏',
        name: 'أجهزة القياس الشخصية',
        description:
            'كل طبيب وتقني يحمل Dosimeter شخصي (Film Badge, TLD, OSL) '
            'لقياس الجرعة التراكمية.',
      ),
      ComponentItem(
        icon: '🚪',
        name: 'منطقة الانتظار المحمية',
        description:
            'المريض ينتظر بعد الحقن في غرفة مبطنة. لا يُسمح للزوار. '
            'شرب السوائل يسرّع الطرح.',
      ),
    ],
    notes: [
      'قاعدة ALARA: أقصر وقت، أكبر مسافة، أفضل حاجز.',
      'الطبيب يقف خلف حاجز رصاصي أثناء الفحص.',
    ],
  ),
];