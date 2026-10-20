import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/domain/model/question_bank_group_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/logic/question_bank_group_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/presentation/widgets/create_new_question_bank_group_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/presentation/widgets/question_bank_group_item_widget.dart';

class QuestionBankGroupListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const QuestionBankGroupListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankGroupController>(
      initState: (val) => Get.find<QuestionBankGroupController>().getQuestionBankGroup(1),
      builder: (questionBankGroupController) {
        final questionBankGroupModel = questionBankGroupController.questionBankGroupModel;
        final groupData = questionBankGroupModel?.data;
        return GenericListSection<QuestionBankGroupItem>(
          sectionTitle: "question_bank".tr,
          pathItems: ["group".tr],
          addNewTitle: "add_new_group".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "group".tr,
              child: const CreateNewQuestionBankGroupWidget())),
          headings: const ["name", ],

          scrollController: scrollController,
          isLoading: questionBankGroupModel == null,
          totalSize: groupData?.total ?? 0,
          offset: groupData?.currentPage ?? 0,
          onPaginate: (offset) async => await questionBankGroupController.getQuestionBankGroup(offset ?? 1),
          items: groupData?.data ?? [],
          itemBuilder: (item, index) => QuestionBankGroupItemWidget(index: index, item: item),
        );
      },
    );
  }
}
