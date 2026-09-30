import '../error_model.dart';

const DeviceErrors ctErrors = DeviceErrors(
  deviceId: 'ct',
  intro:
      'أخطاء CT غالباً متعلقة بالحركة، التباين، أو البنية الرياضية للصورة. '
      'بعضها يُفسد التشخيص كاملاً.',
  errors: [
    MedicalError(
      id: 'motion_ct',
      icon: '👻',
      title: 'Motion Artifact',
      subtitle: 'خطوط ضبابية بسبب الحركة',
      severity: ErrorSeverity.high,
      symptom: 'خطوط مزدوجة أو ضبابية على حدود الأعضاء.',
      cause:
          'حركة المريض أو التنفس أثناء الدوران. خاصة في CT الصدر والبطن.',
      solution:
          'إعادة الفحص. تدريب المريض على حبس النفس. استخدام تسلسل أسرع.',
      prevention:
          'اشرح للمريض. درّبه على حبس النفس. استخدم Respiratory Gating '
          'إذا لزم.',
    ),
    MedicalError(
      id: 'beam_hardening',
      icon: '⚡',
      title: 'Beam Hardening',
      subtitle: 'خطوط داكنة بين عظمتين',
      severity: ErrorSeverity.medium,
      symptom: 'خطوط داكنة بين العظام الكثيفة، خاصة في الرأس.',
      cause:
          'الفوتونات منخفضة الطاقة تُمتص أكثر → طيف الأشعة يصبح "أصلب".',
      solution:
          'استخدام Beam Hardening Correction. تعديل العوامل. استخدام '
          'DECT.',
      prevention:
          'استخدم ترشيح مناسب. اختر kVp أعلى قليلاً.',
    ),
    MedicalError(
      id: 'metal_ct',
      icon: '💍',
      title: 'Metal Artifact',
      subtitle: 'خطوط ساطعة حول المعادن',
      severity: ErrorSeverity.medium,
      symptom: 'خطوط بيضاء ساطعة تنطلق من الشرائح المعدنية.',
      cause:
          'الشرائح، المسامير، أو الأجهزة المزروعة المعدنية.',
      solution:
          'استخدام Metal Artifact Reduction (MAR). تعديل الزاوية.',
      prevention:
          'MAR بروتوكول للأجهزة المزروعة. استخدم kVp أعلى.',
    ),
    MedicalError(
      id: 'contrast_timing',
      icon: '💉',
      title: 'Contrast Timing (توقيت التباين)',
      subtitle: 'التباين في مرحلة خاطئة',
      severity: ErrorSeverity.high,
      symptom: 'الصورة بلا تباين، أو التباين في العضو الخطأ.',
      cause:
          'Bolus Tracking فشل. توقيت الحقن خاطئ. الكانيولا مسدودة.',
      solution:
          'إعادة الفحص. تحقق من الحاقن. استخدم Bolus Tracking.',
      prevention:
          'اختبر الحاقن قبل الفحص. تأكد من الكانيولا. راجع البروتوكول.',
    ),
    MedicalError(
      id: 'partial_volume',
      icon: '📦',
      title: 'Partial Volume Averaging',
      subtitle: 'قيم HU غير دقيقة',
      severity: ErrorSeverity.medium,
      symptom: 'قيم HU للأجسام الصغيرة أقل من المتوقع.',
      cause:
          'شريحة أكبر من الجسم → خلط قيم HU بينه وبين المحيط.',
      solution:
          'إعادة البناء بشرائح أرق (Thin Slices).',
      prevention:
          'استخدم Slice Thickness مناسب للأجسام الصغيرة. راجع البروتوكول.',
    ),
    MedicalError(
      id: 'ring_ct',
      icon: '🔘',
      title: 'Ring Artifact',
      subtitle: 'حلقات متحدة المركز',
      severity: ErrorSeverity.high,
      symptom: 'حلقات دائرية كاملة حول مركز الصورة.',
      cause:
          'خلل في كاشف واحد أو أكثر. يحتاج معايرة.',
      solution:
          'إيقاف الجهاز. إجراء Calibration. الاتصال بالصيانة.',
      prevention:
          'Calibration دوري. راقب الصور للكشف المبكر.',
    ),
    MedicalError(
      id: 'stair_step',
      icon: '🪜',
      title: 'Stair Step Artifact',
      subtitle: 'خطوات في إعادة البناء MPR',
      severity: ErrorSeverity.low,
      symptom: 'خطوات واضحة عند إعادة البناء MPR/3D.',
      cause:
          'Pitch عالٍ مع Slice Thickness كبير.',
      solution:
          'تقليل Pitch. تصغير Slice Thickness. استخدام Interpolation.',
      prevention:
          'اختر Pitch مناسب لكل بروتوكول. في MPR استخدم شرائح رقيقة.',
    ),
  ],
);