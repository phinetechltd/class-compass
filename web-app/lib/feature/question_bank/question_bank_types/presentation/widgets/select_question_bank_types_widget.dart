import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/logic/question_bank_types_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/presentation/widgets/question_bank_types_dropdown.dart';

class QuestionBankSelectTypeWidget extends StatefulWidget {
  final String? title;
  const QuestionBankSelectTypeWidget({super.key, this.title,});

  @override
  State<QuestionBankSelectTypeWidget> createState() => _QuestionBankSelectTypeWidgetState();
}

class _QuestionBankSelectTypeWidgetState extends State<QuestionBankSelectTypeWidget> {
  @override
  void initState() {
    if(Get.find<QuestionBankTypesController>().questionBankTypesModel == null){
      Get.find<QuestionBankTypesController>().getQuestionBankTypes(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if(widget.title != "empty")
       CustomTitle(title: widget.title?? "type"),
      GetBuilder<QuestionBankTypesController>(
          builder: (questionBankTypesController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: QuestionBankTypeDropdown(width: Get.width, title: "select".tr,
                items: questionBankTypesController.questionBankTypesModel?.data?.data??[],
                selectedValue: questionBankTypesController.selectTypeItem,
                onChanged: (val){
                  questionBankTypesController.setSelectTypeItem(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
