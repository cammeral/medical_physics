import '../error_model.dart';

const DeviceErrors ultrasoundErrors = DeviceErrors(
  deviceId: 'us',
  intro:
      'أخطاء Ultrasound غالباً متعلقة بجودة الصورة والمسبار. معظمها يمكن '
      'تصحيحه بسهولة.',
  errors: [
    MedicalError(
      id: 'poor_contact',
      icon: '💧',
      title: 'Poor Contact (تلامس سيء)',
      subtitle: 'صورة داكنة أو غير واضحة',
      severity: ErrorSeverity.medium,
      symptom: 'صورة جزئية أو ضعيفة الإشارة في مناطق.',
      cause:
          'جل غير كافٍ. مسبار لا يلامس الجلد. شعر كثيف.',
      solution:
          'إضافة جل. الضغط قليلاً. حلاقة المنطقة إذا لزم.',
      prevention:
          'استخدم كمية جل كافية. تأكد من التلامس الكامل.',
    ),
    MedicalError(
      id: 'acoustic_shadow',
      icon: '🌑',
      title: 'Acoustic Shadow',
      subtitle: 'ظل خلف حصاة أو عظم',
      severity: ErrorSeverity.low,
      symptom: 'ظل داكن خلف جسم صلب (حصاة، عظم).',
      cause:
          'انعكاس كامل للموجات من الحصى أو العظام.',
      solution:
          'غيّر الزاوية. استخدم مسبار مختلف. Doppler للتفريق.',
      prevention:
          'افحص من زوايا متعددة. لا تعتمد على زاوية واحدة.',
    ),
    MedicalError(
      id: 'reverberation',
      icon: '🔁',
      title: 'Reverberation Artifact',
      subtitle: 'خطوط أفقية متكررة',
      severity: ErrorSeverity.low,
      symptom: 'خطوط أفقية متساوية البعد في الأعماق.',
      cause:
          'انعكاسات متعددة بين سطحين قويين (مثل جدار المثانة).',
      solution:
          'غيّر الزاوية. قلّل Gain. غيّر المسبار.',
      prevention:
          'اعرف الأنسجة التي تُسبب Reverberation (مثل المثانة، الرئة).',
    ),
    MedicalError(
      id: 'aliasing_doppler',
      icon: '🎨',
      title: 'Doppler Aliasing',
      subtitle: 'ألوان معكوسة في الدوبلر',
      severity: ErrorSeverity.medium,
      symptom: 'ألوان معكوسة (أحمر يظهر أزرق) أو خطوط غير منطقية.',
      cause:
          'سرعة الدم تتجاوز حد Nyquist.',
      solution:
          'زد الـ PRF. قلّل التردد. غيّر الزاوية. استخدم CW Doppler.',
      prevention:
          'اختر PRF مناسب للسرعة المتوقعة. استخدم CW للسرعات العالية.',
    ),
    MedicalError(
      id: 'comet_tail',
      icon: '☄️',
      title: 'Comet Tail Artifact',
      subtitle: 'خطوط ذيل المذنب',
      severity: ErrorSeverity.low,
      symptom: 'خطوط قطرية قصيرة متعددة.',
      cause:
          'وجود أجسام صغيرة (بلورات، فقاعات) تسبب رنين.',
      solution:
          'غيّر الزاوية. في الرئة، قد يكون طبيعياً.',
      prevention:
          'اعرف الحالات الطبيعية (مثل B-lines في الرئة) والتي قد تكون مرضية.',
    ),
    MedicalError(
      id: 'mirror_image',
      icon: '🪞',
      title: 'Mirror Image Artifact',
      subtitle: 'صورة معكوسة',
      severity: ErrorSeverity.low,
      symptom: 'عضو يظهر مرتين (صورة معكوسة).',
      cause:
          'انعكاس الموجات من سطح قوي (مثل الحجاب الحاجز).',
      solution:
          'غيّر الزاوية. اعرف الخاصية.',
      prevention:
          'احترس من الأنسجة خلف الحجاب الحاجز (الكبد/الطحال).',
    ),
    MedicalError(
      id: 'too_deep',
      icon: '🌊',
      title: 'Depth Penetration Issues',
      subtitle: 'لا ترى الأعماق',
      severity: ErrorSeverity.medium,
      symptom: 'الأعضاء العميقة غير مرئية.',
      cause:
          'تردد عالٍ جداً. مريض سمين. مسافة كبيرة.',
      solution:
          'استخدم مسبار منخفض التردد. زد الطاقة. اضغط أكثر.',
      prevention:
          'اختر المسبار حسب عمق العضو. استخدم 2-5 MHz للبطن.',
    ),
    MedicalError(
      id: 'gas_obstruction',
      icon: '💨',
      title: 'Gas Obstruction',
      subtitle: 'غازات تحجب الرؤية',
      severity: ErrorSeverity.medium,
      symptom: 'رؤية سيئة للأعضاء بسبب الغازات.',
      cause:
          'غازات معوية كثيفة. مريض لم يصم. ابتلاع هواء.',
      solution:
          'غيّر الوضعية. اضغط. اطلب من المريض شرب ماء. أعد الفحص بعد صيام.',
      prevention:
          'الصيام قبل الفحص. تجنّب المضغ/الكلام أثناء الفحص.',
    ),
  ],
);