import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/logic/question_bank_level_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/presentation/widgets/question_bank_level_dropdown.dart';

class QuestionBankSelectLevelWidget extends StatefulWidget {
  final String? title;
  const QuestionBankSelectLevelWidget({super.key, this.title});

  @override
  State<QuestionBankSelectLevelWidget> createState() => _QuestionBankSelectLevelWidgetState();
}

class _QuestionBankSelectLevelWidgetState extends State<QuestionBankSelectLevelWidget> {
  @override
  void initState() {
    if(Get.find<QuestionBankLevelController>().questionBankLevelModel == null){
      Get.find<QuestionBankLevelController>().getQuestionBankLevel(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if(widget.title != "empty")
       CustomTitle(title: widget.title?? "level".tr),
      GetBuilder<QuestionBankLevelController>(
          builder: (questionBankLevelController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: QuestionBankLevelDropdown(width: Get.width, title: "select".tr,
                items: questionBankLevelController.questionBankLevelModel?.data?.data??[],
                selectedValue: questionBankLevelController.selectedLevelItem,
                onChanged: (val){
                  questionBankLevelController.setSelectLevelItem(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
