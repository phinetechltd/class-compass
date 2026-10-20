import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/presentation/widgets/create_new_question_bank_group_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/presentation/widgets/question_bank_group_list_widget.dart';

class QuestionBankGroupScreen extends StatefulWidget {
  const QuestionBankGroupScreen({super.key});

  @override
  State<QuestionBankGroupScreen> createState() => _QuestionBankGroupScreenState();
}

class _QuestionBankGroupScreenState extends State<QuestionBankGroupScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "group".tr),
        body: CustomWebScrollView(controller: scrollController, slivers:  [

          SliverToBoxAdapter(child: QuestionBankGroupListWidget(scrollController: scrollController,))
        ],),
        floatingActionButton: CustomFloatingButton(title: "add",
            onTap: () => Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: const CreateNewQuestionBankGroupWidget()))));
  }
}
