import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/reports_management/fees_reports/logic/fees_reports_controller.dart';
import 'package:class_compass/feature/reports_management/fees_reports/presentation/widgets/fees_monthly_report_list_widget.dart';

class FeesMonthlyReportScreen extends StatefulWidget {
  const FeesMonthlyReportScreen({super.key});

  @override
  State<FeesMonthlyReportScreen> createState() => _FeesMonthlyReportScreenState();
}

class _FeesMonthlyReportScreenState extends State<FeesMonthlyReportScreen> {
  @override
  void initState() {
    super.initState();

    if (Get.find<FeesReportsController>().feesMonthlyReportModel == null) {
      Get.find<FeesReportsController>().getMonthlyReport();
    }
  }
  ScrollController scrollController = ScrollController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "monthly_fees_report".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(
          child: MonthlyFeesReportListWidget(scrollController: scrollController),
        ),
      ],
      ),
    );
  }
}
