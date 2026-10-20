import 'package:flutter/material.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/my_course_details_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/course_details_information_details_widget.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/frontend_course_summery_overview_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class FrontendCourseDetailsWidget extends StatelessWidget {
  final MyCourseDetailsModel courseDetailsModel;
  const FrontendCourseDetailsWidget({super.key, required this.courseDetailsModel});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      child: ResponsiveHelper.isDesktop(context) ?
      CourseDetailsInformationDetailsWidget(courseDetailsModel: courseDetailsModel):
      SingleChildScrollView(
        child: Padding(padding: EdgeInsets.symmetric(horizontal:ResponsiveHelper.isDesktop(context)? Dimensions.paddingSizeDefault : 0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeLarge, children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: FrontendCourseSummeryOverviewWidget(courseDetailsModel: courseDetailsModel),
            ),
            SingleChildScrollView(child: CourseDetailsInformationDetailsWidget(courseDetailsModel: courseDetailsModel)),
          ]),
        ),
      ),
    );
  }
}

