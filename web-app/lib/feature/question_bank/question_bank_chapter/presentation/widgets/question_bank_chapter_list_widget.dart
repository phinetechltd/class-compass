import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/domain/model/question_bank_chapter_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/logic/question_bank_chapter_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/presentation/widgets/create_new_question_bank_chapter_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/presentation/widgets/question_bank_chapter_item.dart';

class QuestionBankChapterListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const QuestionBankChapterListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankChapterController>(
      initState: (val) => Get.find<QuestionBankChapterController>().getQuestionBankChapter(1),
      builder: (questionBankChapterController) {
        final questionBankChapterModel = questionBankChapterController.questionBankChapterModel;
        final chapterData = questionBankChapterModel?.data;

        return GenericListSection<QuestionBankChapterItem>(
          sectionTitle: "question_bank".tr,
          pathItems: ["chapter".tr],
          addNewTitle: "add_new_chapter".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "chapter".tr,
            child: const CreateNewQuestionBankChapterWidget(),)),
          headings: const ["name", "subject",],
          scrollController: scrollController,
          isLoading: questionBankChapterModel == null,
          totalSize: chapterData?.total ?? 0,
          offset: chapterData?.currentPage ?? 0,
          onPaginate: (offset) async =>
          await questionBankChapterController.getQuestionBankChapter(offset ?? 1),
          items: chapterData?.data ?? [],
          itemBuilder: (item, index) => QuestionBankChapterItemWidget(index: index, item: item),
        );
      },
    );
  }
}
