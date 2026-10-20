import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/domain/model/cash_flow_statemrnt_report_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class CashFlowStatementItemWidget extends StatelessWidget {
  final Data item;
  final int index;
  const CashFlowStatementItemWidget({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text(item.month ?? '', style: textRegular)),
      Expanded(child: Text(item.year?.toString() ?? '', style: textRegular)),
      Expanded(child: Text(item.totalDebit?.toString() ?? '0', style: textRegular)),
      Expanded(child: Text(item.totalCredit?.toString() ?? '0', style: textRegular)),

    ]);
  }
}
