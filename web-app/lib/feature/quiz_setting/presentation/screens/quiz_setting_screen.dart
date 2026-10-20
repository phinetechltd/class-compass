import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/quiz_setting/presentation/widgets/quiz_setting_widget.dart';

class QuizSettingScreen extends StatefulWidget {
  const QuizSettingScreen({super.key});

  @override
  State<QuizSettingScreen> createState() => _QuizSettingScreenState();
}

class _QuizSettingScreenState extends State<QuizSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "quiz_setting".tr),
        body: const CustomWebScrollView( slivers: [

          SliverToBoxAdapter(child: QuizSettingWidget(),)
        ],),
    );
  }
}
