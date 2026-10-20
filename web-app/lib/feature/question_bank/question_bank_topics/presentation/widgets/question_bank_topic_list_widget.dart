import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/domain/model/question_bank_topics_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/logic/question_bank_topics_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/presentation/widgets/create_new_question_bank_topic_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/presentation/widgets/question_bank_topic_item.dart';

class QuestionBankTopicListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const QuestionBankTopicListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankTopicsController>(
      initState: (val) => Get.find<QuestionBankTopicsController>().getQuestionBankTopics(1),
      builder: (questionBankTopicsController) {
        final ApiResponse<QuestionBankTopicsItem>? questionBankTopicModel = questionBankTopicsController.questionBankTopicsModel;
        final topicData = questionBankTopicModel?.data;

        return GenericListSection<QuestionBankTopicsItem>(
          sectionTitle: "question_bank".tr,
          pathItems: ["topic".tr],
          addNewTitle: "add_new_topic".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "topic".tr,
              child: const CreateNewQuestionBankTopicWidget())),
          headings: const ["name", "chapter",],
          scrollController: scrollController,
          isLoading: questionBankTopicModel == null,
          totalSize: topicData?.total ?? 0,
          offset: topicData?.currentPage ?? 0,
          onPaginate: (offset) async =>
          await questionBankTopicsController.getQuestionBankTopics(offset ?? 1),
          items: topicData?.data ?? [],
          itemBuilder: (item, index) => QuestionBankTopicItemWidget(index: index, item: item),
        );
      },
    );
  }
}
