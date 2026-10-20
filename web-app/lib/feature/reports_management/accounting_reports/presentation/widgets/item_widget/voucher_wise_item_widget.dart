import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/domain/model/voucher_report_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class VoucherWiseItemWidget extends StatelessWidget {
  final Data item;
  final int index;
  const VoucherWiseItemWidget({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text(item.transactionDate ?? '', style: textRegular)),
      Expanded(child: Text(item.reference ?? '', style: textRegular)),
      Expanded(child: Text(item.description ?? '', style: textRegular)),
      Expanded(child: Text(item.debit ?? '', style: textRegular)),
      Expanded(child: Text(item.credit ?? '', style: textRegular)),

    ]);
  }
}
