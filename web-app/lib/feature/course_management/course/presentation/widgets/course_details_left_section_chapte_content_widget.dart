import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/add_new_resource_widget.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/course_management/chapter/presentation/widgets/add_new_topic_widget.dart';
import 'package:class_compass/feature/course_management/course/domain/model/chapter_reorder_body.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_details_model.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/course_management/course/presentation/screens/live_class_list_screen.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/add_new_lesson_and_online_widget.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/course_content_widget.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/course_topic_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class CourseDetailsLeftSectionChapterContentWidget extends StatelessWidget {
  final CourseDetailsModel courseDetailsModel;
  const CourseDetailsLeftSectionChapterContentWidget({super.key, required this.courseDetailsModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(
      builder: (courseController) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
            child: CustomContainer(onTap: (){
              ResponsiveHelper.isDesktop(context)?
              courseController.toggleLiveClass(true):
              Get.to(()=> const LiveClassListScreen());
            },
              width:  ResponsiveHelper.isDesktop(context)?
              Get.width/3: Get.width, verticalPadding: 3,
              borderRadius: 5, showShadow: false, border: Border.all(width: .125, color: Theme.of(context).hintColor),
              color: Theme.of(context).primaryColorDark.withValues(alpha: .05),
              child: Padding(padding: const EdgeInsets.all(8.0),
                  child: Text("live_class".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
            ),
          ),
          ReorderableListView.builder(
            shrinkWrap: true,
            buildDefaultDragHandles: false,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: courseDetailsModel.data?.courseChapters?.length ?? 0,
            itemBuilder: (context, index) {
              CourseChapters? courseChapters = courseDetailsModel.data?.courseChapters?[index];
              return ExpansionTile(key: ValueKey(index),
                showTrailingIcon: false,
                initiallyExpanded: courseController.topicExpanded[index],
                title: Row(spacing: Dimensions.paddingSizeSmall,
                  children: [
                    ReorderableDragStartListener(index: index,
                        child: Icon(Icons.grid_view_rounded, color: Theme.of(context).hintColor)),
                    Expanded(child: CourseTopicWidget(courseDetailsModel: courseDetailsModel, courseChapters: courseChapters, topicIndex: index)),
                  ],),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CourseContentWidget(chapters: courseChapters, courseDetailsModel: courseDetailsModel, topicIndex: index),
                  AddNewLessonAndOnlineWidget(courseDetailsModel: courseDetailsModel, courseChapters: courseChapters, topicIndex: index),
                ],
              );
            },
              onReorder: (oldIndex, newIndex) {
                if (newIndex > oldIndex) newIndex -= 1;
                final movedItem = courseDetailsModel.data!.courseChapters!.removeAt(oldIndex);
                courseDetailsModel.data!.courseChapters!.insert(newIndex, movedItem);
                final expanded = courseController.topicExpanded.removeAt(oldIndex);
                courseController.topicExpanded.insert(newIndex, expanded);
                final itemA = courseDetailsModel.data!.courseChapters![newIndex];
                final itemB = courseDetailsModel.data!.courseChapters![oldIndex];
                final tempPriority = itemA.chapterPriority;
                itemA.chapterPriority = itemB.chapterPriority;
                itemB.chapterPriority = tempPriority;
                List<Chapters> reorderChapters = courseDetailsModel.data!.courseChapters!.map((chapter) => Chapters(
                  chapterId: chapter.chapterId, priority: chapter.chapterPriority)).toList();
                ChapterReorderBody body = ChapterReorderBody(courseId: courseDetailsModel.data!.courseId!, chapters: reorderChapters);
                courseController.reOrderChapter(body);
              }
          ),

          Padding(padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault),
              child: AddNewResourceWidget(title: "add_topic".tr,onTap: (){
                courseController.setAddTopicEnabled(true);
              }, width: 100)),
          if(courseController.addTopicEnabled)
            AddNewTopicWidget(courseId: courseDetailsModel.data!.courseId!)
        ]);
      }
    );
  }
}
