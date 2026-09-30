import '../component_section.dart';

const List<ComponentSection> xrayComponents = [
  // 1) أنبوب الأشعة
  ComponentSection(
    icon: '🔵',
    title: 'أنبوب الأشعة السينية (X-ray Tube)',
    imageUrl: 'assets/images/xray_tube.png',
    intro:
        'قلب جهاز الأشعة السينية. أنبوب زجاجي مفرَّغ من الهواء يحتوي على قطبين معدنيين، '
        'حيث تُنتَج الأشعة السينية عند اصطدام الإلكترونات بالهدف.',
    items: [
      ComponentItem(
        icon: '🪟',
        name: 'الغلاف الزجاجي (Glass Envelope)',
        description:
            'أنبوب زجاجي مفرَّغ من الهواء (فراغ عالٍ) لمنع تصادم الإلكترونات بجزيئات الهواء. '
            'مصنوع من زجاج بوروسيليكات مقاوم للحرارة. يحتوي على نافذة (Beryllium Window) '
            'للسماح بخروج الأشعة بأقل امتصاص ممكن.',
      ),
      ComponentItem(
        icon: '🔥',
        name: 'المهبط (Cathode)',
        description:
            'يتكون من جزأين: سلك تسخين (Filament) عادة من التنغستن، وكأس تركيز '
            '(Focusing Cup) لتوجيه الإلكترونات. يمر تيار كهربائي في السلك فيتوهج '
            'ويُطلق إلكترونات (Thermionic Emission).',
        imageUrl: 'assets/images/xray_cathode.png',
      ),
      ComponentItem(
        icon: '⚙️',
        name: 'المصعد الدوّار (Rotating Anode)',
        description:
            'قرص من سبيكة التنغستن والرينيوم يدور بسرعة 3000-10000 دورة/دقيقة. '
            'دورانه يمنع ارتفاع درجة الحرارة في نقطة واحدة. سطحه مائل بزاوية 6-20° '
            'لتوجيه الأشعة نحو النافذة. البقعة البؤرية (Focal Spot) صغيرة جداً '
            '(0.1-2 mm) للحصول على دقة عالية.',
        imageUrl: 'assets/images/xray_anode.png',
      ),
      ComponentItem(
        icon: '🌀',
        name: 'المحرك الدوّار (Rotor & Stator)',
        description:
            'المحرك موجود خارج الأنبوب (Stator) يدير القرص داخل الأنبوب (Rotor) '
            'عن طريق المجال المغناطيسي — بدون اختراق الغلاف الزجاجي.',
      ),
    ],
    notes: [
      'درجة حرارة نقطة الاصطدام تصل إلى ~2500°C.',
      'المصعد الثابت (Stationary Anode) يُستخدم فقط في أجهزة صغيرة (طبية أسنان) حيث التيار منخفض.',
    ],
  ),

  // 2) حاوية الأنبوب
  ComponentSection(
    icon: '📦',
    title: 'حاوية الأنبوب (Tube Housing)',
    imageUrl: 'assets/images/xray_housing.png',
    intro:
        'غلاف معدني خارجي يحمي الأنبوب ويحجب الإشعاع الجانبي غير المفيد.',
    items: [
      ComponentItem(
        icon: '🛡️',
        name: 'البطانة الرصاصية (Lead Lining)',
        description:
            'طبقة من الرصاص بسماكة تكفي لحجب الأشعة الجانبية، فلا يخرج إلا الشعاع '
            'من النافذة المخصصة (Port Window).',
      ),
      ComponentItem(
        icon: '💧',
        name: 'نظام التبريد (Cooling System)',
        description:
            'زيت عازل يملأ الحاوية لتبريد الأنبوب ونقل الحرارة إلى الخارج. '
            'أحياناً يُضاف مروحة أو نظام تبريد بالماء للأجهزة عالية الاستخدام.',
      ),
      ComponentItem(
        icon: '🪟',
        name: 'النافذة (Exit Window)',
        description:
            'فتحة صغيرة في الحاوية تسمح بخروج شعاع الأشعة فقط. تحدد حجم الحزمة الأولي.',
      ),
    ],
    notes: [
      'سماكة البطانة الرصاصية عادة 2-3 mm رصاص مكافئ.',
      'حرارة الزيت تُراقَب لأن ارتفاعها قد يدل على حمل زائد.',
    ],
  ),

  // 3) مولد الجهد العالي
  ComponentSection(
    icon: '⚡',
    title: 'مولد الجهد العالي (High Voltage Generator)',
    imageUrl: 'assets/images/xray_generator.png',
    intro:
        'يوفر فرق الجهد العالي (40-150 kVp) اللازم لتسريع الإلكترونات من المهبط إلى المصعد.',
    items: [
      ComponentItem(
        icon: '🔌',
        name: 'المحول الرافع (Step-up Transformer)',
        description:
            'يرفع الجهد من 220V إلى 40-150 kV. يحتوي على ملفات ابتدائية وثانوية '
            'بنسبة لف عالية. مبطن بالزيت العازل.',
      ),
      ComponentItem(
        icon: '🔀',
        name: 'المقوّم (Rectifier)',
        description:
            'يحوّل التيار المتردد إلى تيار مستمر نبضي. الأجهزة الحديثة تستخدم '
            'تقنية عالية التردد (High Frequency) لتحسين الجودة وتقليل حجم المولد.',
      ),
      ComponentItem(
        icon: '🎛️',
        name: 'دائرة التحكم (Control Circuit)',
        description:
            'تتحكم في شكل الموجة وزمن التعرض وتزامنه مع النظام. تحدد kVp و mAs بدقة.',
      ),
    ],
    notes: [
      'الأجهزة الحديثة تستخدم مولدات عالية التردد (40-100 kHz) بحجم أصغر.',
      'كلما كانت الموجة مستوية أكثر، كانت الأشعة أحادية اللون أكثر = جرعة أقل.',
    ],
  ),

  // 4) لوحة التحكم
  ComponentSection(
    icon: '🎛️',
    title: 'لوحة التحكم (Control Console)',
    imageUrl: 'assets/images/xray_console.png',
    intro: 'واجهة المشغّل لضبط العوامل والحصول على الصورة.',
    items: [
      ComponentItem(
        icon: '🔢',
        name: 'ضبط kVp و mAs',
        description:
            'kVp يحدد طاقة الأشعة واختراقها، و mAs يحدد عدد الفوتونات (شدة الأشعة). '
            'المشغّل يختارهم حسب المنطقة المصوّرة وحجم المريض.',
      ),
      ComponentItem(
        icon: '⏱️',
        name: 'مؤقت التعرض (Exposure Timer)',
        description:
            'زمن التعرض من أجزاء الثانية إلى ثوانٍ. الأجهزة الحديثة تعتمد على '
            'AEC (Automatic Exposure Control) لإيقاف التعرض عند وصول الكاشف للكثافة المطلوبة.',
      ),
      ComponentItem(
        icon: '🚨',
        name: 'مؤشرات التحذير',
        description:
            'مؤشرات صوتية وضوئية تُنبّه قبل إصدار الأشعة (تحذير للمريض والطاقم). '
            'عادة صوت "بيب" قصير قبل التشغيل.',
      ),
    ],
    notes: [
      'AEC يوفر الجرعة ويتجنب إعادة التصوير.',
      'بعض الأجهزة الحديثة تُتيح للمشغل اختيار بروتوكولات جاهزة حسب المنطقة (تشريحياً).',
    ],
  ),

  // 5) الكوليماتور
  ComponentSection(
    icon: '🔲',
    title: 'الكوليماتور (Collimator)',
    imageUrl: 'assets/images/xray_collimator.png',
    intro:
        'جهاز يوضع أسفل الأنبوب لتحديد حجم الحزمة وتقليل الجرعة على المريض.',
    items: [
      ComponentItem(
        icon: '📐',
        name: 'الشرائح الرصاصية (Lead Shutters)',
        description:
            '4 شرائح من الرصاص قابلة للتحرك لتكوين مستطيل يناسب المنطقة المطلوبة '
            'بدقة. تقلل مساحة التعرض → تقلل الجرعة.',
      ),
      ComponentItem(
        icon: '💡',
        name: 'المصباح المحاذي (Light Beam)',
        description:
            'مصباح هالوجين + مرايا تُظهر على جلد المريض نفس منطقة الأشعة بالتحديد، '
            'لضمان التصويب الصحيح قبل التشغيل.',
      ),
      ComponentItem(
        icon: '🧊',
        name: 'الترشيح (Filtration)',
        description:
            'ألمنيوم (Al) بسماكة 2.5 mm عادة + ترشيح إضافي. يزيل الفوتونات منخفضة '
            'الطاقة التي لا تفيد الصورة بل تزيد الجرعة.',
      ),
    ],
    notes: [
      'قاعدة عامة: "لا تُشعّ أوسع مما تحتاج" — كل 1 cm إضافي يزيد الجرعة بشكل ملحوظ.',
      'الفلاتر الخاصة (مثل Cu, Al+Cu) تُستخدم في الفحوصات عالية الجرعة.',
    ],
  ),

  // 6) الكاشف
  ComponentSection(
    icon: '🎯',
    title: 'نظام الكشف (Detector System)',
    imageUrl: 'assets/images/xray_detector.png',
    intro: 'يستقبل الأشعة النافذة من المريض ويحوّلها إلى صورة.',
    items: [
      ComponentItem(
        icon: '📸',
        name: 'الكاشف الرقمي (Digital Detector)',
        description:
            'حديثاً يُستخدم Flat Panel Detector (FPD): لوح من السيليكون اللابلوري '
            '(a-Si) أو السيلينيوم (a-Se) يحوّل الفوتونات إلى إشارة كهربائية تُقرأ '
            'مصفوفةً وتُكوّن الصورة.',
      ),
      ComponentItem(
        icon: '🎞️',
        name: 'CR (Computed Radiography)',
        description:
            'تقنية أقدم تستخدم لوح فوسفوري (Photostimulable Phosphor) يُقرأ بشعاع '
            'ليزر ثم يُمسح ضوئياً لاستخراج الصورة. لا تزال مستخدمة في بعض المستشفيات.',
      ),
      ComponentItem(
        icon: '🖼️',
        name: 'شبكة مضادة للتشتت (Anti-Scatter Grid)',
        description:
            'شبكة من شرائح رصاصية دقيقة بين المريض والكاشف. تحجب الأشعة المشتتة '
            '(التي تُضبّب الصورة) وتُمرر الأشعة الأساسية فقط.',
      ),
    ],
    notes: [
      'FPD أسرع وأدق من CR، لكن أغلى.',
      'بعض الأنظمة الحديثة تُلغي الحاجة للـ Grid بمعالجة برمجية.',
    ],
  ),

  // 7) نظام الحاسوب والعرض
  ComponentSection(
    icon: '💻',
    title: 'نظام الحاسوب والعرض (Computer & Display)',
    imageUrl: 'assets/images/xray_workstation.png',
    intro: 'يعالج الصورة ويعرضها للطبيب مع أدوات القياس والتشخيص.',
    items: [
      ComponentItem(
        icon: '🖥️',
        name: 'محطة العمل (Workstation)',
        description:
            'حاسوب قوي لمعالجة الصور، تطبيق تباين، قياس المسافات، إضافة ملاحظات. '
            'متصل بنظام PACS للمشاركة مع الأقسام الأخرى.',
      ),
      ComponentItem(
        icon: '🎥',
        name: 'شاشة طبية (Medical Display)',
        description:
            'شاشة عالية الدقة (3-5 MegaPixel) ومعايرة معيارياً (DICOM GSDF). '
            'تُراجَع يومياً للتأكد من جودتها.',
      ),
      ComponentItem(
        icon: '💾',
        name: 'التخزين (PACS/RIS)',
        description:
            'PACS: أرشيف الصور الطبية الرقمي. RIS: نظام معلومات الأشعة. '
            'يكفلان حفظ الصور وسهولة الوصول إليها من أي قسم.',
      ),
    ],
    notes: [
      'أي تغيير في إضاءة الغرفة يؤثر على تشخيص الطبيب — لذلك بيئة القراءة مضبوطة.',
      'DICOM هو المعيار العالمي لتبادل الصور الطبية.',
    ],
  ),
];