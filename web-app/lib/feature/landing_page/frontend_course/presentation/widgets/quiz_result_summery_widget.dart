import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/quiz_result_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/screens/quiz_exam_review_result_screen.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class QuizResultSummeryWidget extends StatelessWidget {
  const QuizResultSummeryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   GetBuilder<FrontendCourseController>(
      builder: (courseController) {
        QuizResultModel? quizResultModel = courseController.quizResultModel;
        return CustomContainer(showShadow: false, borderRadius: 5,border: Border.all(width: .125, color: Theme.of(context).hintColor),
          child: ResponsiveHelper.isDesktop(context)?
          Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeDefault, children: [
            Expanded(child:  CustomContainer(showShadow: false, borderRadius: 5,border: Border.all(width: .125, color: Theme.of(context).hintColor),
              child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: CustomContainer(showShadow: false,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
                    Text("your_answer".tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                    const CustomDivider(),

                    SummeryItem(title: "total_questions".tr, value: "${quizResultModel?.data?.answerBreakdown?.totalQuestions??'0'}"),
                    SummeryItem(title: "correct_answers".tr, value: "${quizResultModel?.data?.answerBreakdown?.correctAnswers??'0'}"),
                    SummeryItem(title: "wrong_answers".tr, value: "${quizResultModel?.data?.answerBreakdown?.wrongAnswers??'0'}"),
                    SummeryItem(title: "unanswered".tr, value: "${quizResultModel?.data?.answerBreakdown?.unansweredQuestions??'0'}"),
                  ]),
                )),
              ]),
            ),),
            Expanded(child:  CustomContainer(showShadow: false, borderRadius: 5,border: Border.all(width: .125, color: Theme.of(context).hintColor),
              child: Row(children: [
                Expanded(child: CustomContainer(showShadow: false,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
                    Text("your_marks".tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                    const CustomDivider(),

                    SummeryItem(title: "correct".tr, value: "${quizResultModel?.data?.marksSummary?.marksFromCorrectAnswers??'0'}"),
                    SummeryItem(title: "negative".tr, value: "${quizResultModel?.data?.marksSummary?.negativeMarks??'0'}"),
                    SummeryItem(title: "obtained".tr, value: "${quizResultModel?.data?.marksSummary?.totalObtainedMarks??'0'}"),
                    SummeryItem(title: "highest".tr, value: "${quizResultModel?.data?.marksSummary?.highestMarksInQuiz??'0'}"),
                  ]),
                )),
              ]),
            ),),
            Expanded(child:  CustomContainer(showShadow: false, borderRadius: 5,border: Border.all(width: .125, color: Theme.of(context).hintColor),
              child: Row(children: [
                Expanded(child: CustomContainer(showShadow: false,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
                    Text("your_position".tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                    const CustomDivider(),
                    SummeryItem(title: "position".tr, value: "${quizResultModel?.data?.rankingPositions?.position??'0'}"),

                  ]),
                )),
              ]),
            ),),
          ]):
          Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeDefault, children: [
            CustomContainer(showShadow: false, borderRadius: 5,border: Border.all(width: .125, color: Theme.of(context).hintColor),
              child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: CustomContainer(showShadow: false,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
                    Text("your_answer".tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                    const CustomDivider(),

                    SummeryItem(title: "total_questions".tr, value: "${quizResultModel?.data?.answerBreakdown?.totalQuestions??'0'}"),
                    SummeryItem(title: "correct_answers".tr, value: "${quizResultModel?.data?.answerBreakdown?.correctAnswers??'0'}"),
                    SummeryItem(title: "wrong_answers".tr, value: "${quizResultModel?.data?.answerBreakdown?.wrongAnswers??'0'}"),
                    SummeryItem(title: "unanswered".tr, value: "${quizResultModel?.data?.answerBreakdown?.unansweredQuestions??'0'}"),
                  ]),
                )),
              ]),
            ),
            CustomContainer(showShadow: false, borderRadius: 5,border: Border.all(width: .125, color: Theme.of(context).hintColor),
              child: Row(children: [
                Expanded(child: CustomContainer(showShadow: false,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
                    Text("your_marks".tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                    const CustomDivider(),

                    SummeryItem(title: "correct".tr, value: "${quizResultModel?.data?.marksSummary?.marksFromCorrectAnswers??'0'}"),
                    SummeryItem(title: "negative".tr, value: "${quizResultModel?.data?.marksSummary?.negativeMarks??'0'}"),
                    SummeryItem(title: "obtained".tr, value: "${quizResultModel?.data?.marksSummary?.totalObtainedMarks??'0'}"),
                    SummeryItem(title: "highest".tr, value: "${quizResultModel?.data?.marksSummary?.highestMarksInQuiz??'0'}"),
                  ]),
                )),
              ]),
            ),
            CustomContainer(showShadow: false, borderRadius: 5,border: Border.all(width: .125, color: Theme.of(context).hintColor),
              child: Row(children: [
                Expanded(child: CustomContainer(showShadow: false,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
                    Text("your_position".tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                    const CustomDivider(),
                    SummeryItem(title: "position".tr, value: "${quizResultModel?.data?.rankingPositions?.position??'0'}"),

                  ]),
                )),
              ]),
            ),
          ]),
        );
      }
    );
  }
}
