import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/presentation/widgets/create_new_question_bank_topic_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/presentation/widgets/question_bank_topic_list_widget.dart';

class QuestionBankTopicScreen extends StatefulWidget {
  const QuestionBankTopicScreen({super.key});

  @override
  State<QuestionBankTopicScreen> createState() => _QuestionBankTopicScreenState();
}

class _QuestionBankTopicScreenState extends State<QuestionBankTopicScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "topic".tr),
        body: CustomWebScrollView(controller: scrollController, slivers:  [


          SliverToBoxAdapter(child: QuestionBankTopicListWidget(scrollController: scrollController,))
        ],),
        floatingActionButton: CustomFloatingButton(title: "add",
            onTap: () => Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: const CreateNewQuestionBankTopicWidget()))));
  }
}
