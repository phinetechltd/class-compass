import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/domain/model/question_bank_sources_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/logic/question_bank_sources_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/presentation/widgets/create_new_question_bank_source_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class QuestionBankSourceItemWidget extends StatelessWidget {
  final QuestionBankSourcesItem? item;
  final int index;
  const QuestionBankSourceItemWidget({super.key, this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text('${item?.sourceName}', style: textRegular.copyWith())),
      EditDeleteSection(horizontal: true, onDelete: (){
        Get.dialog(ConfirmationDialog(
          title: "sources",
          content: "sources".tr,
          onTap: (){
            Get.back();
            Get.find<QuestionBankSourcesController>().deleteQuestionBankSources(item!.id!);
          },));

      }, onEdit: (){
        Get.dialog(CustomDialogWidget(title: "sources".tr,
          child: CreateNewQuestionBankSourceWidget(item: item)));
      },)
    ],
    );
  }
}
