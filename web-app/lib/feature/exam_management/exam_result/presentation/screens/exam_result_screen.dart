import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/exam_management/exam_result/presentation/widgets/exam_result_widget.dart';
import 'package:class_compass/feature/exam_management/marksheet/controller/markaheet_controller.dart';

class ExamResultScreen extends StatefulWidget {
  const ExamResultScreen({super.key});

  @override
  State<ExamResultScreen> createState() => _ExamResultScreenState();
}

class _ExamResultScreenState extends State<ExamResultScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Get.find<MarkSheetController>().getMarkSheetConfigList(1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "exam_result".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: ExamResultWidget(scrollController: scrollController,))
      ],),
    );
  }
}
