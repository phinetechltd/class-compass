
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/html_viewer.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/feature/question_bank/question/domain/model/question_model.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';


class QuestionItemWidget extends StatefulWidget {
  final QuestionItem? questionItem;
  final int index;
  final bool fromQuiz;
  const QuestionItemWidget({super.key, this.questionItem, required this.index, required this.fromQuiz});

  @override
  State<QuestionItemWidget> createState() => _QuestionItemWidgetState();
}

class _QuestionItemWidgetState extends State<QuestionItemWidget> {

  @override
  Widget build(BuildContext context) {

    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
      child: Column(children: [
          Column(spacing: Dimensions.paddingSizeDefault,crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                if(widget.fromQuiz)
                SizedBox(height: 20,
                  child: Checkbox(value: widget.questionItem?.selectForQuiz == true, onChanged: (val){
                    Get.find<QuestionController>().selectUnselectQuestionForQuiz(widget.index);
                  }),
                ),
                Text("${widget.index + 1}. ", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),

                Expanded(child:  HtmlViewer(htmlText: widget.questionItem?.question??"")),
                ]),
              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Column(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  if(widget.questionItem?.options != null && widget.questionItem?.options?.isNotEmpty == true)
                    ListView.builder(
                        itemCount: widget.questionItem?.options?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index){
                          return Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                            child: Text("${String.fromCharCode(65 + index)}.  ${widget.questionItem?.options?[index].toString()??''}", style: textSemiBold),
                          );
                        }),

                  if(widget.questionItem?.questionYear != null && widget.questionItem?.questionYear?.isNotEmpty == true)
                  SizedBox(height: 30,
                    child: ListView.builder(
                        itemCount: widget.questionItem?.questionYear?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index){
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3.0),
                            child: CustomContainer(verticalPadding: 0, borderRadius: 300, showShadow: false,
                                color: Colors.red.withValues(alpha: .125),
                                child: Center(child: Text("${widget.questionItem?.questionYear?[index].board.toString()??''} ${widget.questionItem?.questionYear?[index].year.toString()??''}",
                                    style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Colors.red)))),
                          );
                        }),
                  ),

                  GetBuilder<QuestionController>(
                      builder: (questionController) {
                        return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IntrinsicWidth(child: CustomContainer(borderRadius: 5, showShadow: false,
                                onTap: ()=> questionController.toggleQuestionItemSelection(widget.index),
                                border: Border.all(color: Colors.green),
                                child: Row(spacing: Dimensions.paddingSizeDefault, children: [
                                  Text("show_answer_and_solution".tr,
                                      style: textSemiBold.copyWith(color: Colors.green, fontSize: Dimensions.fontSizeDefault)),
                                  const Icon(Icons.check_box, color: Colors.green),

                                ]))),

                            Row(mainAxisSize: MainAxisSize.min,spacing: Dimensions.paddingSizeDefault, children: [
                              CustomContainer(onTap: ()=> Get.toNamed(RouteHelper.getAddNewQuestionRoute(
                                  questionItem: widget.questionItem)),
                                color: Theme.of(context).secondaryHeaderColor.withValues(alpha: .2),
                                width: 40,borderRadius: 5,showShadow: false,border: Border.all(color: Theme.of(context).secondaryHeaderColor, width: .5),
                                child: Image.asset(Images.edit, color: Theme.of(context).secondaryHeaderColor,),),
                              CustomContainer(onTap: (){
                                Get.dialog(ConfirmationDialog(
                                    title: "question",
                                    content: "question".tr,
                                    onTap: (){
                                      Get.back();
                                      Get.find<QuestionController>().deleteQuestion(widget.questionItem!.id!);
                                    }));
                              },
                                color: Theme.of(context).colorScheme.error.withValues(alpha: .2),
                                width: 40,borderRadius: 5,showShadow: false,border: Border.all(color: Theme.of(context).colorScheme.error, width: .5),
                                child: Image.asset(Images.deleteIcon, color: Theme.of(context).colorScheme.error),),
                            ])
                          ],
                        );
                      }
                  ),
                  if(widget.questionItem?.isSelected == true)...[
                    GetBuilder<ProfileController>(
                      builder: (profileController) {
                        return CustomContainer(showShadow: false, borderRadius: 5, border: Border.all(color: Theme.of(context).hintColor),
                            child: Column(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                const CustomImage(image: Images.answerIcon, localAsset: true,width: 20,),
                                Flexible(child: ListView.builder(
                                    itemCount: widget.questionItem?.correctAnswer?.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (_, index) {
                                      return Text("${"answer".tr}: ${String.fromCharCode(65 + index)}.  ${widget.questionItem?.correctAnswer?[index].toString()??''}", style: textSemiBold);
                                    }),
                                ),
                              ],
                              ),
                              Row(spacing: Dimensions.paddingSizeDefault,
                                children: [
                                  const CustomImage(image: Images.answerIcon, localAsset: true,width: 20,),
                                  Text("${"solution".tr}: ", style: textSemiBold),
                                ],
                              ),

                               HtmlViewer(
                                htmlText: widget.questionItem?.explanation ?? "",
                              ),
                            ],
                            ));
                      }
                    ),
                  ],

                ]),
              )
            ]),
        const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
          child: CustomDivider(verticalPadding: Dimensions.paddingSizeExtraSmall))
        ],
      ),
    );
  }
}