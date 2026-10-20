
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/course_management/lesson/logic/lesson_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class SelectCourseVideoWidget extends StatelessWidget {
  const SelectCourseVideoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<CourseController>(
      builder: (courseController) {
        return InkWell(onTap: ()=> courseController.pickVideo(),
          child: Stack(children: [
            ClipRRect(borderRadius: BorderRadius.circular(5),
                child: courseController.selectedVideoPath != null ? SizedBox(width: 200,
                    child: Text(courseController.selectedVideoPath??'', style: textRegular,)):
                 CustomContainer(color: Theme.of(context).secondaryHeaderColor.withValues(alpha: .075),
                     horizontalPadding: 15, verticalPadding: 10, showShadow: false, borderRadius: 2,
                     child: const CustomImage(image: '', height: Dimensions.listHeaderHeight,
                         width: Dimensions.listHeaderHeight, placeholder: Images.video))),

          ]),
        );
      }
    );
  }
}


class SelectLessonDocWidget extends StatelessWidget {
  const SelectLessonDocWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<LessonController>(
        builder: (lessonController) {
          return InkWell(onTap: ()=> lessonController.pickDocument(),
            child: Stack(children: [
              ClipRRect(borderRadius: BorderRadius.circular(5),
                  child: lessonController.selectedDocument != null ? SizedBox(width: 200, child: Text(lessonController.selectedDocument??'', style: textRegular,)):
                  CustomContainer(color: Theme.of(context).secondaryHeaderColor.withValues(alpha: .075),
                      horizontalPadding: 15, verticalPadding: 10, showShadow: false, borderRadius: 2,
                      child: const CustomImage(image: '', height: Dimensions.listHeaderHeight, width: Dimensions.listHeaderHeight, placeholder: Images.quiz))),

            ]),
          );
        }
    );
  }
}
