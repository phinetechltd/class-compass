import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/domain/model/question_bank_board_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/logic/question_bank_board_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/presentation/widgets/create_new_question_bank_board_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class QuestionBankBoardItemWidget extends StatelessWidget {
  final QuestionBankBoardItem? item;
  final int index;
  const QuestionBankBoardItemWidget({super.key, this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text('${item?.board}', style: textRegular.copyWith())),
      Expanded(child: Text('${item?.shortName}', style: textRegular.copyWith())),
      EditDeleteSection(horizontal: true, onDelete: (){
        Get.dialog(ConfirmationDialog(
          title: "board".tr,
          content: "board".tr,
          onTap: (){
            Get.back();
            Get.find<QuestionBankBoardController>().deleteQuestionBankBoard(item!.id!);
          },));

      }, onEdit: (){
        Get.dialog(CustomDialogWidget(title: "board".tr,
          child: CreateNewQuestionBankBoardWidget(item: item),));
      },)
    ],
    );
  }
}
