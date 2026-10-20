import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/coutom_royte_path/custom_route_path_widget.dart';
import 'package:class_compass/common/secure_pdf_viwer/video_pdf_and_image_viewer_widget.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_details_model.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/course_details_corse_related_information_widget.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/course_details_left_section_chapte_content_widget.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/course_zoom_widget.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/my_course_details_lesson_details_widget.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/my_course_details_live_class_widget.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/videocipher_otp_player.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class CourseDetailsWidget extends StatefulWidget {
  final String? id;
  const CourseDetailsWidget({super.key, this.id});

  @override
  State<CourseDetailsWidget> createState() => _CourseDetailsWidgetState();
}

class _CourseDetailsWidgetState extends State<CourseDetailsWidget> {


  @override
  void initState() {
    if(widget.id != null){
      Get.find<CourseController>().getCourseDetails(widget.id.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(
      builder: (courseController) {
        CourseDetailsModel? courseDetailsModel = courseController.courseDetailsModel;
        var type = courseDetailsModel?.data?.courseVideoType;
        return courseDetailsModel != null?
        Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomRoutePathWidget(title: "course_management".tr, subWidget: Row(children: [
              PathItemWidget(title: courseDetailsModel.data?.courseTitle??'',color: systemPrimaryColor(), onTap: (){
                Get.back();
              }),
            ])),

            ResponsiveHelper.isDesktop(context)?
            CustomContainer(showShadow: false, borderRadius: 5, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CourseZoomWidget(courseDetailsModel: courseDetailsModel,),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(width: ResponsiveHelper.isDesktop(context)? 400 : Get.width- 50,
                    child: CourseDetailsLeftSectionChapterContentWidget(courseDetailsModel: courseDetailsModel)),
                if(courseController.showWholePage)
                Expanded(child: CourseDetailsCourseRelatedInformationWidget(courseDetailsModel: courseDetailsModel,type: type,)),
                if(courseController.selectedContent != null && courseController.selectedContent?.type == "lesson" && !courseController.showWholePage)
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    (courseController.selectedContent?.videoType == "cipher")?
                    SizedBox(height: (Get.width- 450)/3,child: const VdoCipherCustomPlayer()):
                    (courseController.selectedContent?.videoType != "text")?
                    const VideoPdfAndImageViewerWidget():const SizedBox(),
                    const MyCourseDetailsLessonDetailsWidget(),

                  ])),
                if(courseController.selectedContent == null && courseController.showLiveClass)
                  const Expanded(child: MyCourseDetailsLiveClassWidget()),

                // if(courseController.selectedContent != null && courseController.selectedContent?.type == "quiz" && courseController.quizDetailsModel != null)
                //   Expanded(child: QuizExamWidget()),
              ]),

            ])):CourseDetailsLeftSectionChapterContentWidget(courseDetailsModel: courseDetailsModel),

          ]),
        ):Center(child: Padding(padding: ThemeShadow.getPadding(),
          child: const CircularProgressIndicator()));
      }
    );
  }
}
