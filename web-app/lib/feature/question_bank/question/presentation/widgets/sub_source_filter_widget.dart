import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/domain/model/question_bank_sub_sources_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/logic/question_bank_sub_sources_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class SubSourceFilterWidget extends StatelessWidget {
  const SubSourceFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankSubSourcesController>(
        builder: (subSourceController) {
          QuestionBankSubSourceModel? subSource = subSourceController.questionBankSubSourceModel;
          return (subSource != null && subSource.data?.data != null && subSource.data?.data?.isNotEmpty == true)?
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: subSource.data?.data?.length,
              itemBuilder: (context, typeIndex){
                QuestionBankSubSourceItem? item = subSource.data?.data?[typeIndex];
                return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                    Expanded(child: Text("${item?.subSourceName}", style: textRegular)),
                    Checkbox(value: item?.isSelected ?? false, onChanged: (val){
                      subSourceController.toggleSelected(typeIndex);
                    })
                  ]),
                );
              }):const SizedBox();
        }
    );
  }
}
