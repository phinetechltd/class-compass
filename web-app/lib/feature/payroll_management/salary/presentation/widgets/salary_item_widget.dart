import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/payroll_management/salary/domain/models/salary_model.dart';
import 'package:class_compass/feature/payroll_management/salary/presentation/widgets/salary_details_widget.dart';
import 'package:class_compass/helper/price_converter.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class SalaryItemWidget extends StatelessWidget {
  final int index;
  final SalarySlips salaryItem;

  const SalaryItemWidget({super.key, required this.index, required this.salaryItem});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ?
    Row(spacing: Dimensions.paddingSizeDefault,
        crossAxisAlignment: CrossAxisAlignment.start, children: [

      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text:"${salaryItem.user?.name ?? ''} ")),
      Expanded(child: CustomItemTextWidget(text: PriceConverter.convertPrice(context, salaryItem.netSalary??0))),

          IconButton(onPressed: ()=> Get.dialog(CustomDialogWidget(
              title: "details".tr,
              child: const PayrollDetailsWidget())),
            icon: Icon(Icons.arrow_forward_ios_rounded, size: 16,
                color: Theme.of(context).hintColor),
          ),
    ]) :
    CustomContainer(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("${"employee".tr} : ${salaryItem.user?.name ?? ''}", style: textMedium.copyWith()),
          Text("${"net_salary".tr} : ${PriceConverter.convertPrice(context, salaryItem.netSalary ?? 0)}",
              style: textMedium.copyWith()),
        ])),
        IconButton(onPressed: ()=> Get.dialog(CustomDialogWidget(
            title: "details".tr,
            child: const PayrollDetailsWidget())),
          icon: Icon(Icons.arrow_forward_ios_rounded, size: 16,
              color: Theme.of(context).hintColor),
        ),
      ]),
    );
  }


}
