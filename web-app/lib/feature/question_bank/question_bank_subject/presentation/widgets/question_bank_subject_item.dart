import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/domain/model/question_bank_subject_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/logic/question_bank_subject_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/presentation/widgets/create_new_question_bank_subject_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class QuestionBankSubjectItemWidget extends StatelessWidget {
  final QuestionBankSubjectItem? item;
  final int index;
  const QuestionBankSubjectItemWidget({super.key, this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text('${item?.name}', style: textRegular.copyWith())),
      Expanded(child: Text('${item?.className}', style: textRegular.copyWith())),
      Expanded(child: Text('${item?.groupName}', style: textRegular.copyWith())),
      EditDeleteSection(horizontal: true, onDelete: (){
        Get.dialog(ConfirmationDialog(
          title: "subject",
          content: "subject".tr,
          onTap: (){
            Get.back();
            Get.find<QuestionBankSubjectController>().deleteQuestionBankSubject(item!.id!);
          },));

      }, onEdit: (){
        Get.dialog(CustomDialogWidget(title: 'subject'.tr,
          child: CreateNewQuestionBankSubjectWidget(item: item),));
      },)
    ],
    );
  }
}
