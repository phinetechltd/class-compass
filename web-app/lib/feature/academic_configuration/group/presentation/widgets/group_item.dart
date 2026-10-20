import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/edit_delete_popup_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:class_compass/feature/academic_configuration/group/domain/model/group_model.dart';
import 'package:class_compass/feature/academic_configuration/group/presentation/widgets/create_new_group_dialog.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class GroupItemWidget extends StatelessWidget {
  final GroupItem? groupItem;
  final int index;
  const GroupItemWidget({super.key, this.groupItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault,
      crossAxisAlignment: CrossAxisAlignment.start, children: [
      NumberingWidget(index: index),
      Expanded(child: Text('${groupItem?.groupName}', style: textRegular.copyWith())),
      EditDeletePopupMenu(onDelete: (){
        Get.dialog(ConfirmationDialog(title: "group", content: "group",
          onTap: (){
            Get.back();
            Get.find<GroupController>().deleteGroup(groupItem!.id!);
          },));

      }, onEdit: (){
        Get.dialog(CustomDialogWidget(title: "group".tr,
            child: CreateNewGroupDialog(groupItem: groupItem)));
      },)
    ],
    );
  }

}
