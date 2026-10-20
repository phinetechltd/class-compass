import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/frontend_my_course_details_lesson_details_widget.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/frontend_videocipher_otp_player.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/secure_pdf_viwer/frontend_video_pdf_and_image_viewer_widget.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class FrontendLessonScreen extends StatefulWidget {
  final double top;
  final double left;
  const FrontendLessonScreen({super.key, required this.top, required this.left});

  @override
  State<FrontendLessonScreen> createState() => _FrontendLessonScreenState();
}

class _FrontendLessonScreenState extends State<FrontendLessonScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: "lesson_details".tr),
      body: GetBuilder<FrontendCourseController>(
        builder: (courseController) {
          return CustomScrollView(slivers: [
            SliverToBoxAdapter(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              (courseController.selectedContent?.videoType != "text")?
              Stack(children: [


                (courseController.selectedContent?.videoType == "cipher")?
                const FrontendVdoCipherCustomPlayer():
                const FrontendVideoPdfAndImageViewerWidget(),

                if(courseController.selectedContent?.videoType != "image" && courseController.selectedContent?.videoType != "none"
                    && courseController.selectedContent?.videoType != "document" && courseController.selectedContent?.videoType != "cipher")
                  GetBuilder<ProfileController>(
                      builder: (profileController) {
                        return AnimatedPositioned(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInOut,
                          top: widget.top,
                          left: widget.left,
                          child: GetBuilder<ProfileController>(
                              builder: (profileController) {
                                return CustomContainer(borderRadius: 123,color: Colors.transparent,showShadow: false, verticalPadding: 5,
                                    child: Row(spacing: Dimensions.paddingSizeExtraSmall,
                                      children: [
                                        //CustomImage(width: 20, height: 20, radius: 120,),
                                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Text("${profileController.profileModel?.data?.name}",
                                              style: textRegular.copyWith(color: Colors.blue, fontSize: Dimensions.fontSizeExtraSmall)),
                                          Text("${profileController.profileModel?.data?.email}",
                                              style: textRegular.copyWith(color: Colors.blue, fontSize: Dimensions.fontSizeExtraSmall)),
                                        ],)
                                      ],
                                    ));
                              }
                          ),
                        );
                      }
                  ),


              ],
              ):const SizedBox(),
              const FrontendMyCourseDetailsLessonDetailsWidget(),

            ]))
          ],);
        }
      ),
    );
  }
}
