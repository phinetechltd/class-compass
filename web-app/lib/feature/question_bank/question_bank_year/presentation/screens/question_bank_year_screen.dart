import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/question_bank/question_bank_year/presentation/widgets/create_new_question_bank_year_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_year/presentation/widgets/question_bank_year_list_widget.dart';

class QuestionBankYearScreen extends StatefulWidget {
  const QuestionBankYearScreen({super.key});

  @override
  State<QuestionBankYearScreen> createState() => _QuestionBankYearScreenState();
}

class _QuestionBankYearScreenState extends State<QuestionBankYearScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "year".tr),
        body: CustomWebScrollView(controller: scrollController, slivers:  [

          SliverToBoxAdapter(child: QuestionBankYearListWidget(scrollController: scrollController,))
        ],),
        floatingActionButton: CustomFloatingButton(title: "add",
            onTap: () => Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: const CreateNewQuestionBankYearWidget()))));
  }
}
