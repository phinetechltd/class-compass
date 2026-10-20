
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/logic/question_bank_board_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/presentation/widgets/select_question_bank_board_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class QuestionYearSelectionWidget extends StatelessWidget {
  const QuestionYearSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankBoardController>(builder: (boardController) {
      return GetBuilder<QuestionController>(builder: (questionController) {
        return ListView.builder(
            itemCount: questionController.questionYearBodyList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (_,index){
              return Row(children: [
                Text("${index + 1}. ${questionController.questionYearBodyList[index].year}"),
                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                    child: Container(width: 1, height: 15, color: Theme.of(context).hintColor)),
                SizedBox(height: 30,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: questionController.questionYearBodyList[index].board?.length??0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, boardIndex){
                      String data = questionController.questionYearBodyList[index].board![boardIndex].board??"";
                      return Padding(padding: const EdgeInsets.all(3.0), child: Text("$data, ",
                          style: textRegular));
                      },
                  )),

                SizedBox(width: 170, child: QuestionBankSelectBoardWidget(index: index)),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                InkWell(onTap: ()=> questionController.removeQuestionYearBody(questionController.questionYearBodyList[index]),
                    child: const Icon(Icons.delete_forever, color: Colors.red)),
              ]);
            });
            }
          );
        }
    );
  }
}
