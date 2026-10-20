import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/authentication/logic/authentication_controller.dart';
import 'package:class_compass/feature/cms_management/cms_settings/controller/frontend_settings_controller.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/policy_enum.dart';
import 'package:class_compass/helper/domain_helper.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/images.dart';

/// Public website of a school (shown at "/" on the school's domain).
/// Content comes from the CMS (banners, about, why choose us, admissions, events, FAQ...)
/// and is wrapped in guide sections that tell parents, learners and staff what to do next.
/// Photos are bundled (free-licence Unsplash photos) and the portal pictures are real
/// screenshots of the parent portal; a school's own CMS images replace them when set.
class SchoolHomePage extends StatefulWidget {
  const SchoolHomePage({super.key});

  @override
  State<SchoolHomePage> createState() => _SchoolHomePageState();
}

class _C {
  static const navy = Color(0xFF043268);
  static const navy2 = Color(0xFF071F45);
  static const blue = Color(0xFF016DF6);
  static const green = Color(0xFF00C090);
  static const mpesa = Color(0xFF00A651);
  static const amber = Color(0xFFF59E0B);
  static const ink = Color(0xFF0B1A33);
  static const text = Color(0xFF45546E);
  static const muted = Color(0xFF6B7A92);
  static const line = Color(0xFFE3E9F2);
  static const bg = Color(0xFFF5F8FC);
  static const soft = Color(0xFFC9D8F2);
}

/// Bundled photos and real portal screenshots.
class _P {
  static const _d = 'assets/image/site';
  static const hero = '$_d/teacher-class.jpg';
  static const classroom = '$_d/classroom.jpg';
  static const smiles = '$_d/smiles.jpg';
  static const learner = '$_d/learner.jpg';
  static const parent = '$_d/parent-phone.jpg';
  static const teacher = '$_d/teacher.jpg';
  static const junior = '$_d/junior.jpg';
  static const sports = '$_d/sports.jpg';
  static const uniforms = '$_d/uniforms.jpg';
  static const lesson = '$_d/hero.jpg';
  static const appDashboard = '$_d/app-parent-dashboard.jpg';
  static const appBalance = '$_d/app-fee-balance.jpg';
  static const appReceipt = '$_d/app-mpesa-receipt.jpg';
}

TextStyle _t(double size, {FontWeight w = FontWeight.w400, Color c = _C.text, double h = 1.55}) =>
    TextStyle(fontFamily: 'OpenSans', fontSize: size, fontWeight: w, color: c, height: h);

String _plain(String? html) => (html ?? '').replaceAll(RegExp(r'<[^>]*>'), ' ').replaceAll('&nbsp;', ' ').replaceAll(RegExp(r'\s+'), ' ').trim();

/// A bundled photo, or a CMS image that falls back to the bundled photo if it cannot load.
Widget _photo(String asset, {String? url, double radius = 0, Alignment align = Alignment.center}) {
  final local = Image.asset(asset, fit: BoxFit.cover, alignment: align, width: double.infinity, height: double.infinity);
  final child = url == null
      ? local
      : CustomImage(image: url, fit: BoxFit.cover, placeholder: asset, width: double.infinity, height: double.infinity);
  return radius == 0 ? child : ClipRRect(borderRadius: BorderRadius.circular(radius), child: child);
}

class _SchoolHomePageState extends State<SchoolHomePage> {
  final _scroll = ScrollController();
  final _keys = {for (final k in ['about', 'programmes', 'portal', 'admissions', 'fees', 'life', 'events', 'faq', 'contact']) k: GlobalKey()};
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // The shared login address has no school website: go straight to sign-in.
    if (DomainHelper.isPortalHost) {
      WidgetsBinding.instance.addPostFrameCallback((_) => Get.offAllNamed(_loggedIn ? RouteHelper.getDashboardRoute() : RouteHelper.getSignInRoute()));
      return;
    }
    final c = Get.find<LandingPageController>();
    c.getBannerData();
    c.getAboutData();
    c.getWhyChooseUsData();
    c.getAdmissionData();
    c.getTestimonialData();
    c.getMobileAppData();
    c.getEventInfoData();
    c.getFaqData();
    final s = Get.find<FrontendSettingsController>();
    if (s.settingModel == null) s.getPublicSetting();
  }

  @override
  void dispose() {
    _scroll.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _go(String key) {
    final ctx = _keys[key]?.currentContext;
    if (ctx != null) Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 650), curve: Curves.easeInOutCubic);
  }

  bool get _loggedIn => Get.find<AuthenticationController>().isLoggedIn();

  void _portal() => Get.toNamed(_loggedIn ? RouteHelper.getDashboardRoute() : RouteHelper.getSignInRoute());

  void _payFees() => Get.toNamed(_loggedIn ? RouteHelper.getPayFeesRoute() : RouteHelper.getSignInRoute());

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: true, brightness: Brightness.light, colorSchemeSeed: _C.blue, fontFamily: 'OpenSans'),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(bottom: false, child: LayoutBuilder(builder: (context, box) {
          final w = box.maxWidth;
          final mobile = w < 760;
          final tablet = w >= 760 && w < 1100;
          return GetBuilder<FrontendSettingsController>(builder: (settings) {
            final data = settings.settingModel?.data;
            final school = (data?.schoolName?.isNotEmpty ?? false) ? data!.schoolName! : AppConstants.appName;
            final phone = data?.phone ?? '';
            final email = data?.email ?? '';
            return GetBuilder<LandingPageController>(builder: (c) {
              return Column(children: [
                if (!mobile) _TopBar(phone: phone, email: email, onPay: _payFees),
                _Nav(school: school, logo: settings.logo, mobile: mobile, tablet: tablet, onLink: _go, onPortal: _portal, onPay: _payFees, loggedIn: _loggedIn),
                Expanded(child: SingleChildScrollView(controller: _scroll, child: Column(children: [
                  _hero(c, school, mobile, tablet),
                  _audiences(mobile, tablet),
                  _about(c, school, mobile),
                  _why(c, mobile, tablet),
                  _programmes(mobile, tablet),
                  _portalSection(c, mobile),
                  _fees(mobile, tablet),
                  _life(mobile),
                  _admissions(c, mobile),
                  _events(c, mobile, tablet),
                  _testimonials(c, mobile, tablet),
                  _faq(c, school),
                  _cta(school, mobile),
                  _contact(data, school, mobile),
                  _footer(school, data, mobile),
                ]))),
              ]);
            });
          });
        })),
      ),
    );
  }

  // ------------------------------------------------------------------ layout helpers

  Widget _wrap(Widget child, {Color? color, Key? key, double v = 88, Gradient? gradient}) => Container(
        key: key,
        width: double.infinity,
        decoration: BoxDecoration(color: color, gradient: gradient),
        padding: EdgeInsets.symmetric(vertical: v),
        child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: child))),
      );

  Widget _heading(String eyebrow, String title, {String? lead, bool center = true, Color eyebrowColor = _C.blue, bool dark = false, bool mobile = false}) => Column(
        crossAxisAlignment: center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          _Eyebrow(eyebrow, color: eyebrowColor, dark: dark),
          const SizedBox(height: 14),
          Text(title, textAlign: center ? TextAlign.center : TextAlign.start,
              style: _t(mobile ? 28 : 38, w: FontWeight.w800, c: dark ? Colors.white : _C.ink, h: 1.15).copyWith(letterSpacing: -0.6)),
          if (lead != null) ...[
            const SizedBox(height: 14),
            ConstrainedBox(constraints: const BoxConstraints(maxWidth: 700), child: Text(lead,
                textAlign: center ? TextAlign.center : TextAlign.start,
                style: _t(17, c: dark ? _C.soft : _C.text))),
          ],
        ],
      );

  Widget _split(bool mobile, Widget a, Widget b, {int fa = 1, int fb = 1, double gap = 64, CrossAxisAlignment cross = CrossAxisAlignment.center}) => mobile
      ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [a, const SizedBox(height: 40), b])
      : Row(crossAxisAlignment: cross, children: [Expanded(flex: fa, child: a), SizedBox(width: gap), Expanded(flex: fb, child: b)]);

  // ------------------------------------------------------------------ hero

  Widget _hero(LandingPageController c, String school, bool mobile, bool tablet) {
    final banners = c.bannerModel?.data ?? [];
    final banner = banners.isNotEmpty ? banners.first : null;
    final title = (banner?.title?.isNotEmpty ?? false) ? banner!.title! : 'A school where every learner discovers their potential';
    final desc = (banner?.description?.isNotEmpty ?? false) ? banner!.description! : 'Quality CBC education, caring teachers and a safe environment — with parents connected every step of the way.';
    final event = _nextEvent(c);
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    final text = Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
      _FadeIn(child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(color: const Color(0x2600C090), borderRadius: BorderRadius.circular(30), border: Border.all(color: const Color(0x6600C090))),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 8, height: 8, decoration: const BoxDecoration(color: _C.green, shape: BoxShape.circle)),
          const SizedBox(width: 10),
          Flexible(child: Text('Welcome to $school', maxLines: 1, overflow: TextOverflow.ellipsis,
              style: _t(14, w: FontWeight.w700, c: Colors.white, h: 1.2))),
        ]),
      )),
      const SizedBox(height: 22),
      _FadeIn(delay: 100, child: Text(title, style: _t(mobile ? 36 : tablet ? 48 : 60, w: FontWeight.w800, c: Colors.white, h: 1.06).copyWith(letterSpacing: -1.2))),
      const SizedBox(height: 20),
      _FadeIn(delay: 200, child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 560),
          child: Text(desc, style: _t(mobile ? 17 : 19, c: const Color(0xFFDCE6F7))))),
      const SizedBox(height: 32),
      _FadeIn(delay: 300, child: Wrap(spacing: 12, runSpacing: 12, children: [
        _Btn('Apply for admission', icon: Icons.arrow_forward, color: _C.green, onTap: () => _go('admissions')),
        _Btn(_loggedIn ? 'Go to my portal' : 'Parent & learner login', ghost: true, icon: Icons.login_rounded, onTap: _portal),
      ])),
      const SizedBox(height: 28),
      _FadeIn(delay: 400, child: Wrap(spacing: 22, runSpacing: 10, children: const [
        _Tick('CBC curriculum', light: true), _Tick('Fees by M-Pesa', light: true), _Tick('Report cards online', light: true),
      ])),
    ]);

    final floating = Column(crossAxisAlignment: CrossAxisAlignment.end, mainAxisSize: MainAxisSize.min, children: [
      _Bob(child: _GlassCard(
        icon: Icons.event_rounded, color: _C.blue, label: 'Next on the calendar',
        value: event == null ? 'See upcoming events' : '${event.$1}${event.$2 != null ? ' · ${event.$2!.day} ${months[event.$2!.month - 1]}' : ''}',
        onTap: () => _go('events'),
      )),
      const SizedBox(height: 16),
      _Bob(delay: 1500, child: Container(
        width: 300,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18),
            boxShadow: const [BoxShadow(color: Color(0x40000000), blurRadius: 40, offset: Offset(0, 18))]),
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(width: 28, height: 28, decoration: BoxDecoration(color: _C.mpesa, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.phone_android_rounded, size: 16, color: Colors.white)),
            const SizedBox(width: 10),
            Expanded(child: Text('Fee payment received', style: _t(14, w: FontWeight.w800, c: _C.ink, h: 1.2))),
          ]),
          const SizedBox(height: 10),
          ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(_P.appReceipt, fit: BoxFit.cover)),
          const SizedBox(height: 6),
          Text('From our parent portal', style: _t(12, c: _C.muted)),
        ]),
      )),
    ]);

    final image = banner?.image != null ? "${AppConstants.imageBaseUrl}/banners/${banner!.image}" : null;
    final heroH = mobile ? null : (tablet ? 640.0 : 700.0);

    final hero = SizedBox(
      height: heroH,
      child: Stack(children: [
        Positioned.fill(child: _photo(_P.hero, url: image, align: Alignment.centerRight)),
        Positioned.fill(child: Container(decoration: BoxDecoration(gradient: LinearGradient(
          begin: mobile ? Alignment.topCenter : Alignment.centerLeft,
          end: mobile ? Alignment.bottomCenter : Alignment.centerRight,
          colors: mobile
              ? const [Color(0xB3041836), Color(0xE6041836)]
              : const [Color(0xF5041836), Color(0xD9041836), Color(0x33041836)],
          stops: mobile ? null : const [0, 0.48, 1],
        )))),
        Padding(
          padding: EdgeInsets.fromLTRB(0, mobile ? 56 : 0, 0, mobile ? 56 : 90),
          child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1200), child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: mobile ? text : Row(children: [
              Expanded(flex: 7, child: text),
              Expanded(flex: 5, child: Align(alignment: Alignment.bottomRight, child: Padding(padding: const EdgeInsets.only(top: 260), child: floating))),
            ]),
          ))),
        ),
      ]),
    );

    final facts = _Facts(mobile: mobile, tablet: tablet);
    if (mobile) {
      return Column(children: [hero, Padding(padding: const EdgeInsets.fromLTRB(20, 24, 20, 8), child: facts)]);
    }
    return Column(children: [
      Stack(clipBehavior: Clip.none, children: [
        hero,
        Positioned(left: 0, right: 0, bottom: -64, child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: facts)))),
      ]),
      const SizedBox(height: 64),
    ]);
  }

  (String, DateTime?)? _nextEvent(LandingPageController c) {
    final now = DateTime.now().subtract(const Duration(days: 1));
    final list = (c.eventModel?.data ?? [])
        .map((e) => (e.name ?? '', DateTime.tryParse(e.startDate ?? '')))
        .where((e) => e.$1.isNotEmpty && (e.$2 == null || e.$2!.isAfter(now)))
        .toList()
      ..sort((a, b) => (a.$2 ?? DateTime(2100)).compareTo(b.$2 ?? DateTime(2100)));
    return list.isEmpty ? null : list.first;
  }

  // ------------------------------------------------------------------ who are you

  Widget _audiences(bool mobile, bool tablet) {
    final items = [
      _Audience(_P.parent, 'Parents & guardians', 'Report cards, attendance, notices and your child\'s fee balance — and pay fees with M-Pesa.', 'Open parent portal', _portal, _C.blue),
      _Audience(_P.learner, 'Learners', 'Your timetable, homework, assignments, exam results and library books in one place.', 'Learner login', _portal, _C.green),
      _Audience(_P.junior, 'New families', 'How to join, what documents to bring and when we admit new learners.', 'How to apply', () => _go('admissions'), _C.amber),
      _Audience(_P.teacher, 'Teachers & staff', 'Take attendance, enter CBC assessments and marks, and share notices with parents.', 'Staff login', _portal, const Color(0xFF7C5CFF)),
    ];
    return _wrap(Column(children: [
      _heading('Start here', 'How can we help you today?', lead: 'Choose who you are to see what you can do on our school portal.', mobile: mobile),
      const SizedBox(height: 44),
      _Grid(cols: mobile ? 1 : tablet ? 2 : 4, gap: 22, children: items.map((i) => _AudienceCard(item: i)).toList()),
    ]), v: mobile ? 64 : 80);
  }

  // ------------------------------------------------------------------ about

  Widget _about(LandingPageController c, String school, bool mobile) {
    final about = c.aboutUsModel?.data;
    final title = (about?.title?.isNotEmpty ?? false) ? about!.title! : 'Welcome to $school';
    final desc = _plain(about?.description).isNotEmpty ? _plain(about?.description)
        : 'We provide a nurturing environment, strong foundations in literacy and numeracy, and plenty of room for talent, sport and values.';
    final img = about?.image != null ? "${AppConstants.imageBaseUrl}/about_us/${about!.image}" : null;

    final text = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _heading('About our school', title, center: false, mobile: mobile),
      const SizedBox(height: 18),
      Text(desc, style: _t(17)),
      const SizedBox(height: 24),
      _Grid(cols: mobile ? 1 : 2, gap: 14, children: const [
        _Feature(Icons.psychology_alt_rounded, 'Competency based', 'Learners grow skills, not just exam scores.'),
        _Feature(Icons.forum_rounded, 'Parents in the loop', 'Notices, reports and fees in the portal.'),
        _Feature(Icons.sports_soccer_rounded, 'Talent & sport', 'Clubs, games, music and leadership.'),
        _Feature(Icons.health_and_safety_rounded, 'Safe & caring', 'Attendance tracked and parents alerted.'),
      ]),
      const SizedBox(height: 28),
      _Btn('Book a school visit', icon: Icons.arrow_forward, onTap: () => _go('contact')),
    ]);

    final collage = SizedBox(height: mobile ? 360 : 540, child: Stack(clipBehavior: Clip.none, children: [
      Positioned(left: 0, top: 0, right: mobile ? 40 : 70, bottom: mobile ? 60 : 90,
          child: _photo(_P.classroom, url: img, radius: 24)),
      Positioned(right: 0, bottom: 0, width: mobile ? 190 : 270, height: mobile ? 150 : 210,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), border: Border.all(color: Colors.white, width: 6),
                boxShadow: const [BoxShadow(color: Color(0x26043268), blurRadius: 40, offset: Offset(0, 16))]),
            child: _photo(_P.smiles, radius: 16),
          )),
      Positioned(left: mobile ? 12 : -18, bottom: mobile ? 24 : 40, child: _Bob(child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Color(0x26043268), blurRadius: 30, offset: Offset(0, 12))]),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 42, height: 42, decoration: BoxDecoration(color: _C.green, borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.workspace_premium_rounded, color: Colors.white)),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Text('CBC report cards', style: _t(15, w: FontWeight.w800, c: _C.ink, h: 1.2)),
            Text('Every term, in the portal', style: _t(13, c: _C.muted, h: 1.3)),
          ]),
        ]),
      ))),
    ]));

    return _wrap(_split(mobile, collage, text, fa: 11, fb: 10), key: _keys['about'], color: _C.bg, v: mobile ? 64 : 96);
  }

  Widget _why(LandingPageController c, bool mobile, bool tablet) {
    final items = c.whyChooseUsModel?.data ?? [];
    if (items.isEmpty) return const SizedBox();
    return _wrap(Column(children: [
      _heading('Why families choose us', 'More than good grades', lead: 'We grow confident, curious and responsible young people.', mobile: mobile),
      const SizedBox(height: 44),
      _Grid(cols: mobile ? 1 : tablet ? 2 : 4, gap: 20, children: items.map((i) => _Card(
        image: i.icon != null ? "${AppConstants.imageBaseUrl}/why_choose_us/${i.icon}" : null,
        icon: Icons.star_rounded, title: i.title ?? '', body: _plain(i.description))).toList()),
    ]), v: mobile ? 64 : 88);
  }

  // ------------------------------------------------------------------ CBC pathway

  Widget _programmes(bool mobile, bool tablet) {
    const levels = [
      ('Pre-Primary', 'PP1 – PP2', 'Ages 4 – 5', 'Play-based learning that builds language, number sense, creativity and social skills.', Icons.toys_rounded, Color(0xFFF59E0B)),
      ('Lower Primary', 'Grade 1 – 3', 'Ages 6 – 8', 'Strong foundations in reading, writing, mathematics and environmental activities.', Icons.abc_rounded, Color(0xFF00C090)),
      ('Upper Primary', 'Grade 4 – 6', 'Ages 9 – 11', 'Science & technology, social studies, agriculture and creative arts with projects.', Icons.science_rounded, Color(0xFF016DF6)),
      ('Junior School', 'Grade 7 – 9', 'Ages 12 – 14', 'Integrated science, pre-technical studies and more, preparing for senior pathways.', Icons.biotech_rounded, Color(0xFF7C5CFF)),
      ('Senior School', 'Grade 10 – 12', 'Ages 15 – 17', 'STEM, social sciences, and arts & sports pathways matched to each learner\'s talent.', Icons.school_rounded, Color(0xFF043268)),
    ];
    return _wrap(Column(children: [
      _heading('Academics', 'Our CBC learning pathway', mobile: mobile,
          lead: 'Learners are assessed on competencies, not just exams. Every term you receive a report showing how your child is doing in each learning area.'),
      const SizedBox(height: 48),
      _Grid(cols: mobile ? 1 : tablet ? 2 : 5, gap: 16, children: [
        for (var i = 0; i < levels.length; i++)
          _Hover(builder: (hover) => AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(0, hover ? -6 : 0, 0),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20),
                border: Border.all(color: hover ? levels[i].$6.withValues(alpha: 0.5) : _C.line),
                boxShadow: hover ? [BoxShadow(color: levels[i].$6.withValues(alpha: 0.18), blurRadius: 36, offset: const Offset(0, 16))] : null),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(width: 48, height: 48, decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: levels[i].$6.withValues(alpha: 0.12)),
                    child: Icon(levels[i].$5, color: levels[i].$6)),
                const Spacer(),
                Text('0${i + 1}', style: _t(28, w: FontWeight.w800, c: const Color(0xFFE3E9F2), h: 1)),
              ]),
              const SizedBox(height: 18),
              Text(levels[i].$1, style: _t(18, w: FontWeight.w800, c: _C.ink, h: 1.25)),
              const SizedBox(height: 4),
              Text(levels[i].$2, style: _t(14, w: FontWeight.w700, c: levels[i].$6)),
              Text(levels[i].$3, style: _t(13, c: _C.muted)),
              const SizedBox(height: 10),
              Text(levels[i].$4, style: _t(14)),
            ]),
          )),
      ]),
      const SizedBox(height: 32),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(color: _C.bg, borderRadius: BorderRadius.circular(18), border: Border.all(color: _C.line)),
        child: Wrap(alignment: WrapAlignment.center, crossAxisAlignment: WrapCrossAlignment.center, spacing: 22, runSpacing: 12, children: [
          Text('How CBC is graded', style: _t(15, w: FontWeight.w800, c: _C.ink)),
          for (final g in const [('EE', 'Exceeding expectations', _C.green), ('ME', 'Meeting expectations', _C.blue), ('AE', 'Approaching expectations', _C.amber), ('BE', 'Below expectations', Color(0xFFEF4444))])
            Row(mainAxisSize: MainAxisSize.min, children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: g.$3, borderRadius: BorderRadius.circular(20)),
                  child: Text(g.$1, style: _t(12, w: FontWeight.w800, c: Colors.white, h: 1.3))),
              const SizedBox(width: 8),
              Text(g.$2, style: _t(14)),
            ]),
        ]),
      ),
    ]), key: _keys['programmes'], v: mobile ? 64 : 96);
  }

  // ------------------------------------------------------------------ parent portal (real screenshots)

  Widget _portalSection(LandingPageController c, bool mobile) {
    final app = (c.mobileAppModel?.data?.isNotEmpty ?? false) ? c.mobileAppModel!.data!.first : null;
    final cms = [app?.featureOne, app?.featureTwo, app?.featureThree].whereType<String>().where((s) => s.isNotEmpty).toList();

    final visual = SizedBox(height: mobile ? 560 : 690, child: Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
      Positioned.fill(child: Center(child: Container(width: mobile ? 300 : 420, height: mobile ? 300 : 420,
          decoration: const BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [Color(0x40016DF6), Color(0x00016DF6)]))))),
      _PhoneFrame(asset: _P.appDashboard, width: mobile ? 240 : 290),
      Positioned(left: mobile ? 0 : 10, top: mobile ? 50 : 70, child: _Bob(child: _ShotCard(asset: _P.appBalance, width: mobile ? 190 : 250, label: 'Live fee balance'))),
      Positioned(right: mobile ? 0 : 0, bottom: mobile ? 50 : 80, child: _Bob(delay: 1500, child: _ShotCard(asset: _P.appReceipt, width: mobile ? 210 : 270, label: 'M-Pesa receipt'))),
    ]));

    final features = [
      (Icons.insert_chart_rounded, 'Report cards', 'CBC assessments and exam results each term.'),
      (Icons.fact_check_rounded, 'Attendance', 'Daily attendance and monthly percentage.'),
      (Icons.account_balance_wallet_rounded, 'Fee statement', 'Balance per term and every receipt.'),
      (Icons.phone_android_rounded, 'Pay with M-Pesa', 'Approve the prompt on your phone.'),
      (Icons.campaign_rounded, 'Notices & events', 'School news the moment it is posted.'),
      (Icons.menu_book_rounded, 'Homework', 'Assignments, timetable and library.'),
    ];

    final text = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _heading('Parent portal', app?.title ?? 'Your child\'s school life, on your phone', center: false, mobile: mobile,
          lead: app?.description ?? 'Log in from any phone or computer to follow progress, stay informed and pay fees — no queues, no lost slips.'),
      if (cms.isNotEmpty) ...[
        const SizedBox(height: 16),
        ...cms.map((s) => Padding(padding: const EdgeInsets.only(bottom: 8), child: _Tick(s, big: true))),
      ],
      const SizedBox(height: 26),
      _Grid(cols: mobile ? 1 : 2, gap: 14, children: features.map((f) => _Feature(f.$1, f.$2, f.$3)).toList()),
      const SizedBox(height: 28),
      Wrap(spacing: 12, runSpacing: 12, children: [
        _Btn(_loggedIn ? 'Open my portal' : 'Log in to the portal', icon: Icons.arrow_forward, onTap: _portal),
        _Btn('Pay school fees', outline: true, onTap: _payFees),
      ]),
      const SizedBox(height: 16),
      Row(children: [
        const Icon(Icons.photo_camera_outlined, size: 16, color: _C.muted),
        const SizedBox(width: 8),
        Expanded(child: Text('Pictures are real screens from the parent portal.', style: _t(13, c: _C.muted))),
      ]),
    ]);

    return _wrap(_split(mobile, text, visual, fa: 10, fb: 11), key: _keys['portal'], v: mobile ? 64 : 96,
        gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFEFF5FF), Colors.white]));
  }

  // ------------------------------------------------------------------ fees

  Widget _fees(bool mobile, bool tablet) {
    final steps = [
      (Icons.login_rounded, 'Log in', 'Use the email or phone number the school registered for you.'),
      (Icons.receipt_long_rounded, 'Open “Pay School Fees”', 'See your child\'s balance for each term and fee item.'),
      (Icons.phone_android_rounded, 'Approve on M-Pesa', 'Enter the amount and your Safaricom number, then your PIN.'),
      (Icons.verified_rounded, 'Get your receipt', 'The payment is posted to the fee statement immediately.'),
    ];
    return _wrap(Column(children: [
      _heading('School fees', 'Pay fees in four simple steps', eyebrowColor: _C.mpesa, mobile: mobile,
          lead: 'Pay with M-Pesa or card from the parent portal — any amount, any time. Part payments are credited to the oldest term first.'),
      const SizedBox(height: 44),
      _Grid(cols: mobile ? 1 : tablet ? 2 : 4, gap: 18, children: [
        for (var i = 0; i < steps.length; i++)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: _C.line)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(width: 48, height: 48, decoration: BoxDecoration(color: const Color(0x1A00A651), borderRadius: BorderRadius.circular(14)),
                    child: Icon(steps[i].$1, color: _C.mpesa)),
                const Spacer(),
                Container(width: 30, height: 30, alignment: Alignment.center, decoration: const BoxDecoration(color: _C.mpesa, shape: BoxShape.circle),
                    child: Text('${i + 1}', style: _t(14, w: FontWeight.w800, c: Colors.white, h: 1))),
              ]),
              const SizedBox(height: 18),
              Text(steps[i].$2, style: _t(17, w: FontWeight.w800, c: _C.ink, h: 1.3)),
              const SizedBox(height: 6),
              Text(steps[i].$3, style: _t(14)),
            ]),
          ),
      ]),
      const SizedBox(height: 28),
      _split(mobile, Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: const Color(0xFFFFF8E6), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFFDE3A7))),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.shield_outlined, color: Color(0xFFB7791F)),
          const SizedBox(width: 12),
          Expanded(child: Text('Stay safe: the school will never ask for your M-Pesa PIN by phone or SMS. Only enter it on your own phone when the prompt appears.',
              style: _t(14, c: const Color(0xFF7A5200)))),
        ]),
      ), Wrap(alignment: WrapAlignment.end, spacing: 12, runSpacing: 12, children: [
        _Btn('Pay fees online', icon: Icons.arrow_forward, color: _C.mpesa, onTap: _payFees),
        _Btn('Talk to the bursar', outline: true, onTap: () => _go('contact')),
      ]), fa: 3, fb: 2, gap: 32),
    ]), key: _keys['fees'], color: _C.bg, v: mobile ? 64 : 96);
  }

  // ------------------------------------------------------------------ life at school (photo gallery)

  Widget _life(bool mobile) {
    final tiles = [
      (_P.sports, 'Sports & games', 'Athletics, football and fun on the field'),
      (_P.lesson, 'Hands-on lessons', 'Small groups and project work'),
      (_P.smiles, 'A happy school', 'Friendship, values and care'),
      (_P.uniforms, 'Assemblies & clubs', 'Leadership, music and drama'),
      (_P.junior, 'Learning together', 'Collaboration in every class'),
    ];
    Widget tile(int i, double h) => SizedBox(height: h, child: _GalleryTile(asset: tiles[i].$1, title: tiles[i].$2, sub: tiles[i].$3));
    return _wrap(Column(children: [
      _heading('Life at school', 'Where learning feels alive', mobile: mobile,
          lead: 'Beyond the classroom, learners discover talents in sport, the arts, clubs and community service.'),
      const SizedBox(height: 44),
      mobile
          ? Column(children: [for (var i = 0; i < tiles.length; i++) Padding(padding: const EdgeInsets.only(bottom: 14), child: tile(i, 230))])
          : SizedBox(height: 520, child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Expanded(flex: 5, child: tile(0, 520)),
              const SizedBox(width: 16),
              Expanded(flex: 7, child: Column(children: [
                Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [Expanded(child: tile(1, 252)), const SizedBox(width: 16), Expanded(child: tile(2, 252))])),
                const SizedBox(height: 16),
                Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [Expanded(child: tile(3, 252)), const SizedBox(width: 16), Expanded(child: tile(4, 252))])),
              ])),
            ])),
    ]), key: _keys['life'], v: mobile ? 64 : 96);
  }

  // ------------------------------------------------------------------ admissions

  Widget _admissions(LandingPageController c, bool mobile) {
    final steps = c.admissionModel?.data ?? [];
    final fallback = [
      ('Enquire & visit', 'Call or visit the school office to tour the school and meet our teachers.'),
      ('Apply', 'Fill in the application form and attach the required documents.'),
      ('Confirm your place', 'Pay the admission fee and complete enrolment before the term starts.'),
    ];
    final items = steps.isNotEmpty ? steps.map((s) => (s.title ?? '', _plain(s.description))).toList() : fallback;

    final stepsCol = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _heading('Admissions', 'Joining us is easy', lead: 'Three simple steps to secure a place for your child.', center: false, eyebrowColor: _C.green, dark: true, mobile: mobile),
      const SizedBox(height: 32),
      for (var i = 0; i < items.length; i++)
        IntrinsicHeight(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Column(children: [
            Container(width: 44, height: 44, alignment: Alignment.center,
                decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [_C.blue, _C.green])),
                child: Text('${i + 1}', style: _t(17, w: FontWeight.w800, c: Colors.white, h: 1))),
            if (i < items.length - 1) Expanded(child: Container(width: 2, margin: const EdgeInsets.symmetric(vertical: 6), color: const Color(0x33FFFFFF))),
          ]),
          const SizedBox(width: 18),
          Expanded(child: Padding(padding: const EdgeInsets.only(bottom: 26, top: 8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(items[i].$1, style: _t(18, w: FontWeight.w800, c: Colors.white, h: 1.25)),
            const SizedBox(height: 4),
            Text(items[i].$2, style: _t(15, c: _C.soft)),
          ]))),
        ])),
    ]);

    final checklist = Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24),
          boxShadow: const [BoxShadow(color: Color(0x40000000), blurRadius: 50, offset: Offset(0, 20))]),
      clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 190, width: double.infinity, child: Stack(fit: StackFit.expand, children: [
          _photo(_P.uniforms, align: const Alignment(0, -0.3)),
          Container(decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0x00000000), Color(0xB3041836)]))),
          Positioned(left: 24, bottom: 18, child: Text('What to bring', style: _t(22, w: FontWeight.w800, c: Colors.white))),
        ])),
        Padding(padding: const EdgeInsets.all(26), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ...['Copy of the learner\'s birth certificate', 'Two recent passport-size photos', 'Last school report or assessment record',
              'Assessment / UPI number (for transfers)', 'Parent or guardian\'s ID and phone number']
              .map((s) => Padding(padding: const EdgeInsets.only(bottom: 12), child: _Tick(s, big: true))),
          const SizedBox(height: 10),
          _Btn('Contact the admissions office', icon: Icons.call, onTap: () => _go('contact')),
        ])),
      ]),
    );

    return _wrap(_split(mobile, stepsCol, checklist, cross: CrossAxisAlignment.start), key: _keys['admissions'], v: mobile ? 64 : 96,
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [_C.navy2, _C.navy]));
  }

  // ------------------------------------------------------------------ events / testimonials / FAQ

  Widget _events(LandingPageController c, bool mobile, bool tablet) {
    final events = c.eventModel?.data ?? [];
    if (events.isEmpty) return const SizedBox(key: ValueKey('no-events'));
    const months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
    return _wrap(Column(children: [
      _heading('What\'s happening', 'Upcoming events', lead: 'Dates for your calendar — sports days, academic clinics, prize giving and more.', mobile: mobile),
      const SizedBox(height: 40),
      _Grid(cols: mobile ? 1 : tablet ? 2 : 3, gap: 18, children: events.take(6).map((e) {
        final d = DateTime.tryParse(e.startDate ?? '');
        return _Hover(builder: (hover) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: hover ? const Color(0x66016DF6) : _C.line),
              boxShadow: hover ? const [BoxShadow(color: Color(0x1A043268), blurRadius: 30, offset: Offset(0, 12))] : null),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(width: 66, padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [_C.navy, _C.blue]), borderRadius: BorderRadius.circular(14)),
                child: Column(children: [
                  Text(d != null ? '${d.day}' : '--', style: _t(24, w: FontWeight.w800, c: Colors.white, h: 1.1)),
                  Text(d != null ? months[d.month - 1] : '', style: _t(11, w: FontWeight.w800, c: _C.green).copyWith(letterSpacing: 1)),
                ])),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(e.name ?? '', style: _t(17, w: FontWeight.w800, c: _C.ink, h: 1.3)),
              if ((e.location ?? '').isNotEmpty) Padding(padding: const EdgeInsets.only(top: 4), child: Row(children: [
                const Icon(Icons.location_on_outlined, size: 15, color: _C.blue),
                const SizedBox(width: 4),
                Expanded(child: Text(e.location!, maxLines: 1, overflow: TextOverflow.ellipsis, style: _t(13, w: FontWeight.w600, c: _C.blue))),
              ])),
              const SizedBox(height: 8),
              Text(_plain(e.details), maxLines: 3, overflow: TextOverflow.ellipsis, style: _t(14)),
            ])),
          ]),
        ));
      }).toList()),
    ]), key: _keys['events'], color: _C.bg, v: mobile ? 64 : 96);
  }

  Widget _testimonials(LandingPageController c, bool mobile, bool tablet) {
    final items = (c.testimonialModel?.data ?? []).where((t) => (t.description ?? '').isNotEmpty).take(3).toList();
    if (items.isEmpty) return const SizedBox();
    return _wrap(Column(children: [
      _heading('Our community', 'What parents and learners say', mobile: mobile),
      const SizedBox(height: 40),
      ConstrainedBox(constraints: BoxConstraints(maxWidth: mobile ? double.infinity : 400.0 * items.length), child: _Grid(cols: mobile ? 1 : (tablet ? 2 : 3).clamp(1, items.length), gap: 18, children: items.map((t) {
        final name = t.user?.name ?? 'Parent';
        return Container(
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: _C.line),
              boxShadow: const [BoxShadow(color: Color(0x0A043268), blurRadius: 24, offset: Offset(0, 10))]),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: List.generate(5, (_) => const Icon(Icons.star_rounded, color: _C.amber, size: 20))),
            const SizedBox(height: 14),
            Text('“${_plain(t.description)}”', style: _t(16, c: _C.ink, h: 1.6)),
            const SizedBox(height: 20),
            Row(children: [
              CircleAvatar(radius: 20, backgroundColor: const Color(0x1A016DF6),
                  child: Text(name.trim().isEmpty ? 'P' : name.trim()[0].toUpperCase(), style: _t(16, w: FontWeight.w800, c: _C.blue, h: 1))),
              const SizedBox(width: 12),
              Expanded(child: Text(name, style: _t(15, w: FontWeight.w700, c: _C.ink))),
            ]),
          ]),
        );
      }).toList())),
    ]), v: mobile ? 64 : 96);
  }

  Widget _faq(LandingPageController c, String school) {
    final cms = (c.faqModel?.data ?? []).where((f) => (f.question ?? '').isNotEmpty).map((f) => (f.question!, _plain(f.answer))).toList();
    final defaults = [
      ('How do I get my parent portal login?', 'The school office creates your account when your child is admitted. If you have not received it, contact the office with your phone number and your child\'s admission number.'),
      ('How do I pay school fees?', 'Log in to the parent portal, open “Pay School Fees”, enter the amount and your Safaricom number, then approve the M-Pesa prompt. You can also pay by card. The receipt appears in the portal immediately.'),
      ('Where can I see my child\'s report card?', 'Report cards are published in the parent portal at the end of each term under Exams. You can download and print them.'),
      ('Who do I contact if my child will be absent?', 'Call or message the class teacher or the school office. You will also get an SMS if your child is marked absent.'),
      ('Can I pay fees in instalments?', 'Yes. You can pay any amount up to the outstanding balance; each payment is credited to the oldest unpaid term first.'),
    ];
    final items = [...cms, ...defaults.where((d) => !cms.any((x) => x.$1 == d.$1))].take(8).toList();
    return _wrap(Column(children: [
      _heading('Help centre', 'Frequently asked questions', lead: 'Quick answers for parents, learners and new families at $school.'),
      const SizedBox(height: 36),
      ConstrainedBox(constraints: const BoxConstraints(maxWidth: 840), child: Column(children: items.map((f) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: _C.line)),
        child: Theme(data: ThemeData(dividerColor: Colors.transparent, useMaterial3: true, colorSchemeSeed: _C.blue), child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
          childrenPadding: const EdgeInsets.fromLTRB(22, 0, 22, 20),
          iconColor: _C.blue, collapsedIconColor: _C.blue,
          title: Text(f.$1, style: _t(16, w: FontWeight.w700, c: _C.ink)),
          expandedAlignment: Alignment.centerLeft,
          children: [Text(f.$2, style: _t(15))],
        )),
      )).toList())),
    ]), key: _keys['faq'], color: _C.bg, v: 88);
  }

  // ------------------------------------------------------------------ CTA, contact, footer

  Widget _cta(String school, bool mobile) => _wrap(Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(28)),
        child: Stack(children: [
          Positioned.fill(child: _photo(_P.junior, align: const Alignment(0, -0.2))),
          Positioned.fill(child: Container(decoration: const BoxDecoration(gradient: LinearGradient(
              begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xF2043268), Color(0xCC016DF6), Color(0x99016DF6)])))),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mobile ? 24 : 56, vertical: mobile ? 40 : 56),
            child: _split(mobile, Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Give your child a great start at $school', style: _t(mobile ? 26 : 34, w: FontWeight.w800, c: Colors.white, h: 1.2)),
              const SizedBox(height: 10),
              Text('Admissions are open. Visit us, meet our teachers and see our classrooms.', style: _t(17, c: const Color(0xFFE3ECFA))),
            ]), Wrap(alignment: WrapAlignment.end, spacing: 12, runSpacing: 12, children: [
              _Btn('Apply for admission', icon: Icons.arrow_forward, color: _C.green, onTap: () => _go('admissions')),
              _Btn('Contact us', ghost: true, onTap: () => _go('contact')),
            ]), fa: 3, fb: 2, gap: 32),
          ),
        ]),
      ), v: mobile ? 48 : 72);

  Widget _contact(dynamic data, String school, bool mobile) {
    final phone = data?.phone ?? '';
    final email = data?.email ?? '';
    final address = (data?.address as String?) ?? '';
    final info = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _heading('Visit or contact us', 'We would love to hear from you', center: false, dark: true, eyebrowColor: _C.green, mobile: mobile,
          lead: 'The school office is open Monday to Friday, 8:00 am – 5:00 pm.'),
      const SizedBox(height: 26),
      if (address.isNotEmpty) _ContactRow(Icons.location_on_rounded, 'Address', address),
      if (phone.isNotEmpty) _ContactRow(Icons.call_rounded, 'Phone', phone, onTap: () => AppConstants.makePhoneCall(phone)),
      if (email.isNotEmpty) _ContactRow(Icons.email_rounded, 'Email', email, onTap: () => AppConstants.sendEmail(email, subject: 'Enquiry')),
      if (address.isEmpty && phone.isEmpty && email.isEmpty) const _ContactRow(Icons.info_outline, 'Contact', 'Contact details will appear here once the school adds them in Website Settings.'),
    ]);
    final box = Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 48, height: 48, decoration: BoxDecoration(color: const Color(0x1A016DF6), borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.mark_email_unread_rounded, color: _C.blue)),
        const SizedBox(height: 16),
        Text('Get school updates', style: _t(21, w: FontWeight.w800, c: _C.ink)),
        const SizedBox(height: 6),
        Text('Leave your email and we will share admission dates, events and important notices.', style: _t(14)),
        const SizedBox(height: 18),
        TextField(controller: _emailController, keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: 'you@example.com', filled: true, fillColor: _C.bg, prefixIcon: const Icon(Icons.alternate_email, size: 20),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: _C.line)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: _C.line)))),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, child: _Btn('Subscribe', onTap: () {
          final e = _emailController.text.trim();
          if (!GetUtils.isEmail(e)) {
            showCustomSnackBar('Enter a valid email address');
            return;
          }
          Get.find<LandingPageController>().newsLetter(e);
          _emailController.clear();
        })),
      ]),
    );
    return _wrap(_split(mobile, info, box, cross: CrossAxisAlignment.start), key: _keys['contact'], v: mobile ? 64 : 88,
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [_C.navy2, _C.navy]));
  }

  Widget _footer(String school, dynamic data, bool mobile) {
    final copyright = _plain(data?.copyrightText as String?).replaceAll('&copy;', '©');
    final links = [('About', 'about'), ('Academics', 'programmes'), ('Parent portal', 'portal'), ('Admissions', 'admissions'), ('Fees', 'fees'), ('FAQ', 'faq'), ('Contact', 'contact')];
    Widget col(String title, List<(String, VoidCallback)> items) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: _t(15, w: FontWeight.w800, c: Colors.white)),
          const SizedBox(height: 12),
          for (final l in items)
            InkWell(onTap: l.$2, child: Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: Text(l.$1, style: _t(14, c: const Color(0xFF9FB3CF))))),
        ]);
    return Container(
      color: const Color(0xFF041431),
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 28),
      child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1200), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Wrap(spacing: 64, runSpacing: 32, children: [
          SizedBox(width: 320, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.asset(Images.logoOnDark, height: 46, fit: BoxFit.contain),
            const SizedBox(height: 16),
            Text(school, style: _t(18, w: FontWeight.w800, c: Colors.white)),
            const SizedBox(height: 6),
            Text('Nurturing skills, values and talent in every learner.', style: _t(14, c: const Color(0xFF9FB3CF))),
          ])),
          col('Explore', links.map((l) => (l.$1, () => _go(l.$2))).toList()),
          col('Portal', [('Parent & learner login', _portal), ('Pay school fees', _payFees), ('Staff login', _portal)]),
          col('Policies', [for (final p in [('Privacy policy', PolicyEnum.privacyPolicy), ('Terms of service', PolicyEnum.termsOfService), ('Cookie policy', PolicyEnum.cookiePolicy)])
              (p.$1, () => Get.toNamed(RouteHelper.getPolicyRoute(p.$2)))]),
        ]),
        const SizedBox(height: 40),
        const Divider(color: Color(0x1FFFFFFF)),
        const SizedBox(height: 16),
        Wrap(alignment: WrapAlignment.spaceBetween, spacing: 20, runSpacing: 8, children: [
          Text(copyright.isNotEmpty ? copyright : '© ${DateTime.now().year} $school', style: _t(13, c: const Color(0xFF9FB3CF))),
          if (!copyright.contains(AppConstants.appName)) Text('Powered by ${AppConstants.appName}', style: _t(13, c: const Color(0xFF9FB3CF))),
        ]),
      ]))),
    );
  }
}

// ------------------------------------------------------------------ small widgets

class _TopBar extends StatelessWidget {
  final String phone, email;
  final VoidCallback onPay;
  const _TopBar({required this.phone, required this.email, required this.onPay});

  @override
  Widget build(BuildContext context) {
    Widget item(IconData i, String s) => Padding(padding: const EdgeInsets.only(right: 22), child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(i, size: 15, color: _C.green),
          const SizedBox(width: 7),
          Text(s, style: _t(13, c: const Color(0xFFD5E1F5), h: 1.2)),
        ]));
    return Container(
      height: 38,
      color: _C.navy2,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1200), child: Row(children: [
        if (phone.isNotEmpty) item(Icons.call_rounded, phone),
        if (email.isNotEmpty) item(Icons.email_outlined, email),
        item(Icons.schedule_rounded, 'Mon – Fri, 8:00 am – 5:00 pm'),
        const Spacer(),
        InkWell(onTap: onPay, child: Row(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.phone_android_rounded, size: 15, color: _C.green),
          const SizedBox(width: 6),
          Text('Pay fees with M-Pesa', style: _t(13, w: FontWeight.w700, c: Colors.white, h: 1.2)),
        ])),
      ]))),
    );
  }
}

class _Nav extends StatelessWidget {
  final String school;
  final String? logo;
  final bool mobile, tablet, loggedIn;
  final void Function(String) onLink;
  final VoidCallback onPortal, onPay;
  const _Nav({required this.school, required this.logo, required this.mobile, required this.tablet, required this.onLink,
      required this.onPortal, required this.onPay, required this.loggedIn});

  static const _links = [('About', 'about'), ('Academics', 'programmes'), ('Portal', 'portal'), ('Admissions', 'admissions'), ('Fees', 'fees'), ('Events', 'events'), ('Contact', 'contact')];

  @override
  Widget build(BuildContext context) {
    final logoH = mobile ? 40.0 : 52.0;
    final brand = SizedBox(
      height: logoH,
      width: logoH * 3.1,
      child: logo != null
          ? CustomImage(image: logo, fit: BoxFit.contain, placeholder: Images.logoWithName)
          : Image.asset(Images.logoWithName, fit: BoxFit.contain),
    );
    return Container(
      height: mobile ? 68 : 82,
      decoration: const BoxDecoration(color: Colors.white,
          boxShadow: [BoxShadow(color: Color(0x0F043268), blurRadius: 18, offset: Offset(0, 4))]),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1200), child: Row(children: [
        Semantics(label: school, child: InkWell(onTap: () => Get.offAllNamed(RouteHelper.getInitialRoute()), child: brand)),
        const Spacer(),
        if (!mobile) ...(tablet ? _links.take(4) : _links).map((l) => _NavLink(l.$1, () => onLink(l.$2))),
        const SizedBox(width: 12),
        if (!mobile && !tablet) ...[_Btn('Pay fees', outline: true, small: true, onTap: onPay), const SizedBox(width: 10)],
        _Btn(loggedIn ? 'My portal' : 'Login', small: true, icon: Icons.arrow_forward, onTap: onPortal),
        if (mobile) IconButton(icon: const Icon(Icons.menu_rounded, color: _C.navy, size: 28), onPressed: () {
          showModalBottomSheet(context: context, backgroundColor: Colors.white, showDragHandle: true,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
              builder: (_) => SafeArea(child: Column(mainAxisSize: MainAxisSize.min, children: [
            for (final l in _links) ListTile(title: Text(l.$1, style: _t(16, w: FontWeight.w600, c: _C.ink)), trailing: const Icon(Icons.chevron_right, color: _C.muted), onTap: () {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 250), () => onLink(l.$2));
            }),
            Padding(padding: const EdgeInsets.fromLTRB(16, 8, 16, 16), child: SizedBox(width: double.infinity, child: _Btn('Pay fees with M-Pesa', color: _C.mpesa, onTap: () {
              Navigator.pop(context);
              onPay();
            }))),
          ])));
        }),
      ]))),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink(this.label, this.onTap);

  @override
  Widget build(BuildContext context) => _Hover(builder: (hover) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(label, style: _t(15, w: FontWeight.w600, c: hover ? _C.blue : _C.ink, h: 1.2)),
          const SizedBox(height: 4),
          AnimatedContainer(duration: const Duration(milliseconds: 180), height: 2, width: hover ? 18 : 0, color: _C.blue),
        ])),
      ));
}

class _Eyebrow extends StatelessWidget {
  final String text;
  final Color color;
  final bool dark;
  const _Eyebrow(this.text, {required this.color, this.dark = false});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: color.withValues(alpha: dark ? 0.18 : 0.1), borderRadius: BorderRadius.circular(30)),
        child: Text(text.toUpperCase(), style: _t(12, w: FontWeight.w800, c: color, h: 1.2).copyWith(letterSpacing: 1.3)),
      );
}

/// Key facts under the hero. Only true statements about how the school works (no invented numbers).
class _Facts extends StatelessWidget {
  final bool mobile, tablet;
  const _Facts({required this.mobile, required this.tablet});

  @override
  Widget build(BuildContext context) {
    const facts = [
      (Icons.school_rounded, 'PP1 – Grade 9', 'CBC learning pathway', _C.blue),
      (Icons.calendar_month_rounded, '3 terms', 'Report card every term', _C.green),
      (Icons.phone_android_rounded, 'M-Pesa', 'Pay fees from your phone', _C.mpesa),
      (Icons.devices_rounded, '24/7 portal', 'Results, attendance & notices', Color(0xFF7C5CFF)),
    ];
    final cells = [
      for (final f in facts)
        Padding(padding: const EdgeInsets.all(20), child: Row(children: [
          Container(width: 52, height: 52, decoration: BoxDecoration(color: f.$4.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(16)),
              child: Icon(f.$1, color: f.$4, size: 26)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(f.$2, style: _t(20, w: FontWeight.w800, c: _C.ink, h: 1.2)),
            Text(f.$3, style: _t(13, c: _C.muted, h: 1.35)),
          ])),
        ])),
    ];
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22), border: Border.all(color: _C.line),
          boxShadow: const [BoxShadow(color: Color(0x1F043268), blurRadius: 50, offset: Offset(0, 20))]),
      child: _Grid(cols: mobile ? 1 : tablet ? 2 : 4, gap: 0, children: cells),
    );
  }
}

class _Audience {
  final String image, title, body, action;
  final VoidCallback onTap;
  final Color color;
  _Audience(this.image, this.title, this.body, this.action, this.onTap, this.color);
}

class _AudienceCard extends StatelessWidget {
  final _Audience item;
  const _AudienceCard({required this.item});

  @override
  Widget build(BuildContext context) => _Hover(builder: (hover) => GestureDetector(
        onTap: item.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          transform: Matrix4.translationValues(0, hover ? -6 : 0, 0),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22), border: Border.all(color: hover ? Colors.transparent : _C.line),
              boxShadow: [BoxShadow(color: const Color(0xFF043268).withValues(alpha: hover ? 0.14 : 0.04), blurRadius: hover ? 44 : 20, offset: const Offset(0, 14))]),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 190, width: double.infinity, child: Stack(fit: StackFit.expand, children: [
              AnimatedScale(scale: hover ? 1.06 : 1, duration: const Duration(milliseconds: 400), child: _photo(item.image, align: const Alignment(0, -0.4))),
              Container(decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0x00000000), Color(0x66000000)]))),
              Positioned(left: 16, bottom: 14, child: Container(width: 10, height: 10, decoration: BoxDecoration(color: item.color, shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2)))),
            ])),
            Padding(padding: const EdgeInsets.fromLTRB(22, 20, 22, 22), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item.title, style: _t(19, w: FontWeight.w800, c: _C.ink, h: 1.25)),
              const SizedBox(height: 8),
              Text(item.body, style: _t(14.5)),
              const SizedBox(height: 16),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Text(item.action, style: _t(15, w: FontWeight.w700, c: _C.blue)),
                AnimatedPadding(duration: const Duration(milliseconds: 200), padding: EdgeInsets.only(left: hover ? 10 : 6),
                    child: const Icon(Icons.arrow_forward, size: 17, color: _C.blue)),
              ]),
            ])),
          ]),
        ),
      ));
}

class _Feature extends StatelessWidget {
  final IconData icon;
  final String title, body;
  const _Feature(this.icon, this.title, this.body);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: _C.line)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(colors: [Color(0x1F016DF6), Color(0x2900C090)])), child: Icon(icon, color: _C.blue, size: 21)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: _t(15, w: FontWeight.w800, c: _C.ink, h: 1.3)),
            const SizedBox(height: 2),
            Text(body, style: _t(13.5, h: 1.45)),
          ])),
        ]),
      );
}

class _GlassCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label, value;
  final VoidCallback onTap;
  const _GlassCard({required this.icon, required this.color, required this.label, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0x2EFFFFFF), borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0x4DFFFFFF))),
          child: Row(children: [
            Container(width: 42, height: 42, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: Colors.white, size: 22)),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(label, style: _t(12, c: const Color(0xFFD5E1F5), h: 1.2)),
              const SizedBox(height: 2),
              Text(value, maxLines: 2, overflow: TextOverflow.ellipsis, style: _t(15, w: FontWeight.w800, c: Colors.white, h: 1.3)),
            ])),
          ]),
        ),
      );
}

/// A real portal screenshot in a phone outline.
class _PhoneFrame extends StatelessWidget {
  final String asset;
  final double width;
  const _PhoneFrame({required this.asset, required this.width});

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: const Color(0xFF0B1A33), borderRadius: BorderRadius.circular(width * 0.15),
            boxShadow: const [BoxShadow(color: Color(0x40043268), blurRadius: 60, offset: Offset(0, 30))]),
        child: ClipRRect(borderRadius: BorderRadius.circular(width * 0.12), child: Image.asset(asset, fit: BoxFit.cover)),
      );
}

class _ShotCard extends StatelessWidget {
  final String asset, label;
  final double width;
  const _ShotCard({required this.asset, required this.width, required this.label});

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18),
            boxShadow: const [BoxShadow(color: Color(0x2E043268), blurRadius: 40, offset: Offset(0, 18))]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(asset, fit: BoxFit.cover)),
          Padding(padding: const EdgeInsets.fromLTRB(6, 8, 6, 2), child: Row(children: [
            Container(width: 8, height: 8, decoration: const BoxDecoration(color: _C.green, shape: BoxShape.circle)),
            const SizedBox(width: 8),
            Text(label, style: _t(12.5, w: FontWeight.w700, c: _C.ink, h: 1.2)),
          ])),
        ]),
      );
}

class _GalleryTile extends StatelessWidget {
  final String asset, title, sub;
  const _GalleryTile({required this.asset, required this.title, required this.sub});

  @override
  Widget build(BuildContext context) => _Hover(builder: (hover) => ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(fit: StackFit.expand, children: [
          AnimatedScale(scale: hover ? 1.06 : 1, duration: const Duration(milliseconds: 500), curve: Curves.easeOutCubic, child: _photo(asset)),
          Container(decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: [Color(0x00000000), Color(0x00000000), Color(0xCC041836)], stops: [0, 0.45, 1]))),
          Positioned(left: 20, right: 20, bottom: 18, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: _t(19, w: FontWeight.w800, c: Colors.white, h: 1.25)),
            Text(sub, style: _t(14, c: const Color(0xFFDCE6F7), h: 1.4)),
          ])),
        ]),
      ));
}

class _Btn extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool outline, ghost, small;
  final IconData? icon;
  final Color? color;
  const _Btn(this.label, {required this.onTap, this.outline = false, this.ghost = false, this.small = false, this.icon, this.color});

  @override
  State<_Btn> createState() => _BtnState();
}

class _BtnState extends State<_Btn> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final solid = !widget.outline && !widget.ghost;
    final base = widget.color ?? _C.blue;
    final bg = solid ? base : widget.ghost ? (_hover ? const Color(0x33FFFFFF) : const Color(0x1AFFFFFF)) : (_hover ? _C.bg : Colors.white);
    final fg = solid || widget.ghost ? Colors.white : _C.navy;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        transform: Matrix4.translationValues(0, _hover ? -2 : 0, 0),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: solid ? null : Border.all(color: widget.ghost ? const Color(0x66FFFFFF) : _C.line, width: 1.5),
          boxShadow: solid ? [BoxShadow(color: base.withValues(alpha: _hover ? 0.4 : 0.25), blurRadius: 22, offset: const Offset(0, 10))] : null,
        ),
        child: Material(color: Colors.transparent, child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: widget.onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.small ? 18 : 24, vertical: widget.small ? 11 : 16),
            child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(widget.label, style: _t(widget.small ? 14 : 16, w: FontWeight.w700, c: fg, h: 1.2)),
              if (widget.icon != null) ...[const SizedBox(width: 10), Icon(widget.icon, size: widget.small ? 16 : 18, color: fg)],
            ]),
          ),
        )),
      ),
    );
  }
}

class _Tick extends StatelessWidget {
  final String text;
  final bool big, light;
  const _Tick(this.text, {this.big = false, this.light = false});

  @override
  Widget build(BuildContext context) => Row(mainAxisSize: big ? MainAxisSize.max : MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(padding: const EdgeInsets.only(top: 3), child: Icon(Icons.check_circle_rounded, size: big ? 20 : 17, color: _C.green)),
        const SizedBox(width: 8),
        big
            ? Expanded(child: Text(text, style: _t(16, c: _C.text)))
            : Text(text, style: _t(14.5, w: FontWeight.w600, c: light ? const Color(0xFFDCE6F7) : _C.muted)),
      ]);
}

class _Card extends StatelessWidget {
  final IconData icon;
  final String? image;
  final String title;
  final String body;
  const _Card({required this.icon, this.image, required this.title, required this.body});

  @override
  Widget build(BuildContext context) => _Hover(builder: (hover) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, hover ? -4 : 0, 0),
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: hover ? Colors.transparent : _C.line),
          boxShadow: hover ? const [BoxShadow(color: Color(0x1A043268), blurRadius: 40, offset: Offset(0, 16))] : null,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          image != null
              ? ClipRRect(borderRadius: BorderRadius.circular(14), child: SizedBox(width: 52, height: 52, child: CustomImage(image: image, fit: BoxFit.cover)))
              : Container(width: 52, height: 52, decoration: BoxDecoration(borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(colors: [Color(0x1F016DF6), Color(0x2900C090)])), child: Icon(icon, color: _C.blue)),
          const SizedBox(height: 18),
          Text(title, style: _t(18, w: FontWeight.w800, c: _C.ink, h: 1.3)),
          const SizedBox(height: 8),
          Text(body, style: _t(15)),
        ]),
      ));
}

/// Equal-width grid that sizes rows to their content (no fixed aspect ratio).
class _Grid extends StatelessWidget {
  final int cols;
  final double gap;
  final List<Widget> children;
  const _Grid({required this.cols, required this.children, this.gap = 18});

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i += cols) {
      final slice = children.sublist(i, (i + cols).clamp(0, children.length));
      rows.add(IntrinsicHeight(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        for (var j = 0; j < cols; j++) ...[
          if (j > 0) SizedBox(width: gap),
          Expanded(child: j < slice.length ? _FadeIn(delay: 70 * j, child: slice[j]) : const SizedBox()),
        ],
      ])));
      if (i + cols < children.length) rows.add(SizedBox(height: gap));
    }
    return Column(children: rows);
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label, text;
  final VoidCallback? onTap;
  const _ContactRow(this.icon, this.label, this.text, {this.onTap});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(14), child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: const Color(0x0FFFFFFF), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0x1AFFFFFF))),
          child: Row(children: [
            Container(width: 44, height: 44, decoration: BoxDecoration(color: const Color(0x2600C090), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: _C.green, size: 22)),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(label, style: _t(12.5, c: const Color(0xFF9FB3CF), h: 1.3)),
              Text(text, style: _t(16, w: FontWeight.w600, c: Colors.white, h: 1.4)),
            ])),
          ]),
        )),
      );
}

/// Rebuilds its child with a hover flag (desktop web); no effect on touch screens.
class _Hover extends StatefulWidget {
  final Widget Function(bool hover) builder;
  const _Hover({required this.builder});

  @override
  State<_Hover> createState() => _HoverState();
}

class _HoverState extends State<_Hover> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: widget.builder(_hover),
      );
}

/// Fades and slides a widget in once it is built.
class _FadeIn extends StatelessWidget {
  final Widget child;
  final int delay;
  const _FadeIn({required this.child, this.delay = 0});

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: Duration(milliseconds: 650 + delay),
        curve: Interval(delay / (650 + delay), 1, curve: Curves.easeOutCubic),
        builder: (_, v, c) => Opacity(opacity: v, child: Transform.translate(offset: Offset(0, 18 * (1 - v)), child: c)),
        child: child,
      );
}

/// Gentle floating motion for the hero cards.
class _Bob extends StatefulWidget {
  final Widget child;
  final int delay;
  const _Bob({required this.child, this.delay = 0});

  @override
  State<_Bob> createState() => _BobState();
}

class _BobState extends State<_Bob> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(seconds: 3));

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _c.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _c,
        builder: (_, child) => Transform.translate(offset: Offset(0, -7 * Curves.easeInOut.transform(_c.value)), child: child),
        child: widget.child,
      );
}
