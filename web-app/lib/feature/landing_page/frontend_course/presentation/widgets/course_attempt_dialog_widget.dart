import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/my_course_details_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/date_converter.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class CourseAttemptDialogWidget extends StatelessWidget {
  final Function()? onTap;
  const CourseAttemptDialogWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FrontendCourseController>(
        builder: (courseController) {
          double totalMark = ((courseController.selectedContent?.questionIds?.length ?? 0) * (courseController.selectedContent?.marksPerQuestion ?? 0)).toDouble();

          return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),child: SizedBox(width: 750,
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,children: [
                  Flexible(child: SingleChildScrollView(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,spacing: Dimensions.paddingSizeDefault, mainAxisSize: MainAxisSize.min, children: [

                        Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, 0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text("review_your_exam_settings".tr,
                                        style: textSemiBold.copyWith(fontSize: ResponsiveHelper.isDesktop(context)? Dimensions.fontSizeLarge: Dimensions.fontSizeSmall),),
                                      Text("please_verify_all_details_before_starting_your_exam".tr,
                                        style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall),),
                                    ],
                                  ),
                                ),
                                IconButton(onPressed: (){
                                  Get.back();
                                }, icon: Icon(Icons.close_rounded, color: Theme.of(context).hintColor, size: 20,)),
                              ],
                            )),
                        const CustomDivider(),



                        CustomContainer(showShadow: false, borderRadius: 5,border: Border.all(color: Theme.of(context).hintColor, width: .25),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                          Row(spacing: Dimensions.paddingSizeSmall, children: [
                            const CustomImage(localAsset: true, image: Images.quiz,width: 25),
                            Text("exam_summery".tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault))
                          ]),
                          const CustomDivider(),
                              const SizedBox(height: Dimensions.paddingSizeDefault),
                              Text("exam_title".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor)),
                              Text(courseController.selectedContent?.title??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                              const SizedBox(height: Dimensions.paddingSizeDefault),

                          Row(children: [
                            Expanded(child: ExamSummeryItemWidget(title: "total_question".tr, value: "${courseController.selectedContent?.questionIds?.length??0}")),
                            Expanded(child: ExamSummeryItemWidget(title: "time_limit".tr,
                                value: "${courseController.selectedContent?.timeLimitValue??0} ${courseController.selectedContent?.timeLimitUnit??''}")),
                            Expanded(child: ExamSummeryItemWidget(title: "total_mark".tr, value: "$totalMark")),
                            Expanded(child: ExamSummeryItemWidget(title: "exam_type".tr, value: "MCQ")),
                          ],)
                        ])),

                        CustomContainer(showShadow: false, verticalPadding: 15, borderRadius: 5,
                            border: Border.all(color: Theme.of(context).colorScheme.error, width: .25),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(spacing: Dimensions.paddingSizeExtraSmall, children: [
                            const Icon(Icons.warning_amber_rounded, size: 16, color: Colors.red,),
                            Text("special_instructions".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))
                          ]),
                          const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                            child: CustomDivider()),

                          Text.rich(TextSpan(
                              text: "",
                              children: [
                                TextSpan(text: "+${courseController.selectedContent?.marksPerQuestion??0} ",
                                    style: textRegular.copyWith( fontSize: Dimensions.fontSizeExtraSmall, color: Colors.green)),
                                TextSpan(text: "marks_for_correct_answer".tr, style: textRegular.copyWith( fontSize: Dimensions.fontSizeExtraSmall))
                              ]
                          )),
                          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                          Text.rich(TextSpan(
                              text: "",
                              children: [
                                TextSpan(text: "-${courseController.selectedContent?.negativeMarksPerWrongAnswer??0} ",
                                    style: textRegular.copyWith( fontSize: Dimensions.fontSizeExtraSmall, color: Colors.red)),
                                TextSpan(text: "marks_for_wrong_answer".tr,
                                  style: textRegular.copyWith( fontSize: Dimensions.fontSizeExtraSmall),)
                              ]
                          )),
                        ])),
                        if(courseController.selectedContent?.quizAttempts != null && courseController.selectedContent!.quizAttempts!.isNotEmpty)
                        CustomContainer(showShadow: false, borderRadius: 5,border: Border.all(color: Theme.of(context).hintColor, width: .25),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                              Row(spacing: Dimensions.paddingSizeSmall, children: [
                                const CustomImage(localAsset: true, image: Images.quiz,width: 25),
                                Text("previous_exam_report".tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault))
                              ]),
                              const CustomDivider(),
                              const SizedBox(height: Dimensions.paddingSizeDefault),

                              CustomContainer(showShadow: false, borderRadius: 5, border: Border.all(color: Theme.of(context).hintColor, width: .25),
                                  horizontalPadding: 0, verticalPadding: 0,
                                  child: Column(children: [
                                Container(decoration: BoxDecoration(color: Theme.of(context).highlightColor.withValues(alpha: .5),
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(5))),
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
                                  child: Row(children: [
                                    Expanded(child: Text( "date_time".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
                                    Expanded(child: Text( "grade".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
                                    Expanded(child: Text( "position".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
                                    Expanded(child: Text( "preview".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),


                                  ]),
                                ),
                                const SizedBox(height: Dimensions.paddingSizeSmall),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: courseController.selectedContent?.quizAttempts?.length??0,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (_, index){
                                      QuizAttempts? quizAttempts = courseController.selectedContent?.quizAttempts?[index];
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeExtraSmall, 0, Dimensions.paddingSizeExtraSmall, Dimensions.paddingSizeSmall),
                                        child: Row(children: [
                                          Expanded(child: Text( DateConverter.dateTimeStringToDateTime(quizAttempts?.submittedAt?? DateTime.now().toString()),
                                              style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall))),
                                          Expanded(child: Text( "${quizAttempts?.resultSummary?.gradeDisplay??0}",
                                              style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall))),
                                          Expanded(child: Text( "${quizAttempts?.resultSummary?.positionRank??0}",
                                              style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall))),
                                          Expanded(child: InkWell(onTap : (){
                                            Get.back();
                                            courseController.quizResults(courseController.selectedContent!.typeId!, quizAttempts!.attemptId!);
                                          },
                                            child: Text( "review".tr, style: textRegular.copyWith(decoration: TextDecoration.underline,
                                                fontSize: Dimensions.fontSizeDefault, color: systemLandingPagePrimaryColor()),),
                                          )),
                                        ]),
                                      );
                                    }),
                              ])),
                            ])),
                      ]),
                    ),
                  ),

                const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: CustomDivider()),
                CustomContainer(onTap: onTap, verticalPadding: 7,
                    borderRadius: Dimensions.radiusSmall, showShadow: false,
                    color: systemLandingPagePrimaryColor(),
                    child: Text("start_exam".tr, style: textRegular.copyWith(color: Colors.white))),
                ],
              ),
            ),
          ));
        }
    );
  }
}
class ExamSummeryItemWidget extends StatelessWidget {
  final String title;
  final String value;
  const ExamSummeryItemWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: textRegular.copyWith(color: Theme.of(context).hintColor)),
      Text(value, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
    ]);
  }
}


