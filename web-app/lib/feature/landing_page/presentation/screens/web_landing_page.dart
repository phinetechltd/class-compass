import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/base_layout.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/banner/banner_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/about_us/about_us.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/gallery/gallery_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/why_choose_us/why_chose_us_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/admission/admisssions_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/teacher/teachers_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/testimonial/testimonial_section.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/mobile_app_section/stay_connected_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/event/event_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/faq/faq_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/screens/mobile_landing_page.dart';
import 'package:class_compass/helper/responsive_helper.dart';

class WebLandingPage extends StatefulWidget {
  const WebLandingPage({super.key});

  @override
  State<WebLandingPage> createState() => _WebLandingPageState();
}

class _WebLandingPageState extends State<WebLandingPage> {
  final ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveHelper.isDesktop(context);
    return isDesktop?
    BaseLayout(scrollController: scrollController,
      child: GetBuilder<LandingPageController>(builder: (landingPageController) {
          return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              buildSection(landingPageController.sectionKeys[0], const BannerWidget()),
              buildSection(landingPageController.sectionKeys[1], const AboutUsWidget()),
              buildSection(landingPageController.sectionKeys[2], const WhyChooseUsWidget()),
              // buildSection(landingPageController.sectionKeys[3], const FrontendCourseWidget()),
              buildSection(landingPageController.sectionKeys[3], const AdmissionsWidget()),
              buildSection(landingPageController.sectionKeys[4], const TeachersWidget()),
              buildSection(landingPageController.sectionKeys[5], const GalleryWidget()),
              buildSection(landingPageController.sectionKeys[6], const TestimonialSection()),
              buildSection(landingPageController.sectionKeys[7], const StayConnectedWidget()),
              buildSection(landingPageController.sectionKeys[8], const EventWidget()),
              buildSection(landingPageController.sectionKeys[9], const FaqWidget()),
            ],
          );
        },
      ),
    ): const MobileLandingPage();
  }

  Widget buildSection(GlobalKey key, Widget child) {
    return Container(key: key, child: child);
  }
}
