import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/presentation/widgets/create_new_question_bank_level_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/presentation/widgets/question_bank_level_list_widget.dart';

class QuestionBankLevelScreen extends StatefulWidget {
  const QuestionBankLevelScreen({super.key});

  @override
  State<QuestionBankLevelScreen> createState() => _QuestionBankLevelScreenState();
}

class _QuestionBankLevelScreenState extends State<QuestionBankLevelScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "level".tr),
        body: CustomWebScrollView(controller: scrollController, slivers:  [

          SliverToBoxAdapter(child: QuestionBankLevelListWidget(scrollController: scrollController,))
        ],),
        floatingActionButton: CustomFloatingButton(title: "add",
            onTap: () => Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: const CreateNewQuestionBankLevelWidget()))));
  }
}
