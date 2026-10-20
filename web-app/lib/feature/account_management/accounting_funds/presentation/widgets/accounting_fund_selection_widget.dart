import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/account_management/accounting_funds/logic/account_fund_controller.dart';
import 'package:class_compass/feature/account_management/accounting_funds/presentation/widgets/accounting_fund_dropdown.dart';
import 'package:class_compass/util/dimensions.dart';

class SelectAccountingFundWidget extends StatefulWidget {
  final bool toFund;
  final String title;
  const SelectAccountingFundWidget({super.key, required this.title,  this.toFund = false});

  @override
  State<SelectAccountingFundWidget> createState() => _SelectAccountingFundWidgetState();
}

class _SelectAccountingFundWidgetState extends State<SelectAccountingFundWidget> {
  @override
  void initState() {
    if(Get.find<AccountingFundController>().accountingFundModel == null){
      Get.find<AccountingFundController>().getAccountingFundList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: Dimensions.paddingSizeDefault),
      CustomTitle(title: widget.title),
      GetBuilder<AccountingFundController>(
          builder: (accountingFundController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: AccountingFundDropdown(width: Get.width, title: "select".tr,
                items: accountingFundController.accountingFundModel?.data?.data??[],
                selectedValue: widget.toFund? accountingFundController.selectedToFundItem : accountingFundController.selectedAccountingFundItem,
                onChanged: (val){
                  accountingFundController.selectAccountingFundItem(val!, to: widget.toFund);
                },
              ),);
          }
      ),
    ],);
  }
}
