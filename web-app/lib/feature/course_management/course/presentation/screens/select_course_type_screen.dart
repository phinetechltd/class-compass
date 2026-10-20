import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/coutom_royte_path/custom_route_path_widget.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_model.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';


class SelectCourseTypeScreen extends StatefulWidget {
  final CourseItem? courseItem;
  const SelectCourseTypeScreen({super.key, this.courseItem});

  @override
  State<SelectCourseTypeScreen> createState() => _SelectCourseTypeScreenState();
}

class _SelectCourseTypeScreenState extends State<SelectCourseTypeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "add_new_course".tr),
      body: CustomWebScrollView(slivers: [

        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Column(
            children: [
              CustomRoutePathWidget(title: "course_management".tr,subWidget: Row(children: [
                PathItemWidget(title: "course_type".tr),
              ])),

              GetBuilder<CourseController>(
                builder: (courseController) {
                  return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Row(spacing: Dimensions.paddingSizeDefault, children: [
                      Expanded(child: CourseTypeWidget(
                          icon: Images.singleCourseItem,
                          title: "single_course".tr,
                          subTitle: "add_single_course_details".tr,
                          onTap: (){
                            courseController.setSelectedCourserType("single");
                            Get.toNamed(RouteHelper.getAddNewCourseRoute());
                          },
                          buttonText: "add_single_course".tr)),

                      Expanded(child: CourseTypeWidget(
                          icon: Images.bundleCourseItem,
                          title: "bundle_course".tr,
                          subTitle: "add_single_course_details".tr,
                          onTap: (){
                            courseController.setSelectedCourserType("bundle");
                          },
                          buttonText: "add_bundle_course".tr)),
                    ]),
                  );
                }
              ),
            ],
          )
        ),)
      ],),
    );
  }
}

class CourseTypeWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;
  final Function()? onTap;
  final String? buttonText;
  const CourseTypeWidget({super.key, required this.icon, required this.title, required this.subTitle, this.onTap, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(showShadow: false, borderRadius: Dimensions.paddingSizeSmall, verticalPadding: Dimensions.paddingSizeOver,
      horizontalPadding: Dimensions.paddingSizeExtraLarge,
      child: Column(spacing: Dimensions.paddingSizeDefault, children: [
        CustomImage(image: icon, localAsset: true, height: 70,),
        Text(title, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
        Text(subTitle, textAlign: TextAlign.center,  style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
            color: Theme.of(context).textTheme.displaySmall?.color)),
        CustomButton(onTap: onTap, text: buttonText??'', fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.w400,
          icon: const Icon(Icons.add, color: Colors.white, size: 16),)
      ]),
    );
  }
}
