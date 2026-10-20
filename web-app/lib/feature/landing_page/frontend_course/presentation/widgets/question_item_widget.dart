import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/html_viewer.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/quiz_details_model.dart';



class QuestionItemWidget extends StatefulWidget {
  final Questions? questionItem;
  final int index;
  final bool practiseMode;
  const QuestionItemWidget({super.key, this.questionItem, required this.index, required this.practiseMode});

  @override
  State<QuestionItemWidget> createState() => _QuestionItemWidgetState();
}

class _QuestionItemWidgetState extends State<QuestionItemWidget> {

  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    return GetBuilder<FrontendCourseController>(
      builder: (courseController) {
        return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,
            vertical: Dimensions.paddingSizeSeven),
          child: Column(children: [
              Column(spacing: Dimensions.paddingSizeDefault,crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start,spacing: Dimensions.paddingSizeDefault, children: [
                    Text("${widget.index+1}. ", style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
                    Expanded(child: HtmlViewer(htmlText : widget.questionItem?.question??'')),
                    ]),

                  if( widget.questionItem?.type == "multiple_true_false")
                  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeOver),
                    child: Row(spacing: Dimensions.paddingSizeDefault,
                        children: [Text("True", style: textMedium.copyWith()), Text("False", style: textMedium.copyWith())])),

                  Padding(padding:  EdgeInsets.symmetric(horizontal: isDesktop? Dimensions.paddingSizeOver: Dimensions.paddingSizeSmall),
                    child: Column(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      if(widget.questionItem?.options != null && widget.questionItem?.options?.isNotEmpty == true)
                        ListView.builder(
                            itemCount: widget.questionItem?.options?.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index){
                              Options option = widget.questionItem!.options![index];
                              bool correctAnswer = widget.questionItem?.correctAnswer?[index] == "true";
                              bool? userAnswer;
                              if (option.isSelected == true) {
                                userAnswer = true;
                              } else if (option.isCorrect == true) {
                                userAnswer = false;
                              }

                              Widget resultIcon = const SizedBox.shrink(); // Default: show nothing
                              if (userAnswer != null) {
                                resultIcon = userAnswer == correctAnswer
                                    ? const Icon(Icons.check_circle, color: Colors.green, size: 20)
                                    : const Icon(Icons.cancel, color: Colors.red, size: 20);
                              }

                              return Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                                child: Row(spacing: Dimensions.paddingSizeSmall, crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.questionItem?.type == "multiple_true_false" ?
                                   Row(spacing: Dimensions.paddingSizeSmall, children: [
                                     InkWell(onTap : ()=> courseController.toggleAnswerSelection(widget.index, index),
                                         child: Icon(option.isSelected? Icons.radio_button_checked : Icons.radio_button_off, color: option.isSelected? systemLandingPagePrimaryColor() : Theme.of(context).hintColor)),
                                     InkWell(onTap : ()=> courseController.toggleFalseAnswerSelection(widget.index, index),
                                         child: Icon(option.isCorrect? Icons.radio_button_checked : Icons.radio_button_off, color: option.isCorrect? systemLandingPagePrimaryColor() : Theme.of(context).hintColor))
                                   ],):InkWell(onTap : ()=> courseController.toggleAnswerSelection(widget.index, index),
                                        child: Icon(option.isSelected? Icons.radio_button_checked : Icons.radio_button_off, color: option.isSelected? systemLandingPagePrimaryColor() : Theme.of(context).hintColor)),
                                    Flexible(child: Text("${String.fromCharCode(65 + index)}.  ${widget.questionItem?.options?[index].option.toString()??''}", style: textSemiBold)),

                                    if(widget.practiseMode)
                                    resultIcon,


                                  ],
                                ),
                              );
                            }),
                      if(widget.practiseMode)
                      GetBuilder<FrontendCourseController>(
                          builder: (questionController) {
                            return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IntrinsicWidth(child: CustomContainer(borderRadius: 5, showShadow: false,
                                    onTap: ()=> questionController.togglePractiseModeResult(widget.index),
                                    border: Border.all(color: Colors.green),
                                    child: Row(spacing: Dimensions.paddingSizeDefault, children: [
                                      Text("show_answer_and_solution".tr, style: textSemiBold.copyWith(color: Colors.green, fontSize: Dimensions.fontSizeDefault)),
                                      const Icon(Icons.check_box, color: Colors.green),

                                    ]))),

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

                                    // (widget.questionItem?.explanation is String && (widget.questionItem?.explanation as String).trim().isNotEmpty)?
                                    // RichText(text: TextSpan(children: spans)):
                                     HtmlViewer(htmlText: widget.questionItem?.explanation??''),
                                  ],
                                  ));
                            }
                        ),
                      ],


                    ]),
                  )
                ]),
            const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
              child: CustomDivider())
            ],
          ),
        );
      }
    );
  }



}