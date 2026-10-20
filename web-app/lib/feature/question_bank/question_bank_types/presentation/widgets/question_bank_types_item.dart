import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/domain/model/question_bank_types_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/logic/question_bank_types_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/presentation/widgets/create_new_question_bank_types_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class QuestionBankTypesItemWidget extends StatelessWidget {
  final QuestionBankTypesItem? item;
  final int index;
  const QuestionBankTypesItemWidget({super.key, this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text('${item?.typeName}', style: textRegular.copyWith())),
      EditDeleteSection(horizontal: true, onDelete: (){
        Get.dialog(ConfirmationDialog(
          title: "types",
          content: "types",
          onTap: (){
            Get.back();
            Get.find<QuestionBankTypesController>().deleteQuestionBankTypes(item!.id!);
          },));

      }, onEdit: (){
        Get.dialog(CustomDialogWidget(title: "types".tr,
          child: CreateNewQuestionBankTypesWidget(item: item),));
      },)
    ],
    );
  }
}
