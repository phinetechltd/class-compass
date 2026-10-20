import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/presentation/widgets/create_new_question_bank_subject_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/presentation/widgets/question_bank_subject_list_widget.dart';

class QuestionBankSubjectScreen extends StatefulWidget {
  const QuestionBankSubjectScreen({super.key});

  @override
  State<QuestionBankSubjectScreen> createState() => _QuestionBankSubjectScreenState();
}

class _QuestionBankSubjectScreenState extends State<QuestionBankSubjectScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "subject".tr),
        body: CustomWebScrollView(controller: scrollController, slivers:  [

          SliverToBoxAdapter(child: QuestionBankSubjectListWidget(scrollController: scrollController,))
        ],),
        floatingActionButton: CustomFloatingButton(title: "add",
            onTap: () => Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: const CreateNewQuestionBankSubjectWidget()))));
  }
}
