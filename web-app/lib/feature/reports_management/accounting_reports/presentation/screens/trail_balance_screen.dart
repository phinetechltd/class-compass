import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/widgets/trail_balance_list_widget.dart';

class TrailBalanceScreen extends StatefulWidget {
  const TrailBalanceScreen({super.key});

  @override
  State<TrailBalanceScreen> createState() => _TrailBalanceScreenState();
}

class _TrailBalanceScreenState extends State<TrailBalanceScreen> {
  @override
  void initState() {
    super.initState();

    if (Get.find<AccountingReportsController>().trialBalanceModel == null) {
      Get.find<AccountingReportsController>().getTrialBalance();
    }
  }
  ScrollController scrollController = ScrollController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "trial_balance".tr),
      body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(
            child: TrailBalanceListWidget(scrollController: scrollController),
          ),
        ],
      ),
    );
  }
}