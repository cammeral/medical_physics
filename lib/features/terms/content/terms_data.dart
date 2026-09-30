import '../term_model.dart';

const List<Term> allTerms = [
  // ═══════════════════════════════════════════════════
  //  أساسيات الفيزياء
  // ═══════════════════════════════════════════════════
  Term(
    english: 'Ionizing Radiation',
    arabic: 'الإشعاع المؤيِّن',
    description:
        'إشعاع يحمل طاقة كافية لطرد إلكترون من الذرة وتحويلها إلى أيون. '
        'يشمل الأشعة السينية وغاما والجسيمات (ألفا، بيتا، نيوترون). '
        'خطير على الأنسجة الحيوية لكنه أساس التصوير الطبي.',
    category: TermCategory.physics,
  ),
  Term(
    english: 'Non-Ionizing Radiation',
    arabic: 'الإشعاع غير المؤيِّن',
    description:
        'إشعاع طاقته غير كافية لتأيين الذرات. يشمل الموجات الراديوية، '
        'الميكروويف، الأشعة تحت الحمراء، الضوء المرئي، الأشعة فوق البنفسجية. '
        'يشمل الموجات الصوتية أيضاً.',
    category: TermCategory.physics,
  ),
  Term(
    english: 'Electromagnetic Radiation',
    arabic: 'الإشعاع الكهرومغناطيسي',
    abbreviation: 'EM',
    description:
        'موجات تنتقل عبر الفراغ بسرعة الضوء. تشمل طيفاً واسعاً من الموجات '
        'الراديوية إلى أشعة غاما. تُوصف بالطول الموجي (λ) أو التردد (f) '
        'أو الطاقة (E).',
    category: TermCategory.physics,
  ),
  Term(
    english: 'Photon',
    arabic: 'الفوتون',
    description:
        'كم الطاقة للإشعاع الكهرومغناطيسي. جسيم بلا كتلة ينتقل بسرعة الضوء. '
        'طاقته تتناسب مع تردده: E = h·f، حيث h ثابت بلانك.',
    category: TermCategory.physics,
  ),
  Term(
    english: 'Wavelength',
    arabic: 'الطول الموجي',
    description:
        'المسافة بين قمتين متتاليتين في الموجة. يُرمز له بـ λ ويُقاس '
        'بالمتر أو أجزائه. علاقته بالطاقة: كلما قصر الطول الموجي زادت الطاقة.',
    category: TermCategory.physics,
  ),
  Term(
    english: 'Frequency',
    arabic: 'التردد',
    description:
        'عدد الذبذبات في الثانية. يُقاس بالهرتز (Hz). علاقته بالطاقة: '
        'E = h·f. كلما زاد التردد زادت الطاقة.',
    category: TermCategory.physics,
  ),
  Term(
    english: "Planck's Constant",
    arabic: 'ثابت بلانك',
    abbreviation: 'h',
    description:
        'ثابت فيزيائي أساسي = 6.626 × 10⁻³⁴ J·s. يربط طاقة الفوتون '
        'بتردده في المعادلة E = h·f. أساس ميكانيكا الكم.',
    category: TermCategory.physics,
  ),
  Term(
    english: 'Half-Life',
    arabic: 'عمر النصف',
    abbreviation: 'T½',
    description:
        'الزمن اللازم لاضمحلال نصف ذرات المادة المشعة. يختلف من نظير لآخر: '
        'Tc-99m = 6 ساعات، F-18 = 110 دقيقة، I-131 = 8 أيام. '
        'قانون الاضمحلال: N(t) = N₀·e^(-λt).',
    category: TermCategory.physics,
  ),
  Term(
    english: 'Radioactive Decay',
    arabic: 'الاضمحلال الإشعاعي',
    description:
        'تحول تلقائي لنواة غير مستقرة إلى نواة أكثر استقراراً بإصدار '
        'إشعاع. أنواعه: ألفا (α)، بيتا (β)، غاما (γ).',
    category: TermCategory.physics,
  ),
  Term(
    english: 'Bremsstrahlung',
    arabic: 'إشعاع الكبح',
    description:
        'إشعاع سيني ينتج عندما يُبطئ إلكترون سريع فجأة عند اصطدامه بهدف '
        'معدني. يحوّل جزءاً من الطاقة الحركية إلى فوتون. أساس طيف '
        'الأشعة السينية.',
    category: TermCategory.physics,
  ),
  Term(
    english: 'Characteristic Radiation',
    arabic: 'الإشعاع المميز',
    description:
        'إشعاع سيني بطاقة محددة ينتج عندما يُطرد إلكترون مداري من ذرة '
        'الهدف، فيحل مكانه إلكترون من مستوى أعلى ويُطلق فوتوناً بطاقة '
        'مميزة للعنصر.',
    category: TermCategory.physics,
  ),
  Term(
    english: 'Attenuation',
    arabic: 'التوهين',
    description:
        'نقصان شدة الإشعاع عند مروره في المادة بسبب الامتصاص والتشتت. '
        'يُوصف بقانون Beer-Lambert: I = I₀·e^(-μx).',
    category: TermCategory.physics,
  ),
  Term(
    english: 'Linear Attenuation Coefficient',
    arabic: 'معامل التوهين الخطي',
    abbreviation: 'μ',
    description:
        'مقياس لاحتمال توهين الإشعاع في وحدة الطول من المادة. يعتمد على '
        'الطاقة والكثافة والعدد الذري للمادة. وحدته cm⁻¹.',
    category: TermCategory.physics,
  ),
  Term(
    english: 'Half-Value Layer',
    arabic: 'نصف طبقة الامتصاص',
    abbreviation: 'HVL',
    description:
        'سماكة المادة اللازمة لتقليل شدة الإشعاع إلى النصف. تُستخدم في '
        'معايرة أجهزة الأشعة. علاقتها بمعامل التوهين: HVL = 0.693/μ.',
    category: TermCategory.physics,
  ),

  // ═══════════════════════════════════════════════════
  //  الوحدات والقياسات
  // ═══════════════════════════════════════════════════
  Term(
    english: 'Gray',
    arabic: 'جراي',
    abbreviation: 'Gy',
    description:
        'وحدة الجرعة الممتصة في النظام الدولي. 1 Gy = 1 جول لكل كيلوغرام '
        'من النسيج. الوحدة القديمة: Rad (1 Gy = 100 Rad).',
    category: TermCategory.units,
  ),
  Term(
    english: 'Sievert',
    arabic: 'سيفرت',
    abbreviation: 'Sv',
    description:
        'وحدة الجرعة المكافئة (للتأثير البيولوجي). H = D × w_R. '
        'الوحدة القديمة: Rem (1 Sv = 100 Rem). للطاقم: 20 mSv/سنة.',
    category: TermCategory.units,
  ),
  Term(
    english: 'Becquerel',
    arabic: 'بيكريل',
    abbreviation: 'Bq',
    description:
        'وحدة النشاط الإشعاعي = اضمحلال واحد في الثانية. الوحدة القديمة: '
        'كوري (Ci)، 1 Ci = 37 GBq.',
    category: TermCategory.units,
  ),
  Term(
    english: 'Curie',
    arabic: 'كوري',
    abbreviation: 'Ci',
    description:
        'وحدة قديمة للنشاط الإشعاعي = 3.7 × 10¹⁰ اضمحلال/ثانية. '
        'تُستخدم أحياناً في الطب النووي. 1 Ci = 37 GBq.',
    category: TermCategory.units,
  ),
  Term(
    english: 'Rad',
    arabic: 'راد',
    abbreviation: 'Rad',
    description:
        'وحدة قديمة للجرعة الممتصة = 0.01 Gy. اختصار لـ "Radiation Absorbed '
        'Dose".',
    category: TermCategory.units,
  ),
  Term(
    english: 'Rem',
    arabic: 'ريم',
    abbreviation: 'Rem',
    description:
        'وحدة قديمة للجرعة المكافئة = 0.01 Sv. اختصار لـ "Roentgen '
        'Equivalent Man".',
    category: TermCategory.units,
  ),
  Term(
    english: 'Roentgen',
    arabic: 'رونتجن',
    abbreviation: 'R',
    description:
        'وحدة قديمة للتعرض الإشعاعي. 1 R = 2.58 × 10⁻⁴ C/kg. '
        'سميت نسبة لمكتشف الأشعة السينية.',
    category: TermCategory.units,
  ),
  Term(
    english: 'Electron Volt',
    arabic: 'إلكترون فولت',
    abbreviation: 'eV',
    description:
        'وحدة طاقة صغيرة = 1.602 × 10⁻¹⁹ جول. تُستخدم لوصف طاقة الفوتونات '
        'والجسيمات. keV = 1000 eV، MeV = مليون eV.',
    category: TermCategory.units,
  ),
  Term(
    english: 'Effective Dose',
    arabic: 'الجرعة الفعالة',
    abbreviation: 'E',
    description:
        'جرعة تأخذ في الحسبان حساسية كل عضو. E = Σ (H_T × w_T). '
        'تُقاس بـ mSv. تُستخدم للمقارنة بين الفحوصات.',
    category: TermCategory.units,
  ),
  Term(
    english: 'Dose Area Product',
    arabic: 'حاصل ضرب الجرعة في المساحة',
    abbreviation: 'DAP',
    description:
        'مقياس الجرعة في الفلوروسكوبي = الجرعة × مساحة الحزمة. '
        'وحدته: mGy·cm². يُستخدم لتقدير الجرعة الفعالة.',
    category: TermCategory.units,
  ),
  Term(
    english: 'CTDIvol',
    arabic: 'مؤشر الجرعة في CT',
    abbreviation: 'CTDIvol',
    description:
        'مقياس الجرعة الحجمي في CT. وحدته mGy. يُسجل مع كل فحص '
        'لمقارنة الجرعة بـ DRL.',
    category: TermCategory.units,
  ),
  Term(
    english: 'Dose Length Product',
    arabic: 'حاصل ضرب الجرعة في الطول',
    abbreviation: 'DLP',
    description:
        'مقياس الجرعة الكلي في CT = CTDIvol × طول المنطقة. '
        'وحدته mGy·cm. يُستخدم لحساب الجرعة الفعالة.',
    category: TermCategory.units,
  ),

  // ═══════════════════════════════════════════════════
  //  الأشعة السينية
  // ═══════════════════════════════════════════════════
  Term(
    english: 'X-ray Tube',
    arabic: 'أنبوب الأشعة السينية',
    description:
        'أنبوب مفرَّغ من الهواء يحتوي على مهبط (Cathode) ومصعد (Anode). '
        'تُنتج الأشعة عند اصطدام الإلكترونات بالهدف. قلب جهاز X-ray.',
    category: TermCategory.xray,
  ),
  Term(
    english: 'Cathode',
    arabic: 'المهبط',
    description:
        'القطب السالب في أنبوب X-ray. يحتوي على سلك تسخين من التنغستن '
        'يُطلق إلكترونات (Thermionic Emission) عند تسخينه.',
    category: TermCategory.xray,
  ),
  Term(
    english: 'Anode',
    arabic: 'المصعد',
    description:
        'القطب الموجب في أنبوب X-ray. هدف معدني (عادة تنغستن) تُصطدم به '
        'الإلكترونات لإنتاج الأشعة السينية. يدور بسرعة لتوزيع الحرارة.',
    category: TermCategory.xray,
  ),
  Term(
    english: 'Focal Spot',
    arabic: 'البقعة البؤرية',
    description:
        'نقطة اصطدام الإلكترونات بالمصعد. حجمها صغير (0.1-2 mm) لزيادة '
        'دقة الصورة. بقعة صغيرة = دقة أعلى لكن حرارة أعلى.',
    category: TermCategory.xray,
  ),
  Term(
    english: 'Kilovoltage Peak',
    arabic: 'ذروة الكيلو فولت',
    abbreviation: 'kVp',
    description:
        'أقصى جهد كهربائي مطبق على أنبوب الأشعة. يحدد طاقة الفوتونات '
        'وقدرتها على الاختراق. للتشخيص: 60-120 kVp.',
    category: TermCategory.xray,
  ),
  Term(
    english: 'Milliampere-Second',
    arabic: 'ملي أمبير-ثانية',
    abbreviation: 'mAs',
    description:
        'حاصل ضرب التيار (mA) في الزمن (s). يحدد عدد الفوتونات المنتجة '
        '(شدة الأشعة). زيادة mAs = صورة أوضح لكن جرعة أعلى.',
    category: TermCategory.xray,
  ),
  Term(
    english: 'Collimator',
    arabic: 'الكوليماتور',
    description:
        'جهاز لتحديد شكل وحجم حزمة الأشعة. شرائح رصاصية قابلة للتحرك. '
        'يقلل الجرعة على المريض ويحسّن جودة الصورة.',
    category: TermCategory.xray,
  ),
  Term(
    english: 'Radiopaque',
    arabic: 'عاكس للأشعة (أبيض)',
    description:
        'وصف للأنسجة أو المواد التي تمتص الأشعة السينية بقوة وتظهر بيضاء '
        'على الصورة. مثل: العظام، المعادن، التباين.',
    category: TermCategory.xray,
  ),
  Term(
    english: 'Radiolucent',
    arabic: 'نافذ للأشعة (أسود)',
    description:
        'وصف للأنسجة أو المواد التي تمرر الأشعة السينية وتظهر داكنة على '
        'الصورة. مثل: الهواء، الرئة، الدهون.',
    category: TermCategory.xray,
  ),
  Term(
    english: 'Automatic Exposure Control',
    arabic: 'التحكم التلقائي في التعرض',
    abbreviation: 'AEC',
    description:
        'نظام يوقف التعرض تلقائياً عند وصول الكاشف للكثافة المطلوبة. '
        'يقلل الجرعة ويتجنب إعادة التصوير.',
    category: TermCategory.xray,
  ),
  Term(
    english: 'Grid',
    arabic: 'الشبكة المضادة للتشتت',
    description:
        'شبكة من شرائح رصاصية دقيقة تحجب الأشعة المشتتة (Scatter) وتحسّن '
        'التباين. تُستخدم لسماكات > 10 cm.',
    category: TermCategory.xray,
  ),

  // ═══════════════════════════════════════════════════
  //  CT
  // ═══════════════════════════════════════════════════
  Term(
    english: 'Hounsfield Unit',
    arabic: 'وحدة هاونسفيلد',
    abbreviation: 'HU',
    description:
        'مقياس لامتصاص الأشعة في CT. الماء = 0 HU، الهواء = -1000 HU، '
        'العظام = +1000 HU. تُمكّن من التمييز بين الأنسجة.',
    category: TermCategory.ct,
  ),
  Term(
    english: 'Gantry',
    arabic: 'الهيكل الدوّار',
    description:
        'الجزء الحلقي الكبير في CT الذي يحمل الأنبوب والكواشف ويدور حول '
        'المريض. سرعته 0.3-1 ثانية للدورة.',
    category: TermCategory.ct,
  ),
  Term(
    english: 'Pitch',
    arabic: 'الخطوة',
    description:
        'في CT الحلزوني: نسبة حركة الطاولة لكل دورة. Pitch = 1 توازن، '
        'Pitch > 1 أسرع وجرعة أقل، Pitch < 1 أدق.',
    category: TermCategory.ct,
  ),
  Term(
    english: 'Slice Thickness',
    arabic: 'سماكة الشريحة',
    description:
        'سماكة الطبقة المصوّرة في CT. من 0.5 mm (دقة عالية) إلى 10 mm '
        '(تغطية أوسع). تؤثر على الدقة والضوضاء.',
    category: TermCategory.ct,
  ),
  Term(
    english: 'Filtered Back Projection',
    arabic: 'الإسقاط الخلفي المُرشَّح',
    abbreviation: 'FBP',
    description:
        'خوارزمية إعادة البناء الكلاسيكية في CT. سريعة لكن ضوضاؤها عالية '
        'في الجرعات المنخفضة.',
    category: TermCategory.ct,
  ),
  Term(
    english: 'Iterative Reconstruction',
    arabic: 'إعادة البناء التكرارية',
    abbreviation: 'IR',
    description:
        'خوارزمية حديثة تُحسّن الصورة تدريجياً. جودة أعلى بجرعة أقل. '
        'أنواع: ASIR، iDose، SAFIRE، ADMIRE.',
    category: TermCategory.ct,
  ),
  Term(
    english: 'Multi-Slice CT',
    arabic: 'التصوير المقطعي متعدد الشرائح',
    abbreviation: 'MSCT',
    description:
        'CT بأكثر من صف كواشف (16، 64، 128، 256، 320). يُصوّر عدة شرائح '
        'في نفس الدوران. أسرع وأدق من Single-Slice.',
    category: TermCategory.ct,
  ),
  Term(
    english: 'Window/Level',
    arabic: 'النافذة والمستوى',
    description:
        'ضبط عرض ومركز درجات الرمادي في CT. نافذة الرئة (W: 1500)، '
        'نافذة العظام (W: 2000)، نافذة الدماغ (W: 80).',
    category: TermCategory.ct,
  ),
  Term(
    english: 'Multi-Planar Reconstruction',
    arabic: 'إعادة البناء متعددة المستويات',
    abbreviation: 'MPR',
    description:
        'إعادة بناء الصور المقطعية في مستويات مختلفة: Axial، Coronal، '
        'Sagittal، Oblique. من بيانات CT الأصلية.',
    category: TermCategory.ct,
  ),
  Term(
    english: 'CT Angiography',
    arabic: 'تصوير الأوعية بالـ CT',
    abbreviation: 'CTA',
    description:
        'CT مع تباين وريدي لعرض الشرايين. بديل أقل توغلاً من القسطرة. '
        'يُستخدم للشرايين التاجية والدماغية والرئوية.',
    category: TermCategory.ct,
  ),

  // ═══════════════════════════════════════════════════
  //  MRI
  // ═══════════════════════════════════════════════════
  Term(
    english: 'Larmor Frequency',
    arabic: 'تردد لارمور',
    description:
        'تردد دوران البروتون في المجال المغناطيسي. ω₀ = γ·B₀. '
        'عند 1.5 T = 63.87 MHz، عند 3 T = 127.74 MHz.',
    category: TermCategory.mri,
  ),
  Term(
    english: 'Gyromagnetic Ratio',
    arabic: 'النسبة الجيرومغناطيسية',
    abbreviation: 'γ',
    description:
        'ثابت لكل نواة يربط بين تردد لارمور والمجال. للبروتون: '
        '42.58 MHz/T. أساس معادلة لارمور.',
    category: TermCategory.mri,
  ),
  Term(
    english: 'T1 Relaxation',
    arabic: 'الاسترخاء الطولي T1',
    description:
        'زمن عودة المغناطيسية الطولية إلى 63% من قيمتها. يُسمى أيضاً '
        'Spin-Lattice Relaxation. الدهون T1 قصير (ساطعة)، الماء T1 طويل (داكن).',
    category: TermCategory.mri,
  ),
  Term(
    english: 'T2 Relaxation',
    arabic: 'الاسترخاء العرضي T2',
    description:
        'زمن اضمحلال المغناطيسية العرضية إلى 37%. يُسمى أيضاً Spin-Spin '
        'Relaxation. الماء T2 طويل (ساطع)، الأنسجة الصلبة T2 قصير.',
    category: TermCategory.mri,
  ),
  Term(
    english: 'Gradient Coils',
    arabic: 'ملفات التدرج',
    description:
        'ثلاثة ملفات (X, Y, Z) تُولّد مجالات متغيرة تُضاف إلى B₀. '
        'تشفير مكاني لتحديد موقع الإشارة. تصل إلى 80 mT/m.',
    category: TermCategory.mri,
  ),
  Term(
    english: 'Radiofrequency Coil',
    arabic: 'ملف التردد الراديوي',
    abbreviation: 'RF Coil',
    description:
        'هوائي يُرسل نبضات RF لإثارة البروتونات (Transmit) أو يستقبل '
        'الإشارة (Receive). أنواع: Body، Head، Surface، Phased Array.',
    category: TermCategory.mri,
  ),
  Term(
    english: 'K-space',
    arabic: 'الفضاء K',
    description:
        'مصفوفة تخزين البيانات في MRI قبل إعادة البناء. تحويل فورييه '
        'يحوّلها إلى صورة. مركزها = التباين، أطرافها = التفاصيل.',
    category: TermCategory.mri,
  ),
  Term(
    english: 'Fast Fourier Transform',
    arabic: 'تحويل فورييه السريع',
    abbreviation: 'FFT',
    description:
        'خوارزمية رياضية تحوّل بيانات K-space إلى صورة في MRI. '
        'أساس إعادة البناء.',
    category: TermCategory.mri,
  ),
  Term(
    english: 'Repetition Time',
    arabic: 'زمن التكرار',
    abbreviation: 'TR',
    description:
        'الزمن بين نبضتين RF متتاليتين. TR قصير = T1-weighted، '
        'TR طويل = T2-weighted أو Proton Density.',
    category: TermCategory.mri,
  ),
  Term(
    english: 'Echo Time',
    arabic: 'زمن الصدى',
    abbreviation: 'TE',
    description:
        'الزمن بين نبضة RF وذروة الإشارة المستقبلة. TE قصير = T1-weighted، '
        'TE طويل = T2-weighted.',
    category: TermCategory.mri,
  ),
  Term(
    english: 'Quench',
    arabic: 'انطفاء المغناطيس',
    description:
        'فقدان مفاجئ للتوصيل الفائق في MRI، يتبخر الهيليوم بسرعة 700 ضعف. '
        'خطر اختناق. حادثة قاتلة موثقة.',
    category: TermCategory.mri,
  ),
  Term(
    english: 'Faraday Cage',
    arabic: 'قفص فاراداي',
    description:
        'غرفة MRI مبطنة بشبكة نحاسية تحجب موجات RF الخارجية. بدونها '
        'تفسد الإشارة. حتى الهاتف المحمول يُفسد الصورة.',
    category: TermCategory.mri,
  ),
  Term(
    english: 'Specific Absorption Rate',
    arabic: 'معدل الامتصاص النوعي',
    abbreviation: 'SAR',
    description:
        'مقياس الطاقة الممتصة من RF لكل kg نسيج (W/kg). يُراقب لتجنب '
        'تسخين المريض. الحد: < 4 W/kg لكل الجسم.',
    category: TermCategory.mri,
  ),

  // ═══════════════════════════════════════════════════
  //  Ultrasound
  // ═══════════════════════════════════════════════════
  Term(
    english: 'Piezoelectric Effect',
    arabic: 'التأثير الكهروضغطي',
    description:
        'خاصية مزدوجة لبعض البلورات: تتقلص عند تطبيق جهد كهربائي، وتولّد '
        'جهداً عند ضغطها. أساس عمل المسبار في Ultrasound.',
    category: TermCategory.ultrasound,
  ),
  Term(
    english: 'Transducer',
    arabic: 'المسبار',
    description:
        'جهاز Ultrasound الذي يُرسل الموجات الصوتية ويستقبلها. يحتوي على '
        'بلورة كهروضغطية. أنواع: Linear، Curved، Phased، Endocavity.',
    category: TermCategory.ultrasound,
  ),
  Term(
    english: 'Acoustic Impedance',
    arabic: 'المعاوقة الصوتية',
    abbreviation: 'Z',
    description:
        'مقاومة النسيج لمرور الموجات الصوتية. Z = الكثافة × السرعة. '
        'اختلافها بين نسيجين يحدد شدة الانعكاس.',
    category: TermCategory.ultrasound,
  ),
  Term(
    english: 'Doppler Effect',
    arabic: 'تأثير دوبلر',
    description:
        'تغير تردد الموجة عند انعكاسها من جسم متحرك. يُستخدم لقياس سرعة '
        'الدم واتجاهه في الأوعية الدموية.',
    category: TermCategory.ultrasound,
  ),
  Term(
    english: 'B-mode',
    arabic: 'النمط B',
    abbreviation: 'Brightness Mode',
    description:
        'النمط الأكثر استخداماً في Ultrasound. يُظهر الصورة كدرجات رمادية '
        'حيث السطوع يمثل شدة الإشارة.',
    category: TermCategory.ultrasound,
  ),
  Term(
    english: 'M-mode',
    arabic: 'النمط M',
    abbreviation: 'Motion Mode',
    description:
        'نمط Ultrasound يعرض حركة الأنسجة بمرور الزمن. يُستخدم للقلب '
        'والصمامات.',
    category: TermCategory.ultrasound,
  ),
  Term(
    english: 'Thermal Index',
    arabic: 'المؤشر الحراري',
    abbreviation: 'TI',
    description:
        'مؤشر لتسخين الأنسجة من Ultrasound. يجب أن يبقى < 1.0. '
        'أنواع: TIS (ناعم)، TIB (عظم)، TIC (جمجمة).',
    category: TermCategory.ultrasound,
  ),
  Term(
    english: 'Mechanical Index',
    arabic: 'المؤشر الميكانيكي',
    abbreviation: 'MI',
    description:
        'مؤشر لخطر التجويف (Cavitation) من Ultrasound. يجب أن يبقى < 1.0. '
        'مهم في فحوصات العين والجنين.',
    category: TermCategory.ultrasound,
  ),
  Term(
    english: 'Time Gain Compensation',
    arabic: 'تعويض الكسب الزمني',
    abbreviation: 'TGC',
    description:
        'تصحيح تلقائي أو يدوي لضعف الإشارة مع العمق. مقابض تُضبط لكل '
        'منطقة عمق.',
    category: TermCategory.ultrasound,
  ),

  // ═══════════════════════════════════════════════════
  //  الطب النووي
  // ═══════════════════════════════════════════════════
  Term(
    english: 'Radiopharmaceutical',
    arabic: 'المستحضر الإشعاعي',
    description:
        'مادة مشعة مرتبطة بجزيء حيوي. تُحقن في المريض لتتراكم في عضو '
        'معين. أمثلة: FDG (أورام)، Tc-99m-MDP (عظام).',
    category: TermCategory.nuclear,
  ),
  Term(
    english: 'Positron Emission Tomography',
    arabic: 'التصوير البوزيتروني',
    abbreviation: 'PET',
    description:
        'تصوير نووي وظيفي يكشف نشاط الأيض. يستخدم F-18 FDG. يُدمج عادة '
        'مع CT (PET/CT). يُظهر السرطان كبقعة ساطعة.',
    category: TermCategory.nuclear,
  ),
  Term(
    english: 'Single Photon Emission CT',
    arabic: 'التصوير المقطعي بإصدار فوتون واحد',
    abbreviation: 'SPECT',
    description:
        'تصوير نووي يستخدم Tc-99m. يكشف فوتون غاما واحد لكل اضمحلال. '
        'أرخص من PET وأوسع استخداماً.',
    category: TermCategory.nuclear,
  ),
  Term(
    english: 'Annihilation',
    arabic: 'الفناء',
    description:
        'التقاء بوزيترون بإلكترون وتحولهما إلى فوتوني غاما بطاقة 511 keV '
        'ينطلقان بزاوية 180°. أساس PET.',
    category: TermCategory.nuclear,
  ),
  Term(
    english: 'Coincidence Detection',
    arabic: 'الكشف التوافقي',
    description:
        'في PET: التقاط فوتونين متعاكسين في نفس اللحظة (نافذة 6-12 ns). '
        'يُحدد خط الاستجابة (LOR) لموقع الفناء.',
    category: TermCategory.nuclear,
  ),
  Term(
    english: 'Line of Response',
    arabic: 'خط الاستجابة',
    abbreviation: 'LOR',
    description:
        'الخط الواصل بين كاشفين في PET. موقع الفناء يقع عليه. '
        'آلاف الخطوط تُستخدم لإعادة بناء الصورة.',
    category: TermCategory.nuclear,
  ),
  Term(
    english: 'Standardized Uptake Value',
    arabic: 'قيمة الامتصاص المعيارية',
    abbreviation: 'SUV',
    description:
        'مقياس كمي لامتصاص FDG في PET. SUV > 2.5 يشير للاشتباه '
        'بالسرطان. يُتابع الاستجابة للعلاج.',
    category: TermCategory.nuclear,
  ),
  Term(
    english: 'Fluorodeoxyglucose',
    arabic: 'فلورو ديوكسي جلوكوز',
    abbreviation: 'FDG',
    description:
        'الجلوكوز المشع (F-18 FDG). الأكثر استخداماً في PET. '
        'الخلايا عالية الأيض (السرطانية) تستهلكه بكثرة.',
    category: TermCategory.nuclear,
  ),
  Term(
    english: 'Technetium-99m',
    arabic: 'تكنيشيوم-99م',
    abbreviation: 'Tc-99m',
    description:
        'النظير الأكثر استخداماً في الطب النووي (~80%). عمر النصف 6 ساعات. '
        'طاقة غاما 140 keV. يُنتج من مولد Mo-99/Tc-99m.',
    category: TermCategory.nuclear,
  ),
  Term(
    english: 'Gamma Camera',
    arabic: 'كاميرا غاما',
    description:
        'جهاز التصوير في SPECT. تحتوي على كوليماتور، بلورة NaI(Tl)، '
        'ومصفوفة PMT. تلتقط فوتونات غاما من المريض.',
    category: TermCategory.nuclear,
  ),
  Term(
    english: 'Cyclotron',
    arabic: 'السيكلوترون',
    description:
        'مُعجّل دوراني يُنتج النظائر المشعة قصيرة العمر (F-18، C-11). '
        'موجود في المستشفيات الكبيرة أو مراكز قريبة.',
    category: TermCategory.nuclear,
  ),

  // ═══════════════════════════════════════════════════
  //  العلاج الإشعاعي
  // ═══════════════════════════════════════════════════
  Term(
    english: 'Linear Accelerator',
    arabic: 'المُعجّل الخطي',
    abbreviation: 'LINAC',
    description:
        'جهاز العلاج الإشعاعي الحديث. يُسرّع الإلكترونات إلى طاقات عالية '
        '(6-25 MeV) لإنتاج أشعة سينية علاجية أو إلكترونات.',
    category: TermCategory.radiotherapy,
  ),
  Term(
    english: 'Fractionation',
    arabic: 'التجزئة',
    description:
        'تقسيم الجرعة الكلية على عدة جلسات (Fractions). يسمح للأنسجة '
        'السليمة بالتعافي. النموذجي: 60-70 Gy على 30-35 جلسة.',
    category: TermCategory.radiotherapy,
  ),
  Term(
    english: 'Gross Tumor Volume',
    arabic: 'حجم الورم الإجمالي',
    abbreviation: 'GTV',
    description:
        'حجم الورم المرئي في التصوير. أول ما يُرسم في التخطيط.',
    category: TermCategory.radiotherapy,
  ),
  Term(
    english: 'Clinical Target Volume',
    arabic: 'حجم الهدف السريري',
    abbreviation: 'CTV',
    description:
        'GTV + منطقة انتشار مجهري محتمل (5-10 mm). يشمل الورم والانتشار '
        'المحيط.',
    category: TermCategory.radiotherapy,
  ),
  Term(
    english: 'Planning Target Volume',
    arabic: 'حجم الهدف التخطيطي',
    abbreviation: 'PTV',
    description:
        'CTV + هامش للأخطاء (وضع المريض، حركة الأعضاء). يضمن وصول الجرعة '
        'للورم في كل الجلسات.',
    category: TermCategory.radiotherapy,
  ),
  Term(
    english: 'Organ at Risk',
    arabic: 'عضو معرض للخطر',
    abbreviation: 'OAR',
    description:
        'أعضاء سليمة قريبة من الورم يجب حمايتها. مثل: النخاع الشوكي، '
        'الغدد اللعابية، الرئة، الكلى.',
    category: TermCategory.radiotherapy,
  ),
  Term(
    english: 'Intensity-Modulated RT',
    arabic: 'العلاج الإشعاعي معدّل الشدة',
    abbreviation: 'IMRT',
    description:
        'تقنية حديثة تُعدّل شدة كل شعاع. تحمي الأعضاء الحساسة مع جرعة '
        'كاملة للورم.',
    category: TermCategory.radiotherapy,
  ),
  Term(
    english: 'Stereotactic Body RT',
    arabic: 'العلاج الإشعاعي التجسيمي للجسم',
    abbreviation: 'SBRT',
    description:
        'جرعة عالية جداً بدقة ملّيمترية. 3-5 جلسات فقط. للأورام الصغيرة '
        'في الرئة والكبد والبروستاتا.',
    category: TermCategory.radiotherapy,
  ),
  Term(
    english: 'Stereotactic Radiosurgery',
    arabic: 'الجراحة الإشعاعية التجسيمية',
    abbreviation: 'SRS',
    description:
        'جرعة عالية في جلسة واحدة لأورام الدماغ. تُجرى بـ Gamma Knife '
        'أو CyberKnife.',
    category: TermCategory.radiotherapy,
  ),
  Term(
    english: 'Brachytherapy',
    arabic: 'العلاج الإشعاعي الداخلي',
    description:
        'وضع مصدر مشع داخل أو قريب جداً من الورم. HDR (جرعة عالية سريعة) '
        'أو LDR (جرعة منخفضة طويلة). للبروستاتا، عنق الرحم، الثدي.',
    category: TermCategory.radiotherapy,
  ),
  Term(
    english: 'Image-Guided RT',
    arabic: 'العلاج الإشعاعي الموجه بالتصوير',
    abbreviation: 'IGRT',
    description:
        'تصوير المريض قبل كل جلسة (CBCT أو EPID) للتأكد من الوضع. '
        'أي انحراف > 2 mm يُصحَّح.',
    category: TermCategory.radiotherapy,
  ),
  Term(
    english: 'Dose-Volume Histogram',
    arabic: 'مخطط الجرعة-الحجم',
    abbreviation: 'DVH',
    description:
        'رسم بياني يُظهر نسبة الحجم الذي يستقبل جرعة معينة. أداة أساسية '
        'لتقييم الخطة قبل البدء.',
    category: TermCategory.radiotherapy,
  ),
  Term(
    english: 'Bragg Peak',
    arabic: 'قمة براغ',
    description:
        'ميزة فريدة للبروتونات: الطاقة تودع عند عمق محدد ثم تتوقف. '
        'تحمي الأنسجة بعد الورم. أساس Proton Therapy.',
    category: TermCategory.radiotherapy,
  ),

  // ═══════════════════════════════════════════════════
  //  الليزر
  // ═══════════════════════════════════════════════════
  Term(
    english: 'Laser',
    arabic: 'الليزر',
    abbreviation: 'LASER',
    description:
        'Light Amplification by Stimulated Emission of Radiation. ضوء '
        'أحادي اللون، متماسك، وموجّه. طبي: Class 3B و 4.',
    category: TermCategory.laser,
  ),
  Term(
    english: 'Stimulated Emission',
    arabic: 'الانبعاث المستحث',
    description:
        'إطلاق فوتون من ذرة مثارة بتحفيز فوتون عابر مطابق. أساس عمل '
        'الليزر. تنبأ به أينشتاين 1917.',
    category: TermCategory.laser,
  ),
  Term(
    english: 'Active Medium',
    arabic: 'الوسط الفعّال',
    description:
        'المادة التي تُنتج الانبعاث المستحث في الليزر. أنواع: غاز (CO₂)، '
        'صلب (Nd:YAG)، سائل (Dye)، شبه موصل (Diode).',
    category: TermCategory.laser,
  ),
  Term(
    english: 'Optical Cavity',
    arabic: 'المرنان البصري',
    description:
        'مرآتان متقابلتان تُضخّمان الضوء بتكرار مروره عبر الوسط الفعال. '
        'إحداهما عاكسة 100%، والأخرى شبه شفافة.',
    category: TermCategory.laser,
  ),
  Term(
    english: 'Q-Switched Laser',
    arabic: 'ليزر Q-Switched',
    description:
        'ليزر بنبضات قصيرة جداً (نانوثانية) وطاقة عالية. لإزالة الوشم '
        'والتصبغات.',
    category: TermCategory.laser,
  ),
  Term(
    english: 'Photodynamic Therapy',
    arabic: 'العلاج الديناميكي الضوئي',
    abbreviation: 'PDT',
    description:
        'دواء حساس للضوء + ليزر. الدواء يتراكم في الورم فقط، والليزر '
        'يُنشّطه لقتل الخلايا السرطانية.',
    category: TermCategory.laser,
  ),
  Term(
    english: 'Excimer Laser',
    arabic: 'ليزر الإكسيمر',
    description:
        'ليزر فوق بنفسجي (193 nm) يُستخدم في LASIK. يُزيل طبقات دقيقة '
        'من القرنية بدون حرارة.',
    category: TermCategory.laser,
  ),

  // ═══════════════════════════════════════════════════
  //  Mammography
  // ═══════════════════════════════════════════════════
  Term(
    english: 'BI-RADS',
    arabic: 'نظام تقارير تصوير الثدي',
    abbreviation: 'BI-RADS',
    description:
        'Breast Imaging Reporting and Data System. تصنيف من 0-6: '
        '1 طبيعي، 4 مشتبه (خزعة)، 5 سرطان محتمل جداً، 6 سرطان مؤكد.',
    category: TermCategory.mammography,
  ),
  Term(
    english: 'Microcalcifications',
    arabic: 'التكلّسات الدقيقة',
    description:
        'ترسبات كالسيوم صغيرة جداً (< 1 mm) في الثدي. قد تكون علامة '
        'مبكرة لسرطان الثدي. تُرى في Mammography.',
    category: TermCategory.mammography,
  ),
  Term(
    english: 'Digital Breast Tomosynthesis',
    arabic: 'التصوير المقطعي الرقمي للثدي',
    abbreviation: 'DBT',
    description:
        'Mammography ثلاثي الأبعاد. يقلل النداءات الكاذبة ويحسّن الكشف. '
        'المعيار الحديث.',
    category: TermCategory.mammography,
  ),
  Term(
    english: 'Mean Glandular Dose',
    arabic: 'متوسط الجرعة الغدية',
    abbreviation: 'MGD',
    description:
        'الجرعة على النسيج الغدي للثدي في Mammography. القيمة النموذجية: '
        '0.3-0.6 mGy لكل صورة.',
    category: TermCategory.mammography,
  ),
  Term(
    english: 'Compression',
    arabic: 'الضغط',
    description:
        'ضغط الثدي بين صفيحتين في Mammography. يقلل السماكة والجرعة '
        'ويحسّن التباين. قوة 10-20 kg.',
    category: TermCategory.mammography,
  ),
  Term(
    english: 'Stereotactic Biopsy',
    arabic: 'الخزعة الاستيريوتكتيكية',
    description:
        'خزعة موجهة بزاويتين مختلفتين لتحديد موقع التكلّسات الدقيقة في '
        '3D. دقة عالية.',
    category: TermCategory.mammography,
  ),

  // ═══════════════════════════════════════════════════
  //  Fluoroscopy
  // ═══════════════════════════════════════════════════
  Term(
    english: 'Fluoroscopy',
    arabic: 'التنظير التألقي',
    description:
        'تصوير حي (Real-time) بالأشعة السينية. يُظهر الحركة داخل الجسم. '
        'يُستخدم للجهاز الهضمي والأوعية والقلب.',
    category: TermCategory.fluoroscopy,
  ),
  Term(
    english: 'C-Arm',
    arabic: 'الذراع على شكل C',
    description:
        'جهاز Fluoroscopy على شكل حرف C يحمل الأنبوب والكاشف متقابلين. '
        'يدور حول المريض. يُستخدم في غرف العمليات.',
    category: TermCategory.fluoroscopy,
  ),
  Term(
    english: 'Image Intensifier',
    arabic: 'مضخّم الصورة',
    abbreviation: 'II',
    description:
        'كاشف تقليدي في Fluoroscopy يحوّل الفوتونات إلى إلكترونات ثم '
        'يُضخّمها. بديله الحديث: Flat Panel Detector.',
    category: TermCategory.fluoroscopy,
  ),
  Term(
    english: 'Last-Image Hold',
    arabic: 'الاحتفاظ بآخر صورة',
    abbreviation: 'LIH',
    description:
        'ميزة في Fluoroscopy تُبقي آخر صورة على الشاشة بدون تعرض إضافي. '
        'تُقلل الجرعة بشكل كبير.',
    category: TermCategory.fluoroscopy,
  ),
  Term(
    english: 'Pulsed Fluoroscopy',
    arabic: 'التنظير التألقي النابض',
    description:
        'تصوير بنبضات (3-15 نبضة/ث) بدلاً من Continuous. يُقلل الجرعة '
        'بشكل ملحوظ.',
    category: TermCategory.fluoroscopy,
  ),
  Term(
    english: 'Angiography',
    arabic: 'تصوير الأوعية',
    description:
        'تصوير الشرايين والأوردة بتباين يودي. يشمل: CTA، MRA، '
        'Catheter Angiography.',
    category: TermCategory.fluoroscopy,
  ),
  Term(
    english: 'Angioplasty',
    arabic: 'رأب الأوعية',
    description:
        'توسيع الوعاء المتضيق بالبالون. قد تُزرع دعامة (Stent). '
        'بديل للجراحة المفتوحة.',
    category: TermCategory.fluoroscopy,
  ),
  Term(
    english: 'Embolization',
    arabic: 'إغلاق الأوعية',
    description:
        'إغلاق وعاء دموي علاجياً. للأورام، النزيف، الأورام الليفية. '
        'يُحقن مواد إغلاق عبر قسطرة.',
    category: TermCategory.fluoroscopy,
  ),
  Term(
    english: 'TACE',
    arabic: 'العلاج الكيميائي الموضعي للكبد',
    abbreviation: 'TACE',
    description:
        'Transarterial Chemoembolization. حقن دواء كيميائي + إغلاق الأوعية '
        'المغذية لورم الكبد.',
    category: TermCategory.fluoroscopy,
  ),

  // ═══════════════════════════════════════════════════
  //  الحماية الإشعاعية
  // ═══════════════════════════════════════════════════
  Term(
    english: 'ALARA',
    arabic: 'أقل جرعة ممكنة',
    abbreviation: 'ALARA',
    description:
        'As Low As Reasonably Achievable. المبدأ الذهبي في الحماية '
        'الإشعاعية. قلّل الجرعة إلى أقل ما يمكن.',
    category: TermCategory.safety,
  ),
  Term(
    english: 'Lead Apron',
    arabic: 'المئزر الرصاصي',
    description:
        'مئزر بحماية رصاصية 0.25-0.5 mm. يحجب 90-95% من الأشعة. '
        'إلزامي للطاقم.',
    category: TermCategory.safety,
  ),
  Term(
    english: 'Thermoluminescent Dosimeter',
    arabic: 'مقياس الجرعة الحراري',
    abbreviation: 'TLD',
    description:
        'جهاز قياس الجرعة التراكمية. يُقرأ شهرياً أو ربع سنوي. '
        'دقيق جداً. يُلبس على الصدر تحت المئزر.',
    category: TermCategory.safety,
  ),
  Term(
    english: 'Optically Stimulated Luminescence',
    arabic: 'قياس الاستضواء البصري',
    abbreviation: 'OSL',
    description:
        'دوسيمتر حديث يُقرأ بليزر. بديل TLD. دقة عالية.',
    category: TermCategory.safety,
  ),
  Term(
    english: 'Personal Dosimeter',
    arabic: 'مقياس الجرعة الشخصي',
    description:
        'جهاز يقيس الجرعة المتراكمة للفرد. أنواع: Film Badge، TLD، OSL، '
        'EPD. إلزامي للعاملين.',
    category: TermCategory.safety,
  ),
  Term(
    english: 'Inverse Square Law',
    arabic: 'قانون التربيع العكسي',
    description:
        'شدة الإشعاع تتناسب عكسياً مع مربع المسافة: I ∝ 1/d². '
        'مضاعفة المسافة = ربع الجرعة.',
    category: TermCategory.safety,
  ),
  Term(
    english: 'Deterministic Effect',
    arabic: 'التأثير الحتمي',
    description:
        'تأثير إشعاعي له جرعة عتبة. شدته تزيد مع الجرعة. مثل: احمرار '
        'الجلد، تساقط الشعر.',
    category: TermCategory.safety,
  ),
  Term(
    english: 'Stochastic Effect',
    arabic: 'التأثير العشوائي',
    description:
        'تأثير إشعاعي لا عتبة له. أي جرعة تزيد الاحتمال. مثل: '
        'السرطان، التشوهات الوراثية.',
    category: TermCategory.safety,
  ),
  Term(
    english: 'Linear No-Threshold',
    arabic: 'النموذج الخطي بدون عتبة',
    abbreviation: 'LNT',
    description:
        'نموذج يفترض أن أي جرعة، مهما صغيرة، تحمل خطراً نظرياً. '
        'أساس الحماية الإشعاعية.',
    category: TermCategory.safety,
  ),
  Term(
    english: 'Radiation Protection Officer',
    arabic: 'مسؤول الوقاية الإشعاعية',
    abbreviation: 'RPO',
    description:
        'شخص مسؤول عن السلامة الإشعاعية في المنشأة. يُتصل به في '
        'الطوارئ.',
    category: TermCategory.safety,
  ),
  Term(
    english: 'Diagnostic Reference Level',
    arabic: 'المستوى المرجعي التشخيصي',
    abbreviation: 'DRL',
    description:
        'مستوى جرعة مرجعي لتقييم الممارسة. إذا تجاوزت جرعات المستشفى '
        'DRL → راجع البروتوكولات.',
    category: TermCategory.safety,
  ),
  Term(
    english: 'International Commission on Radiological Protection',
    arabic: 'اللجنة الدولية للحماية الإشعاعية',
    abbreviation: 'ICRP',
    description:
        'الهيئة الدولية التي تضع توصيات الحماية الإشعاعية. '
        'مرجع عالمي.',
    category: TermCategory.safety,
  ),
  Term(
    english: 'Radiation Absorbed Dose',
    arabic: 'الجرعة الممتصة',
    abbreviation: 'RAD',
    description:
        'وحدة قديمة للجرعة الممتصة = 0.01 Gy. اختصار Radiation Absorbed '
        'Dose.',
    category: TermCategory.safety,
  ),

  // ═══════════════════════════════════════════════════
  //  مصطلحات عامة
  // ═══════════════════════════════════════════════════
  Term(
    english: 'Radiology',
    arabic: 'علم الأشعة',
    description:
        'التخصص الطبي الذي يستخدم التصوير لتشخيص وعلاج الأمراض. '
        'يشمل: تشخيصي (X-ray، CT، MRI) وتداخلي (قسطرة، إغلاق أوعية).',
    category: TermCategory.general,
  ),
  Term(
    english: 'Radiologist',
    arabic: 'طبيب الأشعة',
    description:
        'طبيب متخصص في قراءة الصور الطبية وتفسيرها. يقود فريق الأشعة.',
    category: TermCategory.general,
  ),
  Term(
    english: 'Radiologic Technologist',
    arabic: 'تقني الأشعة',
    description:
        'متخصص يُجري الفحوصات الإشعاعية ويُشغّل الأجهزة. ليس طبيباً '
        'لكنه أساسي في التشغيل.',
    category: TermCategory.general,
  ),
  Term(
    english: 'Medical Physicist',
    arabic: 'الفيزيائي الطبي',
    description:
        'متخصص في فيزياء الأجهزة الطبية. مسؤول عن الجودة والسلامة '
        'والتخطيط في العلاج الإشعاعي.',
    category: TermCategory.general,
  ),
  Term(
    english: 'Contrast Media',
    arabic: 'مادة التباين',
    description:
        'مادة تُحقن أو تُعطى فموياً لتحسين وضوح الأعضاء في التصوير. '
        'أنواع: يودية (CT)، غادولينيوم (MRI)، باريوم (GI).',
    category: TermCategory.general,
  ),
  Term(
    english: 'Iodinated Contrast',
    arabic: 'التباين اليودي',
    description:
        'مادة تباين للـ CT والفلوروسكوبي. تحتوي يود. خطر على الكلى '
        '(فشل كلوي) والحساسية.',
    category: TermCategory.general,
  ),
  Term(
    english: 'Gadolinium',
    arabic: 'الغادولينيوم',
    description:
        'مادة تباين لـ MRI. معدن أرضي نادر. آمن عادة لكن خطر على '
        'مرضى الفشل الكلوي.',
    category: TermCategory.general,
  ),
  Term(
    english: 'Barium',
    arabic: 'الباريوم',
    description:
        'مادة تباين للجهاز الهضمي. تُشرب أو تُعطى شرجياً. لا تُمتص. '
        'لا تُستخدم في الانسداد الكامل.',
    category: TermCategory.general,
  ),
  Term(
    english: 'Picture Archiving and Communication System',
    arabic: 'نظام أرشفة الصور الطبية',
    abbreviation: 'PACS',
    description:
        'نظام رقمي لحفظ الصور الطبية ومشاركتها. يُتيح الوصول من أي '
        'مكان في المستشفى.',
    category: TermCategory.general,
  ),
  Term(
    english: 'Digital Imaging and Communications in Medicine',
    arabic: 'معيار التصوير الرقمي في الطب',
    abbreviation: 'DICOM',
    description:
        'المعيار العالمي لتبادل الصور الطبية. يضمن توافق الأجهزة '
        'والبرامج المختلفة.',
    category: TermCategory.general,
  ),
  Term(
    english: 'Artifact',
    arabic: 'التشويش',
    description:
        'أي عنصر في الصورة لا يمثل الحقيقة التشريحية. مثل: تشويش '
        'الحركة، المعادن، الحلقات.',
    category: TermCategory.general,
  ),
  Term(
    english: 'Scout View / Topogram',
    arabic: 'الصورة الأولية',
    description:
        'صورة أولية تُؤخذ قبل CT لتحديد نطاق الفحص. أشبه بـ X-ray.',
    category: TermCategory.general,
  ),
  Term(
    english: 'Slip Ring',
    arabic: 'الحلقة المنزلقة',
    description:
        'تقنية في CT تسمح للأنبوب بالدوران باستمرار بدون كابل. '
        'أساس CT الحلزوني.',
    category: TermCategory.general,
  ),
  Term(
    english: 'Helical / Spiral CT',
    arabic: 'التصوير المقطعي الحلزوني',
    description:
        'CT مستمر مع حركة الطاولة. يُنتج بيانات ثلاثية الأبعاد حقيقية.',
    category: TermCategory.general,
  ),
  Term(
    english: 'Bolus Tracking',
    arabic: 'تتبع البلعة',
    description:
        'تقنية لتوقيت الفحص بالتزامن مع وصول التباين. تقيس وصول '
        'التباين في وعاء رئيسي ثم تبدأ الفحص.',
    category: TermCategory.general,
  ),
  Term(
    english: 'Radiofrequency Ablation',
    arabic: 'الاستئصال بالتردد الراديوي',
    abbreviation: 'RFA',
    description:
        'علاج الأورام بحرارة عالية من تيار راديوي. بديل أقل توغلاً '
        'من الجراحة.',
    category: TermCategory.general,
  ),
  Term(
    english: 'Interventional Radiology',
    arabic: 'الأشعة التداخلية',
    abbreviation: 'IR',
    description:
        'تخصص يستخدم التصوير لإجراء علاجي بأقل توغل. يشمل: قسطرة، '
        'إغلاق أوعية، خزعة موجهة.',
    category: TermCategory.general,
  ),
  Term(
    english: 'Teleradiology',
    arabic: 'الأشعة عن بُعد',
    description:
        'قراءة الصور الطبية من مكان بعيد عبر الإنترنت. تُتيح '
        'الاستشارات الدولية.',
    category: TermCategory.general,
  ),
  Term(
    english: 'Radiation Dose',
    arabic: 'الجرعة الإشعاعية',
    description:
        'كمية الطاقة الإشعاعية الممتصة في الأنسجة. تقاس بـ Gy أو Sv. '
        'تُسجل لكل مريض في الإجراءات.',
    category: TermCategory.general,
  ),
  Term(
    english: 'Exposure',
    arabic: 'التعرض الإشعاعي',
    description:
        'كمية الشحنة المتولدة في الهواء من الأشعة السينية. تقاس بـ '
        'C/kg أو R. أقدم مقياس.',
    category: TermCategory.general,
  ),
  Term(
    english: 'Kerma',
    arabic: 'كيرما',
    abbreviation: 'KERMA',
    description:
        'Kinetic Energy Released per unit MAss. مقياس للطاقة الحركية '
        'المُنتَجة في الهواء. أساس قياس الجرعة.',
    category: TermCategory.general,
  ),
];