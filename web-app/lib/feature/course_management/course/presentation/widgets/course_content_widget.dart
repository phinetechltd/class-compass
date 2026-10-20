import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_popup_menu.dart';
import 'package:class_compass/feature/course_management/course/domain/model/content_reorder_body.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_details_model.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/course_management/course/presentation/screens/lesson_screen.dart';
import 'package:class_compass/feature/course_management/lesson/logic/lesson_controller.dart';
import 'package:class_compass/feature/dashboard/controller/dashboard_controller.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';


class CourseContentWidget extends StatelessWidget {
  final CourseChapters? chapters;
  final CourseDetailsModel? courseDetailsModel;
  final int topicIndex;
  const CourseContentWidget({super.key, this.chapters, required this.courseDetailsModel, required this.topicIndex});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LessonController>(
        builder: (lessonController) {
          return GetBuilder<CourseController>(
            builder: (courseController) {
              return (courseDetailsModel != null && chapters != null)?
              Padding(padding: const EdgeInsets.only(left: 40),
                  child: ReorderableListView.builder(
                    shrinkWrap: true,
                      buildDefaultDragHandles: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: chapters?.contents?.length ?? 0,
                    padding: EdgeInsets.zero,
                      onReorder: (oldIndex, newIndex) {
                        if (newIndex > oldIndex) newIndex -= 1;
                        final movedItem = chapters!.contents!.removeAt(oldIndex);
                        chapters!.contents!.insert(newIndex, movedItem);
                        final itemA = chapters!.contents![newIndex];
                        final itemB = chapters!.contents![oldIndex];
                        final tempPriority = itemA.serial;
                        itemA.serial = itemB.serial;
                        itemB.serial = tempPriority;
                        List<Content> reorderContent = chapters!.contents!.map((content) => Content(
                            contentId: content.contentId, serial: content.serial)).toList();
                        ContentReorderBody body = ContentReorderBody(chapterId: chapters!.chapterId!, contents: reorderContent);
                        courseController.reOrderContent(body);
                      },

                      itemBuilder: (context, lessonIndex) {
                      final contents = chapters?.contents?[lessonIndex];
                      return Container(key: ValueKey(contents?.serial ?? lessonIndex), // Must have a unique key
                        child: Row(children: [
                            ReorderableDragStartListener(index: lessonIndex,
                                child: Icon(Icons.grid_view_rounded, color: Theme.of(context).hintColor)),
                            Expanded(child: ContentItemWidget(topicIndex: topicIndex, courseDetailsModel: courseDetailsModel, chapters: chapters, contents: contents)),
                          ],
                        ));
                    })
              ):const SizedBox();
            }
          );
        }
    );
  }
}


class ContentItemWidget extends StatelessWidget {
  final Contents? contents;
  final CourseDetailsModel? courseDetailsModel;
  final int topicIndex;
  final CourseChapters? chapters;
  const ContentItemWidget({super.key, this.contents, this.courseDetailsModel, required this.topicIndex, this.chapters});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(
      builder: (courseController) {
        return GetBuilder<LessonController>(
          builder: (lessonController) {
            DateTime scheduledAt = DateTime.parse(contents?.scheduledAt?? DateTime.now().toString());
            DateTime quizStartSchedule = DateTime.parse(contents?.startTime?? DateTime.now().toString());
            DateTime today = DateTime.now();
            DateTime todayOnly = DateTime(today.year, today.month, today.day);


            return Padding(
              padding: const EdgeInsets.fromLTRB(
                Dimensions.paddingSizeDefault,
                0,
                Dimensions.paddingSizeExtraLarge,
                Dimensions.paddingSizeSmall,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: CustomContainer(
                  color: Theme.of(context).primaryColorDark.withValues(alpha: .05),
                  onTap: () {
                    courseController.getMyCourseLessonDetails(contents!.type!, contents!.typeId!.toString());
                    log("videotype==> ${contents?.videoType}");
                    courseController.setSelectedContent(contents!);
                    if (contents?.videoType == "cipher") {
                      Get.find<CourseController>().getVideoCipherOtp(
                        Get.find<ProfileController>().profileModel?.data?.name ?? "N?A",
                        Get.find<ProfileController>().profileModel?.data?.email ?? "N?A",
                        "${contents?.videoUrl}",
                      );
                    }

                    if (contents?.type == "quiz") {
                      // Quiz handling
                    } else {
                      log("lesson is here");
                      if (!ResponsiveHelper.isDesktop(context)) {
                        Get.to(() => const LessonScreen());
                      }
                    }
                  },
                  border: Border.all(
                    color: Theme.of(context).hintColor,
                    width: .05,
                  ),
                  showShadow: false,
                  borderRadius: 5,
                  child: Row(
                    spacing: Dimensions.paddingSizeSmall,
                    children: [
                      CustomContainer(
                        showShadow: false,
                        borderRadius: 5,
                        color: Theme.of(context).secondaryHeaderColor,
                        child: Image.asset(
                          contents?.type == "quiz"
                              ? Images.quizManagementIcon
                              : Images.singleCourseItem,
                          width: 16,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppConstants.htmlToPlainText(contents?.title ?? ''),
                              style: textRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                            ),
                            Text(
                              "${contents?.type}",
                              style: textRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            if (contents?.scheduledAt != null &&
                                contents?.isScheduled == 1 &&
                                !scheduledAt.isBefore(todayOnly))
                              Text(
                                "${"Schedule at"}: ${contents?.scheduledAt}",
                                style: textRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            if (contents?.type == "quiz" &&
                                contents?.startTime != null &&
                                !quizStartSchedule.isBefore(todayOnly))
                              Text(
                                "${"Schedule at"}: ${contents!.startTime!}",
                                style: textRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                          ],
                        ),
                      ),
                      CustomPopupMenu(
                        menuItems: Get.find<DashboardController>().getPopupMenuList(),
                        onSelected: (option) {
                          if (option.title == "delete".tr) {
                            lessonController.deleteLesson(
                              chapters!.chapterId!,
                              contents!.contentId!,
                              courseDetailsModel!.data!.courseId!.toString(),
                            );
                          } else if (option.title == "edit".tr) {
                            courseController.getMyCourseLessonDetails(contents!.type!, contents!.typeId!.toString());
                            courseController.setSelectedContent(contents!);
                            if (contents?.type == "quiz") {
                              courseController.setSelectedChapterAndCourseId(
                                courseDetailsModel!.data!.courseId!,
                                courseDetailsModel!.data!.courseChapters![topicIndex].chapterId!,
                              );
                              Get.toNamed(RouteHelper.getQuizSettingRoute());
                            } else {
                              courseController.setSelectedChapterAndCourseId(
                                courseDetailsModel!.data!.courseId!,
                                courseDetailsModel!.data!.courseChapters![topicIndex].chapterId!,
                              );
                              Get.toNamed(RouteHelper.getLessonRoute());
                            }
                          }
                        },
                        child: const Icon(
                          Icons.more_vert_rounded,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }
}
