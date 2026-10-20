import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/payroll_management/payroll_mapping/domain/models/payroll_mapping_model.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class PayrollMappingItemWidget extends StatelessWidget {
  final int index;
  final PayrollMappingItem? payrollMappingItem;

  const PayrollMappingItemWidget({super.key, required this.index, this.payrollMappingItem});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ?
    Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [
      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text:payrollMappingItem?.ledger?.ledgerName ?? '')),
      Expanded(child: CustomItemTextWidget(text:payrollMappingItem?.fund?.name ?? 'N/A')),
    ]) :
    CustomContainer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomItemTextWidget(text:"${"ledger".tr} : ${payrollMappingItem?.ledger?.ledgerName ?? ''}"),
        CustomItemTextWidget(text:"${"fund".tr} : ${payrollMappingItem?.fund?.name ?? ''}"),
      ]),
    );
  }
}
