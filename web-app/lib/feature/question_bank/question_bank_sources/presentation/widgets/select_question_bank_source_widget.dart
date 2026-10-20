import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/logic/question_bank_sources_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/presentation/widgets/question_bank_source_dropdown.dart';

class QuestionBankSelectSourceWidget extends StatefulWidget {
  final String? title;
  const QuestionBankSelectSourceWidget({super.key, this.title,});

  @override
  State<QuestionBankSelectSourceWidget> createState() => _QuestionBankSelectSourceWidgetState();
}

class _QuestionBankSelectSourceWidgetState extends State<QuestionBankSelectSourceWidget> {
  @override
  void initState() {
    if(Get.find<QuestionBankSourcesController>().questionBankSourcesModel == null){
      Get.find<QuestionBankSourcesController>().getQuestionBankSources(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if(widget.title != "empty")
       CustomTitle(title: widget.title?? "source".tr),
      GetBuilder<QuestionBankSourcesController>(
          builder: (questionBankSourcesController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: QuestionBankSourceDropdown(width: Get.width, title: "select".tr,
                items: questionBankSourcesController.questionBankSourcesModel?.data?.data??[],
                selectedValue: questionBankSourcesController.selectedQuestionBankSourcesItem,
                onChanged: (val){
                  questionBankSourcesController.setQuestionBankSourcesItem(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
