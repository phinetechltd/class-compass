
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/question_bank/question_category/presentation/widgets/create_new_question_category_widget.dart';
import 'package:class_compass/feature/question_bank/question_category/presentation/widgets/question_category_list_widget.dart';

class QuestionCategoryScreen extends StatefulWidget {
  const QuestionCategoryScreen({super.key});

  @override
  State<QuestionCategoryScreen> createState() => _QuestionCategoryScreenState();
}

class _QuestionCategoryScreenState extends State<QuestionCategoryScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "question_category".tr),
        body: CustomWebScrollView(controller: scrollController, slivers: [
          SliverToBoxAdapter(child: QuestionCategoryListWidget(scrollController: scrollController),)
        ],),


        floatingActionButton: CustomFloatingButton(title: "add",
            onTap: ()=> Get.to(()=> const CreateNewQuestionCategoryWidget()))
    );
  }
}



