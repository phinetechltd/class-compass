import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/logic/question_bank_class_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/presentation/widgets/question_bank_class_dropdown.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class QuestionBankSelectClassWidget extends StatefulWidget {
  final String? title;
  final bool fromStudentFilter;
  final bool required;
  const QuestionBankSelectClassWidget({super.key, this.title, this.fromStudentFilter = false, this.required = false});

  @override
  State<QuestionBankSelectClassWidget> createState() => _QuestionBankSelectClassWidgetState();
}

class _QuestionBankSelectClassWidgetState extends State<QuestionBankSelectClassWidget> {
  @override
  void initState() {
    if(Get.find<QuestionBankClassController>().questionBankClassModel == null){
      Get.find<QuestionBankClassController>().getQuestionBankClass(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if(widget.title != "empty")
       Text.rich(TextSpan(children: [
          TextSpan(text: widget.title??"class".tr, style:  textRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
          if(widget.required) TextSpan(text: "*", style: textRegular.copyWith(color: Colors.red))
        ]),),
      GetBuilder<QuestionBankClassController>(
          builder: (questionBankClassController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: QuestionBankClassDropdown(width: Get.width, title: "select".tr,
                items: questionBankClassController.questionBankClassModel?.data?.data??[],
                selectedValue: questionBankClassController.selectedClassItem,
                onChanged: (val){
                  questionBankClassController.setSelectClass(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
