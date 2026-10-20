import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/add_new_resource_widget.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_details_model.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/course_activity_or_resource_type_dialog.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class AddNewLessonAndOnlineWidget extends StatelessWidget {
  final CourseDetailsModel courseDetailsModel;
  final CourseChapters? courseChapters;
  final int topicIndex;
  const AddNewLessonAndOnlineWidget({super.key, required this.courseDetailsModel, this.courseChapters, required this.topicIndex});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(
      builder: (courseController) {
        return Padding(padding: const EdgeInsets.fromLTRB( 55, 0 , 55, 10),
          child: Row(spacing: Dimensions.paddingSizeSmall, children: [
            AddNewResourceWidget(title: "lesson".tr,onTap: (){
              courseController.resetSelectedContent();
              courseController.setSelectedChapterAndCourseId(courseDetailsModel.data!.courseId!, courseDetailsModel.data!.courseChapters![topicIndex].chapterId! );
              Get.dialog(Dialog(child: CourseActivityOrResourceTypeDialog(title: courseChapters?.chapterTitle??'',)));
            }, width: 90),

            AddNewResourceWidget(title: "online".tr,onTap: (){
              courseController.resetSelectedContent();
              courseController.setSelectedChapterAndCourseId(courseDetailsModel.data!.courseId!, courseDetailsModel.data!.courseChapters![topicIndex].chapterId! );
              Get.toNamed(RouteHelper.getQuizSettingRoute());
            }, width: 90),
          ],
          ),
        );
      }
    );
  }
}
