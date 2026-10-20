import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/domain/model/question_bank_types_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/logic/question_bank_types_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/presentation/widgets/create_new_question_bank_types_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/presentation/widgets/question_bank_types_item.dart';

class QuestionBankTypeListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const QuestionBankTypeListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankTypesController>(
      initState: (val) => Get.find<QuestionBankTypesController>().getQuestionBankTypes(1),
      builder: (questionBankTypesController) {
        final questionBankTypesModel = questionBankTypesController.questionBankTypesModel;
        final typesData = questionBankTypesModel?.data;
        return GenericListSection<QuestionBankTypesItem>(
          sectionTitle: "question_bank".tr,
          pathItems: ["types".tr],
          addNewTitle: "add_new_type".tr,
          onAddNewTap: () => Get.dialog( CustomDialogWidget(title: "type".tr,
            child: const CreateNewQuestionBankTypesWidget())),
          headings: const ["name", ],
          scrollController: scrollController,
          isLoading: questionBankTypesModel == null,
          totalSize: typesData?.total ?? 0,
          offset: typesData?.currentPage ?? 0,
          onPaginate: (offset) async => await questionBankTypesController.getQuestionBankTypes(offset ?? 1),
          items: typesData?.data ?? [],
          itemBuilder: (item, index) => QuestionBankTypesItemWidget(index: index, item: item),
        );
      },
    );
  }
}
