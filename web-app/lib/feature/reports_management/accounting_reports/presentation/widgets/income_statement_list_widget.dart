import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/domain/model/income_statement_reports_model.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/widgets/from_to_selection_widget.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/widgets/item_widget/income_statement_item_widget.dart';

class IncomeStatementListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const IncomeStatementListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountingReportsController>(
      builder: (accountingReportsController) {
        IncomeStatementReportModel? incomeStatementModel = accountingReportsController.incomeStatementModel;
        List<Ledgers> allLedgers = [];
        if (incomeStatementModel?.data?.income != null) {
          allLedgers.addAll(incomeStatementModel!.data!.income!);
        }
        if (incomeStatementModel?.data?.expense != null) {
          allLedgers.addAll(incomeStatementModel!.data!.expense!);
        }

        return GenericListSection<Ledgers>(
          showAction: false,
          topWidget: FromToSelectionWidget(onTap: (){
            Get.find<AccountingReportsController>().getIncomeStatement();
          }),
          sectionTitle: "income_statement".tr,
          headings: const ["ledger", "debit", "credit"],
          scrollController: scrollController,
          isLoading: incomeStatementModel == null,
          totalSize: 0,
          offset: 1,
          onPaginate: (offset) async {},
          items: allLedgers,
          itemBuilder: (item, index) => IncomeStatementItemWidget(item: item, index: index),
        );
      },
    );
  }
}