import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/question_bank/question/presentation/widgets/create_new_question_widget.dart';
import 'package:class_compass/util/dimensions.dart';


class CreateNewQuestionCategoryScreen extends StatefulWidget {

  const CreateNewQuestionCategoryScreen({super.key});

  @override
  State<CreateNewQuestionCategoryScreen> createState() => _CreateNewQuestionCategoryScreenState();
}

class _CreateNewQuestionCategoryScreenState extends State<CreateNewQuestionCategoryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "add_new_question_category".tr),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: CreateNewQuestionWidget(),
        ),)
      ],),
    );
  }
}
