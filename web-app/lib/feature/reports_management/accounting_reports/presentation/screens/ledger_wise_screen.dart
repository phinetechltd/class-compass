import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/widgets/ledger_wise_transaction_list_widget.dart';

class LedgerWiseScreen extends StatefulWidget {
  const LedgerWiseScreen({super.key});

  @override
  State<LedgerWiseScreen> createState() => _LedgerWiseScreenState();
}

class _LedgerWiseScreenState extends State<LedgerWiseScreen> {
  @override
  void initState() {
    super.initState();

    if (Get.find<AccountingReportsController>().ledgerWiseModel == null) {
      Get.find<AccountingReportsController>().getLedgerWise();
    }
  }
  ScrollController scrollController = ScrollController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "ledger_wise_report".tr),
      body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(
            child: LedgerWiseTransactionListWidget(scrollController: scrollController),
          ),
        ],
      ),
    );
  }
}
