import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/fees_management/waiver/controller/waiver_controller.dart';
import 'package:class_compass/feature/fees_management/waiver/domain/model/waiver_model.dart';
import 'package:class_compass/feature/fees_management/waiver/presentation/screens/create_new_waiver_dialog.dart';
import 'package:class_compass/feature/fees_management/waiver/presentation/widgets/waiver_item_widget.dart';

class WaiverListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const WaiverListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaiverController>(
      initState: (val) => Get.find<WaiverController>().getWaiverList(1),
        builder: (waiverController) {
      WaiverModel? waiverModel = waiverController.waiverModel;
      Data? waiverData = waiverModel?.data;

      return GenericListSection<WaiverItem>(
        sectionTitle: "fees_management".tr,
        pathItems: ["waiver".tr],
        addNewTitle: "add_new_waiver".tr,
        onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "waiver".tr,
            child: const CreateNewWaiverDialog())),
        headings: const ["waiver_name", ],
        scrollController: scrollController,
        isLoading: waiverModel == null,
        totalSize: waiverData?.total ?? 0,
        offset: waiverData?.currentPage ?? 0,
        onPaginate: (offset) async => await waiverController.getWaiverList(offset ?? 1),
        items: waiverData?.data ?? [],
        itemBuilder: (item, index) => WaiverItemWidget(waiverItem: item, index: index),
      );
    });
  }
}
