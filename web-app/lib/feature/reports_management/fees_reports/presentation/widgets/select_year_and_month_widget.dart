import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_dropdown.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/hrm/payroll/controller/payroll_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class SelectYearAndMonthWidget extends StatelessWidget {
  final Function()? onTap;
  final bool noMonth;
  final double? padding;
  const SelectYearAndMonthWidget({super.key, this.onTap,
    this.noMonth = false, this.padding});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayrollController>(builder: (payrollController) {
        return Padding(padding: EdgeInsets.symmetric(
            horizontal: padding?? Dimensions.paddingSizeDefault),
          child: CustomContainer(
            child: Row(spacing: Dimensions.paddingSizeDefault, children: [

               Expanded(
                 child: Column(children: [
                   const CustomTitle(title: "year"),
                   Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                     child: CustomDropdown(width: Get.width, title: "choose_year".tr,
                       items: payrollController.yearList,
                       selectedValue: payrollController.selectedYear,
                       onChanged: (val){
                         payrollController.setSelectedYear(val!);
                       },
                     ),),
                 ],),
               ),
                if(!noMonth)
                Expanded(child: Column(children: [
                  const CustomTitle(title: "month"),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomDropdown(width: Get.width, title: "choose_month".tr,
                      items: payrollController.monthList,
                      selectedValue: payrollController.selectedMonth,
                      onChanged: (val){
                        payrollController.setSelectedMonth(val!);
                      },
                    ),),
                ])),
              SizedBox(width: 100, child: Column(
                children: [
                  const CustomTitle(title: ""),
                  CustomButton(onTap: onTap, text: "submit".tr, height: 30, width: 100),
                ],
              ))
            ]),
          ),
        );
      }
    );
  }
}
