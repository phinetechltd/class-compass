import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/widgets/income_statement_list_widget.dart';

class IncomeStatementScreen extends StatefulWidget {
  const IncomeStatementScreen({super.key});

  @override
  State<IncomeStatementScreen> createState() => _IncomeStatementScreenState();
}

class _IncomeStatementScreenState extends State<IncomeStatementScreen> {
  @override
  void initState() {
    super.initState();

    if (Get.find<AccountingReportsController>().incomeStatementModel == null) {
      Get.find<AccountingReportsController>().getIncomeStatement();
    }
  }
  ScrollController scrollController = ScrollController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "income_statement".tr),
      body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(
            child: IncomeStatementListWidget(scrollController: scrollController),
          ),
        ],
      ),
    );
  }
}
