import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/video_section/universal_video_player.dart';
import 'package:class_compass/common/widget/add_new_resource_widget.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_details_model.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/course_faq_widget.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/course_summery_overview_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class CourseDetailsCourseRelatedInformationWidget extends StatelessWidget {
  final CourseDetailsModel courseDetailsModel;
  final String? type;
  const CourseDetailsCourseRelatedInformationWidget({super.key, required this.courseDetailsModel, this.type});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(
      builder: (courseController) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeDefault,
          children: [
            CustomTitle(title: "intro_video", webTitle: ResponsiveHelper.isDesktop(context), leftPadding: 0,),
            Container(width: MediaQuery.sizeOf(context).width - 400, height: (MediaQuery.sizeOf(context).width - 400) * .5, decoration: const BoxDecoration(),

                child: (type == "upload" && courseDetailsModel.data?.courseUploadedVideoPath != null)?
                UniversalVideoPlayer(videoUrl: "${AppConstants.baseUrl}/storage/courses/${courseDetailsModel.data?.courseUploadedVideoPath??""}"):
                (courseDetailsModel.data?.courseVideoUrl != null)?
                UniversalVideoPlayer(videoUrl: courseDetailsModel.data?.courseVideoUrl??""): const SizedBox()
            ),


            const SizedBox(height: Dimensions.paddingSizeDefault,),
            CustomTitle(title: "thumbnail", webTitle: ResponsiveHelper.isDesktop(context),leftPadding: 0,),
            Container(decoration: BoxDecoration(color: Theme.of(context).primaryColor.withValues(alpha: .1)),
              child: CustomImage(fit: BoxFit.contain,
                  width: MediaQuery.sizeOf(context).width - 400, height: (MediaQuery.sizeOf(context).width - 400) * .5,
                  image: "${AppConstants.baseUrl}/storage/courses/${courseDetailsModel.data?.courseImage}"),
            ),

            const SizedBox(height: Dimensions.paddingSizeDefault),

            AddNewResourceWidget(title: "over_view".tr, onTap: (){
              courseController.toggleShowCourseOverView();
            }, width: 100),

            const SizedBox(height: Dimensions.paddingSizeDefault),
            if(courseController.showCourseOverView)
              Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraSmall, children: [
                Center(child: SizedBox(width: Dimensions.webMaxWidth,
                  child: Column(spacing: Dimensions.paddingSizeDefault, children: [
                    CourseSummeryOverviewWidget(courseDetailsModel: courseDetailsModel),
                    Text("details_about_the_course".tr, style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                    Text(courseDetailsModel.data?.courseDescription??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),

                    ClipRRect(borderRadius: BorderRadius.circular(5), child: const CustomImage(width: 600, height: 250, image: '')),
                    CourseFaqWidget(courseDetailsModel: courseDetailsModel),

                  ],
                  ),
                ),
                ),
              ]),
          ],
        );
      }
    );
  }
}
