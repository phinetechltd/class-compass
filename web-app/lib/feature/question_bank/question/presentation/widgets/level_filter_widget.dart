import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/domain/model/question_bank_level_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/logic/question_bank_level_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class LevelFilterWidget extends StatelessWidget {
  const LevelFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankLevelController>(
        builder: (levelController) {
          QuestionBankLevelModel? level = levelController.questionBankLevelModel;
          return (level != null && level.data?.data != null && level.data?.data?.isNotEmpty == true)?
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: level.data?.data?.length,
              itemBuilder: (context, typeIndex){
                QuestionBankLevelItem? item = level.data?.data?[typeIndex];
                return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                    Expanded(child: Text("${item?.levelName}", style: textRegular)),
                    Checkbox(value: item?.isSelected ?? false, onChanged: (val){
                      levelController.toggleSelected(typeIndex);
                    })
                  ]),
                );
              }):const SizedBox();
        }
    );
  }
}
