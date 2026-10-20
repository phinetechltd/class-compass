import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/reports_management/fees_reports/domain/model/fees_head_wise_report_model.dart';
import 'package:class_compass/helper/price_converter.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class HeadWiseFeesInfoItemWidget extends StatelessWidget {
  final FeesHeadWiseReportItem? item;
  final int index;
  const HeadWiseFeesInfoItemWidget({super.key, this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: Text("${item?.firstName ?? ''} ${item?.lastName ?? ''}", maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),
      Expanded(child: Text(item?.roll ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),
      Expanded(child: Text(item?.feeHeadName ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),
      Expanded(child: Text(PriceConverter.convertPrice(context, double.tryParse(item?.feeTotalPaid ?? '0') ?? 0), maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),
      Expanded(child: Text(item?.invoiceDate ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular)),

    ]);
  }
}
