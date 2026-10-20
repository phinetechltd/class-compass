import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/quiz/quiz_topic/controller/quiz_topic_controller.dart';
import 'package:class_compass/feature/quiz/quiz_topic/domain/models/quiz_topic_model.dart';
import 'package:class_compass/feature/quiz/quiz_topic/presentation/widgets/create_new_quiz_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class QuizTopicItemWidget extends StatelessWidget {
  final bool fromQuestion;
  final QuizTopicItem? quizTopicItem;
  final int index;

  const QuizTopicItemWidget({super.key, this.quizTopicItem, required this.index, this.fromQuestion = false});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: fromQuestion? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
      child: fromQuestion? CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
        child: Center(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center, children: [

            Text("${quizTopicItem?.title}", maxLines: 1,overflow: TextOverflow.ellipsis, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
            Text(quizTopicItem?.description??'',maxLines: 1,overflow: TextOverflow.ellipsis, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${"mark".tr}: ", style: textRegular,),
                Text(quizTopicItem?.perQMark??'', style: textRegular,),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${"time".tr}: ", style: textRegular,),
                Text(quizTopicItem?.timer != "null" ? quizTopicItem?.timer??'0' : "0", style: textRegular,),
              ],
            ),
            const SizedBox(height :Dimensions.paddingSizeSmall),
            Row(spacing: Dimensions.paddingSizeSmall, children: [
                CustomContainer(borderRadius: 5, color: Theme.of(context).primaryColor,

                    child: Text("add_question".tr, style: textRegular.copyWith(color: Colors.white)),
                    onTap: (){
                     //  Get.find<QuestionController>().setSelectedTopic(quizTopicItem!.id!);
                     // Get.dialog(const CreateNewQuestionWidget());
                    }),

                CustomContainer(borderRadius: 5, child: Text("delete_answer".tr, style: textRegular,)),
              ],
            ),


          ],
          ),
        ),
      ):
      Row(spacing: Dimensions.paddingSizeDefault, children: [
        NumberingWidget(index: index),
        Expanded(child: Text("${quizTopicItem?.title}", maxLines: 1,overflow: TextOverflow.ellipsis, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
        Expanded(child: Text(quizTopicItem?.description??'',maxLines: 1,overflow: TextOverflow.ellipsis, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
        Expanded(child: Text(quizTopicItem?.perQMark??'', style: textRegular,)),
        Expanded(child: Text(quizTopicItem?.timer??'N/A', style: textRegular,)),


        EditDeleteSection(horizontal: true, onEdit: (){
          Get.dialog(CreateNewQuizTopicWidget(quizTopicItem: quizTopicItem));
          },
          onDelete: (){
          Get.find<QuizTopicController>().deleteQuizTopic(quizTopicItem!.id!);
          },)
      ],
      ),
    );
  }
}