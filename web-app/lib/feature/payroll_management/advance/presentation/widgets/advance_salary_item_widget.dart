import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/payroll_management/advance/domain/models/advance_salary_model.dart';
import 'package:class_compass/helper/date_converter.dart';
import 'package:class_compass/helper/price_converter.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class AdvanceSalaryItemWidget extends StatelessWidget {
  final int index;
  final UserPayroll advanceSalaryItem;

  const AdvanceSalaryItemWidget({
    super.key,
    required this.index,
    required this.advanceSalaryItem,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ?
    Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text:advanceSalaryItem.user?.name ?? 'N/A')),

      Expanded(child: CustomItemTextWidget(text: PriceConverter.convertPrice(context, advanceSalaryItem.currentAdvance??0))),
      Expanded(child: CustomItemTextWidget(text: DateConverter.quotationDate(DateTime.parse(advanceSalaryItem.createdAt ?? 'N/A')))),
      Expanded(child: CustomItemTextWidget(
          text: PriceConverter.convertPrice(context, advanceSalaryItem.netSalary ?? 0))),

    ]) :
    CustomContainer(
      child: Row(spacing: Dimensions.paddingSizeExtraSmall, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("${"employee".tr} : ${advanceSalaryItem.user?.name ?? ''}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
          Text("${"advance_salary".tr} : ${advanceSalaryItem.currentAdvance ?? ''}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
          Text("${"date".tr} : ${advanceSalaryItem.createdAt ?? ''}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor)),
          Text("${"net_salary".tr} : ${PriceConverter.convertPrice(context, advanceSalaryItem.netSalary ?? 0)}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),

        ])),
      ]),
    );
  }

}
