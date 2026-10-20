import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/active_inactive_widget.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/custom_popup_menu.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_model.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/dashboard/controller/dashboard_controller.dart';
import 'package:class_compass/helper/date_converter.dart';
import 'package:class_compass/helper/price_converter.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class CourseItemWidget extends StatelessWidget {
  final CourseItem? courseItem;
  final int index;
  const CourseItemWidget({super.key, this.courseItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(builder: (courseController) {
        return ResponsiveHelper.isDesktop(context)?
        Row(spacing: Dimensions.paddingSizeSmall, children: [
          NumberingWidget(index: index),
          CustomImage(image: "${AppConstants.baseUrl}/storage/courses/${courseItem?.image}", width: 50, height: 30, radius: 5,
              fit: BoxFit.contain),
          Expanded(child: CustomItemTextWidget(text:courseItem?.title??'')),
          Expanded(child: CustomItemTextWidget(text:courseItem?.courseCategory?.name??"N/A")),
          Expanded(child: CustomItemTextWidget(text:courseItem?.author?.firstName??'N/A')),
          Expanded(child: CustomItemTextWidget(text:PriceConverter.convertPrice(context, courseItem?.regularPrice??0))),
          Expanded(child: CustomItemTextWidget(text:DateConverter.isoStringToLocalDateOnly(courseItem?.createdAt?? DateTime.now().toString()))),
          Expanded(child: CustomItemTextWidget(text:GetStringUtils(courseItem?.status??'').capitalize)),
           CustomPopupMenu(menuItems: Get.find<DashboardController>().getPopupMenuList(course: true),
             onSelected: (option) {
               if (option.title == "view".tr) {
                 Get.toNamed(RouteHelper.getCourseDetailsRoute(courseItem!.id.toString()));
               }
               else if (option.title == "edit".tr) {
                 Get.toNamed(RouteHelper.getAddNewCourseRoute(courseItem: courseItem));
               } else if (option.title == "delete".tr) {
                 courseController.deleteCourse(courseItem!.id!);
               }
             },
             child: Icon(Icons.more_vert_rounded, size: 20,color: Theme.of(context).hintColor),
           ),
        ]) :

        Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
          child: InkWell(onTap: ()=> Get.toNamed(RouteHelper.getCourseDetailsRoute(courseItem?.id.toString()??'0')),
            child: CustomContainer(showShadow: false,verticalPadding: Dimensions.paddingSizeDefault,
              child: Column( spacing: Dimensions.paddingSizeSmall, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(spacing: Dimensions.paddingSizeSmall, children: [
                  SizedBox(width: 20,
                    child: Checkbox(side: BorderSide(color: Theme.of(context).hintColor, width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                        value: courseItem?.isSelected??false, onChanged: (val){
                      courseController.selectCourse(index);
                    }),
                  ),
                  Expanded(
                    child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                      CustomImage(image: "${AppConstants.baseUrl}/storage/courses/${courseItem?.image}", width: 70,height: 45, radius: 5, fit: BoxFit.contain),
                      Expanded(
                        child: InkWell( onTap: () => Get.toNamed(RouteHelper.getCourseDetailsRoute(courseItem?.id.toString()??'0')),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            CustomItemTextWidget(text:courseItem?.title??'',),
                            Text.rich(TextSpan(children: [
                              TextSpan(text: "${"classes".tr}: ", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor)),
                              TextSpan(text: "${courseItem?.totalClasses??0} ", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                              TextSpan(text: "${"notes".tr}: ", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor)),
                              TextSpan(text: "${courseItem?.totalNotes??0} "),
                              TextSpan(text: "${"exams".tr}: ", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor)),
                              TextSpan(text: "${courseItem?.totalExams??0} "),

                            ]),
                              style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),)
                          ]),
                        ),
                      )
                    ],
                    ),
                  ),
                ]),

                CustomItemTextWidget(text:"${"category".tr}: ${courseItem?.courseCategory?.name??""}"),
                CustomItemTextWidget(text:'${"author".tr}: ${courseItem?.author?.firstName}'),
                CustomItemTextWidget(text:"${"regular_price".tr}: ${PriceConverter.convertPrice(context, courseItem?.regularPrice??0)}"),
                CustomItemTextWidget(text:"${"created_at".tr}: ${DateConverter.isoStringToLocalDateOnly(courseItem?.createdAt??DateTime.now().toString())}"),
                CustomItemTextWidget(text:"${"total_enrolled".tr}: ${courseItem?.totalEnrolled.toString()??''}"),

                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  ActiveInActiveWidget(active: courseItem?.status == "1", onChanged: (val){},),
                  CustomPopupMenu(menuItems: Get.find<DashboardController>().getPopupMenuList(editDelete: true),
                    onSelected: (option) {
                      if (option.title == "edit".tr) {
                        Get.toNamed(RouteHelper.getAddNewCourseRoute(courseItem: courseItem));
                      } else if (option.title == "delete".tr) {
                        courseController.deleteCourse(courseItem!.id!);
                      }
                    },
                    child: Icon(Icons.more_vert_rounded, size: 20,color: Theme.of(context).hintColor),
                  ),
                  const SizedBox(width: 50)
                ])
              ]),
            ),
          ),
        );
      }
    );
  }
}