import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/logic/question_bank_subject_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/presentation/widgets/question_bank_subject_dropdown.dart';
import 'package:class_compass/util/dimensions.dart';

import '../../../../../util/styles.dart' show textRegular;

class QuestionBankSelectSubjectWidget extends StatefulWidget {
  final String? title;
  final bool required;
  final bool filter;
  const QuestionBankSelectSubjectWidget({super.key, this.title, this.required = false,  this.filter = false});

  @override
  State<QuestionBankSelectSubjectWidget> createState() => _QuestionBankSelectSubjectWidgetState();
}

class _QuestionBankSelectSubjectWidgetState extends State<QuestionBankSelectSubjectWidget> {
  @override
  void initState() {
    if(Get.find<QuestionBankSubjectController>().questionBankSubjectModel == null){
      Get.find<QuestionBankSubjectController>().getQuestionBankSubject(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if(widget.title != "empty")
        Text.rich(TextSpan(children: [
          TextSpan(text: widget.title??"subject".tr, style:  textRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
          if(widget.required) TextSpan(text: "*", style: textRegular.copyWith(color: Colors.red))
        ]),),

      GetBuilder<QuestionBankSubjectController>(
          builder: (questionBankSubjectController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: QuestionBankSubjectDropdown(width: Get.width, title: "select".tr,
                items: questionBankSubjectController.questionBankSubjectModel?.data?.data??[],
                selectedValue: questionBankSubjectController.selectSubjectItem,
                onChanged: (val){
                  questionBankSubjectController.setSelectSubjectItem(val!, filter: widget.filter);
                },
              ),);
          }
      ),
    ],);
  }
}
