import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/account_management/accounting_category/controller/accounting_category_controller.dart';
import 'package:class_compass/feature/account_management/accounting_category/domain/models/accounting_category_model.dart';
import 'package:class_compass/feature/account_management/accounting_category/presentation/screens/create_new_account_category_screen.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class AccountingCategoryItemWidget extends StatelessWidget {
  final AccountingCategoryItem? accountingCategoryItem;
  final int index;
  const AccountingCategoryItemWidget({super.key, this.accountingCategoryItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text('${accountingCategoryItem?.name}', style: textRegular.copyWith())),
        Expanded(child: Text('${accountingCategoryItem?.type}', style: textRegular.copyWith())),
        EditDeleteSection(horizontal: true, onDelete: (){
          Get.dialog(ConfirmationDialog(title: "accounting_category", content: "accounting_category",
            onTap: (){
              Get.back();
              Get.find<AccountingCategoryController>().deleteAccountingCategory(accountingCategoryItem!.id!);
            },));

        }, onEdit: (){
          Get.dialog(CustomDialogWidget(title: "category".tr,
              child: CreateNewAccountingCategoryScreen(accountingCategoryItem: accountingCategoryItem)));
        },)
      ],
      ),
    );
  }
}