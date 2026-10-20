import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_year/domain/model/question_bank_year_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_year/logic/question_bank_year_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_year/presentation/widgets/create_new_question_bank_year_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_year/presentation/widgets/question_bank_year_item.dart';

class QuestionBankYearListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const QuestionBankYearListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankYearController>(
      initState: (val) => Get.find<QuestionBankYearController>().getQuestionBankYear(1),
      builder: (controller) {
        final ApiResponse<QuestionBankYearItem>? model = controller.questionBankYearModel;
        final data = model?.data;
        return GenericListSection<QuestionBankYearItem>(
          sectionTitle: "question_bank".tr,
          pathItems: ["year".tr],
          addNewTitle: "add_new_year".tr,
          onAddNewTap: () => Get.dialog(
            CustomDialogWidget(title: "year".tr,
              child: const CreateNewQuestionBankYearWidget())),
          headings: const ["name", ],
          scrollController: scrollController,
          isLoading: model == null,
          totalSize: data?.total ?? 0,
          offset: data?.currentPage ?? 0,
          onPaginate: (offset) async =>
          await controller.getQuestionBankYear(offset ?? 1),
          items: data?.data ?? [],
          itemBuilder: (item, index) => QuestionBankYearItemWidget(index: index, item: item),
        );
      },
    );
  }
}
