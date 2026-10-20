import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/domain/model/question_bank_types_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/logic/question_bank_types_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class TypeFilterWidget extends StatelessWidget {
  const TypeFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankTypesController>(
        builder: (typesController) {
          return (typesController.questionBankTypesModel != null && typesController.questionBankTypesModel?.data?.data != null && typesController.questionBankTypesModel?.data?.data?.isNotEmpty == true)?
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: typesController.questionBankTypesModel?.data?.data?.length,
              itemBuilder: (context, typeIndex){
                QuestionBankTypesItem? item = typesController.questionBankTypesModel?.data?.data?[typeIndex];
                return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                    Expanded(child: Text("${typesController.questionBankTypesModel?.data?.data?[typeIndex].typeName}", style: textRegular)),
                    Checkbox(value: item?.isSelected ?? false, onChanged: (val){
                      typesController.toggleSelected(typeIndex);
                    })
                  ]),
                );
              }):const SizedBox();
        }
    );
  }
}
