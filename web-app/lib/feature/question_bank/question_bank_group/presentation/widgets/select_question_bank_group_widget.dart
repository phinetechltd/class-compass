import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/logic/question_bank_group_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/presentation/widgets/question_bank_group_dropdown.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class QuestionBankSelectGroupWidget extends StatefulWidget {
  final String? title;
  final bool fromStudentFilter;
  final bool required;
  const QuestionBankSelectGroupWidget({super.key, this.title, this.fromStudentFilter = false, this.required = false});

  @override
  State<QuestionBankSelectGroupWidget> createState() => _QuestionBankSelectGroupWidgetState();
}

class _QuestionBankSelectGroupWidgetState extends State<QuestionBankSelectGroupWidget> {
  @override
  void initState() {
    if(Get.find<QuestionBankGroupController>().questionBankGroupModel == null){
      Get.find<QuestionBankGroupController>().getQuestionBankGroup(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if(widget.title != "empty")
        if(widget.title != "empty")
          Text.rich(TextSpan(children: [
            TextSpan(text: widget.title??"group".tr, style:  textRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
            if(widget.required) TextSpan(text: "*", style: textRegular.copyWith(color: Colors.red))
          ]),),
      GetBuilder<QuestionBankGroupController>(
          builder: (questionBankGroupController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: QuestionBankGroupDropdown(width: Get.width, title: "select".tr,
                items: questionBankGroupController.questionBankGroupModel?.data?.data??[],
                selectedValue: questionBankGroupController.selectedGroupItem,
                onChanged: (val){
                  questionBankGroupController.setSelectGroupItem(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
