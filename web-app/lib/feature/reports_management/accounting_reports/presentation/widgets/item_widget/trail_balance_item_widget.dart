import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/domain/model/trail_balance_report_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class TrailBalanceItemWidget extends StatelessWidget {
  final Data item;
  final int index;
  const TrailBalanceItemWidget({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text(item.ledgerName ?? '', style: textRegular)),
      Expanded(child: Text(item.totalDebit ?? '', style: textRegular)),
      Expanded(child: Text(item.totalCredit ?? '', style: textRegular)),

    ]);
  }
}
