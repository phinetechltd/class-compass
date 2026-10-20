import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/feature/authentication/logic/authentication_controller.dart';
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
import 'package:class_compass/feature/profile/presentation/widgets/header_profile_info_dropdown.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class MobileLandingPage extends StatefulWidget {
  const MobileLandingPage({super.key});

  @override
  State<MobileLandingPage> createState() => _MobileLandingPageState();
}

class _MobileLandingPageState extends State<MobileLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(
       actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        child: GetBuilder<AuthenticationController>(
            builder: (authenticationController) {
              return authenticationController.isLoggedIn()?
              const HeaderProfileInfoMenu():
              IntrinsicWidth(child: CustomButton(height: 35, onTap: (){
                Get.toNamed(RouteHelper.getSignInRoute());
              }, text: "login".tr));
            }
        ),
      ),
    ],
    ),
    body: CustomScrollView(slivers: [
      SliverToBoxAdapter(child: GetBuilder<LandingPageController>(builder: (landingPageController) {
          return Column(children: [
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
          ]);
        }
      ))
    ]));

  }
  Widget buildSection(GlobalKey key, Widget child) {
    return Container(key: key, child: child);
  }
}
