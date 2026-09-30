import '../usage_section.dart';

const UsageContent spectUsage = UsageContent(
  intro:
      'خطوات SPECT أبسط من PET — النظير (عادة Tc-99m) عمره أقصر، والفحص '
      'قد يستغرق 30-60 دقيقة. الفحص قد يكون ثابتاً (Static) أو متحركاً (Dynamic).',
  stages: [
    UsageStage(
      icon: '📋',
      title: 'قبل الفحص',
      duration: '10 دقائق',
      steps: [
        UsageStep(icon: '📄', text: 'راجع الطلب: نوع الفحص (عظام، قلب، كلى، غدة...).'),
        UsageStep(icon: '🪪', text: 'تحقق من هوية المريض.'),
        UsageStep(icon: '🤰', text: 'اسأل عن الحمل والرضاعة.'),
        UsageStep(icon: '💊', text: 'تحقق من الأدوية: بعضها يُوقف (مثل Beta-blockers لفحص القلب).'),
        UsageStep(icon: '🍽️', text: 'حسب الفحص: صيام لبعضها، بدون صيام للبعض الآخر.'),
        UsageStep(icon: '💧', text: 'شرب ماء كافٍ — يساعد على طرح النظير.'),
        UsageStep(icon: '📋', text: 'اشرح للمريض: "سنحقن مادة مشعة بسيطة، الفحص قد يستغرق ساعة".'),
      ],
      checklist: [
        'تم التحقق من هوية المريض',
        'تم السؤال عن الحمل والرضاعة',
        'تم مراجعة الأدوية',
        'تم التحقق من الصيام (إن لزم)',
        'تم شرح الإجراء للمريض',
      ],
      expertTips: [
        'للغدة الدرقية: يجب إيقاف أدوية الغدة 4-6 أسابيع قبل.',
        'لمرضى القلب: إيقاف الكافيين 24 ساعة.',
      ],
    ),

    UsageStage(
      icon: '💉',
      title: 'حقن النظير',
      duration: '5 دقائق',
      steps: [
        UsageStep(icon: '🧪', text: 'تحقق من نشاط النظير (Tc-99m من المولد).'),
        UsageStep(icon: '📏', text: 'احسب الجرعة حسب وزن المريض ونوع الفحص.'),
        UsageStep(icon: '💉', text: 'احقن النظير وريدياً — عادة Tc-99m.'),
        UsageStep(icon: '⏱️', text: 'سجّل وقت الحقن بالضبط.'),
        UsageStep(icon: '🧼', text: 'اغسل يديك وتخلّص من المحقنة بأمان.'),
      ],
      commonMistake:
          'خروج النظير خارج الوريد — يفسد التوزيع ويعطي صورة خاطئة.',
      mistakeFix:
          'تأكد من الكانيولا، واستخدم Geiger Counter للتأكد من عدم وجود تسرب.',
      expertTips: [
        'Tc-99m يُحضّر يومياً من المولد — تحقق من Molybdenum Breakthrough.',
        'الجرعة النموذجية: 10-30 mCi حسب الفحص.',
      ],
    ),

    UsageStage(
      icon: '⏱️',
      title: 'فترة الانتظار',
      duration: '1-4 ساعات',
      steps: [
        UsageStep(icon: '🛋️', text: 'المريض ينتظر في غرفة مخصصة — قد تكون مظلمة.'),
        UsageStep(icon: '🚽', text: 'شرب سوائل كثيرة، تفريغ المثانة قبل التصوير.'),
        UsageStep(icon: '⏰', text: 'المدة تعتمد على الفحص:'),
        UsageStep(icon: '🦴', text: 'عظام: 3-4 ساعات (لتراكم النظير في العظام).'),
        UsageStep(icon: '❤️', text: 'قلب: 30-60 دقيقة (مع إجهاد).'),
        UsageStep(icon: '🫘', text: 'كلى: تصوير فوري ومتكرر (ديناميكي).'),
        UsageStep(icon: '🦋', text: 'غدة درقية: 20-30 دقيقة.'),
        UsageStep(icon: '🚫', text: 'تجنّب الحركة الزائدة — قد تزيد Uptake في العضلات.'),
      ],
      expertTips: [
        'فحص العظام: المريض يجب أن يشرب كثيراً ويتبول — يُحسّن الصورة.',
        'لا تضع المريض قرب مرضى آخرين — التلوث الإشعاعي.',
      ],
    ),

    UsageStage(
      icon: '📸',
      title: 'التصوير',
      duration: '20-45 دقيقة',
      steps: [
        UsageStep(icon: '🛏️', text: 'ضع المريض على طاولة كاميرا غاما.'),
        UsageStep(icon: '🎯', text: 'اضبط الكوليماتور المناسب (Parallel, Pinhole...).'),
        UsageStep(icon: '🔄', text: 'إذا كان SPECT: الكاميرا تدور 180-360° حول المريض.'),
        UsageStep(icon: '📐', text: 'إذا كان ثابتاً (Static): صورة واحدة من زاوية محددة.'),
        UsageStep(icon: '⏱️', text: 'المدة تعتمد على عدد الإطارات والنشاط.'),
        UsageStep(icon: '💬', text: 'المريض يبقى ساكناً تماماً — أي حركة تُشوّه الصورة.'),
        UsageStep(icon: '🔊', text: 'استخدم سماعات للتواصل والتوجيه.'),
      ],
      commonMistake:
          'حركة المريض — تُسبب خطوطاً في الصورة (Motion Artifact).',
      mistakeFix:
          'ثبّت المريض بأحزمة لطيفة، وشرح له أهمية عدم الحركة.',
      expertTips: [
        'فحص القلب: يحتاج ECG Gating لتزامن مع النبض.',
        'فحص العظام: قد يحتاج صورتين (أمامي وخلفي).',
        'SPECT: قد يستغرق 20-30 دقيقة دوران الكاميرا.',
      ],
    ),

    UsageStage(
      icon: '✅',
      title: 'بعد الفحص',
      duration: '5 دقائق',
      steps: [
        UsageStep(icon: '🖼️', text: 'راجع الصور: هل Uptake منتظم؟ أي مناطق غير طبيعية؟'),
        UsageStep(icon: '🧮', text: 'احسب النسب (مثل SUV-like ratios) إذا لزم.'),
        UsageStep(icon: '💾', text: 'أرسل الصور إلى PACS.'),
        UsageStep(icon: '💧', text: 'أنصح المريض بشرب سوائل كثيرة.'),
        UsageStep(icon: '🍼', text: 'المرضعات: إيقاف الرضاعة 24 ساعة (Tc-99m).'),
        UsageStep(icon: '👶', text: 'تجنّب التواصل القريب مع الأطفال لعدة ساعات.'),
        UsageStep(icon: '🧽', text: 'نظّف الطاولة والكاميرا، وتحقق بـ Geiger Counter.'),
      ],
      checklist: [
        'تم مراجعة الصور',
        'تم إرسال الصور إلى PACS',
        'تم توجيه المريض بشرب السوائل',
        'تم التحقق من عدم وجود تلوث إشعاعي',
        'تم توثيق الجرعة والوقت',
      ],
      expertTips: [
        'البول مشع لعدة ساعات — نصائح لتفريغ المرحاض جيداً.',
        'المريض لا يمثل خطراً على الآخرين بعد 24 ساعة.',
      ],
    ),
  ],
);