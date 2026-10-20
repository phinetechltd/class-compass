import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/reports_management/fees_reports/domain/model/payment_ratio_model.dart';
import 'package:class_compass/util/dimensions.dart';

class FeesPaymentRatioItemWidget extends StatelessWidget {
  final PaymentRatioItem? item;
  final int index;
  const FeesPaymentRatioItemWidget({super.key, this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text: item?.className??'')),
      Expanded(child: CustomItemTextWidget(text: item?.totalStudents??'')),
      Expanded(child: CustomItemTextWidget(text: item?.paidStudents??'')),
      Expanded(child: CustomItemTextWidget(text: item?.unpaidStudents??'')),
      Expanded(child: CustomItemTextWidget(text: item?.paidPercentage??'')),
      Expanded(child: CustomItemTextWidget(text: item?.unpaidPercentage??'')),

    ]);
  }
}
