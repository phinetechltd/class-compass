import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/my_course_details_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/frontend_my_course_details_lesson_details_widget.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/frontend_my_course_details_live_class_widget.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/frontend_videocipher_otp_player.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/my_course_details_left_menu_widget.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/quiz_exam_widget.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/secure_pdf_viwer/frontend_video_pdf_and_image_viewer_widget.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

import '../../../../../common/widget/custom_app_bar.dart';

class MyCourseDetailsScreen extends StatefulWidget {
  final String? slug;
  const MyCourseDetailsScreen({super.key, required this.slug});

  @override
  State<MyCourseDetailsScreen> createState() => _MyCourseDetailsScreenState();
}

class _MyCourseDetailsScreenState extends State<MyCourseDetailsScreen> {
  double _top = 100;
  double _left = 100;
  late Timer _timer;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    Get.find<FrontendCourseController>().resetSelectedContent();
    Get.find<FrontendCourseController>().toggleLeftMenu(notify: false, hide: false);
    Get.find<FrontendCourseController>().toggleLiveClass(false, notify: false);
    Get.find<FrontendCourseController>().getMyCourseDetails(widget.slug!);
    _startMoving();
  }
  void _startMoving() {

    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      setState(() {
        _top = _random.nextDouble() * (((MediaQuery.sizeOf(context).width - 400) * .5));
        _left = _random.nextDouble() * ((MediaQuery.sizeOf(context).width - 400));
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    return Scaffold(

      appBar: (Get.find<FrontendCourseController>().selectedContent?.type == "quiz" && Get.find<FrontendCourseController>().quizDetailsModel != null)? null :
       CustomAppBar(title: "Course Details", onBackPress: ()=> Get.back()),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: GetBuilder<FrontendCourseController>(
            builder: (courseController) {
              MyCourseDetailsModel? courseDetailsModel = courseController.myCourseDetailsModel;
              return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  (courseController.selectedContent != null && courseController.selectedContent?.type == "quiz" && courseController.quizDetailsModel != null)?
                  const SizedBox():
                  Row(spacing: Dimensions.paddingSizeSmall,
                    children: [
                      IconButton(onPressed: (){
                        courseController.toggleLeftMenu();
                      }, icon: Icon(Icons.menu_rounded, color: systemLandingPagePrimaryColor(), size: 25)),
                      Expanded(child: Text(courseDetailsModel?.data?.courseTitle??'', style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),)),

                      if(isDesktop)
                        CustomContainer(onTap: ()=> Get.toNamed(RouteHelper.getMyCoursesRoute()),
                            borderRadius: 5, verticalPadding: 5,horizontalPadding: 15,
                            child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                              Icon(Icons.arrow_back_ios, size: 16, color: Theme.of(context).hintColor),
                              Text("back".tr, style: textRegular.copyWith()),
                            ],
                            )),
                    ],
                  ),
                  Expanded(
                    child: isDesktop?
                    Row(spacing: Dimensions.paddingSizeDefault, children: [

                      SizedBox(width: courseController.hideLeftMenu? 0: Get.width/2.5,
                          child: MyCourseDetailsLeftMenuWidget(top: _top,left: _left,)),
                      if(courseController.selectedContent == null && courseController.showLiveClass)
                        const Expanded(child: FrontendMyCourseDetailsLiveClassWidget()),

                      if(courseController.selectedContent != null && courseController.selectedContent?.type == "lesson")
                        Expanded(child: CustomScrollView(slivers: [
                          SliverToBoxAdapter(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            (courseController.selectedContent?.videoType != "text")?
                            Stack(children: [

                              (courseController.selectedContent?.videoType == "cipher")?
                              const FrontendVdoCipherCustomPlayer():
                              const FrontendVideoPdfAndImageViewerWidget(),

                              if(courseController.selectedContent?.videoType != "image" && courseController.selectedContent?.videoType != "none" &&
                                  courseController.selectedContent?.videoType != "document" && courseController.selectedContent?.videoType != "cipher")
                                GetBuilder<ProfileController>(
                                    builder: (profileController) {
                                      return AnimatedPositioned(
                                        duration: const Duration(milliseconds: 1000),
                                        curve: Curves.easeInOut,
                                        top: _top,
                                        left: _left,
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
                        ],)),

                      if(courseController.selectedContent != null && courseController.selectedContent?.type == "q uiz" && courseController.quizDetailsModel != null)
                        const Expanded(child: QuizExamWidget()),

                      // if(courseController.selectedContent?.type == "quiz" && courseController.showQuizReview )
                      //   Expanded(child: QuizExamReviewWidget()),

                    ],
                    ):MyCourseDetailsLeftMenuWidget(top: _top, left: _left,),
                  ),
                ],
                ),
              );
            }
        ),)
      ]),

    );
  }
}
