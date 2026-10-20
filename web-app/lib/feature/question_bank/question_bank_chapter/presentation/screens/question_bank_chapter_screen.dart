import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/presentation/widgets/create_new_question_bank_chapter_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/presentation/widgets/question_bank_chapter_list_widget.dart';


class QuestionBankChapterScreen extends StatefulWidget {
  const QuestionBankChapterScreen({super.key});

  @override
  State<QuestionBankChapterScreen> createState() => _QuestionBankChapterScreenState();
}

class _QuestionBankChapterScreenState extends State<QuestionBankChapterScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "chapter".tr),
        body: CustomWebScrollView(controller: scrollController, slivers:  [
          SliverToBoxAdapter(child: QuestionBankChapterListWidget(scrollController: scrollController,))
        ],),
        floatingActionButton: CustomFloatingButton(title: "add",
            onTap: () => Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: const CreateNewQuestionBankChapterWidget()))));
  }
}
