import '../error_model.dart';

const DeviceErrors spectErrors = DeviceErrors(
  deviceId: 'spect',
  intro:
      'أخطاء SPECT غالباً متعلقة بالكوليماتور، الحركة، أو التلوث الإشعاعي.',
  errors: [
    MedicalError(
      id: 'motion_spect',
      icon: '👻',
      title: 'Motion Artifact',
      subtitle: 'خطوط في الصورة المقطعية',
      severity: ErrorSeverity.high,
      symptom: 'خطوط أو أهداب في الصورة المقطعية.',
      cause: 'حركة المريض بين زوايا الدوران.',
      solution:
          'إعادة الفحص. تثبيت المريض. تقليل مدة الدوران.',
      prevention:
          'تثبيت جيد. شرائح أسرع. Gating إن لزم.',
    ),
    MedicalError(
      id: 'collimator_damage',
      icon: '🔲',
      title: 'Collimator Damage',
      subtitle: 'خطوط في كل الصور',
      severity: ErrorSeverity.high,
      symptom: 'خطوط ثابتة في كل الفحوصات.',
      cause: 'ثقوب مسدودة أو تالفة في الكوليماتور.',
      solution: 'استبدال الكوليماتور. صيانة فورية.',
      prevention:
          'تعامل حذر. فحص دوري. تخزين في مكان آمن.',
    ),
    MedicalError(
      id: 'contamination',
      icon: '☢️',
      title: 'Detector Contamination',
      subtitle: 'بقع ساطعة ثابتة',
      severity: ErrorSeverity.high,
      symptom: 'بقع ساطعة ثابتة في مواضع محددة.',
      cause:
          'تلوث بمواد مشعة على الكاشف أو الكوليماتور.',
      solution:
          'إيقاف الجهاز. تنظيف مكثف. فحص بـ Geiger.',
      prevention:
          'قفازات دائماً. تغطية الكاشف. تنظيف بعد كل مريض.',
    ),
    MedicalError(
      id: 'motion_gating',
      icon: '❤️',
      title: 'Cardiac Motion',
      subtitle: 'ضبابية في فحص القلب',
      severity: ErrorSeverity.medium,
      symptom: 'حدود القلب غير واضحة.',
      cause: 'حركة القلب أثناء التصوير.',
      solution: 'استخدام ECG Gating.',
      prevention:
          'Gating إلزامي لفحوصات القلب. نافذة قبول 20%.',
    ),
    MedicalError(
      id: 'attenuation',
      icon: '📉',
      title: 'Attenuation Artifact',
      subtitle: 'مناطق داكنة',
      severity: ErrorSeverity.medium,
      symptom: 'مناطق داكنة غير مبررة في الصورة.',
      cause:
          'امتصاص الأشعة في الأنسجة الكثيفة (خاصة في القلب).',
      solution:
          'تصحيح التوهين (Attenuation Correction). استخدام SPECT/CT.',
      prevention:
          'استخدم SPECT/CT دائماً. تصحيح رياضي إلزامي.',
    ),
    MedicalError(
      id: 'short_half_life',
      icon: '⏱️',
      title: 'Decay Before Imaging',
      subtitle: 'إشارة ضعيفة',
      severity: ErrorSeverity.medium,
      symptom: 'صورة باهتة بسبب قلة الإشارة.',
      cause:
          'طول الانتظار بين الحقن والتصوير (تجاوز عمر النصف).',
      solution: 'تصوير فوري. حساب التصحيح.',
      prevention:
          'التزم بالبروتوكول. Tc-99m عمر نصفه 6 ساعات.',
    ),
    MedicalError(
      id: 'wrong_collimator',
      icon: '🔲',
      title: 'Wrong Collimator',
      subtitle: 'صورة غير مناسبة',
      severity: ErrorSeverity.high,
      symptom: 'دقة منخفضة أو حساسية عالية.',
      cause: 'استخدام كوليماتور غير مناسب للنظير.',
      solution: 'استبدال الكوليماتور المناسب.',
      prevention:
          'اعرف كوليماتور كل نظير. علامات على كل كوليماتور.',
    ),
    MedicalError(
      id: 'scatter',
      icon: '🌫️',
      title: 'Compton Scatter',
      subtitle: 'خلفية عالية',
      severity: ErrorSeverity.medium,
      symptom: 'خلفية عالية تُخفي التفاصيل.',
      cause:
          'تشتت كومبتون من الأنسجة العميقة.',
      solution:
          'استخدم نافذة طاقة ضيقة. تصحيح التشتت.',
      prevention:
          'نافذة طاقة ±10%. تصحيح رياضي.',
    ),
  ],
);