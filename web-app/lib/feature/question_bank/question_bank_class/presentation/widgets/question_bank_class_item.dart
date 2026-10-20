import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/domain/model/question_bank_class_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/logic/question_bank_class_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/presentation/widgets/create_new_question_bank_class_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class QuestionBankClassItemWidget extends StatelessWidget {
  final QuestionBankClassItem? classItem;
  final int index;
  const QuestionBankClassItemWidget({super.key, this.classItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text('${classItem?.name}', style: textRegular.copyWith())),
      EditDeleteSection(horizontal: true, onDelete: (){
        Get.dialog(ConfirmationDialog(
          title: "class",
          content: "are_you_sure_you_want_to_delete_this_class".tr,
          onTap: (){
            Get.back();
            Get.find<QuestionBankClassController>().deleteQuestionBankClass(classItem!.id!);
          },));

      }, onEdit: (){
        Get.dialog(CustomDialogWidget(title: "class".tr,
            child: CreateNewQuestionBankClassWidget(classItem: classItem)));
      },)
    ],
    );
  }
}
