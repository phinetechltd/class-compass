
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/domain/model/balance_sheet_report_model.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/widgets/from_to_selection_widget.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/widgets/item_widget/balance_sheet_item_widget.dart';

class BalanceSheetListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const BalanceSheetListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountingReportsController>(builder: (accountingReportsController) {
        BalanceSheetReportModel? balanceSheetModel = accountingReportsController.balanceSheetModel;
        return GenericListSection<BalanceSheetItem>(
          topWidget: FromToSelectionWidget(onTap: (){
            Get.find<AccountingReportsController>().getBalanceSheet();
          }),
          showAction: false,
          sectionTitle: "balance_sheet".tr,
          headings: const ["ledger", "debit", "credit"],
          scrollController: scrollController,
          isLoading: balanceSheetModel == null,
          totalSize:  0,
          offset: 1,
          onPaginate: (offset) async {},
          items: balanceSheetModel?.data ?? [],
          itemBuilder: (item, index) => BalanceSheetItemWidget(item: item, index: index),
        );
      },
    );
  }
}