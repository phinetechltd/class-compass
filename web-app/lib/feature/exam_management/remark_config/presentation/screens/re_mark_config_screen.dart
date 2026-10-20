
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/exam_management/remark_config/presentation/widgets/remark_config_list_widget.dart';

class ReMarkConfigScreen extends StatefulWidget {
  const ReMarkConfigScreen({super.key});

  @override
  State<ReMarkConfigScreen> createState() => _ReMarkConfigScreenState();
}

class _ReMarkConfigScreenState extends State<ReMarkConfigScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "remark_config".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: ReMarkConfigListWidget(scrollController: scrollController),)
      ],),

    );
  }
}



