import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_popup_menu.dart';
import 'package:class_compass/feature/course_management/chapter/logic/chapter_controller.dart';
import 'package:class_compass/feature/course_management/chapter/presentation/widgets/add_new_topic_widget.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_details_model.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/dashboard/controller/dashboard_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class CourseTopicWidget extends StatelessWidget {
  final int topicIndex;
  final CourseDetailsModel courseDetailsModel;
  final CourseChapters? courseChapters;
  const CourseTopicWidget({super.key, required this.topicIndex, required this.courseDetailsModel, this.courseChapters});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(
      builder: (courseController) {
        return CustomContainer(color: Theme.of(context).primaryColorDark.withValues(alpha: .05),
            border: Border.all(color: Theme.of(context).hintColor, width: .25),
            showShadow: false, borderRadius: 5,child: Row(spacing: Dimensions.paddingSizeSmall,children: [
              Icon(courseController.topicExpanded[topicIndex]? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right, size: 16,),
              Expanded(child: Text(courseChapters?.chapterTitle??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),),

              GetBuilder<ChapterController>(
                  builder: (chapterController) {
                    return CustomPopupMenu(menuItems: Get.find<DashboardController>().getPopupMenuList(),
                      onSelected: (option) {
                        if (option.title == "delete".tr) {
                          chapterController.deleteChapter(courseChapters!.chapterId!, courseDetailsModel.data!.courseId!.toString() );
                        } else if (option.title == "edit".tr) {
                          Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: AddNewTopicWidget(courseId: courseDetailsModel.data!.courseId!, chapterId: courseChapters?.chapterId, title: courseChapters?.chapterTitle, description: courseChapters?.chapterDescription,)));
                        }
                      },
                      child: const Icon(Icons.more_vert_rounded, size: 16,),
                    );
                  }
              )

            ]));
      }
    );
  }
}
