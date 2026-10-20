import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/fees_management/paid_info/presentation/widgets/paid_info_list_widget.dart';

class PaidReportScreen extends StatefulWidget {
  const PaidReportScreen({super.key});

  @override
  State<PaidReportScreen> createState() => _PaidReportScreenState();
}

class _PaidReportScreenState extends State<PaidReportScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "payment_fee_info".tr),
    body: CustomWebScrollView(controller: scrollController, slivers:  [
      SliverToBoxAdapter(child: PaidReportListWidget(scrollController: scrollController,))
    ],));
  }
}
