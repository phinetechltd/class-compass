import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/domain/model/cash_flow_statemrnt_report_model.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/widgets/from_to_selection_widget.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/widgets/item_widget/cash_flow_statement_item_widget.dart';

class CashFlowStatementListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const CashFlowStatementListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountingReportsController>(
      builder: (accountingReportsController) {
        CashFlowStatementReportModel? cashFlowStatementModel = accountingReportsController.cashFlowStatementModel;
        return GenericListSection<Data>(
          sectionTitle: "cash_flow_statement".tr,
          showAction: false,
          topWidget:  FromToSelectionWidget(onTap: (){
            Get.find<AccountingReportsController>().getCashFlowStatement();
          }),
          headings: const ["month", "year", "total_debit", "total_credit"],
          scrollController: scrollController,
          isLoading: cashFlowStatementModel == null,
          totalSize: 0,
          offset: 1,
          onPaginate: (offset) async {},
          items: cashFlowStatementModel?.data ?? [],
          itemBuilder: (item, index) => CashFlowStatementItemWidget(item: item, index: index),
        );
      },
    );
  }
}