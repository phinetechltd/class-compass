import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/question_bank/question_category/domain/model/question_category_model.dart';
import 'package:class_compass/feature/question_bank/question_category/logic/question_category_controller.dart';
import 'package:class_compass/feature/question_bank/question_category/presentation/widgets/question_category_item_widget.dart';
import 'package:class_compass/feature/question_bank/question_category/presentation/widgets/create_new_question_category_widget.dart';

class QuestionCategoryListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const QuestionCategoryListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionCategoryController>(
      initState: (val) => Get.find<QuestionCategoryController>().getQuestionCategory(1),
      builder: (questionCategoryController) {
        final questionCategoryModel = questionCategoryController.questionCategoryModel;
        final categoryData = questionCategoryModel?.data;
        return GenericListSection<QuestionCategoryItem>(
          sectionTitle: "question_bank".tr,
          pathItems: ["category".tr],
          addNewTitle: "question_category".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "category".tr,
              child: const CreateNewQuestionCategoryWidget())),
          headings: const ["category", ],
          scrollController: scrollController,
          isLoading: questionCategoryModel == null,
          totalSize: categoryData?.total ?? 0,
          offset: categoryData?.currentPage ?? 0,
          onPaginate: (offset) async =>
          await questionCategoryController.getQuestionCategory(offset ?? 1),
          items: categoryData?.data ?? [],
          itemBuilder: (item, index) => QuestionCategoryItemWidget(index: index, questionCategoryItem: item),
        );
      },
    );
  }
}
