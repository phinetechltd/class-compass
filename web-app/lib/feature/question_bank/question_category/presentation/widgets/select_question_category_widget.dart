import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_category/logic/question_category_controller.dart';
import 'package:class_compass/feature/question_bank/question_category/presentation/widgets/question_category_dropdown.dart';


class SelectQuestionCategoryWidget extends StatefulWidget {
  const SelectQuestionCategoryWidget({super.key});

  @override
  State<SelectQuestionCategoryWidget> createState() => _SelectQuestionCategoryWidgetState();
}

class _SelectQuestionCategoryWidgetState extends State<SelectQuestionCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "question_category"),
      GetBuilder<QuestionCategoryController>(
        initState: (val){
          if(Get.find<QuestionCategoryController>().questionCategoryModel == null){
            Get.find<QuestionCategoryController>().getQuestionCategory(1);
          }
        },
          builder: (questionCategoryController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: QuestionCategoryDropdown(width: Get.width, title: "select".tr,
                items: questionCategoryController.questionCategoryModel?.data?.data??[],
                selectedValue:  questionCategoryController.selectedQuestionCategoryItem,
                onChanged: (val){
                questionCategoryController.setSelectQuestionCategoryItem(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
