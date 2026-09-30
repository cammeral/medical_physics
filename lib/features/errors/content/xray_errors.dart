import '../error_model.dart';

const DeviceErrors xrayErrors = DeviceErrors(
  deviceId: 'xray',
  intro:
      'أخطاء X-ray عادة بسيطة لكنها تؤثر على جودة الصورة أو الجرعة. '
      'معظمها قابل للتصحيح بسهولة.',
  errors: [
    MedicalError(
      id: 'motion',
      icon: '👻',
      title: 'Motion Artifact (ضبابية الحركة)',
      subtitle: 'صورة ضبابية بسبب حركة المريض',
      severity: ErrorSeverity.high,
      symptom: 'الصورة غير واضحة، حدود الأعضاء ضبابية ومشوشة.',
      cause:
          'حركة المريض أثناء التعرض. خاصة في الأطفال، كبار السن، أو '
          'المصابين بألم.',
      solution:
          'إعادة التصوير. علّم المريض على حبس النفس. ثبّت المنطقة بوسائل '
          'مساعدة إذا لزم.',
      prevention:
          'اشرح الإجراء للمريض قبل التعرض. جرّب معه حبس النفس. استخدم '
          'أقصر زمن تعرض ممكن.',
    ),
    MedicalError(
      id: 'underexposure',
      icon: '🌑',
      title: 'Underexposure (تعرض منخفض)',
      subtitle: 'صورة داكنة جداً',
      severity: ErrorSeverity.medium,
      symptom: 'الصورة داكنة، تفاصيلها غير واضحة. تبدو كأنها غير معرّضة.',
      cause:
          'kVp أو mAs منخفض جداً. AEC لم يعمل. المسافة كبيرة جداً.',
      solution:
          'زيادة kVp أو mAs. تفعيل AEC. تقليل المسافة.',
      prevention:
          'اضبط العوامل حسب المنطقة وحجم المريض. تأكد من عمل AEC قبل '
          'التصوير.',
    ),
    MedicalError(
      id: 'overexposure',
      icon: '☀️',
      title: 'Overexposure (تعرض عالٍ)',
      subtitle: 'صورة فاتحة جداً',
      severity: ErrorSeverity.medium,
      symptom: 'الصورة فاتحة جداً، تفاصيلها مفقودة. قد تكون بيضاء بالكامل.',
      cause:
          'kVp أو mAs مرتفع جداً. AEC معطّل. المسافة قصيرة جداً. تعرض '
          'مزدوج.',
      solution:
          'تقليل kVp أو mAs. تفعيل AEC. زيادة المسافة.',
      prevention:
          'استخدم AEC دائماً. راجع الإعدادات قبل الضغط. لا تضغط الزر '
          'مرتين.',
    ),
    MedicalError(
      id: 'poor_positioning',
      icon: '📐',
      title: 'Poor Positioning (وضعية خاطئة)',
      subtitle: 'الصورة لا تُظهر المنطقة المطلوبة',
      severity: ErrorSeverity.high,
      symptom: 'الجزء المطلوب مقطوع من الصورة، أو الوضعية غير صحيحة.',
      cause:
          'المريض لم يُوضع في الوضعية الصحيحة. الليزر المحاذي لم يعمل. '
          'الكوليماتور غير مضبوط.',
      solution:
          'إعادة تصوير بالوضعية الصحيحة. اضبط الليزر على المنطقة.',
      prevention:
          'راجع البروتوكول قبل وضع المريض. استخدم الليزر المحاذي دائماً. '
          'اختبر الوضع على المعاينة.',
    ),
    MedicalError(
      id: 'dose_repeat',
      icon: '🔁',
      title: 'إعادة تصوير متكررة',
      subtitle: 'إعادات متعددة = جرعة إضافية',
      severity: ErrorSeverity.high,
      symptom: 'المريض يتعرض لعدة مرات — جرعة تراكمية عالية.',
      cause:
          'أخطاء في الوضعية أو العوامل. عدم مراجعة الصورة قبل التسليم. '
          'ضغط العمل.',
      solution:
          'راجع الصورة فوراً بعد التعرض. لا تُعِد إلا لسبب مقنع.',
      prevention:
          'استخدم AEC. درّب الفريق. لا تكرر بلا داعٍ. وثّق كل إعادة.',
    ),
    MedicalError(
      id: 'metal_artifact',
      icon: '💍',
      title: 'Metal Artifact (تشويش معدني)',
      subtitle: 'خطوط أو ظلال من معدن',
      severity: ErrorSeverity.low,
      symptom: 'خطوط بيضاء أو رمادية من معدن في الصورة.',
      cause:
          'مجوهرات، أزرار، سحابات، أو زرعات معدنية لم تُزل.',
      solution:
          'إعادة تصوير بعد إزالة المعدن. أو تعديل الزاوية لتقليل التشويش.',
      prevention:
          'اطلب إزالة كل المعادن قبل التصوير. استخدم Metal Detector.',
    ),
    MedicalError(
      id: 'grid_lines',
      icon: '🔲',
      title: 'Grid Lines (خطوط الشبكة)',
      subtitle: 'خطوط رأسية في الصورة',
      severity: ErrorSeverity.low,
      symptom: 'خطوط رأسية متكررة في الصورة.',
      cause:
          'شبكة مضادة للتشتت (Anti-Scatter Grid) غير معايرة، أو '
          'استخدام Grid خاطئ.',
      solution: 'إعادة تصوير بدون Grid أو بـ Grid مناسب.',
      prevention:
          'تحقق من نوع Grid قبل الاستخدام. استخدم Grid لسماكات > 10 cm.',
    ),
    MedicalError(
      id: 'skin_dose',
      icon: '🔥',
      title: 'Skin Dose (جرعة جلدية عالية)',
      subtitle: 'احمرار جلدي بعد الفحص',
      severity: ErrorSeverity.high,
      symptom: 'احمرار أو حرق جلدي في موقع التعرض.',
      cause:
          'تعرض متكرر لنفس المنطقة. جرعة تراكمية > 2 Gy.',
      solution:
          'إيقاف التعرض فوراً. مراجعة الجرعة التراكمية. متابعة الجلد.',
      prevention:
          'سجّل الجرعة التراكمية. لا تكرر نفس المنطقة بدون داعٍ. استخدم '
          'الحاجز الرصاصي.',
    ),
  ],
);