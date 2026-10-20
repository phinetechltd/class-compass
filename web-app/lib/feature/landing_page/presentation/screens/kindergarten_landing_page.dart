import 'package:flutter/material.dart';
import 'package:class_compass/common/layout/base_layout.dart';
import 'package:class_compass/feature/landing_page/presentation/kindergarten/kinderdarten_our_program_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/kindergarten/kindergarten_about_us.dart';
import 'package:class_compass/feature/landing_page/presentation/kindergarten/kindergarten_banner_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/kindergarten/kindergarten_event_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/kindergarten/kindergarten_faq_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/kindergarten/kindergarten_stay_connected_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/kindergarten/kindergarten_teachers_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/kindergarten/kindergarten_testimonial_section.dart';
import 'package:class_compass/feature/landing_page/presentation/kindergarten/kindergarten_why_chose_us_widget.dart';

class KindergartenLandingPage extends StatefulWidget {
  const KindergartenLandingPage({super.key});

  @override
  State<KindergartenLandingPage> createState() => _KindergartenLandingPageState();
}

class _KindergartenLandingPageState extends State<KindergartenLandingPage> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      scrollController: scrollController,
      child: const Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        KindergartenBannerWidget(),
        KindergartenAboutUsWidget(),
        KindergartenWhyChooseUsWidget(),
        KindergartenOurProgramWidget(),
        KindergartenTeachersWidget(),
        KindergartenTestimonialSection(),
        KindergartenStayConnectedWidget(),
        KindergartenFaqWidget(),
        KindergartenEventWidget(),
        KindergartenBannerWidget(footer: true)

        ],
      ),
    );
  }
}
