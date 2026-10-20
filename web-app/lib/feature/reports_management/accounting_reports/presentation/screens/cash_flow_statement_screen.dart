import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/widgets/cash_flow_statement_list_widget.dart';

class CashFlowStatementScreen extends StatefulWidget {
  const CashFlowStatementScreen({super.key});

  @override
  State<CashFlowStatementScreen> createState() => _CashFlowStatementScreenState();
}

class _CashFlowStatementScreenState extends State<CashFlowStatementScreen> {
  @override
  void initState() {
    super.initState();

    if (Get.find<AccountingReportsController>().cashFlowStatementModel == null) {
      Get.find<AccountingReportsController>().getCashFlowStatement();
    }
  }
  ScrollController scrollController = ScrollController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "cash_flow_statement".tr),
      body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(
            child: CashFlowStatementListWidget(scrollController: scrollController),
          ),
        ],
      ),
    );
  }
}
