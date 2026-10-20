import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_tag/domain/model/question_bank_tag_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_tag/logic/question_bank_tag_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_tag/presentation/widgets/create_new_question_bank_tag_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_tag/presentation/widgets/question_bank_tag_item.dart';

class QuestionBankTagListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const QuestionBankTagListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankTagController>(
      initState: (val) =>
          Get.find<QuestionBankTagController>().getQuestionBankTag(1),
      builder: (controller) {
        final ApiResponse<QuestionBankTagItem>? model = controller.questionBankTagModel;
        final data = model?.data;
        return GenericListSection<QuestionBankTagItem>(
          sectionTitle: "question_bank".tr,
          pathItems: ["tag".tr],
          addNewTitle: "add_new_tag".tr,
          onAddNewTap: () => Get.dialog(
            CustomDialogWidget(title: "tag".tr,
              child: const CreateNewQuestionBankTagWidget())),
          headings: const ["name", ],
          scrollController: scrollController,
          isLoading: model == null,
          totalSize: data?.total ?? 0,
          offset: data?.currentPage ?? 0,
          onPaginate: (offset) async =>
          await controller.getQuestionBankTag(offset ?? 1),
          items: data?.data ?? [],
          itemBuilder: (item, index) => QuestionBankTagItemWidget(index: index, item: item),
        );
      },
    );
  }
}
