import '../error_model.dart';

const DeviceErrors mammographyErrors = DeviceErrors(
  deviceId: 'mammo',
  intro:
      'أخطاء Mammography متعلقة بالضغط، الوضعية، والجرعة. الضغط الأمثل '
      'ضروري لجودة الصورة.',
  errors: [
    MedicalError(
      id: 'poor_compression',
      icon: '🔽',
      title: 'Poor Compression',
      subtitle: 'صورة غير واضحة',
      severity: ErrorSeverity.high,
      symptom:
          'صورة غير كافية، سماكة الثدي كبيرة، تفاصيل غير واضحة.',
      cause:
          'ضغط غير كافٍ. ألم المريضة. تقنية خاطئة.',
      solution:
          'إعادة الفحص. شرح أهمية الضغط. تقنية لطيفة.',
      prevention:
          'اشرح للمريضة. تقنية تدريجية. لا تتخطى الضغط الكافي.',
    ),
    MedicalError(
      id: 'position_mammo',
      icon: '📐',
      title: 'Positioning Error',
      subtitle: 'أجزاء مفقودة',
      severity: ErrorSeverity.high,
      symptom:
          'أجزاء من الثدي غير مرئية (خاصة الإبطية).',
      cause:
          'وضعية خاطئة (CC أو MLO). عدم توسيط الحلمة.',
      solution:
          'إعادة الفحص. تصحيح الوضع. تدريب التقني.',
      prevention:
          'توسيط الحلمة. افحص الوضع قبل التعرض. MLO 45° دائماً.',
    ),
    MedicalError(
      id: 'motion_mammo',
      icon: '👻',
      title: 'Motion Blur',
      subtitle: 'صورة ضبابية',
      severity: ErrorSeverity.medium,
      symptom:
          'تفاصيل غير واضحة. خطوط ضبابية.',
      cause:
          'حركة المريضة أثناء التعرض.',
      solution:
          'إعادة الفحص. تثبيت أفضل.',
      prevention:
          'اشرح للمريضة: "لا تتحركي لحظة". وقت قصير.',
    ),
    MedicalError(
      id: 'skin_folds',
      icon: '〰️',
      title: 'Skin Folds',
      subtitle: 'طيّات جلدية',
      severity: ErrorSeverity.low,
      symptom:
          'خطوط داكنة على الجلد تُحاكي آفات.',
      cause:
          'الجلد مطوي بين الصفيحتين.',
      solution:
          'إعادة الفحص. افرد الجلد بلطف.',
      prevention:
          'افرد الجلد قبل الضغط. تقنية صحيحة.',
    ),
    MedicalError(
      id: 'artifacts_mammo',
      icon: '💍',
      title: 'Metal/Implant Artifacts',
      subtitle: 'معادن أو زرعات',
      severity: ErrorSeverity.medium,
      symptom:
          'ظلال معدنية أو خطوط من الزرعات.',
      cause:
          'زرعات سيليكون/سالين. معادن على الجلد (حلقات).',
      solution:
          'تقنية Implant Displacement. إزالة المعادن.',
      prevention:
          'اسأل عن الزرعات. استخدم تقنية خاصة.',
    ),
    MedicalError(
      id: 'high_dose_mammo',
      icon: '☢️',
      title: 'High Dose',
      subtitle: 'جرعة أعلى من اللازم',
      severity: ErrorSeverity.medium,
      symptom:
          'MGD أعلى من المسموح.',
      cause:
          'تقنية خاطئة. AEC معطوب. تكرار بدون داعٍ.',
      solution:
          'مراجعة التقنية. AEC. تقليل التكرار.',
      prevention:
          'معايرة دورية. AEC. تدريب.',
    ),
    MedicalError(
      id: 'underpenetration',
      icon: '🌑',
      title: 'Underpenetration',
      subtitle: 'صورة داكنة',
      severity: ErrorSeverity.medium,
      symptom:
          'صورة داكنة، تفاصيل رخوة غير واضحة.',
      cause:
          'kVp منخفض. ضغط زائد.',
      solution:
          'زيادة kVp. تقليل الضغط.',
      prevention:
          'AEC. توازن بين الضغط والطاقة.',
    ),
    MedicalError(
      id: 'missing_previous',
      icon: '📂',
      title: 'Missing Previous Images',
      subtitle: 'لا مقارنة متاحة',
      severity: ErrorSeverity.medium,
      symptom:
          'لا يمكن المقارنة مع الفحوصات السابقة.',
      cause:
          'الصور السابقة لم تُحضر. PACS غير متصل.',
      solution:
          'اطلب الصور السابقة. ابحث في PACS.',
      prevention:
          'اطلب من المريضة إحضار الصور. تكامل PACS.',
    ),
  ],
);