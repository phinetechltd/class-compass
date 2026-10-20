import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/domain/model/question_bank_sources_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/logic/question_bank_sources_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/presentation/widgets/create_new_question_bank_source_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/presentation/widgets/question_bank_source_item.dart';

class QuestionBankSourceListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const QuestionBankSourceListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankSourcesController>(
      initState: (val) => Get.find<QuestionBankSourcesController>().getQuestionBankSources(1),
      builder: (questionBankSourcesController) {
        final questionBankSourceModel = questionBankSourcesController.questionBankSourcesModel;
        final sourceData = questionBankSourceModel?.data;

        return GenericListSection<QuestionBankSourcesItem>(
          sectionTitle: "question_bank".tr,
          pathItems: ["sources".tr],
          addNewTitle: "add_new_source".tr,
          onAddNewTap: () => Get.dialog(
            CustomDialogWidget(title: "source".tr,
              child: const CreateNewQuestionBankSourceWidget())),
          headings: const ["name",],
          scrollController: scrollController,
          isLoading: questionBankSourceModel == null,
          totalSize: sourceData?.total ?? 0,
          offset: sourceData?.currentPage ?? 0,
          onPaginate: (offset) async => await questionBankSourcesController.getQuestionBankSources(offset ?? 1),
          items: sourceData?.data ?? [],
          itemBuilder: (item, index) => QuestionBankSourceItemWidget(index: index, item: item));
      },
    );
  }
}
