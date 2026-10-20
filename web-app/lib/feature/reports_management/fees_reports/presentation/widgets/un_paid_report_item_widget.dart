import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/fees_management/paid_info/domain/model/un_paid_report_model.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class UnPaidReportItemWidget extends StatelessWidget {
  final UnpaidStudentData? unPaidReportItem;
  final int index;
  const UnPaidReportItemWidget({super.key, this.unPaidReportItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Row(spacing: Dimensions.paddingSizeSmall, children: [
      NumberingWidget(index: index),
      Expanded(child: Text('${unPaidReportItem?.roll}', style: textRegular.copyWith())),
      Expanded(child: Text('${unPaidReportItem?.name}', style: textRegular.copyWith())),
      Expanded(child: Text('${unPaidReportItem?.totalPaidAmount}', style: textRegular.copyWith())),

    ],):
    CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,

      child: Row(spacing: Dimensions.paddingSizeSmall, children: [
        Expanded(child: Text('${unPaidReportItem?.roll}', style: textRegular.copyWith())),
        Expanded(child: Text('${unPaidReportItem?.name}', style: textRegular.copyWith())),
        Expanded(child: Text('${unPaidReportItem?.totalPaidAmount}', style: textRegular.copyWith())),

      ],),
    );
  }
}
