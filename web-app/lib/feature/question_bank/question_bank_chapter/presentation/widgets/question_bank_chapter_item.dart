import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/domain/model/question_bank_chapter_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/logic/question_bank_chapter_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/presentation/widgets/create_new_question_bank_chapter_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class QuestionBankChapterItemWidget extends StatelessWidget {
  final QuestionBankChapterItem? item;
  final int index;
  const QuestionBankChapterItemWidget({super.key, this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text('${item?.name}', style: textRegular.copyWith())),
      Expanded(child: Text('${item?.subjectName}', style: textRegular.copyWith())),
      EditDeleteSection(horizontal: true, onDelete: (){
        Get.dialog(ConfirmationDialog(
          title: "chapter",
          content: "chapter".tr,
          onTap: (){
            Get.back();
            Get.find<QuestionBankChapterController>().deleteQuestionBankChapter(item!.id!);
          },));

      }, onEdit: (){
        Get.dialog(CustomDialogWidget(title: "chapter".tr,
          child: CreateNewQuestionBankChapterWidget(item: item),));
      },)
    ],
    );
  }
}
