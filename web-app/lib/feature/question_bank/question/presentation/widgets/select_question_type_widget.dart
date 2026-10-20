import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class SelectQuestionTypeWidget extends StatelessWidget {
  const SelectQuestionTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        builder: (questionController) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const CustomTitle(title: "choose_a_question_type_to_add", leftPadding: 0),
            Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(height: 50,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: questionController.questionType.length,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index){
                  return IntrinsicWidth(
                    child: RadioGroup(groupValue: questionController.selectedQuestionType,
                      onChanged: (val){
                        questionController.changeQuestionType(val!);
                      },
                      child: Text(questionController.questionType[index],
                          style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                    ),
                  );
                }),
              )
            ),
          ],);
        }
    );
  }
}
