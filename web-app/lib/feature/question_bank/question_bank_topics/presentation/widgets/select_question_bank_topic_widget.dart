import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/logic/question_bank_topics_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/presentation/widgets/question_bank_topic_dropdown.dart';

class QuestionBankSelectTopicWidget extends StatefulWidget {
  final String? title;
  final bool filter;
  const QuestionBankSelectTopicWidget({super.key, this.title,  this.filter = false,});

  @override
  State<QuestionBankSelectTopicWidget> createState() => _QuestionBankSelectTopicWidgetState();
}

class _QuestionBankSelectTopicWidgetState extends State<QuestionBankSelectTopicWidget> {
  @override
  void initState() {
    if(Get.find<QuestionBankTopicsController>().questionBankTopicsModel == null){
      Get.find<QuestionBankTopicsController>().getQuestionBankTopics(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if(widget.title != "empty")
       CustomTitle(title: widget.title?? "topic".tr),
      GetBuilder<QuestionBankTopicsController>(
          builder: (questionBankTopicsController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: QuestionBankTopicDropdown(width: Get.width, title: "select".tr,
                items: questionBankTopicsController.questionBankTopicsModel?.data?.data??[],
                selectedValue: questionBankTopicsController.selectQuestionBankTopicItem,
                onChanged: (val){
                  questionBankTopicsController.setSelectQuestionBankTopicItem(val!, filter: widget.filter);
                },
              ),);
          }
      ),
    ],);
  }
}
