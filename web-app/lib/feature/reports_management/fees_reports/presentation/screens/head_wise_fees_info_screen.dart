import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/reports_management/fees_reports/logic/fees_reports_controller.dart';
import 'package:class_compass/feature/reports_management/fees_reports/presentation/widgets/head_wise_fees_info_list_widget.dart';

class HeadWiseFeesInfoScreen extends StatefulWidget {
  const HeadWiseFeesInfoScreen({super.key});

  @override
  State<HeadWiseFeesInfoScreen> createState() => _HeadWiseFeesInfoScreenState();
}

class _HeadWiseFeesInfoScreenState extends State<HeadWiseFeesInfoScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<FeesReportsController>().getHeadWisePayment();
  }
  ScrollController scrollController = ScrollController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "head_wise_fees_info".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(
          child: HeadWiseFeesInfoListWidget(scrollController: scrollController),
        ),
      ],
      ),
    );
  }
}
