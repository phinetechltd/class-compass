import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/presentation/widgets/create_new_question_bank_sub_source_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/presentation/widgets/question_bank_sub_source_list_widget.dart';

class QuestionBankSubSourceScreen extends StatefulWidget {
  const QuestionBankSubSourceScreen({super.key});

  @override
  State<QuestionBankSubSourceScreen> createState() => _QuestionBankSubSourceScreenState();
}

class _QuestionBankSubSourceScreenState extends State<QuestionBankSubSourceScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "sub_source".tr),
        body: CustomWebScrollView(controller: scrollController, slivers:  [

          SliverToBoxAdapter(child: QuestionBankSubSourceListWidget(scrollController: scrollController,))
        ],),
        floatingActionButton: CustomFloatingButton(title: "add",
            onTap: () => Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: const CreateNewQuestionBankSubSourceWidget()))));
  }
}
