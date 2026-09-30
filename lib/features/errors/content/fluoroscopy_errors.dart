import '../error_model.dart';

const DeviceErrors fluoroscopyErrors = DeviceErrors(
  deviceId: 'fluoro',
  intro:
      'أخطاء Fluoroscopy خطيرة — الجرعة تراكمية مع الوقت. أي خطأ قد يؤدي '
      'لحرق جلدي.',
  errors: [
    MedicalError(
      id: 'high_dose_fluoro',
      icon: '☢️',
      title: 'High Skin Dose',
      subtitle: 'حرق جلدي محتمل',
      severity: ErrorSeverity.high,
      symptom:
          'احمرار جلد بعد الإجراء. تقشّر بعد أسابيع.',
      cause:
          'زمن Fluoroscopy طويل. جرعة تراكمية > 2 Gy.',
      solution:
          'إيقاف التعرض. توثيق الجرعة. متابعة جلدية.',
      prevention:
          'راقب Dose Monitor. حد أقصى 5 دقائق. Last-Image Hold.',
    ),
    MedicalError(
      id: 'staff_dose',
      icon: '🧑‍⚕️',
      title: 'High Staff Dose',
      subtitle: 'جرعة الطبيب عالية',
      severity: ErrorSeverity.high,
      symptom:
          'قراءة Dosimeter أعلى من الحد.',
      cause:
          'قرب الطبيب من الأنبوب. عدم ارتداء المئزر. زمن طويل.',
      solution:
          'مراجعة الوضعية. مئزر. EPD.',
      prevention:
          'قف جهة الكاشف. مئزر رصاصي. Dosimeter يومي.',
    ),
    MedicalError(
      id: 'contrast_reaction_fluoro',
      icon: '💉',
      title: 'Contrast Reaction',
      subtitle: 'حساسية للتباين',
      severity: ErrorSeverity.high,
      symptom:
          'طفح، صعوبة تنفس، انخفاض ضغط.',
      cause:
          'حساسية للتباين اليودي.',
      solution:
          'إيقاف فوري. Adrenaline. Steroids. O₂.',
      prevention:
          'اسأل عن حساسية. Premedication. أدوية طوارئ جاهزة.',
    ),
    MedicalError(
      id: 'bleeding',
      icon: '🩸',
      title: 'Bleeding at Puncture Site',
      subtitle: 'نزيف من موقع البزل',
      severity: ErrorSeverity.medium,
      symptom:
          'نزيف، ورم دموي، ألم في موضع البزل.',
      cause:
          'مضادات تخثر. ضغط غير كافٍ بعد الإجراء.',
      solution:
          'ضغط موضعي. فحص تخثر. مراقبة.',
      prevention:
          'إيقاف مضادات التخثر. ضغط كافٍ. راحة بعد الإجراء.',
    ),
    MedicalError(
      id: 'catheter_displacement',
      icon: '🩹',
      title: 'Catheter Displacement',
      subtitle: 'انزلاق القسطرة',
      severity: ErrorSeverity.medium,
      symptom:
          'القسطرة تتحرك من مكانها. تسرب تباين.',
      cause:
          'حركة المريض. عدم تثبيت جيد.',
      solution:
          'إعادة التثبيت. تحقق بالتصوير.',
      prevention:
          'تثبيت جيد. تعليم المريض. فحص دوري.',
    ),
    MedicalError(
      id: 'long_fluoro_time',
      icon: '⏱️',
      title: 'Long Fluoroscopy Time',
      subtitle: 'تعرض مطوّل',
      severity: ErrorSeverity.high,
      symptom:
          'تجاوز 30 دقيقة Fluoroscopy.',
      cause:
          'إجراء معقد. عدم خبرة. Last-Image Hold لم يُستخدم.',
      solution:
          'إيقاف التعرض. مراجعة الإجراء. تسجيل الجرعة.',
      prevention:
          'تدريب. Pulsed Fluoroscopy. Last-Image Hold.',
    ),
    MedicalError(
      id: 'magnification_overuse',
      icon: '🔍',
      title: 'Magnification Overuse',
      subtitle: 'تكبير زائد = جرعة أعلى',
      severity: ErrorSeverity.medium,
      symptom:
          'جرعة أعلى دون فائدة تشخيصية.',
      cause:
          'استخدام Magnification في كل الصور.',
      solution:
          'استخدم Magnification فقط عند الحاجة.',
      prevention:
          'اعرف مخاطر التكبير. قلّل استخدامه.',
    ),
    MedicalError(
      id: 'collimator_fluoro',
      icon: '🔲',
      title: 'Wide Collimation',
      subtitle: 'كوليماتور واسع',
      severity: ErrorSeverity.medium,
      symptom:
          'مساحة تعرض أكبر من اللازم.',
      cause:
          'كوليماتور لم يُضبط.',
      solution:
          'اضبط الكوليماتور قبل التعرض.',
      prevention:
          'قاعدة: "لا تُشعّ أوسع مما تحتاج".',
    ),
  ],
);