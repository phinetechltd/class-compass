import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/logic/question_bank_sub_sources_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/presentation/widgets/question_bank_sub_source_dropdown.dart';

class QuestionBankSelectSubSourceWidget extends StatefulWidget {
  final String? title;
  const QuestionBankSelectSubSourceWidget({super.key, this.title,});

  @override
  State<QuestionBankSelectSubSourceWidget> createState() => _QuestionBankSelectSubSourceWidgetState();
}

class _QuestionBankSelectSubSourceWidgetState extends State<QuestionBankSelectSubSourceWidget> {
  @override
  void initState() {
    if(Get.find<QuestionBankSubSourcesController>().questionBankSubSourceModel == null){
      Get.find<QuestionBankSubSourcesController>().getQuestionBankSubSources(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if(widget.title != "empty")
       CustomTitle(title: widget.title?? "sub_source"),
      GetBuilder<QuestionBankSubSourcesController>(
          builder: (questionBankSubSourcesController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: QuestionBankSubSourceDropdown(width: Get.width, title: "select".tr,
                items: questionBankSubSourcesController.questionBankSubSourceModel?.data?.data??[],
                selectedValue: questionBankSubSourcesController.selectedQuestionBankSubSourcesItem,
                onChanged: (val){
                  questionBankSubSourcesController.setQuestionBankSubSourcesItem(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
