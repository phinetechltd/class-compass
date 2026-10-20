import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/logic/question_bank_board_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/presentation/widgets/question_bank_board_dropdown.dart';

class QuestionBankSelectBoardWidget extends StatefulWidget {
  final String? title;
  final int? index;
  const QuestionBankSelectBoardWidget({super.key, this.title, this.index,});

  @override
  State<QuestionBankSelectBoardWidget> createState() => _QuestionBankSelectBoardWidgetState();
}

class _QuestionBankSelectBoardWidgetState extends State<QuestionBankSelectBoardWidget> {
  @override
  void initState() {
    if(Get.find<QuestionBankBoardController>().questionBankBoardModel == null){
      Get.find<QuestionBankBoardController>().getQuestionBankBoard(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if(widget.title != null && widget.title != "empty")
       CustomTitle(title: widget.title!),
      GetBuilder<QuestionBankBoardController>(
          builder: (questionBankBoardController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: QuestionBankBoardDropdown(width: Get.width, title: "select".tr,
                items: questionBankBoardController.questionBankBoardModel?.data?.data??[],
                selectedValue: questionBankBoardController.selectBoardItem,
                onChanged: (val){
                  questionBankBoardController.setSelectBoardItem(val!, index: widget.index);
                },
              ),);
          }
      ),
    ],);
  }
}
