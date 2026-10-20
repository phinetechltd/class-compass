import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/coutom_royte_path/custom_route_path_widget.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/no_data_found.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/quiz_result_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/quiz_result_summery_widget.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/quiz_review_question_item_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class QuizExamReviewResultScreen extends StatefulWidget {
  final String? courseId;
  const QuizExamReviewResultScreen({super.key, this.courseId});

  @override
  State<QuizExamReviewResultScreen> createState() => _QuizExamReviewResultScreenState();
}

class _QuizExamReviewResultScreenState extends State<QuizExamReviewResultScreen> {

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ResponsiveHelper.isDesktop(context);
    return Scaffold(
      body: GetBuilder<FrontendCourseController>(
        builder: (courseController) {
          QuizResultModel? quizResultModel = courseController.quizResultModel;
          var question = quizResultModel?.data?.questions;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomRoutePathWidget(title: "course_management".tr,
                  subWidget: Row(children: [
                    PathItemWidget(title: "quiz".tr, color: Theme.of(context).secondaryHeaderColor),
                  ]), onBackTap: ()=> Get.toNamed(RouteHelper.getMyCourseDetailsRoute(widget.courseId!)),),

                Text("${quizResultModel?.data?.quizInfo?.quizTitle??''} - "
                    "${"total_questions".tr} ${quizResultModel?.data?.quizInfo?.quizTotalQuestions??'0'} - ${"total_time".tr} "
                    "${quizResultModel?.data?.quizInfo?.quizTimeLimitValue??'0'} ${quizResultModel?.data?.quizInfo?.quizTimeLimitUnit??'min'}",
                    style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                Text("${quizResultModel?.data?.quizInfo?.courseTitle??''} - ${quizResultModel?.data?.quizInfo?.chapterTitle??''}",
                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),),

                const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: QuizResultSummeryWidget()),


                Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Column(spacing: Dimensions.paddingSizeSmall, children: [
                    Row(spacing: Dimensions.paddingSizeSmall, children: [
                      const Icon(Icons.check_circle, color: Colors.green, size: 16,),
                      Text("you_have_chosen_the_correct_answer".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                    ]),
                    Row(spacing: Dimensions.paddingSizeSmall, children: [
                      const Icon(Icons.cancel, color: Colors.red, size: 16),
                      Text("you_have_chosen_the_incorrect_answer".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                    ]),
                  ]),
                ),

                CustomContainer(width: Get.width,showShadow: false,borderRadius: 0,
                    color: isDesktop? Theme.of(context).cardColor : Colors.transparent,
                    horizontalPadding:  isDesktop ? Dimensions.paddingSizeDefault : 0,
                    child : quizResultModel != null? (question != null && question.isNotEmpty)?
                    ListView.builder(
                        itemCount: question.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return QuizReviewQuestionItemWidget(index: index, questionItem: question[index]);
                        }):
                    Padding(padding: ThemeShadow.getPadding(),
                      child: const Center(child: NoDataFound()),):
                    Padding(padding:ThemeShadow.getPadding(),
                        child: const Center(child: CircularProgressIndicator())))
              ]),
            ),
          );
        }
      ),
    );
  }
}

class SummeryItem extends StatelessWidget {
  final String title;
  final String value;
  final Color? color;
  const SummeryItem({super.key, required this.title, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(child: Text(title, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor))),
      Text(value, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: color)),


    ]);
  }
}
