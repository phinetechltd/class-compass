import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/presentation/widgets/create_new_question_bank_board_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/presentation/widgets/question_bank_board_list_widget.dart';


class QuestionBankBoardScreen extends StatefulWidget {
  const QuestionBankBoardScreen({super.key});

  @override
  State<QuestionBankBoardScreen> createState() => _QuestionBankBoardScreenState();
}

class _QuestionBankBoardScreenState extends State<QuestionBankBoardScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "board".tr),
        body: CustomWebScrollView(controller: scrollController, slivers:  [

          SliverToBoxAdapter(child: QuestionBankBoardListWidget(scrollController: scrollController,))
        ],),
        floatingActionButton:  CustomFloatingButton(title: "add",
            onTap: () => Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: const CreateNewQuestionBankBoardWidget()))));
  }
}
