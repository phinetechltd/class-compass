import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/fees_management/fees_head/controller/fees_head_controller.dart';
import 'package:class_compass/feature/fees_management/fees_head/domain/model/fees_head_model.dart';
import 'package:class_compass/feature/fees_management/fees_head/presentation/screens/create_new_fees_head_dialog.dart';
import 'package:class_compass/feature/fees_management/fees_head/presentation/widgets/fees_head_item_widget.dart';

class FeesHeadListWidget extends StatelessWidget {
  final ScrollController scrollController;
  final bool fromSelection;
  const FeesHeadListWidget({super.key, required this.scrollController, this.fromSelection = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesHeadController>(
      initState: (val) => Get.find<FeesHeadController>().getFeesHeadList(1),
        builder: (feesHeadController) {
      FeesHeadModel? feesHeadModel = feesHeadController.feesHeadModel;
      Data? feesHeadData = feesHeadModel?.data;

      return GenericListSection<FeesHeadItem>(
        sectionTitle: "fees_management".tr,
        pathItems: ["fees_head".tr],
        addNewTitle: "add_new_fees_head".tr,
        onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "fees_head".tr,
            child: const CreateNewFeesHeadDialog())),
        headings: const ["name", "serial", ],
        scrollController: scrollController,
        isLoading: feesHeadModel == null,
        totalSize: feesHeadData?.total ?? 0,
        offset: feesHeadData?.currentPage ?? 0,
        onPaginate: (offset) async => await feesHeadController.getFeesHeadList(offset ?? 1),
        items: feesHeadData?.data ?? [],
        itemBuilder: (item, index) => InkWell(
          onTap: (){
            if(fromSelection){
              Get.back();
              Get.find<FeesHeadController>().selectFeesHeadItem(item);
            }
          },
            child: FeesHeadItemWidget(feesHeadItem: item, index: index)),
      );
    });
  }
}
