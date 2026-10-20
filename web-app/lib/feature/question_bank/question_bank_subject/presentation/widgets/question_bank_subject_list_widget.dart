import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/domain/model/question_bank_subject_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/logic/question_bank_subject_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/presentation/widgets/create_new_question_bank_subject_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/presentation/widgets/question_bank_subject_item.dart';

class QuestionBankSubjectListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const QuestionBankSubjectListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankSubjectController>(
      initState: (val) => Get.find<QuestionBankSubjectController>().getQuestionBankSubject(1),
      builder: (questionBankSubjectController) {
        final questionBankSubjectModel = questionBankSubjectController.questionBankSubjectModel;
        final subjectData = questionBankSubjectModel?.data;

        return GenericListSection<QuestionBankSubjectItem>(
          sectionTitle: "question_bank".tr,
          pathItems: ["subject".tr],
          addNewTitle: "add_new_subject".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "subject".tr,
            child: const CreateNewQuestionBankSubjectWidget(),)),
          headings: const ["name", "class", "group",],
          scrollController: scrollController,
          isLoading: questionBankSubjectModel == null,
          totalSize: subjectData?.total ?? 0,
          offset: subjectData?.currentPage ?? 0,
          onPaginate: (offset) async => await questionBankSubjectController.getQuestionBankSubject(offset ?? 1),
          items: subjectData?.data ?? [],
          itemBuilder: (item, index) => QuestionBankSubjectItemWidget(index: index, item: item),
        );
      },
    );
  }
}
