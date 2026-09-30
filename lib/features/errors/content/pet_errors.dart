import '../error_model.dart';

const DeviceErrors petErrors = DeviceErrors(
  deviceId: 'pet',
  intro:
      'أخطاء PET غالباً متعلقة بامتصاص FDG، الحركة، أو التوقيت. بعضها '
      'يُفسد التشخيص كاملاً.',
  errors: [
    MedicalError(
      id: 'high_glucose',
      icon: '🍬',
      title: 'High Blood Glucose',
      subtitle: 'FDG لا يتراكم في الورم',
      severity: ErrorSeverity.high,
      symptom: 'صورة باهتة، الورم غير واضح.',
      cause:
          'سكر الدم > 200 mg/dL. الأنسولين المنافس يمنع دخول FDG للورم.',
      solution:
          'إعادة جدولة الفحص. تأكد من سكر الدم قبل الحقن.',
      prevention:
          'قياس السكر قبل الحقن. صيام 6 ساعات. إيقاف الأنسولين صباحاً.',
    ),
    MedicalError(
      id: 'muscle_uptake',
      icon: '💪',
      title: 'Muscle Uptake',
      subtitle: 'العضلات تستهلك FDG',
      severity: ErrorSeverity.high,
      symptom: 'العضلات ساطعة في الصورة، تُخفي الورم.',
      cause:
          'حركة أو كلام بعد الحقن. مريض متحمس. توتر.',
      solution:
          'إعادة الفحص. غرفة هادئة مظلمة. منع الكلام.',
      prevention:
          'غرفة راحة هادئة. لا كلام، لا حركة، لا مضغ. موسيقى هادئة فقط.',
    ),
    MedicalError(
      id: 'brown_fat',
      icon: '🧊',
      title: 'Brown Fat Uptake',
      subtitle: 'الدهون البنية ساطعة',
      severity: ErrorSeverity.medium,
      symptom: 'مناطق ساطعة في الرقبة والإبطين والمنصف.',
      cause:
          'الدهون البنية تستهلك FDG عند البرد.',
      solution:
          'تسخين المريض. Beta-blocker قبل الفحص. تمييزها عن الورم.',
      prevention:
          'غرفة دافئة. بطانية. تجنّب التبريد.',
    ),
    MedicalError(
      id: 'urinary_uptake',
      icon: '🚽',
      title: 'Urinary Uptake',
      subtitle: 'FDG في المثانة يخفي الأورام',
      severity: ErrorSeverity.medium,
      symptom: 'المثانة ساطعة جداً، قد تُخفي أورام الحوض.',
      cause:
          'FDG يُطرح عبر الكلى ويتجمع في المثانة.',
      solution:
          'تفريغ المثانة قبل التصوير. شرب ماء. Furosemide إذا لزم.',
      prevention:
          'اطلب من المريض تفريغ المثانة قبل التصوير. شرب 1-2 لتر ماء.',
    ),
    MedicalError(
      id: 'extravasation',
      icon: '💉',
      title: 'FDG Extravasation',
      subtitle: 'تسرب FDG خارج الوريد',
      severity: ErrorSeverity.high,
      symptom: 'انتفاخ موضعي، بقعة ساطعة في موقع الحقن.',
      cause:
          'الكانيولا خارج الوريد. ثقب الوريد.',
      solution:
          'إيقاف الحقن. إعادة الحقن في ذراع آخر. حساب الجرعة الفعلية.',
      prevention:
          'تأكد من الكانيولا بـ Saline أولاً. خبرة في الحقن.',
    ),
    MedicalError(
      id: 'brain_uptake',
      icon: '🧠',
      title: 'Normal Brain Uptake',
      subtitle: 'الدماغ ساطع جداً',
      severity: ErrorSeverity.low,
      symptom: 'الدماغ ساطع — يُخفي النقائل الصغيرة.',
      cause:
          'الدماغ طبيعياً عالي الأيض (10% من FDG).',
      solution:
          'لا علاج. البلورات المميزة للنقائل تُرى بالتكبير.',
      prevention:
          'لازم تعرف النمط الطبيعي للدماغ. النقائل عادة في الأطراف.',
    ),
    MedicalError(
      id: 'misregistration',
      icon: '🎯',
      title: 'PET/CT Misregistration',
      subtitle: 'عدم تطابق بين PET و CT',
      severity: ErrorSeverity.medium,
      symptom: 'الصورة المدمجة تظهر السرطان في موضع خاطئ.',
      cause:
          'حركة المريض بين CT و PET. تنفس مختلف.',
      solution:
          'إعادة الفحص. Gating للتنفس. تصحيح برمجي.',
      prevention:
          'لا تتحرك المريض. استخدم نفس الوضع. Gating للصدر والبطن.',
    ),
    MedicalError(
      id: 'inflammation_uptake',
      icon: '🔥',
      title: 'Inflammation Uptake',
      subtitle: 'التهابات تظهر كسرطانات',
      severity: ErrorSeverity.medium,
      symptom: 'مناطق ساطعة في الالتهابات — يُفهم خطأً كورم.',
      cause:
          'خلايا المناعة تستهلك FDG بكثافة أيضاً.',
      solution:
          'التمييز بالسياق السريري. مقارنة مع CT/MRI. قد يحتاج Biopsy.',
      prevention:
          'اعرف التاريخ الطبي (جراحات حديثة، التهابات). افحص SUV بدقة.',
    ),
  ],
);