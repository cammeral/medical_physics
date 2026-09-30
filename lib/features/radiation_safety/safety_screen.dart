import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 16),
              _buildIntro(),
              _section(
                number: '١',
                title: 'المبادئ الأساسية',
                icon: '🎯',
                color: const Color(0xFFC62828),
                child: _content1(),
              ),
              _section(
                number: '٢',
                title: 'وحدات القياس',
                icon: '📏',
                color: const Color(0xFF1565C0),
                child: _content2(),
              ),
              _section(
                number: '٣',
                title: 'التأثيرات البيولوجية',
                icon: '🧬',
                color: const Color(0xFF6A1B9A),
                child: _content3(),
              ),
              _section(
                number: '٤',
                title: 'الحماية الشخصية للطاقم',
                icon: '🛡️',
                color: const Color(0xFF00695C),
                child: _content4(),
              ),
              _section(
                number: '٥',
                title: 'حماية المريض العامة',
                icon: '👤',
                color: const Color(0xFF2E7D32),
                child: _content5(),
              ),
              _devicesAccordion(),
              _section(
                number: '٧',
                title: 'الحمل والإشعاع',
                icon: '🤰',
                color: const Color(0xFFAD1457),
                child: _content7(),
              ),
              _section(
                number: '٨',
                title: 'اللوائح والحدود السنوية',
                icon: '📜',
                color: const Color(0xFF4527A0),
                child: _content8(),
              ),
              _section(
                number: '٩',
                title: 'الطوارئ والمراقبة',
                icon: '🚨',
                color: const Color(0xFFD84315),
                child: _content9(),
              ),
              const SizedBox(height: 40),
            ]),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════
  //  AppBar
  // ═══════════════════════════════════════════════════
  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: const Color(0xFFC62828),
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC62828), Color(0xFF8E0000)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Row(
                    children: [
                      Text('☢️', style: TextStyle(fontSize: 40)),
                      SizedBox(width: 12),
                      Text(
                        'الحماية الإشعاعية',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'اضغط على أي قسم لعرض تفاصيله',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════
  //  مقدمة (ثابتة، ليست Accordion)
  // ═══════════════════════════════════════════════════
  Widget _buildIntro() {
    return _container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'مقدمة',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC62828),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'الحماية الإشعاعية هي العلم الذي يهدف إلى حماية الإنسان والبيئة من '
            'الآثار الضارة للإشعاع المؤيِّن، مع الاستفادة القصوى من فوائده '
            'التشخيصية والعلاجية. تنقسم الحماية إلى: حماية المريض، حماية '
            'الطاقم الطبي، وحماية البيئة.',
            style: TextStyle(
              fontSize: 14,
              height: 1.8,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════
  //  Accordion لأي قسم عادي
  // ═══════════════════════════════════════════════════
  Widget _section({
    required String number,
    required String title,
    required String icon,
    required Color color,
    required Widget child,
  }) {
    return _AccordionSection(
      number: number,
      title: title,
      icon: icon,
      color: color,
      child: child,
    );
  }

  // ═══════════════════════════════════════════════════
  //  Accordion خاص بقسم الأجهزة (6)
  // ═══════════════════════════════════════════════════
  Widget _devicesAccordion() {
    return _AccordionSection(
      number: '٦',
      title: 'الحماية الخاصة بكل جهاز',
      icon: '🔬',
      color: const Color(0xFFD84315),
      initiallyExpanded: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'لكل جهاز طبي خصائصه الخاصة في الحماية. اضغط على أي جهاز لعرض '
            'تفاصيله (المخاطر، الحماية، تحذيرات).',
            style: TextStyle(
              fontSize: 13.5,
              height: 1.7,
              color: AppColors.textLight,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          _deviceAccordion(
            number: '٦.١',
            icon: '📷',
            name: 'X-ray (الأشعة السينية)',
            color: const Color(0xFF4A6CF7),
            intro:
                'الأشعة السينية هي الأساس في التصوير الطبي. الجرعة منخفضة '
                'لكن يجب الحذر من التكرار. القاعدة الذهبية: ALARA.',
            hazards: [
              'جرعة منخفضة (0.1 mSv لصورة صدر).',
              'خطر تراكمي عند التصوير المتكرر.',
              'الخطر الأكبر: الأطفال والنساء الحوامل.',
            ],
            protection: [
              '🛡️ استخدم المئزر الرصاصي دائماً (0.5 mm Pb).',
              '📏 ضاعف المسافة — كل 2 m يقلل الجرعة 4 أضعاف.',
              '🎯 الكوليماتور على المنطقة المطلوبة فقط.',
              '👶 حماية الخصيتين والمبيضين إلزامية.',
              '🚪 قف خلف الحاجز الرصاصي أثناء التعرض.',
              '🔄 لا تُعِد التصوير إلا لسبب مقنع.',
            ],
            warning:
                '⚠️ في الأجهزة المحمولة: لا تقف قرب المريض أثناء التعرض. '
                'ابتعد 2 m على الأقل.',
          ),
          _deviceAccordion(
            number: '٦.٢',
            icon: '🧠',
            name: 'CT Scan (التصوير المقطعي)',
            color: const Color(0xFF06B6A4),
            intro:
                'CT يعطي جرعة أعلى بـ 10-100 ضعف من X-ray العادي. الحماية '
                'فيه أكثر أهمية، خاصة للأطفال والحوامل.',
            hazards: [
              'جرعة متوسطة (2-10 mSv للفحص الواحد).',
              'أعلى بكثير من X-ray — خاصة البطن والحوض.',
              'خطر السرطان النظري أعلى في الأطفال.',
            ],
            protection: [
              '🛡️ المئزر الرصاصي إلزامي للطاقم.',
              '🎯 اضبط FOV على المنطقة المطلوبة فقط.',
              '📉 استخدم Low-Dose CT عندما لا تحتاج دقة عالية.',
              '💊 استخدم Iterative Reconstruction بدلاً من FBP.',
              '👶 في الأطفال: قلّل kVp و mAs بشكل ملحوظ.',
              '🤰 لا تستخدم CT للحوامل إلا للضرورة القاتلة.',
              '📊 سجّل CTDIvol و DLP لكل فحص.',
              '⚖️ قارن الجرعة بـ DRL.',
            ],
            warning:
                '⚠️ CT هو أكبر مصدر إشعاع طبي في المستشفى. ضبط البروتوكولات '
                'يُقلل الجرعة بنسبة 40-60% بدون فقدان الجودة.',
          ),
          _deviceAccordion(
            number: '٦.٣',
            icon: '🧲',
            name: 'MRI (الرنين المغناطيسي)',
            color: const Color(0xFF9B5DE5),
            intro:
                'MRI لا يستخدم إشعاعاً مؤيناً إطلاقاً — لا خطر إشعاعي. '
                'لكن المجال المغناطيسي القوي (1.5-3 T) له مخاطر خطيرة.',
            hazards: [
              '⚠️ تأثير المقذوف: أي معدن يُسحب بقوة نحو المغناطيس.',
              '⚠️ خطر الاحتراق من RF.',
              '⚠️ خطر Quench (تبخر الهيليوم المفاجئ).',
              '⚠️ خطر على الأجهزة المزروعة.',
              '🔊 الضوضاء (110 dB).',
            ],
            protection: [
              '📋 استبيان أمان MRI شامل قبل أي فحص.',
              '🚫 ممنوع دخول أي معدن مغناطيسي للغرفة.',
              '🛡️ Metal Detector قبل الدخول إلزامي.',
              '🎧 سدادات أذن للمريض — إلزامية.',
              '🚨 زر Quench للطوارئ (بحذر شديد).',
              '👤 لا تدخل الغرفة أثناء التشغيل بدون ضرورة.',
              '🧊 في حالات Quench: اخرج فوراً واتصل بالمسؤول.',
            ],
            warning:
                '⚠️ MRI ليس "آمناً" — هو آمن من الإشعاع، لكن خطير مغناطيسياً.',
          ),
          _deviceAccordion(
            number: '٦.٤',
            icon: '🔊',
            name: 'Ultrasound (الموجات فوق الصوتية)',
            color: const Color(0xFFF4A261),
            intro:
                'Ultrasound لا يستخدم إشعاعاً مؤيناً — آمن للحوامل والأطفال. '
                'لكنه ليس خالياً من المخاطر: التسخين والتجويف.',
            hazards: [
              '🔥 التسخين (Thermal Index — TI).',
              '💥 التجويف (Mechanical Index — MI).',
              '⏱️ خطر يزيد مع زمن التعرض.',
            ],
            protection: [
              '📊 راقب TI و MI — يجب أن يبقى كلاهما < 1.0.',
              '⏱️ قلّل زمن التعرض (مبدأ ALARA ينطبق).',
              '🚫 لا تستخدم Ultrasound للترفيه.',
              '👁️ حذر خاص في فحوصات العين.',
              '🧠 في تصوير دماغ الجنين: أقل طاقة ممكنة.',
            ],
            warning:
                '⚠️ Ultrasound آمن لكن ليس بريئاً. استخدامه بدون داعٍ طبي '
                'غير مبرر.',
          ),
          _deviceAccordion(
            number: '٦.٥',
            icon: '☢️',
            name: 'PET (التصوير البوزيتروني)',
            color: const Color(0xFFE63946),
            intro:
                'PET يستخدم مواد مشعة (F-18 FDG). المريض يصبح مصدراً مشعاً '
                'لعدة ساعات بعد الحقن.',
            hazards: [
              '☢️ جرعة عالية (15-25 mSv).',
              '🔥 المريض يصبح مشعاً (مصدر متحرك).',
              '💧 البول والعرق مشعان.',
              '🧪 خطر التلوث عند التعامل مع FDG.',
            ],
            protection: [
              '🧤 قفازات واقية عند حقن FDG.',
              '🚪 المئزر الرصاصي إلزامي (0.5 mm Pb).',
              '📏 ابعد عن المريض.',
              '⏱️ قلّل زمن التعامل مع المريض.',
              '🧪 استخدم محقنة محمية بالرصاص.',
              '🚽 المريض يستخدم مرحاضاً مخصصاً.',
              '💧 اطلب من المريض شرب سوائل كثيرة.',
              '👶 تجنّب الأطفال والحوامل بعد الفحص 12 ساعة.',
              '📊 Dosimeter شخصي إلزامي للطاقم.',
            ],
            warning:
                '⚠️ المريض في PET هو مصدر مشع متحرك! كل من يقترب منه يتعرض '
                'لجرعة.',
          ),
          _deviceAccordion(
            number: '٦.٦',
            icon: '🌟',
            name: 'SPECT (التصوير النووي)',
            color: const Color(0xFF10B981),
            intro:
                'SPECT يستخدم Tc-99m (عمر نصف 6 ساعات). أقل خطورة من PET '
                'لكن يحتاج احتياطات مشابهة.',
            hazards: [
              '☢️ جرعة متوسطة (5-10 mSv).',
              '🔥 المريض مصدر مشع لأيام.',
              '💧 البول مشع.',
              '🧪 خطر التلوث عند التحضير.',
            ],
            protection: [
              '🧤 قفازات واقية إلزامية.',
              '🚪 المئزر الرصاصي (0.5 mm Pb).',
              '📏 حافظ على مسافة آمنة.',
              '⏱️ قلّل زمن التعامل.',
              '🧪 استخدم حاويات رصاصية للنظائر.',
              '🚽 مرحاض مخصص للمرضى.',
              '💧 اطلب من المريض شرب سوائل كثيرة.',
              '👶 تجنّب الأطفال والحوامل 12-24 ساعة.',
              '📊 Ring Dosimeter للأصابع.',
            ],
            warning:
                '⚠️ النظير Tc-99m يُطرح في البول والعرق — انتبه عند التعامل.',
          ),
          _deviceAccordion(
            number: '٦.٧',
            icon: '💥',
            name: 'Radiotherapy (العلاج الإشعاعي)',
            color: const Color(0xFFEF4444),
            intro:
                'العلاج الإشعاعي يستخدم جرعات علاجية عالية جداً (60-80 Gy). '
                'الحماية صارمة — أي خطأ قد يكون كارثياً.',
            hazards: [
              '☢️ جرعات عالية جداً (60-80 Gy).',
              '⚠️ خطر على الطاقم إذا بقي في الغرفة.',
              '⚠️ خطر على المريض إذا كانت الخطة خاطئة.',
              '☢️ Brachytherapy: مصادر عالية النشاط.',
            ],
            protection: [
              '🚪 الطاقم يخرج من الغرفة أثناء التشغيل.',
              '🔒 Interlocks: نظام أقفال متعدد.',
              '📹 كاميرات مراقبة للمريض.',
              '🚨 زر طوارئ لإيقاف LINAC فوراً.',
              '🧱 جدران خرسانية بسماكة 1-2 m.',
              '📊 Dosimeter شخصي + EPD.',
              '🧪 QA يومي قبل بدء العمل.',
              '⚖️ مراجعة الخطة بواسطة الفيزيائي.',
            ],
            warning:
                '⚠️ في LINAC: لا تدخل الغرفة إلا بعد التأكد من إيقاف الحزمة.',
          ),
          _deviceAccordion(
            number: '٦.٨',
            icon: '💡',
            name: 'Laser (الليزر الطبي)',
            color: const Color(0xFFF59E0B),
            intro:
                'الليزر ليس إشعاعاً مؤيناً، لكنه خطير على العين والجلد. '
                'Class 3B و 4 هي الأخطر.',
            hazards: [
              '👁️ إصابة العين: قد تسبب عمى دائم.',
              '🔥 حرق الجلد.',
              '🚒 خطر حريق.',
              '💨 دخان الليزر ضار.',
            ],
            protection: [
              '🕶️ نظارات واقية مخصصة للطول الموجي.',
              '🚪 إغلاق الباب ولافتة "ليزر قيد التشغيل".',
              '🪟 تغطية النوافذ إذا لزم.',
              '🧯 مطفأة حريق قريبة.',
              '💨 نظام شفط الدخان.',
              '🚫 منع المواد القابلة للاشتعال.',
              '🔒 مفتاح التشغيل بحوزة المسؤول.',
            ],
            warning:
                '⚠️ نظارات الحماية إلزامية لكل من في الغرفة. لا استثناءات!',
          ),
          _deviceAccordion(
            number: '٦.٩',
            icon: '🩻',
            name: 'Mammography (تصوير الثدي)',
            color: const Color(0xFF8B5CF6),
            intro:
                'Mammography يستخدم جرعات منخفضة جداً (0.4 mSv). الحماية '
                'تركز على الثدي نفسه وعلى النساء الحوامل.',
            hazards: [
              '☢️ جرعة منخفضة (0.4 mSv).',
              '👩 الثدي حساس للإشعاع.',
              '🔄 خطر تراكمي مع الفحوصات المتكررة.',
            ],
            protection: [
              '🤰 لا تُصوّر الحوامل إلا للضرورة.',
              '📅 التوقيت الأمثل: بعد الدورة بأسبوع.',
              '🛡️ الحاجز الرصاصي على البطن.',
              '🎯 FOV على الثدي فقط.',
              '📊 استخدم DBT لتقليل إعادة التصوير.',
              '🔄 لا تكرر الفحص قبل سنة.',
              '📈 استخدم AEC لضبط التعرض.',
            ],
            warning:
                '⚠️ جرعة Mammography منخفضة جداً. الفائدة تفوق المخاطر بكثير.',
          ),
          _deviceAccordion(
            number: '٦.١٠',
            icon: '📺',
            name: 'Fluoroscopy (التنظير التألقي)',
            color: const Color(0xFF0EA5E9),
            intro:
                'Fluoroscopy يمكن أن يُعطي جرعات عالية جداً في الإجراءات '
                'الطويلة. الجرعة تراكمية مع الزمن.',
            hazards: [
              '☢️ جرعة عالية (قد تصل 50 mSv).',
              '🔥 خطر حرق جلدي > 2 Gy.',
              '⏱️ الجرعة تراكمية.',
              '🧑‍⚕️ الطبيب قريب من المريض.',
            ],
            protection: [
              '🦺 مئزر رصاصي 0.5 mm Pb + سترة إضافية.',
              '🕶️ نظارات رصاصية.',
              '🧣 واقي الغدة الدرقية.',
              '📏 الطبيب يقف في جهة الكاشف.',
              '⏱️ قلّل زمن Fluoroscopy.',
              '🎯 استخدم Pulsed Fluoroscopy.',
              '🖼️ Last-Image Hold ميزة أساسية.',
              '🔲 قلّل الـ Magnification.',
              '📊 EPD للقراءة الفورية.',
              '⏰ حد أقصى 5 دقائق.',
            ],
            warning:
                '⚠️ Fluoroscopy يمكن أن يُعطي جرعة أعلى من CT!',
          ),
        ],
      ),
    );
  }

  Widget _deviceAccordion({
    required String number,
    required String icon,
    required String name,
    required Color color,
    required String intro,
    required List<String> hazards,
    required List<String> protection,
    required String warning,
  }) {
    return _DeviceAccordion(
      number: number,
      icon: icon,
      name: name,
      color: color,
      intro: intro,
      hazards: hazards,
      protection: protection,
      warning: warning,
    );
  }

  // ═══════════════════════════════════════════════════
  //  محتوى الأقسام (1-5، 7-9)
  // ═══════════════════════════════════════════════════
  Widget _content1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subHeading('1.1 مبدأ ALARA'),
        const Text(
          'ALARA (As Low As Reasonably Achievable) هو المبدأ الذهبي في '
          'الحماية الإشعاعية. نصّه: "قلّل الجرعة إلى أقل مستوى يمكن تحقيقه '
          'بشكل معقول".',
          style: TextStyle(fontSize: 14, height: 1.8, color: AppColors.textDark),
        ),
        const SizedBox(height: 10),
        _note(
          'لا توجد جرعة "آمنة" تماماً. أي جرعة تحمل خطراً نظرياً.',
        ),
        const SizedBox(height: 16),
        _subHeading('1.2 العوامل الثلاثة: TDS'),
        _bullets([
          '⏱️ الوقت (Time): قلّل زمن التعرض.',
          '📏 المسافة (Distance): ضاعف المسافة = ربع الجرعة.',
          '🛡️ الدرع (Shielding): استخدم الرصاص أو الخرسانة.',
        ]),
        const SizedBox(height: 12),
        _table(
          headers: ['العامل', 'القاعدة', 'المثال'],
          rows: [
            ['الوقت', 'نصف الزمن = نصف الجرعة', '10 د → 5 د = 50% أقل'],
            ['المسافة', 'ضعف المسافة = ربع الجرعة', 'من 1 m → 2 m = 25%'],
            ['الدرع', '0.5 mm رصاص', 'يحجب 95% من الأشعة'],
          ],
        ),
        const SizedBox(height: 16),
        _subHeading('1.3 التبرير والتحسين'),
        _bullets([
          'Justification (التبرير): هل الفحص ضروري؟',
          'Optimization (التحسين): هل يمكن تحقيق الهدف بأقل جرعة؟',
          'Dose Limits (الحدود): لا تتجاوز الحدود المسموحة.',
        ]),
        const SizedBox(height: 10),
        _success(
          'كل فحص طبي يجب أن يكون "مبرراً" و"محسّناً".',
        ),
      ],
    );
  }

  Widget _content2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subHeading('2.1 الوحدات الأساسية'),
        _table(
          headers: ['الوحدة', 'الرمز', 'تقيس', 'القديمة'],
          rows: [
            ['جراي', 'Gy', 'الجرعة الممتصة', 'Rad'],
            ['سيفرت', 'Sv', 'الجرعة المكافئة', 'Rem'],
            ['بيكريل', 'Bq', 'النشاط الإشعاعي', 'Ci'],
            ['كولوم/كغ', 'C/kg', 'التعرض', 'R'],
          ],
        ),
        const SizedBox(height: 8),
        _note('1 Gy = 100 Rad | 1 Sv = 100 Rem | 1 Ci = 37 GBq'),
        const SizedBox(height: 16),
        _subHeading('2.2 الفرق بين Gy و Sv'),
        const Text(
          'الجرعة الممتصة (Gy) تقيس الطاقة المودعة. لكن التأثير البيولوجي '
          'يعتمد على نوع الإشعاع، لذلك نستخدم الجرعة المكافئة (Sv):',
          style: TextStyle(fontSize: 14, height: 1.8, color: AppColors.textDark),
        ),
        const SizedBox(height: 10),
        _equation('H (Sv) = D (Gy) × w_R'),
        const SizedBox(height: 10),
        _table(
          headers: ['نوع الإشعاع', 'w_R', 'الخطر'],
          rows: [
            ['X-ray, γ', '1', 'منخفض'],
            ['β (إلكترون)', '1', 'منخفض'],
            ['بروتون', '2', 'متوسط'],
            ['نيوترون', '5-20', 'مرتفع'],
            ['α (ألفا)', '20', 'مرتفع جداً'],
          ],
        ),
        const SizedBox(height: 16),
        _subHeading('2.3 النشاط الإشعاعي (Bq)'),
        _bullets([
          '1 kBq = 1,000 Bq',
          '1 MBq = 1,000,000 Bq',
          '1 GBq = 1,000,000,000 Bq',
          '1 Ci (كوري) = 37 GBq',
        ]),
      ],
    );
  }

  Widget _content3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subHeading('3.1 آلية التأثير'),
        _bullets([
          'التأثير المباشر: فوتون يصطدم بـ DNA.',
          'التأثير غير المباشر: جذور حرة (Free Radicals).',
          'كسر أحادي الشريط (SSB): يمكن إصلاحه.',
          'كسر مزدوج الشريط (DSB): صعب الإصلاح.',
        ]),
        const SizedBox(height: 16),
        _subHeading('3.2 التأثيرات الحتمية'),
        const Text(
          'تحدث فقط عند تجاوز جرعة عتبة محددة. شدتها تزيد مع الجرعة.',
          style: TextStyle(fontSize: 14, height: 1.8, color: AppColors.textDark),
        ),
        const SizedBox(height: 10),
        _table(
          headers: ['التأثير', 'الجرعة العتبة'],
          rows: [
            ['احمرار الجلد', '~2 Gy'],
            ['تساقط الشعر', '3-5 Gy'],
            ['حرق جلدي', '5-10 Gy'],
            ['الساد (Cataract)', '0.5-2 Gy'],
          ],
        ),
        const SizedBox(height: 12),
        _danger(
          'التأثيرات الحتمية نادرة في الطب التشخيصي.',
        ),
        const SizedBox(height: 16),
        _subHeading('3.3 التأثيرات العشوائية'),
        const Text(
          'لا عتبة لها. أي جرعة تزيد الاحتمال. مثال: السرطان.',
          style: TextStyle(fontSize: 14, height: 1.8, color: AppColors.textDark),
        ),
        const SizedBox(height: 10),
        _bullets([
          'السرطان: لوكيميا، سرطان الغدة الدرقية، سرطان الثدي.',
          'التشوهات الوراثية: تأثير نظري.',
          'فترة الحضانة طويلة (5-30 سنة).',
        ]),
        const SizedBox(height: 10),
        _note(
          'النموذج: LNT (Linear No-Threshold) — أي جرعة تحمل خطراً نظرياً.',
        ),
        const SizedBox(height: 16),
        _subHeading('3.4 الفئات الأكثر حساسية'),
        _bullets([
          '👶 الأجنة: 10-20 ضعف حساسية البالغين.',
          '🧒 الأطفال: 3-5 أضعاف البالغين.',
          '👩 النساء: الثدي والغدة الدرقية.',
          '👨 الرجال: الخصية.',
          '🧓 كبار السن: أقل حساسية.',
        ]),
      ],
    );
  }

  Widget _content4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subHeading('4.1 المئزر الرصاصي'),
        _table(
          headers: ['السماكة', 'نسبة الحجب', 'الاستخدام'],
          rows: [
            ['0.25 mm Pb', '90%', 'تشخيصي خفيف'],
            ['0.35 mm Pb', '93%', 'استخدام معياري'],
            ['0.5 mm Pb', '95%+', 'إجراءات تداخلية'],
          ],
        ),
        const SizedBox(height: 10),
        _bullets([
          'يُفحص سنوياً بـ Fluoroscopy للكشف عن شقوق.',
          'لا يُطوى — يُعلَّق دائماً.',
          'العمر الافتراضي: 5-10 سنوات.',
        ]),
        const SizedBox(height: 16),
        _subHeading('4.2 أجهزة قياس الجرعة (Dosimeters)'),
        _table(
          headers: ['النوع', 'القراءة', 'الميزة'],
          rows: [
            ['Film Badge', 'شهري', 'رخيص'],
            ['TLD', 'شهري-ربعي', 'دقيق'],
            ['OSL', 'ربعي', 'حديث'],
            ['Ring Dosimeter', 'شهري', 'للأصابع'],
            ['EPD', 'فوري', 'قراءة مباشرة'],
          ],
        ),
        const SizedBox(height: 10),
        _note(
          'يُلبس Dosimeter على الصدر تحت المئزر. في الإجراءات التداخلية: '
          'Dosimeter إضافي على الرقبة.',
        ),
        const SizedBox(height: 16),
        _subHeading('4.3 الحماية الإضافية'),
        _bullets([
          '🕶️ نظارات رصاصية: لحماية العدسة.',
          '🧤 قفازات رصاصية: للتدخلات.',
          '🧣 واقي الغدة الدرقية.',
          '🦺 سترات إضافية في الإجراءات الطويلة.',
        ]),
        const SizedBox(height: 10),
        _success('قاعدة: "لو ترى شعاع الأشعة، فأنت تتعرض له."'),
      ],
    );
  }

  Widget _content5() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subHeading('5.1 المبادئ الثلاثة'),
        _bullets([
          '① التبرير: هل الفحص ضروري؟',
          '② التحسين: أقل جرعة ممكنة.',
          '③ الجرعات المرجعية: قارن بـ DRLs.',
        ]),
        const SizedBox(height: 16),
        _subHeading('5.2 دروع المريض'),
        _bullets([
          '🎽 حاجز الخصيتين: للبطن/الحوض للرجال.',
          '🌸 حاجز المبيض: للنساء في سن الإنجاب.',
          '🦋 واقي الغدة الدرقية: للأسنان والرأس.',
          '👁️ واقي العين: في CT الرأس.',
          '🤰 حاجز البطن: للحوامل.',
        ]),
        const SizedBox(height: 16),
        _subHeading('5.3 قواعد عملية'),
        _bullets([
          '① الكوليماتور على المنطقة المطلوبة فقط.',
          '② استخدم AEC.',
          '③ kVp الأمثل: 80-120.',
          '④ تجنّب إعادة التصوير.',
          '⑤ السؤال عن الحمل إلزامي.',
          '⑥ قارن بالصور السابقة.',
        ]),
        const SizedBox(height: 16),
        _subHeading('5.4 حماية الأطفال'),
        _bullets([
          'قلّل kVp و mAs حسب وزن الطفل.',
          'بروتوكولات خاصة بالأطفال.',
          'تجنّب CT إن أمكن.',
          'AEC إلزامي.',
        ]),
        const SizedBox(height: 10),
        _success('في الأطفال: "Image Gently".'),
      ],
    );
  }

  Widget _content7() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subHeading('7.1 حساسية الجنين حسب العمر'),
        _table(
          headers: ['الفترة', 'الخطر', 'الجرعة الحرجة'],
          rows: [
            ['0-2 أسبوع', 'إجهاض', '< 50 mGy'],
            ['2-8 أسابيع', 'تشوهات', '> 100 mGy'],
            ['8-15 أسبوع', 'تخلف عقلي', '> 200 mGy'],
            ['15-40 أسبوع', 'سرطان طفولي', '> 100 mGy'],
          ],
        ),
        const SizedBox(height: 16),
        _subHeading('7.2 جرعات الفحوصات الشائعة'),
        _table(
          headers: ['الفحص', 'جرعة الجنين', 'الخطر'],
          rows: [
            ['صدر X-ray', '< 0.01 mGy', 'ضئيل'],
            ['أسنان X-ray', '< 0.01 mGy', 'ضئيل'],
            ['CT صدر', '0.1-0.7 mGy', 'منخفض'],
            ['CT بطن', '1-10 mGy', 'منخفض-متوسط'],
            ['PET/CT', '5-15 mGy', 'متوسط'],
          ],
        ),
        const SizedBox(height: 16),
        _subHeading('7.3 الاحتياطات'),
        _bullets([
          'اسأل دائماً عن الحمل.',
          'حاجز رصاصي على البطن.',
          'قلّل عدد الصور.',
          'استخدم Ultrasound أو MRI.',
          'وثّق كل شيء.',
        ]),
        const SizedBox(height: 12),
        _danger(
          'في حالة طوارئ قاتلة: لا تتأخر — الفحص ضروري.',
        ),
        const SizedBox(height: 16),
        _subHeading('7.4 الرضاعة والطب النووي'),
        _table(
          headers: ['النظير', 'إيقاف الرضاعة'],
          rows: [
            ['Tc-99m', '24 ساعة'],
            ['F-18 FDG', '12 ساعة'],
            ['Ga-67', '2 أسابيع'],
            ['I-131', '3 أسابيع'],
          ],
        ),
        const SizedBox(height: 10),
        _note('بعد X-ray أو CT: الرضاعة الطبيعية آمنة تماماً.'),
      ],
    );
  }

  Widget _content8() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subHeading('8.1 الهيئات الدولية'),
        _bullets([
          'ICRP: اللجنة الدولية للحماية الإشعاعية.',
          'IAEA: الوكالة الدولية للطاقة الذرية.',
          'NCRP: المجلس الأمريكي.',
          'UNSCEAR: اللجنة العلمية للأمم المتحدة.',
        ]),
        const SizedBox(height: 16),
        _subHeading('8.2 الحدود السنوية للطاقم'),
        _table(
          headers: ['الفئة', 'الحد السنوي'],
          rows: [
            ['جسم كامل', '20 mSv/سنة'],
            ['عدسة العين', '20 mSv/سنة'],
            ['الجلد', '500 mSv/سنة'],
            ['الأطراف', '500 mSv/سنة'],
            ['الحمل (9 أشهر)', '1 mSv'],
            ['الجمهور العام', '1 mSv/سنة'],
          ],
        ),
        const SizedBox(height: 16),
        _subHeading('8.3 قواعد عملية'),
        _bullets([
          '① لا تدخل غرفة الأشعة بدون ضرورة.',
          '② قف خلف الحاجز الرصاصي.',
          '③ ارتدِ المئزر والـ Dosimeter.',
          '④ في الفلوروسكوبي: قف جهة الكاشف.',
          '⑤ في المحمولة: ابتعد 2 m.',
          '⑥ لا تحمل المريض أثناء التعرض.',
        ]),
      ],
    );
  }

  Widget _content9() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subHeading('9.1 انسكاب مادة مشعة'),
        _bullets([
          '① أخبر الجميع: "Spill! Spill!".',
          '② أخرج من ليس ضرورياً.',
          '③ أغلق الغرفة وعلّق لافتة.',
          '④ اتصل بـ RPO.',
          '⑤ ارتدِ قفازات ومئزر واقٍ.',
          '⑥ ورق نشاف للامتصاص.',
          '⑦ حاوية رصاصية للمواد الملوثة.',
          '⑧ نظّف بمحلول خاص.',
          '⑨ تحقق بـ Geiger Counter.',
          '⑩ وثّق كل شيء.',
        ]),
        const SizedBox(height: 12),
        _danger('لا تحاول التنظيف بدون معدات واقية!'),
        const SizedBox(height: 16),
        _subHeading('9.2 انطفاء المغناطيس (MRI Quench)'),
        _bullets([
          '⚠️ الهيليوم يتبخر بسرعة — 700 ضعف حجمه.',
          '⚠️ يزيح الأوكسجين — خطر اختناق.',
          '⚠️ اخرج من الغرفة فوراً.',
          '⚠️ افتح الأبواب للتهوية.',
          '⚠️ لا تدخل إلا مع جهاز تنفس.',
        ]),
        const SizedBox(height: 10),
        _danger('حادثة Quench قاتلة موثقة (الهند 2018).'),
        const SizedBox(height: 16),
        _subHeading('9.3 المراقبة'),
        _table(
          headers: ['النوع', 'التكرار'],
          rows: [
            ['شخصية (Personal)', 'شهري'],
            ['مساحية (Area)', 'مستمر'],
            ['تلوث (Contamination)', 'يومي'],
            ['بيئية (Environmental)', 'ربع سنوي'],
          ],
        ),
        const SizedBox(height: 16),
        _subHeading('9.4 أجهزة القياس'),
        _bullets([
          'Geiger Counter: كشف التلوث.',
          'Ionization Chamber: قياس دقيق.',
          'TLD/OSL: الجرعات التراكمية.',
          'Survey Meter: مسح الأسطح.',
          'Dose Calibrator: قياس جرعة النظائر.',
        ]),
      ],
    );
  }

  // ═══════════════════════════════════════════════════
  //  أدوات مساعدة
  // ═══════════════════════════════════════════════════
  Widget _container({required Widget child}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: child,
    );
  }

  Widget _subHeading(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  Widget _bullets(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) => Padding(
        padding: const EdgeInsets.only(bottom: 8, right: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFFC62828),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 13.5,
                  height: 1.7,
                  color: AppColors.textDark,
                ),
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _smallBullet(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, right: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.5,
                height: 1.65,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _table({required List<String> headers, required List<List<String>> rows}) {
    return Container(
      margin: const EdgeInsets.only(top: 6, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFC62828).withValues(alpha: 0.25)),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Table(
          border: TableBorder.symmetric(
            inside: BorderSide(
              color: const Color(0xFFC62828).withValues(alpha: 0.12),
            ),
          ),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: const Color(0xFFC62828).withValues(alpha: 0.12),
              ),
              children: headers.map((h) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                child: Text(h,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC62828),
                    )),
              )).toList(),
            ),
            ...rows.map((row) => TableRow(
              children: row.map((cell) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 9),
                child: Text(cell,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11.5,
                      height: 1.4,
                      color: AppColors.textDark,
                    )),
              )).toList(),
            )),
          ],
        ),
      ),
    );
  }

  Widget _equation(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFC62828).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFC62828).withValues(alpha: 0.25)),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC62828),
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }

  Widget _note(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('💡', style: TextStyle(fontSize: 15)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.5,
                height: 1.6,
                color: Colors.brown.shade800,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _danger(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('⚠️', style: TextStyle(fontSize: 15)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.5,
                height: 1.6,
                color: Colors.red.shade900,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _success(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFA5D6A7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('✅', style: TextStyle(fontSize: 15)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.5,
                height: 1.6,
                color: Color(0xFF1B5E20),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
//  Widget: Accordion لقسم عادي
// ═══════════════════════════════════════════════════
class _AccordionSection extends StatefulWidget {
  final String number;
  final String title;
  final String icon;
  final Color color;
  final Widget child;
  final bool initiallyExpanded;

  const _AccordionSection({
    required this.number,
    required this.title,
    required this.icon,
    required this.color,
    required this.child,
    this.initiallyExpanded = false,
  });

  @override
  State<_AccordionSection> createState() => _AccordionSectionState();
}

class _AccordionSectionState extends State<_AccordionSection> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _expanded
              ? widget.color.withValues(alpha: 0.4)
              : Colors.grey.shade200,
          width: _expanded ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          // الرأس
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      widget.number,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(widget.icon, style: const TextStyle(fontSize: 22)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: widget.color,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: widget.color,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // المحتوى
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _expanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: widget.child,
            ),
            secondChild: const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
//  Widget: Accordion لجهاز
// ═══════════════════════════════════════════════════
class _DeviceAccordion extends StatefulWidget {
  final String number;
  final String icon;
  final String name;
  final Color color;
  final String intro;
  final List<String> hazards;
  final List<String> protection;
  final String warning;

  const _DeviceAccordion({
    required this.number,
    required this.icon,
    required this.name,
    required this.color,
    required this.intro,
    required this.hazards,
    required this.protection,
    required this.warning,
  });

  @override
  State<_DeviceAccordion> createState() => _DeviceAccordionState();
}

class _DeviceAccordionState extends State<_DeviceAccordion> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.color.withValues(alpha: 0.3),
          width: _expanded ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          // الرأس
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _expanded
                    ? widget.color.withValues(alpha: 0.08)
                    : Colors.transparent,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(widget.icon,
                        style: const TextStyle(fontSize: 22)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.number,
                          style: TextStyle(
                            fontSize: 10.5,
                            color: widget.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: widget.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: widget.color,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // المحتوى
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _expanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 1),
                  const SizedBox(height: 12),
                  // المقدمة
                  Text(
                    widget.intro,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.75,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 14),
                  // المخاطر
                  Row(
                    children: [
                      Icon(Icons.warning_amber_rounded,
                          color: Colors.orange.shade700, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        'المخاطر',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ...widget.hazards.map(
                      (h) => _smallBullet(h, Colors.orange.shade700)),
                  const SizedBox(height: 12),
                  // الحماية
                  Row(
                    children: [
                      Icon(Icons.shield, color: widget.color, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        'إجراءات الحماية',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: widget.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ...widget.protection
                      .map((p) => _smallBullet(p, widget.color)),
                  const SizedBox(height: 10),
                  // التحذير
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Text(
                      widget.warning,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.6,
                        color: Colors.red.shade900,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            secondChild: const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }

  Widget _smallBullet(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, right: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.5,
                height: 1.65,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}