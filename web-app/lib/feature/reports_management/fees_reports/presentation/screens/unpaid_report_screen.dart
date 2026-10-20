import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/reports_management/fees_reports/presentation/widgets/un_paid_report_list_widget.dart';

class UnPaidReportScreen extends StatefulWidget {
  const UnPaidReportScreen({super.key});

  @override
  State<UnPaidReportScreen> createState() => _UnPaidReportScreenState();
}

class _UnPaidReportScreenState extends State<UnPaidReportScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "unpaid_info".tr),
        body: CustomWebScrollView(controller: scrollController, slivers:  [
          SliverToBoxAdapter(child: UnPaidReportListWidget(scrollController: scrollController,))
        ],));
  }
}
