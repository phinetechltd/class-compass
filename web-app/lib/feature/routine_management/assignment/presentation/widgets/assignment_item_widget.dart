import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/routine_management/assignment/controller/assignment_controller.dart';
import 'package:class_compass/feature/routine_management/assignment/domain/models/assignment_model.dart';
import 'package:class_compass/feature/routine_management/assignment/presentation/screens/create_new_assignment_screen.dart';
import 'package:class_compass/feature/routine_management/assignment/presentation/widgets/assignment_files_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class AssignmentItemWidget extends StatelessWidget {
  final AssignmentItem? assignmentItem;
  final int index;
  const AssignmentItemWidget({super.key, this.assignmentItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      AssignmentFilesWidget(assignmentItem : assignmentItem),
        Expanded(child: CustomItemTextWidget(text:"${assignmentItem?.title}")),
        Expanded(child: CustomItemTextWidget(text:assignmentItem?.description??'')),
        Expanded(child: CustomItemTextWidget(text:assignmentItem?.deadline??'')),
        Expanded(child: CustomItemTextWidget(text:assignmentItem?.className??'')),
        Expanded(child: CustomItemTextWidget(text:assignmentItem?.sectionName??'')),
        Expanded(child: CustomItemTextWidget(text:assignmentItem?.subjectName??'')),
        EditDeleteSection(horizontal: true, onEdit: (){
          Get.to(() =>  CreateNewAssignmentScreen(assignmentItem: assignmentItem));
        },
          onDelete: (){
            Get.dialog(ConfirmationDialog(title: "assignment", content: "assignment",
              onTap: (){
                Get.back();
                Get.find<AssignmentController>().deleteAssignment(assignmentItem!.id!);
              },));

        },)
      ],
    );
  }
}