import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/logic/question_bank_chapter_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/presentation/widgets/question_bank_chapter_dropdown.dart';

class QuestionBankSelectChapterWidget extends StatefulWidget {
  final String? title;
  final bool filter;
  const QuestionBankSelectChapterWidget({super.key, this.title,  this.filter = false,});

  @override
  State<QuestionBankSelectChapterWidget> createState() => _QuestionBankSelectChapterWidgetState();
}

class _QuestionBankSelectChapterWidgetState extends State<QuestionBankSelectChapterWidget> {
  @override
  void initState() {
    if(Get.find<QuestionBankChapterController>().questionBankChapterModel == null){
      Get.find<QuestionBankChapterController>().getQuestionBankChapter(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if(widget.title != "empty")
       CustomTitle(title: widget.title?? "chapter".tr),
      GetBuilder<QuestionBankChapterController>(
          builder: (questionBankChapterController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: QuestionBankChapterDropdown(width: Get.width, title: "select".tr,
                items: questionBankChapterController.questionBankChapterModel?.data?.data??[],
                selectedValue: questionBankChapterController.selectChapterItem,
                onChanged: (val){
                  questionBankChapterController.setSelectChapterItem(val!, filter: widget.filter);
                },
              ),);
          }
      ),
    ],);
  }
}
