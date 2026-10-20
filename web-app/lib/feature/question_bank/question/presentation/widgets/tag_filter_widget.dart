import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_tag/domain/model/question_bank_tag_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_tag/logic/question_bank_tag_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class TagFilterWidget extends StatelessWidget {
  const TagFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankTagController>(
        builder: (tagController) {
          ApiResponse<QuestionBankTagItem>? tag = tagController.questionBankTagModel;
          return (tag != null && tag.data?.data != null && tag.data?.data?.isNotEmpty == true)?
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tag.data?.data?.length,
              itemBuilder: (context, typeIndex){
                QuestionBankTagItem? item = tag.data?.data?[typeIndex];
                return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                    Expanded(child: Text("${item?.tagName}", style: textRegular)),
                    Checkbox(value: item?.isSelected ?? false, onChanged: (val){
                      tagController.toggleSelected(typeIndex);
                    })
                  ]),
                );
              }):const SizedBox();
        }
    );
  }
}
