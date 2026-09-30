import '../error_model.dart';

const DeviceErrors laserErrors = DeviceErrors(
  deviceId: 'laser',
  intro:
      'أخطاء الليزر غالباً متعلقة بالأمان البصري والتأثيرات الجلدية.',
  errors: [
    MedicalError(
      id: 'eye_injury',
      icon: '👁️',
      title: 'Eye Injury (إصابة العين)',
      subtitle: 'إصابة خطيرة محتملة',
      severity: ErrorSeverity.high,
      symptom:
          'ألم في العين، فقدان جزئي للرؤية، بقعة في مجال الرؤية.',
      cause:
          'عدم ارتداء النظارات الواقية. انعكاس الشعاع.',
      solution:
          'طوارئ عيون فورية. فحص شبكية. علاج عاجل.',
      prevention:
          'نظارات إلزامية. تغطية النوافذ. لافتات تحذير.',
    ),
    MedicalError(
      id: 'skin_burn',
      icon: '🔥',
      title: 'Skin Burn',
      subtitle: 'حرق جلدي',
      severity: ErrorSeverity.medium,
      symptom:
          'احمرار شديد، فقاعات، أو تصبغ دائم.',
      cause:
          'طاقة عالية. تبريد غير كافٍ. بشرة داكنة.',
      solution:
          'كمادات باردة. كريم مضاد حيوي. متابعة.',
      prevention:
          'اختبار Test Spot. تبريد كافٍ. طاقة مناسبة للبشرة.',
    ),
    MedicalError(
      id: 'scarring',
      icon: '🩹',
      title: 'Scarring / Keloid',
      subtitle: 'ندبة دائمة',
      severity: ErrorSeverity.medium,
      symptom:
          'ندبة بارزة، سميكة، أو تصبغ دائم.',
      cause:
          'حساسية فردية. طاقة عالية. عدوى بعد الإجراء.',
      solution:
          'كريمات الكورتيزون. سيليكون جيل. حقن داخل الأدمة.',
      prevention:
          'استبيان تاريخ الكيلويد. طاقة أقل. نظافة صارمة.',
    ),
    MedicalError(
      id: 'infection',
      icon: '🦠',
      title: 'Post-procedure Infection',
      subtitle: 'عدوى جلدية',
      severity: ErrorSeverity.medium,
      symptom:
          'احمرار، تورم، ألم متزايد، إفرازات.',
      cause:
          'عدم تعقيم كافٍ. لمس الجلد بعد الإجراء.',
      solution:
          'مضاد حيوي. تنظيف. متابعة.',
      prevention:
          'تعقيم كامل. عدم لمس. تعليمات واضحة للمريض.',
    ),
    MedicalError(
      id: 'hyperpigmentation',
      icon: '🎨',
      title: 'Hyperpigmentation',
      subtitle: 'تصبغات',
      severity: ErrorSeverity.low,
      symptom:
          'مناطق داكنة بعد العلاج.',
      cause:
          'تعرض للشمس. بشرة داكنة. التهاب بعد الإجراء.',
      solution:
          'واقي شمس. تفتيح. صبر (يختفي خلال أشهر).',
      prevention:
          'تجنّب الشمس. SPF 50+. طاقة مناسبة.',
    ),
    MedicalError(
      id: 'fire_hazard',
      icon: '🚒',
      title: 'Fire Hazard',
      subtitle: 'خطر حريق',
      severity: ErrorSeverity.high,
      symptom:
          'اشتعال مفاجئ في الغرفة (نادر).',
      cause:
          'ليزر + أوكسجين + مادة قابلة للاشتعال (كحول، قطن، أنابيب).',
      solution:
          'إيقاف الليزر. مطفأة حريق. إخلاء الغرفة.',
      prevention:
          'لا كحول قرب الليزر. مطفأة جاهزة. تجنّب O₂ قرب الجراحة.',
    ),
    MedicalError(
      id: 'wrong_wavelength',
      icon: '🌈',
      title: 'Wrong Wavelength',
      subtitle: 'نتيجة غير فعالة',
      severity: ErrorSeverity.medium,
      symptom:
          'العلاج لا يعطي نتيجة. آفات تبقى.',
      cause:
          'اختيار طول موجي غير مناسب للهدف.',
      solution:
          'إعادة التقييم. اختيار الليزر الصحيح.',
      prevention:
          'اعرف امتصاص الهدف (هيموغلوبين، ميلانين، ماء). تدريب.',
    ),
    MedicalError(
      id: 'no_maintenance',
      icon: '🔧',
      title: 'Calibration Drift',
      subtitle: 'طاقة غير دقيقة',
      severity: ErrorSeverity.medium,
      symptom:
          'النتائج تتغير دون سبب. طاقة أقل أو أكثر من المتوقع.',
      cause:
          'عدم معايرة الجهاز دورياً.',
      solution:
          'معايرة. فحص الطاقة بمقياس.',
      prevention:
          'معايرة دورية. سجل الصيانة. اختبار الطاقة شهرياً.',
    ),
  ],
);