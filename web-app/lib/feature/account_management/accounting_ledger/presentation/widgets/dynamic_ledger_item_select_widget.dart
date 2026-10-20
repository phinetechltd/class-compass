import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/account_management/accounting_ledger/logic/account_ledger_controller.dart';
import 'package:class_compass/feature/account_management/accounting_ledger/presentation/widgets/accounting_ledger_dropdown.dart';
import 'package:class_compass/feature/account_management/accounting_ledger/domain/model/accounting_ledger_model.dart';

class SelectDynamicAccountingLedgerWidget extends StatefulWidget {
  final AccountingLedgerItem? selectedValue;
  final Function(AccountingLedgerItem) onSelect;

  const SelectDynamicAccountingLedgerWidget({
    super.key,
    required this.onSelect,
    this.selectedValue,
  });

  @override
  State<SelectDynamicAccountingLedgerWidget> createState() => _SelectDynamicAccountingLedgerWidgetState();
}

class _SelectDynamicAccountingLedgerWidgetState extends State<SelectDynamicAccountingLedgerWidget> {
  @override
  void initState() {
    final controller = Get.find<AccountLedgerController>();
    if (controller.accountingLedgerModel == null) {
      controller.getAccountingLedgerList(1);
    }
    if (controller.accountingLedgerModelForPayment == null) {
      controller.getAccountingLedgerListForPayment(1);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountLedgerController>(
      builder: (accountingLedgerController) {
        final items = accountingLedgerController.accountingLedgerModel?.data?.data ?? [];
        return AccountingLedgerDropdown(
          width: Get.width,
          title: "select".tr,
          items: items,
          selectedValue: widget.selectedValue,
          onChanged: (val) {
            if (val != null) widget.onSelect(val);
          },
        );
      },
    );
  }
}
