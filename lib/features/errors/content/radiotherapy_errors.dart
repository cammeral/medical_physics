import '../error_model.dart';

const DeviceErrors radiotherapyErrors = DeviceErrors(
  deviceId: 'rt',
  intro:
      'أخطاء العلاج الإشعاعي خطيرة — قد تؤدي لجرعات خاطئة. كل خطأ يحتاج '
      'تحقيقاً فورياً.',
  errors: [
    MedicalError(
      id: 'wrong_plan',
      icon: '📋',
      title: 'Wrong Plan (خطة خاطئة)',
      subtitle: 'جرعة لمريض آخر',
      severity: ErrorSeverity.high,
      symptom:
          'المريض يتلقى جرعة خطة مريض آخر. تشوه في الجرعة.',
      cause:
          'خطأ في إدخال بيانات المريض. عدم التحقق المزدوج.',
      solution:
          'إيقاف الجلسة فوراً. إخطار الفيزيائي الطبي. توثيق الحادث.',
      prevention:
          'تحقق مزدوج. باركود لكل مريض. نظام إلكتروني آمن.',
    ),
    MedicalError(
      id: 'position_error',
      icon: '🎯',
      title: 'Position Error',
      subtitle: 'المريض في وضع خاطئ',
      severity: ErrorSeverity.high,
      symptom: 'الجرعة تصل للأعضاء السليمة بدلاً من الورم.',
      cause:
          'القوالب غير مثبتة. IGRT لم يُجرَ. المريض تحرك.',
      solution:
          'إعادة التثبيت. IGRT إلزامي. تصحيح الوضع.',
      prevention:
          'IGRT يومي. تحقق من الوشم. قوالب دقيقة.',
    ),
    MedicalError(
      id: 'machine_error',
      icon: '⚡',
      title: 'Machine Malfunction',
      subtitle: 'خلل في LINAC',
      severity: ErrorSeverity.high,
      symptom:
          'توقف مفاجئ. جرعة غير دقيقة. صوت غير طبيعي.',
      cause:
          'خلل كهربائي. مشكلة في الـ MLC. تسرب في الميكروويف.',
      solution:
          'إيقاف فوري. الاتصال بالصيانة. QA شامل.',
      prevention:
          'QA يومي. صيانة دورية. مراقبة الأداء.',
    ),
    MedicalError(
      id: 'dose_calc',
      icon: '🧮',
      title: 'Dose Calculation Error',
      subtitle: 'حساب خاطئ للجرعة',
      severity: ErrorSeverity.high,
      symptom:
          'DVH غير منطقي. الجرعة أعلى/أقل من المتوقع.',
      cause:
          'خطأ في الـ TPS. بيانات CT غير دقيقة. Contouring خاطئ.',
      solution:
          'إعادة الحساب. مراجعة الفيزيائي. QA جديد.',
      prevention:
          'مراجعة مزدوجة. QA قبل الجلسة. تدريب مستمر.',
    ),
    MedicalError(
      id: 'shielding_fail',
      icon: '🧱',
      title: 'Shielding Failure',
      subtitle: 'تسرب إشعاعي',
      severity: ErrorSeverity.high,
      symptom:
          'قياس إشعاع خارج الغرفة. تحذيرات من أجهزة القياس.',
      cause:
          'شقوق في الجدران أو الباب. صيانة غير مناسبة.',
      solution:
          'إيقاف العلاج. فحص الغرفة. إصلاح فوري.',
      prevention:
          'فحص دوري. صيانة سنوية. إعادة القياس بعد كل تعديل.',
    ),
    MedicalError(
      id: 'brachy_source',
      icon: '💉',
      title: 'Brachytherapy Source Loss',
      subtitle: 'فقدان مصدر مشع',
      severity: ErrorSeverity.high,
      symptom:
          'مصدر لم يعد للـ Afterloader. المريض قد يكون يحمل مصدراً.',
      cause:
          'خلل في Afterloader. انحشار المصدر في القسطرة.',
      solution:
          'إيقاف البرنامج. فحص المريض بـ Geiger. إخراج المصدر بأمان.',
      prevention:
          'فحص Afterloader قبل الاستخدام. مراقبة الفيديو.',
    ),
    MedicalError(
      id: 'skin_reaction',
      icon: '🔥',
      title: 'Severe Skin Reaction',
      subtitle: 'حرق جلدي شديد',
      severity: ErrorSeverity.medium,
      symptom:
          'احمرار شديد، تقشّر، أو تقرّح جلدي في منطقة العلاج.',
      cause:
          'جرعة عالية للجلد. تكرار. حساسية فردية.',
      solution:
          'علاج الجلد. تأخير الجلسات إن لزم. تعديل الخطة.',
      prevention:
          'راقب الجلد أسبوعياً. كريمات واقية. تقليل الجرعة الجلدية.',
    ),
    MedicalError(
      id: 'secondary_cancer',
      icon: '⚠️',
      title: 'Secondary Cancer Risk',
      subtitle: 'سرطان ثانوي بعيد المدى',
      severity: ErrorSeverity.medium,
      symptom:
          'سرطان جديد بعد 5-20 سنة في منطقة العلاج.',
      cause:
          'جرعة إشعاعية على الأنسجة السليمة. خاصة في المرضى الصغار.',
      solution:
          'علاج مبكر. متابعة طويلة.',
      prevention:
          'IMRT/VMAT لجرعات أقل للأنسجة. Proton للأطفال. متابعة طويلة.',
    ),
  ],
);