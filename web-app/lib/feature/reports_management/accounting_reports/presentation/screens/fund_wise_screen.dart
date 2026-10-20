import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/widgets/fund_wise_transaction_list_widget.dart';

class FundWiseScreen extends StatefulWidget {
  const FundWiseScreen({super.key});

  @override
  State<FundWiseScreen> createState() => _FundWiseScreenState();
}

class _FundWiseScreenState extends State<FundWiseScreen> {
  @override
  void initState() {
    super.initState();

    if (Get.find<AccountingReportsController>().fundWiseModel == null) {
      Get.find<AccountingReportsController>().getFundWise();
    }
  }
  ScrollController scrollController = ScrollController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "fund_wise_report".tr),
      body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(
            child: FundWiseTransactionListWidget(scrollController: scrollController),
          ),
        ],
      ),
    );
  }
}
