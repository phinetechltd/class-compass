import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/frontend_course_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/course_item_card_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class FrontendCourseWidget extends StatelessWidget {
  const FrontendCourseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ResponsiveHelper.isDesktop(context);
    return GetBuilder<FrontendCourseController>(
      initState: (val)=> Get.find<FrontendCourseController>().getCategoryWiseCourse(),
      builder: (courseController) {
        FrontendCourseModel? courseModel = courseController.categoryWiseCourseModel;
        return Center(child: Padding(padding: EdgeInsets.symmetric(
            vertical: isDesktop? 40 : Dimensions.paddingSizeDefault),
            child: SizedBox(width: Dimensions.webMaxWidth,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                CustomTitle(title: "explore_online_course",
                  fontWeight: FontWeight.w700, fontSize: Dimensions.fontSizeExtraOverLarge,
                    widget: InkWell(onTap: (){
                      Get.toNamed(RouteHelper.getFrontendCoursesRoute());
                      }, child: Text("view_all_courses".tr))),

                  ListView.builder(
                    itemCount: courseModel?.data?.courseCategories?.length ?? 0,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        CourseCategories? courseCategories = courseModel?.data?.courseCategories?[index];
                    return Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                      child: Column(spacing: Dimensions.paddingSizeSmall,
                        crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(courseCategories?.name??'',
                            style: textBold.copyWith(
                                fontSize: Dimensions.fontSizeLarge)),

                        MasonryGridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                            itemCount: courseCategories?.courses?.length??0,
                            gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 520),
                            itemBuilder: (context, courseIndex){
                          return CourseItemCardWidget(courses: courseCategories?.courses?[courseIndex],);
                            }),

                      ],),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

class CourseItemInfoWidget extends StatelessWidget {
  final String icon;
  final String title;
  const CourseItemInfoWidget({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeExtraSmall,
        mainAxisSize: MainAxisSize.min, children: [
     SizedBox(width: 20,child: Image.asset(icon)),
      Text(title, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
    ]);
  }
}
