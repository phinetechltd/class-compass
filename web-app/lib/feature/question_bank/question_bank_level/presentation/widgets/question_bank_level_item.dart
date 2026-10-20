import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/domain/model/question_bank_level_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/presentation/widgets/create_new_question_bank_level_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/logic/question_bank_topics_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class QuestionBankLevelItemWidget extends StatelessWidget {
  final QuestionBankLevelItem? item;
  final int index;
  const QuestionBankLevelItemWidget({super.key, this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text('${item?.levelName}', style: textRegular.copyWith())),

      EditDeleteSection(horizontal: true, onDelete: (){
        Get.dialog(ConfirmationDialog(
          title: "level",
          content: "level".tr,
          onTap: (){
            Get.back();
            Get.find<QuestionBankTopicsController>().deleteQuestionBankTopics(item!.id!);
          },));

      }, onEdit: (){
        Get.dialog(CustomDialogWidget(title: "level".tr,
          child: CreateNewQuestionBankLevelWidget(item: item),));
      },)
    ],
    );
  }
}
