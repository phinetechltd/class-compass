import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_year/domain/model/question_bank_year_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_year/logic/question_bank_year_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_year/presentation/widgets/create_new_question_bank_year_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class QuestionBankYearItemWidget extends StatelessWidget {
  final QuestionBankYearItem? item;
  final int index;
  const QuestionBankYearItemWidget({super.key, this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text('${item?.year}', style: textRegular.copyWith())),
      EditDeleteSection(horizontal: true, onDelete: (){
        Get.dialog(ConfirmationDialog(
          title: "year",
          content: "year".tr,
          onTap: (){
            Get.back();
            Get.find<QuestionBankYearController>().deleteQuestionBankYear(item!.id!);
          },));

      }, onEdit: (){
        Get.dialog(CustomDialogWidget(title: "year".tr,
          child: CreateNewQuestionBankYearWidget(item: item),));
      },)
    ],
    );
  }
}
