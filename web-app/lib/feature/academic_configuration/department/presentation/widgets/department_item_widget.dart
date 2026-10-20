import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/academic_configuration/department/controller/department_controller.dart';
import 'package:class_compass/feature/academic_configuration/department/domain/models/department_model.dart';
import 'package:class_compass/feature/academic_configuration/department/presentation/screens/create_new_department_screen.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class DepartmentItemWidget extends StatelessWidget {
  final DepartmentItem? departmentItem;
  final int index;
  const DepartmentItemWidget({super.key, this.departmentItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

      NumberingWidget(index: index),
      Expanded(child: Text('${departmentItem?.name}', style: textRegular.copyWith())),
      Expanded(child: Text('${departmentItem?.description}', style: textRegular.copyWith())),
      EditDeleteSection(horizontal: true, onDelete: (){
        Get.dialog(ConfirmationDialog(title: "department", content: "department",
          onTap: (){
            Get.back();
            Get.find<DepartmentController>().deleteDepartment(departmentItem!.id!);
          },));

      }, onEdit: (){
        Get.dialog(CustomDialogWidget(title: "department".tr,
            child: CreateNewDepartmentScreen(departmentItem: departmentItem)));
      },)
    ],
    );
  }
}