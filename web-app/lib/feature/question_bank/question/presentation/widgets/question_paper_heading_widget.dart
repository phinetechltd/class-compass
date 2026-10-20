import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';
import 'package:responsive_grid/responsive_grid.dart';


class QuestionPaperHeadingItem extends StatefulWidget {
  const QuestionPaperHeadingItem({super.key});

  @override
  State<QuestionPaperHeadingItem> createState() => _QuestionPaperHeadingItemState();
}

class _QuestionPaperHeadingItemState extends State<QuestionPaperHeadingItem> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
      builder: (questionController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: ResponsiveGridList(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            desiredItemWidth: 250,
            minSpacing: Dimensions.paddingSizeDefault,
          children: [
            CustomTextField(controller: questionController.schoolNameController,hintText: "Class Compass"),
            CustomTextField(controller: questionController.classNameController,hintText: "HSC 1st Year"),
            CustomTextField(controller: questionController.examNameController,hintText: "Model Test Exam"),
            CustomTextField(controller: questionController.subjectNameController,hintText: "Physics 1st Paper"),
            CustomTextField(controller: questionController.markController,hintText: "Marks: 100"),
            CustomTextField(controller: questionController.timeController,hintText: "Time: 60 min"),

          ],),
        );
      }
    );
  }
}


class QuestionPaperHeadingWidget extends StatelessWidget {
  const QuestionPaperHeadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(builder: (questionController) {
      String schoolName = questionController.schoolNameController.text.trim().isEmpty
          ? "Class Compass"
          : questionController.schoolNameController.text.trim();

      String className = questionController.classNameController.text.trim().isEmpty
          ? "HSC 1st Year"
          : questionController.classNameController.text.trim();

      String examName = questionController.examNameController.text.trim().isEmpty
          ? "Model Test Exam"
          : questionController.examNameController.text.trim();

      String subjectName = questionController.subjectNameController.text.trim().isEmpty
          ? "Physics 1st Paper"
          : questionController.subjectNameController.text.trim();

      String mark = questionController.markController.text.trim().isEmpty
          ? "Marks: 100"
          : questionController.markController.text.trim();

      String time = questionController.timeController.text.trim().isEmpty
          ? "Times: 60 min"
          : questionController.timeController.text.trim();

        return Column(children: [
          Text(schoolName, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),),
          Text(className, style: textRegular),
          Text(examName, style: textRegular,),
          Text(subjectName, style: textRegular,),
          Text(mark, style: textRegular,),
          Text(time, style: textRegular,),
        ]);
      }
    );
  }
}
