import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/presentation/widgets/create_new_question_bank_class_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/presentation/widgets/question_bank_class_list_widget.dart';

class QuestionBankClassScreen extends StatefulWidget {
  const QuestionBankClassScreen({super.key});

  @override
  State<QuestionBankClassScreen> createState() => _QuestionBankClassScreenState();
}

class _QuestionBankClassScreenState extends State<QuestionBankClassScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "class".tr),
        body: CustomWebScrollView(controller: scrollController, slivers:  [

          SliverToBoxAdapter(child: QuestionBankClassListWidget(scrollController: scrollController,))
        ],),
        floatingActionButton: CustomFloatingButton(title: "add",
            onTap: () => Get.dialog(
                Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: const CreateNewQuestionBankClassWidget()))));
  }
}
