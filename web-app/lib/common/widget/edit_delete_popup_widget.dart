import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_popup_menu.dart';
import 'package:class_compass/feature/dashboard/controller/dashboard_controller.dart';

class EditDeletePopupMenu extends StatelessWidget {
  final Function()? onEdit;
  final Function()? onDelete;

  const EditDeletePopupMenu({super.key, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      menuItems: Get.find<DashboardController>().getPopupMenuList(editDelete: true),
      onSelected: (val) {
        if (val.title == "edit".tr) {
          onEdit?.call();
        } else if (val.title == "delete".tr) {
          onDelete?.call();
        }
      },
    );
  }
}
