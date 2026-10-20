import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/exam_management/mark_config/controller/mark_config_controller.dart';
import 'package:class_compass/feature/exam_management/mark_config/presentation/widgets/grand_final_mark_percentage_update_widget.dart';
import 'package:class_compass/util/dimensions.dart';

import '../../../../academic_configuration/class/domain/model/class_model.dart';

class GrandFinalExamItemWidget extends StatelessWidget {
  final ClassItem? examItem;
  final int index;
  const GrandFinalExamItemWidget({super.key, this.examItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text:"${examItem?.className}")),
      EditDeleteSection(
        onEdit: (){
          Get.find<MarkConfigController>().getGrandFinalExamPercentage(examItem!.id!).then((val){
            Get.dialog(CustomDialogWidget(title: "grand_final_exam".tr,
              child: const GrandFinalMarkPercentageUpdateWidget(),));
          });

        },
      )

    ],
    );
  }
}