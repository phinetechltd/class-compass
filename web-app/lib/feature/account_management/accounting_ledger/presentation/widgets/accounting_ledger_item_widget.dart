import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/account_management/accounting_ledger/domain/model/accounting_ledger_model.dart';
import 'package:class_compass/feature/account_management/accounting_ledger/logic/account_ledger_controller.dart';
import 'package:class_compass/feature/account_management/accounting_ledger/presentation/screen/create_new_accounting_ledger_item_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class AccountingLedgerItemWidget extends StatelessWidget {
  final AccountingLedgerItem? accountingLedgerItem;
  final int index;
  const AccountingLedgerItemWidget({super.key, this.accountingLedgerItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

      NumberingWidget(index: index),
      Expanded(child: Text('${accountingLedgerItem?.ledgerName}', style: textRegular.copyWith())),
      EditDeleteSection(horizontal: true, onDelete: (){
        Get.dialog(ConfirmationDialog(title: "accounting_ledger",
          content: "accounting_ledger",
          onTap: (){
            Get.back();
            Get.find<AccountLedgerController>().deleteAccountingLedger(accountingLedgerItem!.id!);
          },));

      }, onEdit: (){
        Get.dialog(CustomDialogWidget(title: "ledger".tr,
          child: CreateNewAccountingLedgerWidget(
              accountingLedgerItem: accountingLedgerItem),
        ));
      },)
    ],
    );
  }
}
