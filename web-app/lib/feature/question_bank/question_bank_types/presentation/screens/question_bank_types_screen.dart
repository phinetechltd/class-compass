import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/presentation/widgets/create_new_question_bank_class_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/presentation/widgets/question_bank_types_list_widget.dart';

class QuestionBankTypeScreen extends StatefulWidget {
  const QuestionBankTypeScreen({super.key});

  @override
  State<QuestionBankTypeScreen> createState() => _QuestionBankTypeScreenState();
}

class _QuestionBankTypeScreenState extends State<QuestionBankTypeScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "types".tr),
        body: CustomWebScrollView(controller: scrollController, slivers:  [


          SliverToBoxAdapter(child: QuestionBankTypeListWidget(scrollController: scrollController,))
        ],),
        floatingActionButton: CustomFloatingButton(title: "add",
            onTap: () => Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: const CreateNewQuestionBankClassWidget()))));
  }
}
