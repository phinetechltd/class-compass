import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/secure_pdf_viwer/video_pdf_and_image_viewer_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/my_course_details_lesson_details_widget.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/videocipher_otp_player.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: "lesson_details".tr),
      body: GetBuilder<CourseController>(
        builder: (courseController) {
          return CustomWebScrollView(slivers: [
            SliverToBoxAdapter(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              (courseController.selectedContent?.videoType != "text")?
              Stack(children: [

                (courseController.selectedContent?.videoType == "cipher")?
                SizedBox(height: Get.width/2,child: const VdoCipherCustomPlayer()):
                const VideoPdfAndImageViewerWidget(),
              ],
              ):const SizedBox(),
              const MyCourseDetailsLessonDetailsWidget(),

            ]))
          ],);
        }
      ),
    );
  }
}
