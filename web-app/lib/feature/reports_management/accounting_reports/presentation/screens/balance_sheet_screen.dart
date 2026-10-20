import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/widgets/balance_sheet_list_widget.dart';

class BalanceSheetScreen extends StatefulWidget {
  const BalanceSheetScreen({super.key});

  @override
  State<BalanceSheetScreen> createState() => _BalanceSheetScreenState();
}

class _BalanceSheetScreenState extends State<BalanceSheetScreen> {
  @override
  void initState() {
    super.initState();

    if (Get.find<AccountingReportsController>().balanceSheetModel == null) {
      Get.find<AccountingReportsController>().getBalanceSheet();
    }
  }
  ScrollController scrollController = ScrollController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "balance_sheet".tr),
      body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(
            child: BalanceSheetListWidget(scrollController: scrollController),
          ),
        ],
      ),
    );
  }
}