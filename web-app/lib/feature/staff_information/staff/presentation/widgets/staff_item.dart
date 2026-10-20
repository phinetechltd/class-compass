import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/custom_popup_menu.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/dashboard/controller/dashboard_controller.dart';
import 'package:class_compass/feature/staff_information/staff/controller/staff_controller.dart';
import 'package:class_compass/feature/staff_information/staff/domain/models/staff_model.dart';
import 'package:class_compass/feature/staff_information/teacher/presentation/widgets/add_new_teacher_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';

class StaffItemWidget extends StatelessWidget {
  final StaffItem? staffItem;
  final int index;
  final bool duePayment;
  const StaffItemWidget({super.key, this.staffItem, required this.index, this.duePayment = false});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Row(spacing: Dimensions.paddingSizeDefault, children: [

      NumberingWidget(index: index),
      ClipRRect(borderRadius: BorderRadius.circular(120),
          child: CustomImage(width: Dimensions.profileWebImageSize,
              height: Dimensions.profileWebImageSize,
              image: "${AppConstants.imageBaseUrl}/users/${staffItem?.image}")),

      Expanded(child :CustomItemTextWidget(text:"${staffItem?.name}")),
      Expanded(child: CustomItemTextWidget(text:staffItem?.phone??'')),
      Expanded(child: CustomItemTextWidget(text:staffItem?.email??'')),
      Expanded(child: CustomItemTextWidget(text:staffItem?.designation??'')),
      _buildPopupMenu(context),
    ]) :
    CustomContainer(borderRadius: 6,
        child: Row(spacing: Dimensions.paddingSizeSmall, crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(borderRadius: BorderRadius.circular(120),
            child: const CustomImage(width: Dimensions.imageSizeBig, height: Dimensions.imageSizeBig, image: "")),

        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomItemTextWidget(text:"${staffItem?.name}, ${staffItem?.designation??''}"),
          CustomItemTextWidget(text:"${"phone".tr} : ${staffItem?.phone??''}"),


        ]),
        ),
          _buildPopupMenu(context),
      ],
    ));
  }

  Widget _buildPopupMenu(BuildContext context) {
    return CustomPopupMenu(
      menuItems: Get.find<DashboardController>().getPopupMenuList(editDelete: true),
      onSelected: (option) {
        if (option.title == "edit".tr) {
          Get.dialog(CustomDialogWidget(title: "staff".tr,
            child: AddNewTeacherWidget(teacherItem: staffItem, fromStaff: true),
          ));
        } else if (option.title == "delete".tr) {
          Get.dialog(ConfirmationDialog(
            content: "staff".tr,
            title: "staff".tr,
            onTap: () {
              Get.find<StaffController>().deleteStaff(staffItem!.id!);
            },
          ));
        }
      },
      child: Icon(Icons.more_vert_rounded, size: 20, color: Theme.of(context).hintColor),
    );
  }

}