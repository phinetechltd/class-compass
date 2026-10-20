import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/question_bank/question_bank_tag/presentation/widgets/question_bank_tag_list_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_year/presentation/widgets/create_new_question_bank_year_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';

class QuestionBankTagScreen extends StatefulWidget {
  const QuestionBankTagScreen({super.key});

  @override
  State<QuestionBankTagScreen> createState() => _QuestionBankTagScreenState();
}

class _QuestionBankTagScreenState extends State<QuestionBankTagScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: ResponsiveHelper.isDesktop(context)? null : CustomAppBar(title: "tag".tr),
        body: CustomWebScrollView(controller: scrollController, slivers:  [

          SliverToBoxAdapter(child: QuestionBankTagListWidget(scrollController: scrollController,))
        ],),
        floatingActionButton: CustomFloatingButton(title: "add",
            onTap: () => Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: const CreateNewQuestionBankYearWidget()))));
  }
}
