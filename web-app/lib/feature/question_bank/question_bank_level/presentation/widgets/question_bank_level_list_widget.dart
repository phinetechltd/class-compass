import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/domain/model/question_bank_level_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/logic/question_bank_level_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/presentation/widgets/create_new_question_bank_level_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/presentation/widgets/question_bank_level_item.dart';

class QuestionBankLevelListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const QuestionBankLevelListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankLevelController>(
      initState: (val) => Get.find<QuestionBankLevelController>().getQuestionBankLevel(1),
      builder: (questionBankLevelController) {
        final questionBankLevelModel = questionBankLevelController.questionBankLevelModel;
        final levelData = questionBankLevelModel?.data;

        return GenericListSection<QuestionBankLevelItem>(
          sectionTitle: "question_bank".tr,
          pathItems: ["level".tr],
          addNewTitle: "add_new_level".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "level".tr,
            child: const CreateNewQuestionBankLevelWidget())),
          headings: const ["name", ],
          scrollController: scrollController,
          isLoading: questionBankLevelModel == null,
          totalSize: levelData?.total ?? 0,
          offset: levelData?.currentPage ?? 0,
          onPaginate: (offset) async => await questionBankLevelController.getQuestionBankLevel(offset ?? 1),
          items: levelData?.data ?? [],
          itemBuilder: (item, index) => QuestionBankLevelItemWidget(index: index, item: item),
        );
      },
    );
  }
}
