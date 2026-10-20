import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/domain/model/question_bank_board_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/logic/question_bank_board_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/presentation/widgets/create_new_question_bank_board_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/presentation/widgets/question_bank_board_item.dart';

class QuestionBankBoardListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const QuestionBankBoardListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankBoardController>(
      initState: (val) => Get.find<QuestionBankBoardController>().getQuestionBankBoard(1),
      builder: (controller) {
        final ApiResponse<QuestionBankBoardItem>? model = controller.questionBankBoardModel;
        final data = model?.data;
        return GenericListSection<QuestionBankBoardItem>(
          sectionTitle: "question_bank".tr,
          pathItems: ["board".tr],
          addNewTitle: "add_new_board".tr,
          onAddNewTap: () => Get.dialog(
            CustomDialogWidget(title: "board".tr,
              child: const CreateNewQuestionBankBoardWidget())),
          headings: const ["name", "short_name",],
          scrollController: scrollController,
          isLoading: model == null,
          totalSize: data?.total ?? 0,
          offset: data?.currentPage ?? 0,
          onPaginate: (offset) async =>
          await controller.getQuestionBankBoard(offset ?? 1),
          items: data?.data ?? [],
          itemBuilder: (item, index) => QuestionBankBoardItemWidget(index: index, item: item),
        );
      },
    );
  }
}
