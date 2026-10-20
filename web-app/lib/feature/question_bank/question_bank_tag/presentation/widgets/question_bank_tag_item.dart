


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_tag/domain/model/question_bank_tag_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_tag/logic/question_bank_tag_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_tag/presentation/widgets/create_new_question_bank_tag_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class QuestionBankTagItemWidget extends StatelessWidget {
  final QuestionBankTagItem? item;
  final int index;
  const QuestionBankTagItemWidget({super.key, this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text('${item?.tagName}', style: textRegular.copyWith())),
      EditDeleteSection(horizontal: true, onDelete: (){
        Get.dialog(ConfirmationDialog(
          title: "tag",
          content: "tag".tr,
          onTap: (){
            Get.back();
            Get.find<QuestionBankTagController>().deleteQuestionBankTag(item!.id!);
          },));

      }, onEdit: (){
        Get.dialog(CustomDialogWidget(title: "tag".tr,
          child: CreateNewQuestionBankTagWidget(item: item),));
      },)
    ]);
  }
}
