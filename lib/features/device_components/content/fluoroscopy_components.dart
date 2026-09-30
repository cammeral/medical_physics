import '../component_section.dart';

const List<ComponentSection> fluoroscopyComponents = [
  ComponentSection(
    icon: '🔄',
    title: 'الذراع على شكل C (C-Arm)',
    imageUrl: 'assets/images/fluoro_c_arm.png',
    intro:
        'الشكل المميز لجهاز Fluoroscopy الحديث. يحمل الأنبوب والكاشف '
        'متقابلين، ويدور حول المريض بمرونة.',
    items: [
      ComponentItem(
        icon: '🌀',
        name: 'الدوران (Rotation)',
        description:
            'يدور حول 3 محاور: LAO/RAO، CRA/CAU، Oblique. يوفر '
            'زوايا متعددة أثناء الإجراء.',
      ),
      ComponentItem(
        icon: '🛏️',
        name: 'الطاولة (Table)',
        description:
            'شفافة للأشعة. يمكن إمالتها بزوايا مختلفة (Trendelenburg، '
            'Fowler). مثبتة في C-Arm أو منفصلة.',
      ),
      ComponentItem(
        icon: '🎛️',
        name: 'موضع الأنبوب والكاشف',
        description:
            'الأنبوب عادة تحت الطاولة، الكاشف فوق المريض. المسافة '
            'بينهما ثابتة.',
      ),
    ],
    notes: [
      'C-Arm يُستخدم في غرف العمليات والقسطرة.',
      'يمكن تدويره لعدة زوايا في وقت قصير.',
    ],
  ),

  ComponentSection(
    icon: '🔵',
    title: 'أنبوب الأشعة والكاشف',
    intro:
        'يختلف عن X-ray العام: يعمل بتيار منخفض مستمر أو نابض، والكاشف '
        'يعطي صورة فورية.',
    items: [
      ComponentItem(
        icon: '⚡',
        name: 'الأنبوب المستمر',
        description:
            'يعمل بتيار منخفض (1-5 mA) لمدة ثوانٍ. عكس X-ray العادي '
            '(100-1000 mA لجزء من الثانية).',
      ),
      ComponentItem(
        icon: '🎯',
        name: 'Image Intensifier (II)',
        description:
            'التقليدي: يحوّل الفوتونات إلى إلكترونات ثم يكبرها. أقدم '
            'لكن لا يزال يستخدم.',
      ),
      ComponentItem(
        icon: '📸',
        name: 'Flat Panel Detector (FPD)',
        description:
            'الحديث: يحوّل الفوتونات مباشرة إلى إشارة رقمية. جودة أعلى '
            'وجرعة أقل.',
      ),
    ],
    notes: [
      'التصوير النابض (Pulsed) يقلل الجرعة بشكل كبير.',
      'FPD حل مكان II في الأجهزة الحديثة.',
    ],
  ),

  ComponentSection(
    icon: '🛡️',
    title: 'نظام الحماية',
    intro:
        'Fluoroscopy قد يُعطي جرعة عالية في إجراءات طويلة. الحماية صارمة.',
    items: [
      ComponentItem(
        icon: '🧱',
        name: 'الدرع الواقي للمريض',
        description:
            'ألواح رصاصية حول الطاولة. حماية الأعضاء الحساسة (الغدد، '
            'العين، الغدد التناسلية).',
      ),
      ComponentItem(
        icon: '🦺',
        name: 'مئزر الرصاص للطبيب',
        description:
            '0.5 mm رصاص مكافئ. يحمي 90%+ من الأشعة. يجب فحصه سنوياً '
            'بحثاً عن شقوق.',
      ),
      ComponentItem(
        icon: '🕶️',
        name: 'نظارات رصاصية',
        description:
            'لحماية عدسة العين (خطر الساد). خاصة في الإجراءات المعقدة.',
      ),
      ComponentItem(
        icon: '📏',
        name: 'Dosimeter الشخصي',
        description:
            'تحت المئزر + dosimeter ثانٍ للجلد. مراقبة الجرعة التراكمية.',
      ),
      ComponentItem(
        icon: '🎯',
        name: 'Last-Image Hold',
        description:
            'يُظهر آخر صورة بدلاً من التعرض المستمر. يوفر جرعة كبيرة.',
      ),
    ],
    notes: [
      'قاعدة: "قف في جهة الكاشف" — الفرق قد يكون 10 أضعاف جرعة.',
      'كل دقيقة إضافية = جرعة كبيرة. دقيقة = 10-50 mGy.',
    ],
  ),

  ComponentSection(
    icon: '💉',
    title: 'حاقن التباين (Injector)',
    intro:
        'جهاز يحقن مادة التباين في الوعاء أو العضو أثناء الفحص. مهم جداً '
        'لإظهار الأوعية والأعضاء المجوفة.',
    items: [
      ComponentItem(
        icon: '🚀',
        name: 'مضخة التباين',
        description:
            'تحقن مادة التباين بسرعة عالية (2-6 mL/s) أو منخفضة حسب '
            'الإجراء. يمكن التحكم اليدوي أو الآلي.',
      ),
      ComponentItem(
        icon: '💧',
        name: 'أنواع التباين',
        description:
            'يودي (IV): للأوعية والقلب. باريوم (فموي/شرجي): للجهاز '
            'الهضمي. هوائي: للتنظير المزدوج.',
      ),
      ComponentItem(
        icon: '⏱️',
        name: 'التوقيت',
        description:
            'يُزامَن مع التصوير. يجب التقاط الصور عند وصول التباين '
            'للمنطقة المستهدفة.',
      ),
    ],
    notes: [
      'قبل الحقن: اسأل عن الحساسية، وظائف الكلى.',
      'يجب توفر أدوية الطوارئ (Adrenaline, Steroids).',
    ],
  ),

  ComponentSection(
    icon: '🖥️',
    title: 'نظام العرض والتسجيل',
    intro:
        'يشمل شاشات الفحص الحي، تسجيل الفيديو، ونظام معالجة الصور.',
    items: [
      ComponentItem(
        icon: '📺',
        name: 'شاشات الفحص الحي',
        description:
            '1-3 شاشات: واحدة للطبيب، واحدة للمساعد، وواحدة مرجعية. '
            'دقة عالية وتحديث سريع.',
      ),
      ComponentItem(
        icon: '📹',
        name: 'تسجيل الفيديو',
        description:
            'DICOM Cine — يحفظ الفحوصات كمقاطع فيديو. لمراجعة الحركة '
            'بعد الفحص.',
      ),
      ComponentItem(
        icon: '🎨',
        name: 'ما بعد المعالجة',
        description:
            'قياس المسافات، قياس التضيّق في الأوعية، حجب مناطق معينة. '
            'Pixel Shift لتحسين الرؤية.',
      ),
      ComponentItem(
        icon: '💾',
        name: 'PACS Integration',
        description:
            'إرسال الصور والفيديو إلى PACS. سهولة المراجعة والمقارنة.',
      ),
    ],
    notes: [
      'DICOM XA (X-ray Angiography) معيار للقسطرة.',
      'تسجيل إجراءات القسطرة مهم قانونياً وطبياً.',
    ],
  ),

  ComponentSection(
    icon: '🏥',
    title: 'أنواع أجهزة Fluoroscopy',
    intro:
        'أنواع مختلفة حسب الاستخدام: تشخيصي، جراحي، قلبي.',
    items: [
      ComponentItem(
        icon: '🔧',
        name: 'C-Arm المحمول',
        description:
            'محمول لغرف العمليات. يدور 360° بمرونة. يُستخدم في جراحة '
            'العظام، المسالك، والجهاز الهضمي.',
      ),
      ComponentItem(
        icon: '🏥',
        name: 'Fluoroscopy الثابت',
        description:
            'غرفة مخصصة للأشعة التداخلية (Interventional Radiology). '
            'أنبوب + طاولة + C-Arm ضخم.',
      ),
      ComponentItem(
        icon: '❤️',
        name: 'غرفة القسطرة القلبية',
        description:
            'نظام متكامل مع رسم القلب، إيكو، وقياس الضغط. للقلب '
            'والشرايين التاجية.',
      ),
      ComponentItem(
        icon: '📺',
        name: 'Remote-Controlled',
        description:
            'جهاز قديم كان يستخدم للجهاز الهضمي. الطبيب يتحكم من '
            'خارج الغرفة.',
      ),
    ],
    notes: [
      'C-Arm هو الأكثر استخداماً اليوم.',
      'Biplane (ذراعان) يُستخدم في قسطرة القلب للرؤية المزدوجة.',
    ],
  ),

  ComponentSection(
    icon: '📊',
    title: 'أنظمة الدعم',
    intro:
        'أنظمة مساعدة تضمن الأمان والدقة والفعالية.',
    items: [
      ComponentItem(
        icon: '🚨',
        name: 'نظام الإنذار',
        description:
            'ينبّه عند تجاوز زمن Fluoroscopy أو الجرعة المسموحة. مهم '
            'لتقليل الجرعة.',
      ),
      ComponentItem(
        icon: '📈',
        name: 'Dose Monitoring',
        description:
            'يراقب DAP (Dose Area Product) و Air Kerma. يظهر الجرعة '
            'التراكمية على الشاشة.',
      ),
      ComponentItem(
        icon: '🔄',
        name: 'Pulsed Fluoroscopy Control',
        description:
            'التحكم بمعدل النبضات (3-15 في الثانية). تقليل المعدل '
            'يقلل الجرعة.',
      ),
      ComponentItem(
        icon: '📐',
        name: 'Magnification Control',
        description:
            'تكبير الصورة — يزيد الجرعة. يُستخدم عند الحاجة فقط.',
      ),
    ],
    notes: [
      'تسجيل الجرعة لكل مريض ضروري للتوثيق.',
      'ALARA يُطبّق بصرامة في Fluoroscopy.',
    ],
  ),
];