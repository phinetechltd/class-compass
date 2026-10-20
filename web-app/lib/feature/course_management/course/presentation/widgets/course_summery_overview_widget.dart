import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_details_model.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/course_summery_item_info_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';

class CourseSummeryOverviewWidget extends StatelessWidget {
  final CourseDetailsModel courseDetailsModel;
  const CourseSummeryOverviewWidget({super.key, required this.courseDetailsModel});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(borderRadius: 5,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
                CourseSummeryInfoWidget(icon: Images.student, title: "student_joined".tr, count: "${courseDetailsModel.data?.courseTotalEnrolled??0}",),
                CourseSummeryInfoWidget(icon: Images.video, title: "video_classes".tr, count: "${courseDetailsModel.data?.courseTotalClasses??0}",),
                CourseSummeryInfoWidget(icon: Images.notes, title: "total_notes".tr, count: "${courseDetailsModel.data?.courseTotalNotes??0}",),
                CourseSummeryInfoWidget(icon: Images.quiz, title: "total_exams".tr, count: "${courseDetailsModel.data?.courseTotalExams??0}",showDivider: false),
              ]),
        ));
  }
}
