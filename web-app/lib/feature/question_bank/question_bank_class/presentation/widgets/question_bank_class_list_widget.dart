import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/domain/model/question_bank_class_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/logic/question_bank_class_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/presentation/widgets/create_new_question_bank_class_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/presentation/widgets/question_bank_class_item.dart';

class QuestionBankClassListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const QuestionBankClassListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankClassController>(
      initState: (val) => Get.find<QuestionBankClassController>().getQuestionBankClass(1),
      builder: (questionBankClassController) {
        final questionBankClassModel = questionBankClassController.questionBankClassModel;
        final classData = questionBankClassModel?.data;

        return GenericListSection<QuestionBankClassItem>(
          sectionTitle: "question_bank".tr,
          pathItems: ["class".tr],
          addNewTitle: "add_new_class".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "class".tr,
              child: const CreateNewQuestionBankClassWidget())),
          headings: const ["name"],
          scrollController: scrollController,
          isLoading: questionBankClassModel == null,
          totalSize: classData?.total ?? 0,
          offset: classData?.currentPage ?? 0,
          onPaginate: (offset) async =>
          await questionBankClassController.getQuestionBankClass(offset ?? 1),
          items: classData?.data ?? [],
          itemBuilder: (item, index) => QuestionBankClassItemWidget(index: index, classItem: item),

        );
      },
    );
  }
}
