import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/html_viewer.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/quiz_result_model.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';



class QuizReviewQuestionItemWidget extends StatefulWidget {
  final Questions? questionItem;
  final int index;
  const QuizReviewQuestionItemWidget({super.key, this.questionItem, required this.index});

  @override
  State<QuizReviewQuestionItemWidget> createState() => _QuizReviewQuestionItemWidgetState();
}

class _QuizReviewQuestionItemWidgetState extends State<QuizReviewQuestionItemWidget> {


  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {

    return GetBuilder<FrontendCourseController>(
      builder: (courseController) {
        final isDesktop = ResponsiveHelper.isDesktop(context);
        return Padding(padding: EdgeInsets.symmetric(horizontal:  isDesktop ? Dimensions.paddingSizeDefault : 0, vertical: Dimensions.paddingSizeSeven),
          child: CustomContainer(showShadow: false, borderRadius: 5,

            child: Column(children: [
                Column(spacing: Dimensions.paddingSizeDefault,crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.start,spacing: Dimensions.paddingSizeDefault, children: [
                      Text("${widget.index+1}. ", style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
                      Expanded(child:  HtmlViewer(htmlText: widget.questionItem?.questionText??'')),
                      ]),


                    Padding(padding: EdgeInsets.symmetric(horizontal: isDesktop ? Dimensions.paddingSizeOver : Dimensions.paddingSizeSmall),
                      child: Column(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [
                        if(widget.questionItem?.questionOptions != null && widget.questionItem?.questionOptions?.isNotEmpty == true)
                          ListView.builder(
                              itemCount: widget.questionItem?.questionOptions?.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index){
                                return Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                                  child: Row(children: [
                                      Expanded(child: Text("${String.fromCharCode(65 + index)}.  ${widget.questionItem?.questionOptions?[index].toString()??''}",
                                            style: textRegular)),

                                      if(widget.questionItem?.questionType == "multiple_true_false")...[
                                        SizedBox(width:  isDesktop? 110 : 80,
                                          child: Row(spacing: isDesktop? Dimensions.paddingSizeDefault : Dimensions.paddingSizeExtraSmall,
                                            children: [
                                              CustomContainer(borderRadius: 120, width: isDesktop? 25 : 20, height: isDesktop? 25:20, showShadow: false,
                                                  verticalPadding: 0, horizontalPadding: 0,
                                                  border: Border.all(color: systemLandingPagePrimaryColor(), width: 2),
                                                  color: widget.questionItem?.userAnswer?[index] == "true" ? systemLandingPagePrimaryColor() : Colors.transparent,
                                                  child: Center(child: Text("T", style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraSmall,
                                                      color: widget.questionItem?.userAnswer?[index] == "true" ?
                                                      Colors.white : systemLandingPagePrimaryColor())))),
                                              CustomContainer(borderRadius: 120, width: isDesktop? 25 : 20, height: isDesktop? 25:20, showShadow: false,
                                                  verticalPadding: 0, horizontalPadding: 0,
                                                  border: Border.all(color: systemLandingPagePrimaryColor(), width: 2),
                                                  color: widget.questionItem?.userAnswer?[index] == "false" ? systemLandingPagePrimaryColor() : Colors.transparent,
                                                  child: Center(child: Text("F", style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraSmall,
                                                      color: widget.questionItem?.userAnswer?[index] == "false" ? Colors.white :
                                                      systemLandingPagePrimaryColor())))),

                                              if(widget.questionItem?.userAnswer?[index] != "N/A")...[
                                                (widget.questionItem?.correctAnswer?[index] == widget.questionItem?.userAnswer?[index])?
                                                Icon(Icons.check_circle, color: Colors.green, size: isDesktop? 25 : 20):

                                                Icon(Icons.cancel, color: Colors.red, size: isDesktop? 25 : 20),
                                              ],

                                            ],
                                          ),
                                        ),
                                        ]
                                    ],
                                  ),
                                );
                              }),

                      ]),
                    ),

                  IntrinsicWidth(
                    child: CustomContainer(borderRadius: 5, showShadow: false,
                        onTap: ()=> courseController.toggleQuestionItemSelection(widget.index),
                        border: Border.all(color: Colors.green),
                        child: Row(spacing: Dimensions.paddingSizeDefault, children: [
                          Text("show_answer_and_solution".tr, style: textRegular.copyWith(color: Colors.green, fontSize: Dimensions.fontSizeSmall)),
                          const Icon(Icons.check_circle, color: Colors.green, size: 16,),

                        ])),
                  ),

                  if(widget.questionItem?.isSelected == true)...[
                    CustomContainer(showShadow: false, borderRadius: 5, border: Border.all(color: Theme.of(context).hintColor),
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
                              Text("${"solution".tr}: ", style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
                            ]),

                           HtmlViewer(htmlText: widget.questionItem?.explanation??''),
                        ],
                        )),
                  ],


                  ]),
              ],
            ),
          ),
        );
      }
    );
  }

}