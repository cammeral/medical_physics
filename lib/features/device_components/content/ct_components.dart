import '../component_section.dart';

const List<ComponentSection> ctComponents = [
  // 1) الهيكل الدوّار
  ComponentSection(
    icon: '🔄',
    title: 'الهيكل الدوّار (Gantry)',
    imageUrl: 'assets/images/ct_gantry.png',
    intro:
        'الجزء الأكبر والأكثر تميزاً في جهاز CT. هيكل حلقي ضخم يحتوي على الأنبوب '
        'والكواشف، ويدور 360° حول المريض بسرعة عالية (0.3-1 ثانية للدورة الواحدة).',
    items: [
      ComponentItem(
        icon: '🔘',
        name: 'الحلقة الخارجية (Gantry Frame)',
        description:
            'الهيكل المعدني الخارجي الذي يحمل جميع المكونات الدوّارة. يحتوي على '
            'فتحة (Aperture) بقطر 70-80 cm لمرور المريض. يحوي نظام تبريد ونظام '
            'تزييت لضمان دوران سلس.',
      ),
      ComponentItem(
        icon: '🎛️',
        name: 'نظام التحكم في الميل (Tilt Mechanism)',
        description:
            'يسمح بإمالة الهيكل بزاوية تصل إلى ±30° لبعض الفحوصات (مثل تصوير '
            'الجيوب الأنفية أو الرأس). يتحكم به المشغّل من غرفة التحكم.',
      ),
      ComponentItem(
        icon: '📡',
        name: 'نظام الاتصال (Data Transmission)',
        description:
            'ينقل بيانات الكواشف من الجزء الدوّار إلى الحاسوب الثابت. يستخدم '
            'تقنيات لاسلكية أو بصرية عالية السرعة (Optical Slip Ring).',
      ),
    ],
    notes: [
      'سرعة الدوران تصل إلى 4 دورات/ثانية في أجهزة القلب الحديثة.',
      'قوة الطرد المركزي على الأنبوب تعادل عشرات أضعاف الجاذبية!',
    ],
  ),

  // 2) أنبوب الأشعة
  ComponentSection(
    icon: '🔵',
    title: 'أنبوب الأشعة السينية عالي الطاقة',
    imageUrl: 'assets/images/ct_tube.png',
    intro:
        'أنبوب X-ray مخصص بأداء أعلى من الأنبوب التقليدي، لأنه يعمل بشكل شبه مستمر '
        'لفترات طويلة أثناء دوران الهيكل.',
    items: [
      ComponentItem(
        icon: '⚡',
        name: 'أنبوب عالي الحمل (High-Capacity Tube)',
        description:
            'قدرة حرارية عالية (5-8 MHU) لتحمّل الاستخدام المتواصل. يستخدم هدف '
            'تنغستن دوّار بسرعة عالية، مع نظام تبريد متطور بالزيت أو الماء.',
      ),
      ComponentItem(
        icon: '🎯',
        name: 'البقعة البؤرية الصغيرة',
        description:
            'بقعة بؤرية صغيرة جداً (0.5-1 mm) للحصول على دقة مكانية عالية. '
            'أحياناً يوجد وضعان: صغير للدقة، وكبير لتحمّل الحرارة.',
      ),
      ComponentItem(
        icon: '🪟',
        name: 'ترشيح الأشعة (Beam Filtration)',
        description:
            'ترشيح قوي (Al + Cu) لإزالة الفوتونات منخفضة الطاقة. يُشكّل الحزمة '
            'إلى شكل مروحي (Fan Beam) أو مخروطي (Cone Beam).',
      ),
    ],
    notes: [
      'أنبوب CT يعمل بـ 120-140 kVp (أعلى من X-ray العادي).',
      'التيار قد يصل إلى 800 mA في الفحوصات عالية الجودة.',
    ],
  ),

  // 3) الكواشف
  ComponentSection(
    icon: '📡',
    title: 'نظام الكواشف (Detector Array)',
    imageUrl: 'assets/images/ct_detectors.png',
    intro:
        'آلاف الكواشف الدقيقة مرتبة في صفوف متعددة، تقيس شدة الأشعة النافذة من '
        'المريض بدقة عالية. هي "العين" التي ترى داخلك.',
    items: [
      ComponentItem(
        icon: '📊',
        name: 'الكواشف الوميضية (Scintillation Detectors)',
        description:
            'مصنوعة من مواد مثل GOS (Gadolinium Oxysulfide) أو CWO (Cadmium '
            'Tungstate). تحوّل الفوتون السيني إلى ضوء مرئي بكفاءة عالية.',
      ),
      ComponentItem(
        icon: '🔬',
        name: 'المواد شبه الموصلة (Semiconductor)',
        description:
            'بديل حديث: الكواشف المباشرة مثل CdTe و CdZnTe. تحوّل الفوتون مباشرة '
            'إلى إشارة كهربائية بدون وسيط ضوئي — كفاءة أعلى.',
      ),
      ComponentItem(
        icon: '🔢',
        name: 'صفوف الكواشف (Detector Rows)',
        description:
            'عدد الصفوف يحدد عدد الشرائح في الدوران الواحد. الأجهزة الحديثة تحتوي '
            'على 64، 128، 256، أو 320 صفاً. مثال: 64-slice CT = 64 صفاً من الكواشف.',
      ),
      ComponentItem(
        icon: '🖼️',
        name: 'الكوليماتور بعد المريض (Post-Patient Collimator)',
        description:
            'شبكة رصاصية صغيرة قبل الكاشف مباشرة، تحجب الأشعة المشتتة (Scatter) '
            'التي تصل من زوايا خاطئة وتُضبّب الصورة.',
      ),
    ],
    notes: [
      'كل صف يحتوي على ~700-1000 عنصر كاشف مستقل.',
      'الكواشف هي أغلى جزء في جهاز CT بعد المغناطيس في MRI.',
    ],
  ),

  // 4) الحلقة المنزلقة
  ComponentSection(
    icon: '💫',
    title: 'الحلقة المنزلقة (Slip Ring)',
    imageUrl: 'assets/images/ct_slip_ring.png',
    intro:
        'تقنية ثورية سمحت للأنبوب والكواشف بالدوران باستمرار دون انقطاع — '
        'بدونها لن يكون CT الحلزوني (Helical) ممكناً.',
    items: [
      ComponentItem(
        icon: '🔌',
        name: 'الحلقة الموصلة (Conductive Ring)',
        description:
            'حلقة معدنية كبيرة (عادة نحاسية) تدور مع الهيكل. تتلامس مع فرش كربون '
            'ثابتة تنقل الكهرباء والبيانات من وإلى الأجزاء الدوّارة.',
      ),
      ComponentItem(
        icon: '⚡',
        name: 'نقل الطاقة العالية (High Power Transfer)',
        description:
            'تنقل جهداً عالياً (حتى 150 kV) وتياراً كبيراً (مئات الأمبيرات) بدون '
            'توقف. هذا ما يسمح بتشغيل مستمر.',
      ),
      ComponentItem(
        icon: '📶',
        name: 'نقل البيانات (Data Transfer)',
        description:
            'ينقل بيانات آلاف الكواشف بمعدل غيغابت/ثانية. تقنية بصرية (Optical '
            'Slip Ring) حديثة لسرعة أعلى وتداخل أقل.',
      ),
    ],
    notes: [
      'قبل Slip Ring، كان CT يعمل بتردد "دوران-توقف" (Rotate-Stop) بطيء جداً.',
      'تقنية Slip Ring هي ما جعل التصوير الحلزوني (Helical/Spiral CT) ممكناً.',
    ],
  ),

  // 5) طاولة المريض
  ComponentSection(
    icon: '🛏️',
    title: 'طاولة المريض (Patient Table)',
    imageUrl: 'assets/images/ct_table.png',
    intro:
        'طاولة متحركة بدقة عالية تنقل المريض داخل فتحة الهيكل أثناء الدوران، '
        'لتوليد صورة حلزونية ثلاثية الأبعاد.',
    items: [
      ComponentItem(
        icon: '📏',
        name: 'الحركة الدقيقة (Precise Positioning)',
        description:
            'تتحرك بدقة تصل إلى 0.25 mm. السرعة قابلة للضبط حسب سماكة الشريحة '
            'و Pitch (خطوة الفحص). تحدد المسافة في المحور Z.',
      ),
      ComponentItem(
        icon: '🏋️',
        name: 'حمولة الوزن (Weight Capacity)',
        description:
            'تتحمل عادة حتى 200-300 kg. مصنوعة من مواد خفيفة وقوية (ألياف '
            'الكربون) لتقليل امتصاص الأشعة.',
      ),
      ComponentItem(
        icon: '🎯',
        name: 'نظام تحديد الموقع بالليزر',
        description:
            'أشعة ليزر داخلية (Internal Lasers) لمحاذاة المريض بدقة قبل الفحص. '
            'تُري المشغّل موقع الفحص بدقة على جسم المريض.',
      ),
      ComponentItem(
        icon: '🔌',
        name: 'منافذ وملحقات',
        description:
            'منافذ لتوصيل حقن التباين (Contrast Injector)، شاشة عرض للمريض، '
            'زر طوارئ للتوقف الفوري، نظام إيقاف صوتي.',
      ),
    ],
    notes: [
      'الطاولة قابلة للتحكم من غرفة التحكم أو من جانب المريض.',
      'في حالات الطوارئ، يمكن تحريرها يدوياً لسحب المريض بسرعة.',
    ],
  ),

  // 6) مولد الجهد العالي
  ComponentSection(
    icon: '⚡',
    title: 'مولد الجهد العالي (High Voltage Generator)',
    imageUrl: 'assets/images/ct_generator.png',
    intro:
        'يوفر جهداً عالياً (80-140 kVp) وتياراً كبيراً (حتى 800 mA) للأنبوب. '
        'قدرته أعلى بكثير من مولدات X-ray التقليدية.',
    items: [
      ComponentItem(
        icon: '🌊',
        name: 'مولد عالي التردد (High Frequency)',
        description:
            'يعمل بترددات 20-100 kHz بدلاً من 50/60 Hz. النتيجة: حجم أصغر، '
            'موجة أنعم، وجرعة أقل مع جودة أعلى.',
      ),
      ComponentItem(
        icon: '📊',
        name: 'التحكم في الموجة (Waveform Control)',
        description:
            'يتحكم في شكل موجة الجهد — مهم جداً لأن أي تذبذب في kVp يؤثر على '
            'طيف الأشعة وجودة الصورة.',
      ),
      ComponentItem(
        icon: '🔥',
        name: 'نظام التبريد',
        description:
            'تبريد بالزيت أو الماء. درجة الحرارة تُراقَب باستمرار لأن ارتفاعها '
            'يُخفّض قدرة الأنبوب أو يوقف الفحص.',
      ),
    ],
    notes: [
      'في CT، يجب أن يكون الجهد ثابتاً لأن التغيرات تؤثر على قيم HU.',
      'المولد جزء من Gantry (الدوّار) في الأجهزة الحديثة.',
    ],
  ),

  // 7) غرفة التحكم
  ComponentSection(
    icon: '🎛️',
    title: 'غرفة التحكم (Control Room)',
    imageUrl: 'assets/images/ct_console.png',
    intro:
        'غرفة منفصلة عن غرفة الفحص، يفصلها زجاج رصاصي. تحتوي على لوحة التحكم '
        'وحاسوب المشغّل ونظام الصوت.',
    items: [
      ComponentItem(
        icon: '🖥️',
        name: 'لوحة التحكم (Control Console)',
        description:
            'واجهة المشغّل: اختيار البروتوكول، ضبط kVp/mAs/Pitch، بدء الفحص، '
            'عرض الصور مباشرة، وإعادة البناء.',
      ),
      ComponentItem(
        icon: '🎙️',
        name: 'نظام التواصل الصوتي',
        description:
            'ميكروفون ومكبر صوت للتواصل مع المريض. أيضاً إرشادات تلقائية '
            '(مثل: "احبس نفسك") باللغة المناسبة.',
      ),
      ComponentItem(
        icon: '👀',
        name: 'النافذة الرصاصية',
        description:
            'زجاج رصاصي يسمح للمشغّل برؤية المريض دون التعرض للإشعاع. سماكة '
            'تعادل ~2 mm رصاص.',
      ),
      ComponentItem(
        icon: '🚨',
        name: 'زر الطوارئ',
        description:
            'زر لإيقاف الفحص فوراً وسحب الطاولة. أيضاً زر لإيقاف حقن التباين في '
            'حالات الحساسية.',
      ),
    ],
    notes: [
      'المشغّل يبقى داخل غرفة التحكم أثناء الفحص — لا يتعرض للإشعاع.',
      'إذا احتاج المريض مساعدة، ينتظر المشغّل حتى يتوقف الأنبوب.',
    ],
  ),

  // 8) نظام إعادة البناء
  ComponentSection(
    icon: '💻',
    title: 'نظام إعادة البناء (Reconstruction System)',
    imageUrl: 'assets/images/ct_computer.png',
    intro:
        'حاسوب فائق القوة يحوّل آلاف الصور الخام (Raw Data) إلى صور مقطعية '
        'وثلاثية الأبعاد باستخدام خوارزميات رياضية معقدة.',
    items: [
      ComponentItem(
        icon: '🧮',
        name: 'Filtered Back Projection (FBP)',
        description:
            'الخوارزمية الكلاسيكية: تعيد "إسقاط" البيانات عكسياً لبناء الصورة. '
            'سريعة لكن ضوضاؤها عالية خاصة في الجرعات المنخفضة.',
      ),
      ComponentItem(
        icon: '🤖',
        name: 'Iterative Reconstruction (IR)',
        description:
            'خوارزمية حديثة: تُكرّر التقدير حتى الوصول لأفضل صورة. تستخدم '
            'جرعة أقل وجودة أعلى. أنواع: ASIR، iDose، SAFIRE، ADMIRE.',
      ),
      ComponentItem(
        icon: '🧠',
        name: 'Deep Learning Reconstruction',
        description:
            'أحدث تقنية: شبكات عصبية عميقة (AI) لتحسين الصورة. تعطي جودة '
            'مذهلة بجرعة أقل. أمثلة: TrueFidelity, AiCE.',
      ),
      ComponentItem(
        icon: '🎨',
        name: 'برامج ما بعد المعالجة',
        description:
            'MPR (Multi-Planar Reconstruction): عرض بمستويات مختلفة. MIP '
            '(Maximum Intensity Projection): للشرايين. 3D Volume Rendering: '
            'نماذج ثلاثية الأبعاد.',
      ),
    ],
    notes: [
      'إعادة البناء تستغرق ثوانٍ في الأجهزة الحديثة (كانت دقائق قديماً).',
      'GPU تُستخدم في الأجهزة الحديثة لتسريع العمليات الحسابية.',
    ],
  ),

  // 9) حاقن التباين
  ComponentSection(
    icon: '💉',
    title: 'حاقن التباين (Contrast Injector)',
    imageUrl: 'assets/images/ct_injector.png',
    intro:
        'جهاز آلي يحقن مادة التباين (عادة يودية) بسرعة ودقة عالية في الوريد، '
        'مما يُظهر الأوعية والأعضاء بشكل أوضح.',
    items: [
      ComponentItem(
        icon: '🚀',
        name: 'المضخة الآلية (Automated Pump)',
        description:
            'تحقن بسرعات تصل إلى 6-8 mL/s بضغط عالٍ (300 PSI). تُزامَن مع '
            'بدء الفحص للحصول على أفضل توقيت.',
      ),
      ComponentItem(
        icon: '💧',
        name: 'مادة التباين (Iodinated Contrast)',
        description:
            'عادة يودية (Iodine-based). تمتص الأشعة السينية بقوة (Z عالٍ). '
            'أنواع: Ionic، Non-ionic، Iso-osmolar.',
      ),
      ComponentItem(
        icon: '⏱️',
        name: 'التوقيت الذكي (Bolus Tracking)',
        description:
            'يقيس وصول التباين في وعاء رئيسي، ثم يبدأ الفحص تلقائياً. يضمن '
            'التقاط الأوعية في أوج امتلائها بالتباين.',
      ),
    ],
    notes: [
      'قبل الحقن: قياس وظائف الكلى (Creatinine) والسؤال عن الحساسية.',
      'يجب توفر أدوية الطوارئ (Adrenaline، Steroids) في حال الحساسية.',
    ],
  ),

  // 10) نظام العرض
  ComponentSection(
    icon: '🖼️',
    title: 'نظام العرض الطبي (Display System)',
    imageUrl: 'assets/images/ct_display.png',
    intro:
        'شاشات طبية معايرة لعرض الصور بدقة عالية. الطبيب يقرأ الصور على شاشة '
        'منفصلة عن شاشة المشغّل.',
    items: [
      ComponentItem(
        icon: '📺',
        name: 'شاشات طبية معتمدة (Diagnostic Displays)',
        description:
            'دقة 3-5 MegaPixel معتمدة من FDA. معايرة يومياً حسب معيار DICOM '
            'GSDF لضمان ثبات السطوع.',
      ),
      ComponentItem(
        icon: '🎨',
        name: 'نوافذ العرض (Window/Level)',
        description:
            'الطبيب يستطيع تغيير Window (المدى) و Level (المستوى) لعرض '
            'الأنسجة المختلفة: نافذة للرئة، للعظام، للدماغ، إلخ.',
      ),
      ComponentItem(
        icon: '💾',
        name: 'PACS Integration',
        description:
            'الصور تُرسل تلقائياً إلى PACS. الطبيب يقرأها من أي مكان في '
            'المستشفى. سهولة المراجعة والمقارنة مع فحوصات سابقة.',
      ),
    ],
    notes: [
      'شاشات القراءة معايرة، شاشات المشغّل لا تحتاج نفس الدقة.',
      'DICOM هو المعيار العالمي لتبادل الصور الطبية.',
    ],
  ),
];