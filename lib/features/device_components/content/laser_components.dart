import '../component_section.dart';

const List<ComponentSection> laserComponents = [
  ComponentSection(
    icon: '💡',
    title: 'الوسط الفعّال (Active Medium)',
    imageUrl: 'assets/images/laser_device.png',
    intro:
        'المادة التي تُنتج الانبعاث المستحث. تحدد الطول الموجي وخصائص الليزر. '
        'أنواع: غاز، سائل (صبغة)، صلب (بلورة)، شبه موصل.',
    items: [
      ComponentItem(
        icon: '💨',
        name: 'الوسط الغازي',
        description:
            'CO₂ (10.6 μm): للقطع الجراحي. Argon (488/514 nm): للعيون. '
            'Excimer (193 nm): لـ LASIK. He-Ne (633 nm): للتصويب.',
      ),
      ComponentItem(
        icon: '💎',
        name: 'الوسط الصلب',
        description:
            'Nd:YAG (1064 nm): جراحة عامة. Er:YAG (2940 nm): جلدي. '
            'Alexandrite (755 nm): إزالة الشعر. Ho:YAG: جراحة البروستاتا.',
      ),
      ComponentItem(
        icon: '🧪',
        name: 'الوسط السائل (Dye)',
        description:
            'صبغات عضوية مثل Rhodamine 6G. الطول الموجي قابل للضبط '
            '(Tunable) — مفيد لأبحاث.',
      ),
      ComponentItem(
        icon: '🔌',
        name: 'شبه الموصل (Diode)',
        description:
            'أشباه موصلات مثل GaAs و GaAlAs. صغيرة ورخيصة. 800-980 nm '
            'لإزالة الشعر والليزر العلاجي.',
      ),
    ],
    notes: [
      'كل وسط له "طيف إصدار" محدد — يحدد الطول الموجي.',
      'اختيار الوسط حسب الاستخدام الطبي.',
    ],
  ),

  ComponentSection(
    icon: '⚡',
    title: 'نظام الضخ (Pumping System)',
    intro:
        'يوفر الطاقة اللازمة لإثارة الذرات إلى المستوى الأعلى. بدون ضخ '
        'كافٍ لا يحدث الانبعاث المستحث.',
    items: [
      ComponentItem(
        icon: '💡',
        name: 'الضخ الضوئي (Optical Pumping)',
        description:
            'مصابيح قوية (Xenon Flashlamps) أو ليزر آخر لضخ الوسط. '
            'يُستخدم مع Nd:YAG و Dye lasers.',
      ),
      ComponentItem(
        icon: '⚡',
        name: 'الضخ الكهربائي (Electrical Pumping)',
        description:
            'تيار كهربائي مباشر عبر الغاز. يُستخدم مع CO₂ و Excimer '
            'و Diode lasers.',
      ),
      ComponentItem(
        icon: '🔥',
        name: 'الضخ الكيميائي',
        description:
            'تفاعل كيميائي طارد للطاقة. نادر في الطب (استخدام عسكري).',
      ),
    ],
    notes: [
      'الضخ يحتاج طاقة عالية جداً — معظمها يفقد كحرارة.',
      'لهذا الليزر الطبي يحتاج تبريداً قوياً.',
    ],
  ),

  ComponentSection(
    icon: '🪞',
    title: 'المرنان البصري (Optical Cavity)',
    intro:
        'يُضخّم الضوء بتكرار مروره عبر الوسط الفعال. مرآتان متقابلتان — '
        'واحدة عاكسة 100%، والأخرى شبه شفافة.',
    items: [
      ComponentItem(
        icon: '🪞',
        name: 'المرآة الخلفية (Back Mirror)',
        description:
            'عاكسة 100%. تُعيد كل الضوء نحو الوسط.',
      ),
      ComponentItem(
        icon: '🪟',
        name: 'المرآة الأمامية (Output Coupler)',
        description:
            'عاكسة 95-99%. تسمح بمرور جزء من الضوء كشعاع ليزر.',
      ),
      ComponentItem(
        icon: '🎯',
        name: 'الشعاع الخارجي',
        description:
            'شعاع شديد التوازي والتماسك. يُوجَّه عبر نظام بصري إلى '
            'النسيج المستهدف.',
      ),
    ],
    notes: [
      'طول المرنان يحدد أطوال الموجات المسموحة.',
      'كل انعكاس يضاعف الطاقة حتى تصل للحد الأقصى.',
    ],
  ),

  ComponentSection(
    icon: '🔬',
    title: 'نظام التوصيل (Delivery System)',
    intro:
        'يوصّل شعاع الليزر من الجهاز إلى النسيج. عدة تقنيات حسب التطبيق.',
    items: [
      ComponentItem(
        icon: '🪞',
        name: 'المرايا المفصلية (Articulated Arm)',
        description:
            'أذرع معدنية بمرايا داخلية. تُستخدم في ليزر CO₂ للجراحة '
            'الدقيقة.',
      ),
      ComponentItem(
        icon: '🌊',
        name: 'الألياف الضوئية (Optical Fiber)',
        description:
            'ألياف رقيقة تنقل الليزر بمرونة. تُستخدم في Nd:YAG و '
            'Diode. سهلة الإدخال في المناظير.',
      ),
      ComponentItem(
        icon: '🖐️',
        name: 'الأدوات الطرفية (Handpieces)',
        description:
            'رؤوس متعددة: Focused (للقطع)، Defocused (للتخثير)، '
            'Scanner (للجلد)، Fiber tip (داخل الجسم).',
      ),
    ],
    notes: [
      'الألياف الضوئية لا تنقل CO₂ (طول موجي طويل) — لذلك يُستخدم الذراع.',
      'Fiber tip يُستخدم في جراحة البروستاتا (HoLEP).',
    ],
  ),

  ComponentSection(
    icon: '🎛️',
    title: 'نظام التحكم والتبريد',
    intro:
        'يتحكم في الطاقة وزمن النبضة. التبريد ضروري لمنع ارتفاع حرارة الجهاز.',
    items: [
      ComponentItem(
        icon: '🎚️',
        name: 'التحكم بالطاقة',
        description:
            'الطاقة (Watt) والزمن (Pulse Duration). أوضاع: Continuous '
            'Wave (CW)، Pulsed، Q-Switched (نبضات قصيرة جداً).',
      ),
      ComponentItem(
        icon: '💧',
        name: 'نظام التبريد',
        description:
            'ماء أو هواء. الأجهزة الطبية الحديثة لها تبريد داخلي مدمج. '
            'بعض الأنظمة تستخدم Peltier للتبريد.',
      ),
      ComponentItem(
        icon: '🖥️',
        name: 'واجهة المستخدم',
        description:
            'شاشة لمس لاختيار البروتوكول، الطاقة، الزمن. تسجيل تلقائي '
            'لبيانات الجلسة.',
      ),
    ],
    notes: [
      'Q-Switched يعطي نبضات بالنانوثانية — لإزالة الوشم.',
      'Long-pulsed يُستخدم لإزالة الشعر بأمان.',
    ],
  ),

  ComponentSection(
    icon: '🛡️',
    title: 'الحماية والأمان',
    intro:
        'الليزر الطبي من Class 3B أو 4 — خطير على العين والجلد. الاحتياطات صارمة.',
    items: [
      ComponentItem(
        icon: '🕶️',
        name: 'نظارات الحماية',
        description:
            'لكل شخص في الغرفة. مخصصة للطول الموجي المستخدم. '
            'يجب أن تكون معتمدة (OD رقم محدد).',
      ),
      ComponentItem(
        icon: '🚪',
        name: 'لافتات التحذير',
        description:
            'علامات على الباب: "ليزر قيد التشغيل". الباب مغلق. الدخول '
            'بحذر.',
      ),
      ComponentItem(
        icon: '🧯',
        name: 'مخاطر الحريق',
        description:
            'الليزر قد يُشعل مواد قابلة للاشتعال (قطن، كحول، أنابيب '
            'أوكسجين). مطفأة حريق قريبة.',
      ),
      ComponentItem(
        icon: '🔒',
        name: 'مفاتيح الأمان',
        description:
            'مفتاح للتشغيل. زر توقف طارئ. Foot switch للتحكم بالقدم '
            'أثناء الجراحة.',
      ),
    ],
    notes: [
      'أي إصابة ليزر بالعين = طوارئ عيون فورية.',
      'التدخين والليزر = خطر حريق كبير.',
    ],
  ),
];