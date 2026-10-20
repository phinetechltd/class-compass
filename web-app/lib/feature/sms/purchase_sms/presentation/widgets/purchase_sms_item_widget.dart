import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/custom_popup_menu.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/dashboard/controller/dashboard_controller.dart';
import 'package:class_compass/feature/sms/purchase_sms/controller/purchase_sms_controller.dart';
import 'package:class_compass/feature/sms/purchase_sms/domain/models/purchase_sms_model.dart';
import 'package:class_compass/feature/sms/purchase_sms/presentation/widgets/create_new_purchase_sms_widget.dart';
import 'package:class_compass/helper/price_converter.dart';
import 'package:class_compass/util/dimensions.dart';

class PurchaseSmsItemWidget extends StatelessWidget {
  final PurchaseSmsItem? purchaseSmsItem;
  final int index;
  const PurchaseSmsItemWidget({super.key, this.purchaseSmsItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text: "${purchaseSmsItem?.smsGateway}")),
      Expanded(child: CustomItemTextWidget(text: "${purchaseSmsItem?.maskingType}")),
      Expanded(child: CustomItemTextWidget(text: "${purchaseSmsItem?.transactionDate}")),
      Expanded(child: CustomItemTextWidget(text: "${purchaseSmsItem?.noOfSms}")),
      Expanded(child: CustomItemTextWidget(text: PriceConverter.convertPrice(context, purchaseSmsItem?.amount??0))),
      _buildPopupMenu(context, purchaseSmsItem)

          ],
        );
  }
  Widget _buildPopupMenu(BuildContext context, PurchaseSmsItem? purchaseSmsItem ) {
    return CustomPopupMenu(
      menuItems: Get.find<DashboardController>().getPopupMenuList(editDelete: true),
      onSelected: (option) {
        if (option.title == "edit".tr) {
          Get.dialog(Dialog(
            child: CreateNewPurchaseSmsWidget(purchaseSmsItem: purchaseSmsItem),
          ));
        }else if (option.title == "delete".tr) {
          Get.dialog(ConfirmationDialog(title: "purchase_sms".tr,
            content: "purchase_sms".tr,
            onTap: (){
            Get.back();
              Get.find<PurchaseSmsController>().deletePurchaseSms(purchaseSmsItem!.id!);
            },
          ));
        }
      },
      child: Icon(Icons.more_vert, color: Theme.of(context).hintColor),
    );
  }
}