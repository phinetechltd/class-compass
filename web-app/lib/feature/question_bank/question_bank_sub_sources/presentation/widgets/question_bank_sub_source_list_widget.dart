import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/domain/model/question_bank_sub_sources_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/logic/question_bank_sub_sources_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/presentation/widgets/create_new_question_bank_sub_source_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/presentation/widgets/question_bank_sub_source_item.dart';

class QuestionBankSubSourceListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const QuestionBankSubSourceListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankSubSourcesController>(
      initState: (val) => Get.find<QuestionBankSubSourcesController>().getQuestionBankSubSources(1),
      builder: (controller) {
        final QuestionBankSubSourceModel? model = controller.questionBankSubSourceModel;
        final data = model?.data;

        return GenericListSection<QuestionBankSubSourceItem>(
          sectionTitle: "question_bank".tr,
          pathItems: ["sub_sources".tr],
          addNewTitle: "add_new_sub_source".tr,
          onAddNewTap: () => Get.dialog(
            CustomDialogWidget(title: "sub_source".tr,
              child: const CreateNewQuestionBankSubSourceWidget())),
          headings: const ["name", "source", ],
          scrollController: scrollController,
          isLoading: model == null,
          totalSize: data?.total ?? 0,
          offset: data?.currentPage ?? 0,
          onPaginate: (offset) async => await controller.getQuestionBankSubSources(offset ?? 1),
          items: data?.data ?? [],
          itemBuilder: (item, index) => QuestionBankSubSourceItemWidget(index: index, item: item),
        );
      },
    );
  }
}
