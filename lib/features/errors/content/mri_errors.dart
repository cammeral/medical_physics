import '../error_model.dart';

const DeviceErrors mriErrors = DeviceErrors(
  deviceId: 'mri',
  intro:
      'أخطاء MRI معقدة بسبب طبيعة الفيزياء (Rf, gradients). معظمها يعطي '
      'تشويشاً في الصورة أو صورة غير تشخيصية.',
  errors: [
    MedicalError(
      id: 'aliasing',
      icon: '🔀',
      title: 'Aliasing (Wrap-around)',
      subtitle: 'التفاف الأنسجة من الخارج',
      severity: ErrorSeverity.medium,
      symptom: 'جزء من الجسم يظهر على الجانب الآخر من الصورة.',
      cause:
          'FOV أصغر من الجسم. ترددات لارمور تتجاوز نافذة القياس.',
      solution:
          'زيادة FOV. أو تفعيل Phase Oversampling.',
      prevention:
          'اختر FOV يشمل كل المنطقة. استخدم Saturation Bands.',
    ),
    MedicalError(
      id: 'motion_mri',
      icon: '👻',
      title: 'Motion Artifact',
      subtitle: 'ضبابية أو خطوط متكررة',
      severity: ErrorSeverity.high,
      symptom: 'خطوط متوازية أو ضبابية. قد تُخفي الآفات الصغيرة.',
      cause:
          'حركة المريض، التنفس، نبضات القلب، أو حركة العين.',
      solution:
          'إعادة التسلسل. استخدام Respiratory/ Cardiac Gating. تهدئة المريض.',
      prevention:
          'تدريب المريض. سدادات أذن. Gating للقلب والبطن.',
    ),
    MedicalError(
      id: 'rf_interference',
      icon: '📻',
      title: 'RF Interference (Zipper)',
      subtitle: 'خطوط رأسية مزعجة',
      severity: ErrorSeverity.high,
      symptom: 'خطوط رأسية متوازية (Zipper Artifact) في الصورة.',
      cause:
          'تسرب موجات RF من خارج الغرفة. باب الغرفة مفتوح. جهاز إلكتروني '
          'داخل الغرفة.',
      solution:
          'إغلاق الباب. إزالة أي جهاز إلكتروني. فحص قفص فاراداي.',
      prevention:
          'اختبر الغرفة دورياً. لا تدخل أجهزة إلكترونية. أبقِ الباب مغلقاً.',
    ),
    MedicalError(
      id: 'chemical_shift',
      icon: '🧪',
      title: 'Chemical Shift',
      subtitle: 'خط أسود/أبيض بين الدهون والماء',
      severity: ErrorSeverity.low,
      symptom: 'خط أسود أو أبيض على حدود الدهون والماء.',
      cause:
          'اختلاف ترددات الدهون والماء يسبب انزياحاً في الصورة.',
      solution:
          'استخدم Fat Saturation. تقنيات Dixon.',
      prevention:
          'استخدم التسلسلات الحديثة (Dixon, IDEAL) في المناطق الحرجة.',
    ),
    MedicalError(
      id: 'susceptibility',
      icon: '🧲',
      title: 'Susceptibility Artifact',
      subtitle: 'تشوه قرب المعادن',
      severity: ErrorSeverity.medium,
      symptom: 'تشوه هندسي وخطوط حول معدن أو هواء.',
      cause:
          'اختلاف في القابلية المغناطيسية بين الأنسجة.',
      solution:
          'تقليل TE. استخدام تسلسلات SE بدل GRE. زيادة Bandwidth.',
      prevention:
          'استخدم SE/TSE قرب المعادن. Spine Echo أفضل من GRE.',
    ),
    MedicalError(
      id: 'quench',
      icon: '💨',
      title: 'Quench (انطفاء المغناطيس)',
      subtitle: 'تبخر مفاجئ للهيليوم',
      severity: ErrorSeverity.high,
      symptom:
          'صوت انفجار، ضباب أبيض كثيف، انهيار المجال المغناطيسي.',
      cause:
          'فقدان التوصيل الفائق، خطأ في النظام، أو تفعيل زر Quench.',
      solution:
          'إخلاء الغرفة فوراً. فتح الأبواب. الاتصال بالمهندسين. تحقق '
          'من الأوكسجين.',
      prevention:
          'صيانة دورية. اختبارات منتظمة. تدريب الطاقم. لا تُفعّل Quench '
          'إلا للضرورة القاتلة.',
    ),
    MedicalError(
      id: 'herringbone',
      icon: '🦴',
      title: 'Herringbone Artifact',
      subtitle: 'نمط متعرج في الصورة',
      severity: ErrorSeverity.medium,
      symptom: 'نمط متعرج (Herringbone) في كامل الصورة.',
      cause:
          'Shimming سيء. تدرج المجال غير متجانس.',
      solution:
          'إعادة Shim. تقليل FOV. تحسين التجانس.',
      prevention:
          'شيم نشط قبل كل فحص. تجنب الحالات التي تُفسد التجانس (معدن كبير).',
    ),
    MedicalError(
      id: 'zipper_gradient',
      icon: '⚡',
      title: 'Gradient Artifact',
      subtitle: 'خطوط أفقية من التدرجات',
      severity: ErrorSeverity.medium,
      symptom: 'خطوط أفقية أو عمودية في الصورة.',
      cause:
          'خلل في ملفات التدرج أو Slew Rate مرتفع.',
      solution:
          'تقليل Slew Rate. استخدام تسلسل أقل سرعة. صيانة.',
      prevention:
          'استخدم بروتوكولات مناسبة. صيانة دورية لملفات التدرج.',
    ),
    MedicalError(
      id: 'contrast_reaction',
      icon: '💉',
      title: 'Gadolinium Reaction',
      subtitle: 'حساسية للتباين',
      severity: ErrorSeverity.high,
      symptom:
          'طفح جلدي، غثيان، صعوبة تنفس، انخفاض ضغط، أو رد فعل تأقي.',
      cause:
          'حساسية للـ Gadolinium. فشل كلوي (خطر NSF).',
      solution:
          'إيقاف الحقن فوراً. Adrenaline، Steroids. مراقبة العلامات الحيوية.',
      prevention:
          'قياس eGFR قبل الفحص. السؤال عن حساسية سابقة. توفر أدوية '
          'الطوارئ.',
    ),
  ],
);