import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/feature/hrm/leave_type/controller/leave_type_controller.dart';
import 'package:class_compass/feature/hrm/leave_type/domain/models/leave_type_model.dart';
import 'package:class_compass/feature/hrm/leave_type/presentation/screens/create_new_leave_type_screen.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class LeaveTypeItemWidget extends StatelessWidget {
  final LeaveTypeItem? leaveTypeItem;
  final int index;
  const LeaveTypeItemWidget({super.key, this.leaveTypeItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${leaveTypeItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
              Text(leaveTypeItem?.description??'', style: textRegular.copyWith(),),
            ]),
          ),
          EditDeleteSection(onEdit: (){
            Get.to(()=> CreateNewLeaveTypeScreen(leaveTypeItem: leaveTypeItem));
          },
            onDelete: (){
              Get.dialog(ConfirmationDialog(
                title: "leave_type",
                content: "leave_type",
                onTap: (){
                  Get.back();
                  Get.find<LeaveTypeController>().deleteLeaveType(leaveTypeItem!.id!);
                },));

          },)
        ],
      )),
    );
  }
}