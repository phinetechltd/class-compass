import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/fees_management/fees_sub_head/controller/fees_sub_head_controller.dart';
import 'package:class_compass/feature/fees_management/fees_sub_head/domain/model/fees_sub_head_model.dart';
import 'package:class_compass/feature/fees_management/fees_sub_head/presentation/screens/create_new_fees_sub_head_dialog.dart';
import 'package:class_compass/feature/fees_management/fees_sub_head/presentation/widgets/fees_sub_head_item_widget.dart';

class FeesSubHeadListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const FeesSubHeadListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesSubHeadController>(
      initState: (val) => Get.find<FeesSubHeadController>().getFeesSubHeadList(1),
        builder: (feesSubHeadController) {
      FeesSubHeadModel? feesSubHeadModel = feesSubHeadController.feesSubHeadModel;
      Data? feesSubHeadData = feesSubHeadModel?.data;

      return GenericListSection<FeesSubHeadItem>(
        sectionTitle: "fees_management".tr,
        pathItems: ["fees_sub_head".tr],
        addNewTitle: "add_new_fees_sub_head".tr,
        onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "fees_sub_head".tr,
            child: const CreateNewFeesSubHeadDialog())),
        headings: const ["name", "serial",],
        scrollController: scrollController,
        isLoading: feesSubHeadModel == null,
        totalSize: feesSubHeadData?.total ?? 0,
        offset: feesSubHeadData?.currentPage ?? 0,
        onPaginate: (offset) async => await feesSubHeadController.getFeesSubHeadList(offset ?? 1),
        items: feesSubHeadData?.data ?? [],
        itemBuilder: (item, index) => FeesSubHeadItemWidget(feesSubHeadItem: item, index: index),
      );
    });
  }
}
