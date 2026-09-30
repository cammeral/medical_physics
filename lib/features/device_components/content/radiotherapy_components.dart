import '../component_section.dart';

const List<RadiotherapyComponent> radiotherapyComponents = [
  RadiotherapyComponent(
    icon: '⚡',
    title: 'المُعجّل الخطي (LINAC)',
    imageUrl: 'assets/images/rt_linac.png',
    intro:
        'قلب جهاز العلاج الإشعاعي الحديث. يُسرّع الإلكترونات إلى طاقة عالية '
        '(6-25 MV) ثم يصطدم بهدف تنغستن لإنتاج أشعة سينية عالية الطاقة، أو '
        'يُستخدم الإلكترون مباشرة.',
    items: [
      ComponentItem(
        icon: '🔫',
        name: 'مدفع الإلكترونات (Electron Gun)',
        description:
            'يُصدر حزمة إلكترونات ابتدائية. تيار منخفض لكن جهد عالٍ.',
      ),
      ComponentItem(
        icon: '📏',
        name: 'أنبوب التسريع (Accelerator Waveguide)',
        description:
            'أنبوب طويل يحتوي على تجاويف ميكروويفية. الإلكترونات تُسرّع '
            'عبر موجات كهرومغناطيسية حتى تصل إلى 99% من سرعة الضوء.',
      ),
      ComponentItem(
        icon: '🎯',
        name: 'الهدف (Target)',
        description:
            'قرص من التنغستن. عند اصطدام الإلكترونات به تُنتج أشعة سينية '
            'عالية الطاقة. يمكن سحبه بعيداً لاستخدام الإلكترونات مباشرة.',
      ),
      ComponentItem(
        icon: '🔀',
        name: 'نظام تسطيح الحزمة (Flattening Filter)',
        description:
            'يُسطّح الحزمة لتكون موحدة الشدة. الأجهزة الحديثة FFF (Flattening '
            'Filter Free) تُزيله للحصول على شدة أعلى — للـ SBRT.',
      ),
    ],
    notes: [
      'LINAC يعمل في نطاق 6-25 MeV.',
      'الأجهزة الحديثة بحجم غرفة صغيرة ويمكن تركيبها بدقة ملّيمترية.',
    ],
  ),

  ComponentSection(
    icon: '🌿',
    title: 'نظام تحديد الحزمة (Beam Shaping)',
    intro:
        'يُشكّل الحزمة لتناسب شكل الورم مع حماية الأنسجة السليمة. أهم '
        'تقنية في العلاج الإشعاعي الحديث.',
    items: [
      ComponentItem(
        icon: '🔲',
        name: 'Multileaf Collimator (MLC)',
        description:
            '60-160 شريحة من التنغستن قابلة للحركة بشكل مستقل. تُشكّل الحزمة '
            'بدقة ملّيمترية حسب شكل الورم. القلب التقني لـ IMRT و VMAT.',
      ),
      ComponentItem(
        icon: '📐',
        name: 'Jaws (الفكوك)',
        description:
            '4 شرائح كبيرة تحدد الإطار الأساسي للحزمة. تعمل مع MLC '
            'لتحسين الدقة.',
      ),
      ComponentItem(
        icon: '🛡️',
        name: 'Block Tray (حامل القوالب)',
        description:
            'يحتوي على قوالب رصاصية مصنوعة لكل مريض — تقنية أقدم من MLC.',
      ),
    ],
    notes: [
      'MLC الحديث يتيح تقنية "IMRT" التي تُغيّر شكل الحزمة أثناء العلاج.',
      'في VMAT، MLC يتحرك بسرعة مع دوران الجهاز — علاج سريع جداً.',
    ],
  ),

  ComponentSection(
    icon: '🩺',
    title: 'نظام التصوير المدمج (IGRT)',
    intro:
        'تصوير المريض قبل كل جلسة للتأكد من الوضع الصحيح. مهم جداً لأن '
        'الورم قد يتحرك بين الجلسات.',
    items: [
      ComponentItem(
        icon: '📷',
        name: 'EPID (Electronic Portal Imaging)',
        description:
            'كاشف رقمي يلتقط صورة الأشعة الخارجة من المريض. يُقارن مع '
            'صورة التخطيط للتأكد من الوضع.',
      ),
      ComponentItem(
        icon: '🦴',
        name: 'CBCT (Cone Beam CT)',
        description:
            'CT بحزمة مخروطية مدمج مع LINAC. يعطي صورة ثلاثية الأبعاد '
            'قبل كل جلسة — دقة أعلى من EPID.',
      ),
      ComponentItem(
        icon: '📍',
        name: 'تتبع الأهداف (Tracking)',
        description:
            'أنظمة Calypso، Brainlab — تتتبع علامات صغيرة مزروعة في '
            'الورم، أو تتبع العظام آلياً.',
      ),
    ],
    notes: [
      'قاعدة: "لا تعالج حتى ترى الورم" — IGRT يضمن ذلك.',
      'IGRT يقلل الهوامش الأمانية من 10 mm إلى 2-3 mm.',
    ],
  ),

  ComponentSection(
    icon: '🔄',
    title: 'الذراع الدوّار (Gantry)',
    intro:
        'الهيكل الدوّار الذي يحمل LINAC. يدور 360° حول المريض لتوجيه '
        'الحزمة من أي زاوية.',
    items: [
      ComponentItem(
        icon: '⚙️',
        name: 'الدوران',
        description:
            'من 0° إلى 360° بدقة عالية. يتحرك بسرعة لأجهزة VMAT '
            '(دورة في دقيقة).',
      ),
      ComponentItem(
        icon: '🛏️',
        name: 'طاولة العلاج (Treatment Couch)',
        description:
            'طاولة دقيقة تتحرك في 6 محاور. تحمل أنظمة تثبيت المريض '
            '(Masks, Molds).',
      ),
      ComponentItem(
        icon: '📐',
        name: 'isocenter',
        description:
            'نقطة التقاء كل الأشعة. يجب أن يقع الورم في هذه النقطة. '
            'دقة ± 1 mm.',
      ),
    ],
    notes: [
      'أجهزة CyberKnife و GammaKnife لها تصاميم مختلفة.',
      'دقة isocenter تُختبر يومياً بـ Winston-Lutz Test.',
    ],
  ),

  ComponentSection(
    icon: '💻',
    title: 'نظام التخطيط (Treatment Planning System - TPS)',
    intro:
        'برنامج حاسوبي متقدم لحساب توزيع الجرعة وتخطيط العلاج. الأطباء '
        'الفيزيائيون يستخدمونه لاختيار أفضل خطة.',
    items: [
      ComponentItem(
        icon: '🖼️',
        name: 'دمج الصور',
        description:
            'دمج CT + MRI + PET لتحديد الورم بدقة. الأنسجة السليمة '
            'تُرسم يدوياً (Contouring).',
      ),
      ComponentItem(
        icon: '🧮',
        name: 'خوارزميات حساب الجرعة',
        description:
            'Monte Carlo أو Superposition/Convolution. تحسب توزيع '
            'الجرعة بدقة جرافيتية.',
      ),
      ComponentItem(
        icon: '📊',
        name: 'DVH (Dose-Volume Histogram)',
        description:
            'يُظهر نسبة الحجم الذي يستقبل جرعة معينة. أداة أساسية '
            'لتقييم الخطة قبل البدء.',
      ),
      ComponentItem(
        icon: '🎯',
        name: 'Optimization',
        description:
            'خوارزميات تحسّن توزيع الجرعة تلقائياً — خاصة في IMRT '
            'و VMAT.',
      ),
    ],
    notes: [
      'الفيزيائي الطبي هو من يوافق على الخطة النهائية.',
      'اختبارات ضمان الجودة (QA) قبل العلاج ضرورية.',
    ],
  ),

  ComponentSection(
    icon: '🧪',
    title: 'مكونات Brachytherapy',
    intro:
        'العلاج الداخلي يستخدم مصادر مشعة توضع داخل أو قريباً من الورم. '
        'مكوناته مختلفة عن EBRT.',
    items: [
      ComponentItem(
        icon: '💉',
        name: 'المصادر (Sources)',
        description:
            'Ir-192 (عمر نصف 74 يوم، للـ HDR)، I-125 (60 يوم، للـ LDR '
            'بالبروستاتا)، Cs-137 (للقديم). كل مصدر مغلف بطبقة من '
            'البلاتينيوم.',
      ),
      ComponentItem(
        icon: '🔧',
        name: 'المُوصّل (Afterloader)',
        description:
            'جهاز يدفع المصدر عبر قنوات إلى مواقع محددة مسبقاً. يعمل '
            'آلياً بالكامل — الطبيب لا يقترب.',
      ),
      ComponentItem(
        icon: '🩹',
        name: 'قوالب التطبيق (Applicators)',
        description:
            'أنابيب أو حاويات خاصة تُوضع في التجويف (الرحم، المريء) أو '
            'داخل الأنسجة (البروستاتا).',
      ),
    ],
    notes: [
      'HDR = High Dose Rate (جرعة عالية جداً، دقائق).',
      'LDR = Low Dose Rate (جرعة منخفضة، أيام).',
      'PDR = Pulsed Dose Rate (نبضات قصيرة).',
    ],
  ),

  ComponentSection(
    icon: '🛡️',
    title: 'الحماية والتأمين (Safety)',
    intro:
        'أجهزة LINAC لها إجراءات أمان صارمة جداً — أي خطأ قد يكون كارثياً.',
    items: [
      ComponentItem(
        icon: '🚪',
        name: 'باب محصن (Shielded Door)',
        description:
            'باب رصاصي أو خرساني بسماكة كبيرة (1-2 m خرسانة). يمنع '
            'أي تسرب إشعاعي خارج الغرفة.',
      ),
      ComponentItem(
        icon: '🔒',
        name: 'Interlocks',
        description:
            'نظام أقفال متعدد: الباب، جهاز المراقبة، زر الطوارئ. أي '
            'خلل → يتوقف LINAC تلقائياً.',
      ),
      ComponentItem(
        icon: '📹',
        name: 'كاميرات المراقبة',
        description:
            'المريض تحت مراقبة بصرية وصوتية كاملة. الطبيب يتواصل معه '
            'من غرفة التحكم.',
      ),
      ComponentItem(
        icon: '🚨',
        name: 'زر التوقف الطارئ',
        description:
            'أزرار حمراء في كل مكان — داخل الغرفة وعلى جدرانها. تُوقف '
            'كل شيء فوراً.',
      ),
      ComponentItem(
        icon: '🎵',
        name: 'موسيقى للمريض',
        description:
            'للتخفيف من التوتر — الجلسة قد تستمر 15-30 دقيقة والمريض '
            'وحده.',
      ),
    ],
    notes: [
      'قبل التشغيل: Survey للمكان للتحقق من الإشعاع.',
      'بعد كل صيانة: اختبار شامل قبل استقبال المرضى.',
    ],
  ),
];

// نموذج مؤقت (يمكنك استبداله بـ ComponentSection الموجود)
typedef RadiotherapyComponent = ComponentSection;