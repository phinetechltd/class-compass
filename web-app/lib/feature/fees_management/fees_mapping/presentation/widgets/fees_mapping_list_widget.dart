import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/fees_management/fees_mapping/controller/fees_mapping_controller.dart';
import 'package:class_compass/feature/fees_management/fees_mapping/domain/model/fees_mapping_model.dart';
import 'package:class_compass/feature/fees_management/fees_mapping/presentation/widgets/create_new_fee_mapping_widget_web.dart';
import 'package:class_compass/feature/fees_management/fees_mapping/presentation/widgets/fees_mapping_item_widget.dart';

class FeesMappingListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const FeesMappingListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesMappingController>(
      initState: (val) => Get.find<FeesMappingController>().getFeesMappingList(1),
        builder: (feesMappingController) {
      FeesMappingModel? feesMappingModel = feesMappingController.feesMappingModel;
      Data? feesMappingData = feesMappingModel?.data;

      return GenericListSection<FeesMappingItem>(
        sectionTitle: "fees_management".tr,
        pathItems: ["fees_mapping".tr],
        addNewTitle: "add_new_fee_mapping".tr,
        onAddNewTap: () => Get.dialog(CustomDialogWidget(
          title: "fees_mapping".tr,
            child: const CreateNewFeeMappingWidget())),
        headings: const ["fee_head", "sub_head", "fee_ledger",],
        scrollController: scrollController,
        isLoading: feesMappingModel == null,
        totalSize: feesMappingData?.total ?? 0,
        offset: feesMappingData?.currentPage ?? 0,
        onPaginate: (offset) async => await feesMappingController.getFeesMappingList(offset ?? 1),
        items: feesMappingData?.data ?? [],
        itemBuilder: (item, index) => FeesMappingItemWidget(feesMappingItem: item, index: index),
      );
    });
  }
}
