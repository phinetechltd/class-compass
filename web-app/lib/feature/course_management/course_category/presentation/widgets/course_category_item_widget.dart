
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/custom_popup_menu.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/course_management/course_category/domain/model/course_category_model.dart';
import 'package:class_compass/feature/course_management/course_category/logic/course_category_controller.dart';
import 'package:class_compass/feature/course_management/course_category/presentation/widgets/create_new_course_category_widget.dart';
import 'package:class_compass/feature/dashboard/controller/dashboard_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class CourseCategoryItemWidget extends StatelessWidget {
  final CourseCategoryItem? courseCategoryItem;
  final int index;
  const CourseCategoryItemWidget({super.key, this.courseCategoryItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
        SizedBox(width: 50, height: 40, child: CustomImage(image: "${AppConstants.baseUrl}/storage/course_categories/${ courseCategoryItem?.image??""}", radius: 5)),
        Expanded(child: Text("${courseCategoryItem?.name}",maxLines: 2, overflow: TextOverflow.ellipsis, style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall),)),
        Expanded(child: Text("${courseCategoryItem?.description}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall),)),
        Expanded(child: Text("${5}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall),)),
      CustomPopupMenu(menuItems: Get.find<DashboardController>().getPopupMenuList(editDelete: true),
        onSelected: (option) {
          if (option.title == "edit".tr) {
            Get.dialog(Dialog(child: CreateNewCourseCategoryWidget(courseCategoryItem: courseCategoryItem)));
          } else if (option.title == "delete".tr) {
            Get.dialog(ConfirmationDialog(title: "category".tr, content: "category".tr,
                onTap: (){
                Get.back();
              Get.find<CourseCategoryController>().deleteCourseCategory(courseCategoryItem!.id!);
            }));
          }
        },
        child: const Icon(Icons.more_vert),
      ),
      ]);
  }
}