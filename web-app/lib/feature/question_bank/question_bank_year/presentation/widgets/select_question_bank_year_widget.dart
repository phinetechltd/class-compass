import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_year/logic/question_bank_year_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_year/presentation/widgets/question_bank_year_dropdown.dart';

class QuestionBankSelectYearWidget extends StatefulWidget {
  final String? title;
  const QuestionBankSelectYearWidget({super.key, this.title,});

  @override
  State<QuestionBankSelectYearWidget> createState() => _QuestionBankSelectYearWidgetState();
}

class _QuestionBankSelectYearWidgetState extends State<QuestionBankSelectYearWidget> {
  @override
  void initState() {
    if(Get.find<QuestionBankYearController>().questionBankYearModel == null){
      Get.find<QuestionBankYearController>().getQuestionBankYear(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if(widget.title != "empty")
       CustomTitle(title: widget.title?? "year"),
      GetBuilder<QuestionBankYearController>(
          builder: (questionBankYearController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: QuestionBankYearDropdown(width: Get.width, title: "select".tr,
                items: questionBankYearController.questionBankYearModel?.data?.data??[],
                selectedValue: questionBankYearController.selectYearItem,
                onChanged: (val){
                  questionBankYearController.setSelectYearItem(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
