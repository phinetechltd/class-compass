
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/my_course_details_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/frontend_course_details_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/landing_page_appbar.dart';
import 'package:class_compass/helper/responsive_helper.dart';


class FrontendCourseDetailsScreen extends StatefulWidget {
  final String? slug;
  const FrontendCourseDetailsScreen({super.key, required this.slug});

  @override
  State<FrontendCourseDetailsScreen> createState() => _FrontendCourseDetailsScreenState();
}

class _FrontendCourseDetailsScreenState extends State<FrontendCourseDetailsScreen> {
  ScrollController scrollController = ScrollController();


  @override
  void initState() {
    Get.find<FrontendCourseController>().getCourseDetails(widget.slug!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop =  ResponsiveHelper.isDesktop(context);
    return Scaffold(
      appBar: isDesktop? const LandingPageAppBar(): CustomAppBar(title: "course_details".tr),
      body: GetBuilder<FrontendCourseController>(
        builder: (courseController) {
          MyCourseDetailsModel? courseDetailsModel = courseController.courseDetailsModel;
          return courseDetailsModel != null?
          FrontendCourseDetailsWidget(courseDetailsModel: courseDetailsModel):
          const Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
}
