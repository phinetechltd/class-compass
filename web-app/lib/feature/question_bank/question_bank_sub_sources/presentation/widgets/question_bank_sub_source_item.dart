import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/domain/model/question_bank_sub_sources_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/logic/question_bank_sub_sources_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/presentation/widgets/create_new_question_bank_sub_source_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class QuestionBankSubSourceItemWidget extends StatelessWidget {
  final QuestionBankSubSourceItem? item;
  final int index;
  const QuestionBankSubSourceItemWidget({super.key, this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text('${item?.subSourceName}', style: textRegular.copyWith())),
      Expanded(child: Text('${item?.sourceName}', style: textRegular.copyWith())),
      EditDeleteSection(horizontal: true, onDelete: (){
        Get.dialog(ConfirmationDialog(
          title: "sub_sources",
          content: "sub_sources".tr,
          onTap: (){
            Get.back();
            Get.find<QuestionBankSubSourcesController>().deleteQuestionBankSubSources(item!.id!);
          },));

      }, onEdit: (){
        Get.dialog(Dialog(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall))),
          child: CreateNewQuestionBankSubSourceWidget(item: item),));
      },)
    ],
    );
  }
}
