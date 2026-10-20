import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/sms/purchase_sms/controller/purchase_sms_controller.dart';
import 'package:class_compass/feature/sms/purchase_sms/domain/models/purchase_sms_model.dart';
import 'package:class_compass/feature/sms/purchase_sms/presentation/widgets/create_new_purchase_sms_widget.dart';
import 'package:class_compass/feature/sms/purchase_sms/presentation/widgets/purchase_sms_item_widget.dart';

class PurchaseSmsListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const PurchaseSmsListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseSmsController>(
      initState: (_) => Get.find<PurchaseSmsController>().getPurchaseSmsList(1),
      builder: (purchaseSmsController) {
        final purchaseSmsModel = purchaseSmsController.purchaseSmsModel;
        final purchaseSmsData = purchaseSmsModel?.data;

        return GenericListSection<PurchaseSmsItem>(
          sectionTitle: "sms_management".tr,
          pathItems: ["purchase_sms_list".tr],
          addNewTitle: "add_new_purchase_sms".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "purchase_sms".tr,
              child: const CreateNewPurchaseSmsWidget())),
          headings: const ["sms_gateway", "masking_type", "transaction_date", "no_of_sms","amount",],

          scrollController: scrollController,
          isLoading: purchaseSmsModel == null,
          totalSize: purchaseSmsData?.total ?? 0,
          offset: purchaseSmsData?.currentPage ?? 0,
          onPaginate: (offset) async =>
          await purchaseSmsController.getPurchaseSmsList(offset ?? 1),
          items: purchaseSmsData?.data ?? [],
          itemBuilder: (item, index) => PurchaseSmsItemWidget(index: index, purchaseSmsItem: item),

        );
      },
    );
  }
}
