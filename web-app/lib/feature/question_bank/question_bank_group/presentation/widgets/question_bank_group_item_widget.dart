import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/domain/model/question_bank_group_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/logic/question_bank_group_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/presentation/widgets/create_new_question_bank_group_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class QuestionBankGroupItemWidget extends StatelessWidget {
  final QuestionBankGroupItem? item;
  final int index;
  const QuestionBankGroupItemWidget({super.key, this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text('${item?.name}', style: textRegular.copyWith())),
      EditDeleteSection(horizontal: true, onDelete: (){
        Get.dialog(ConfirmationDialog(title: "group", content: "group".tr,
          onTap: (){
            Get.back();
            Get.find<QuestionBankGroupController>().deleteQuestionBankGroup(item!.id!);
          },));

      }, onEdit: (){
        Get.dialog(CustomDialogWidget(title: "group".tr,
            child: CreateNewQuestionBankGroupWidget(item: item)));
      },)
    ],
    );
  }
}
