import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/domain/model/ledger_wise_report_model.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/widgets/from_to_selection_widget.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/widgets/item_widget/ledger_wise_item_widget.dart';

class LedgerWiseTransactionListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const LedgerWiseTransactionListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountingReportsController>(
      builder: (accountingReportsController) {
        LedgerWiseReportModel? ledgerWiseModel = accountingReportsController.ledgerWiseModel;
        return GenericListSection<Data>(
          topWidget: FromToSelectionWidget(onTap: (){
            Get.find<AccountingReportsController>().getLedgerWise();
          }),
          sectionTitle: "ledger_wise_report".tr,
          showAction: false,
          headings: const ["date", "reference", "ledger", "debit", "credit"],
          scrollController: scrollController,
          isLoading: ledgerWiseModel == null,
          totalSize: 0,
          offset: 1,
          onPaginate: (offset) async {},
          items: ledgerWiseModel?.data ?? [],
          itemBuilder: (item, index) => LedgerWiseItemWidget(item: item, index: index),
        );
      },
    );
  }
}