
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/my_course_details_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/screens/frontend_lesson_screen.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/screens/frontend_live_class_list_screen.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/course_attempt_dialog_widget.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/quiz_exam_screen.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class MyCourseDetailsLeftMenuWidget extends StatelessWidget {
  final double top;
  final double left;
  const MyCourseDetailsLeftMenuWidget({super.key, required this.top, required this.left});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FrontendCourseController>(
      builder: (courseController) {
        MyCourseDetailsModel? courseDetailsModel = courseController.myCourseDetailsModel;
        return courseDetailsModel != null?
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if(!courseController.hideLeftMenu)
          CustomContainer(onTap: (){
            ResponsiveHelper.isDesktop(context)?
            courseController.toggleLiveClass(true):
                Get.to(()=> const FrontendLiveClassListScreen());
          },
            width:  ResponsiveHelper.isDesktop(context)?
          Get.width/2.5: Get.width, verticalPadding: 5,
            borderRadius: 5, showShadow: false, border: Border.all(width: .125, color: Theme.of(context).hintColor),
            color: Theme.of(context).primaryColorDark.withValues(alpha: .05),
            child: Padding(padding: const EdgeInsets.all(8.0),
                child: Text("live_class".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
          ),

          Expanded(child: ListView.builder(
              itemCount: courseDetailsModel.data?.courseChapters?.length??0,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, topicIndex){
                CourseChapters? courseChapters = courseDetailsModel.data?.courseChapters?[topicIndex];
                return ExpansionTile(showTrailingIcon: false,tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,dense: true,
                    title: CustomContainer(color: Theme.of(context).primaryColorDark.withValues(alpha: .05),
                        border: Border.all(color: Theme.of(context).hintColor, width: .25),
                        showShadow: false, borderRadius: 5,child: Row(children: [
                          Icon(Icons.keyboard_arrow_right, size: 16, color: Theme.of(context).hintColor),
                          Expanded(child: Text(courseChapters?.chapterTitle??'',maxLines: 1, overflow: TextOverflow.ellipsis,
                              style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
                        ])), expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      ListView.builder(
                          itemCount: courseChapters?.contents?.length??0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, lessonIndex){
                            Contents? contents = courseChapters?.contents?[lessonIndex];

                              DateTime scheduledAt = DateTime.parse(contents?.scheduledAt?? DateTime.now().toString());
                            DateTime quizStartSchedule = DateTime.parse(contents?.startTime?? DateTime.now().toString());
                              DateTime today = DateTime.now();
                              DateTime todayOnly = DateTime(today.year, today.month, today.day);



                            return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, 0, Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall),
                              child: CustomContainer(color: Theme.of(context).secondaryHeaderColor.withValues(alpha: .1),
                                  onTap: (){
                                courseController.getMyCourseLessonDetails(contents!.type!, contents.typeId!.toString());
                                if(contents.videoType == "cipher"){
                                  Get.find<FrontendCourseController>().getVideoCipherOtp(Get.find<ProfileController>().profileModel?.data?.name??"N?A", Get.find<ProfileController>().profileModel?.data?.email??"N?A", "${contents.videoUrl}");
                                }
                                    if(contents.type == "quiz" && contents.startTime != null  && !quizStartSchedule.isBefore(todayOnly)){
                                      showCustomSnackBar("Quiz is not started yet");
                                    }else if(contents.scheduledAt != null && contents.isScheduled == 1 && !scheduledAt.isBefore(todayOnly)){
                                      showCustomSnackBar("Lesson is not published yet");
                                    }


                                else if(contents.type == "quiz") {
                                  Get.dialog(CourseAttemptDialogWidget(onTap: (){
                                    Get.back();
                                    Get.find<FrontendCourseController>().getQuizDetails(contents.typeId!);
                                    Get.find<FrontendCourseController>().quizAttempt(contents.typeId!);
                                    if(!ResponsiveHelper.isDesktop(context)){
                                      Get.to(()=> const QuizExamScreen());
                                    }
                                  }));
                                  courseController.setSelectedContent(contents);

                                }else if(contents.videoType == "document" && kIsWeb){
                                  showCustomSnackBar("please_use_mobile_app_to_view_document".tr);
                                }else{

                                  courseController.setSelectedContent(contents);
                                    if(!ResponsiveHelper.isDesktop(context)){
                                      Get.to(()=> FrontendLessonScreen(top: top, left: left));

                                    }
                                }
                                  },
                                  verticalPadding: 5,
                                  border: Border.all(color: Theme.of(context).hintColor, width: .05),
                                  showShadow: false, borderRadius: 5,
                                  child: Row(spacing: Dimensions.paddingSizeSmall,
                                    children: [
                                      if(contents?.isSelected == true)
                                      Icon(Icons.radio_button_checked, color: Theme.of(context).secondaryHeaderColor,size: 20),
                                      Expanded(
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                          Text(AppConstants.htmlToPlainText(contents?.title??''), style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                                          Row(spacing: Dimensions.paddingSizeSmall, children: [
                                            Expanded(child: Text("${contents?.type}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).hintColor))),
                                            if (contents?.playbackHours != null && contents?.playbackMinutes != null && contents?.playbackSeconds != null &&
                                              (contents?.playbackHours != 0 || contents?.playbackMinutes != 0 || contents?.playbackSeconds != 0))
                                              Text(contents?.type == "lesson"
                                                  ? "${(contents?.playbackHours ?? 0).toString().padLeft(2, '0')}:${(contents?.playbackMinutes ?? 0).toString().padLeft(2, '0')}:${(contents?.playbackSeconds ?? 0).toString().padLeft(2, '0')}" : "",
                                                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).hintColor))]),

                                          if(contents?.scheduledAt != null && contents?.isScheduled == 1 && !scheduledAt.isBefore(todayOnly))
                                          Text("${"Schedule at"}: ${contents?.scheduledAt}",
                                              style: textRegular.copyWith(color: Colors.red, fontSize: Dimensions.fontSizeExtraSmall)),

                                          if(contents?.type == "quiz" && contents?.startTime != null  && !quizStartSchedule.isBefore(todayOnly))
                                            Text("${"Schedule at"}: ${contents!.startTime!}",
                                                style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).colorScheme.error)),
                                        ]))])),
                            );
                          }),

                    ]);
              }))
        ]):Center(child: CircularProgressIndicator(color: systemLandingPagePrimaryColor()));
      }
    );
  }
}
