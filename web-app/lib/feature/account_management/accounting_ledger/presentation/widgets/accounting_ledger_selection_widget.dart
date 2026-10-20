import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/account_management/accounting_ledger/logic/account_ledger_controller.dart';
import 'package:class_compass/feature/account_management/accounting_ledger/presentation/widgets/accounting_ledger_dropdown.dart';

class SelectAccountingLedgerWidget extends StatefulWidget {
  final bool showBalance;
  final String title;
  const SelectAccountingLedgerWidget({super.key, this.showBalance = false, required this.title});

  @override
  State<SelectAccountingLedgerWidget> createState() => _SelectAccountingLedgerWidgetState();
}

class _SelectAccountingLedgerWidgetState extends State<SelectAccountingLedgerWidget> {
  @override
  void initState() {
    if(Get.find<AccountLedgerController>().accountingLedgerModel == null){
      Get.find<AccountLedgerController>().getAccountingLedgerList(1);
    }
    if(Get.find<AccountLedgerController>().accountingLedgerModelForPayment == null){
      Get.find<AccountLedgerController>().getAccountingLedgerListForPayment(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.symmetric(vertical : 8),
        child: CustomTitle(title: widget.title)),

      GetBuilder<AccountLedgerController>(
          builder: (accountingLedgerController) {
            return AccountingLedgerDropdown(width: Get.width, title: "select".tr,
              items: widget.showBalance?
              accountingLedgerController.accountingLedgerModelForPayment?.data?.data??[] :
              accountingLedgerController.accountingLedgerModel?.data?.data??[],
              selectedValue:  widget.showBalance?
              accountingLedgerController.selectedAccountingLedgerItemForPayment :
              accountingLedgerController.selectedAccountingLedgerItemForTransaction,
              onChanged: (val){
              accountingLedgerController.selectAccountLedgerItem(val!,
                  forTransaction: !widget.showBalance);
              },
            );
          }
      ),
    ],);
  }
}
