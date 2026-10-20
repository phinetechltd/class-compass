import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/reports_management/fees_reports/logic/fees_reports_controller.dart';
import 'package:class_compass/feature/reports_management/fees_reports/presentation/widgets/fees_payment_info_report_list_widget.dart';

class FeesPaymentInfoScreen extends StatefulWidget {
  const FeesPaymentInfoScreen({super.key});

  @override
  State<FeesPaymentInfoScreen> createState() => _FeesPaymentInfoScreenState();
}

class _FeesPaymentInfoScreenState extends State<FeesPaymentInfoScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<FeesReportsController>().getPaymentFeesInfo();
  }
  ScrollController scrollController = ScrollController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "payment_fees_info".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(
          child: FeesPaymentInfoReportListWidget(scrollController: scrollController),
        ),
      ],
      ),
    );
  }
}
