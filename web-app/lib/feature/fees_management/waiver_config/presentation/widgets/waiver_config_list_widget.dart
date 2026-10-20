import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/fees_management/waiver_config/controller/waiver_config_controller.dart';
import 'package:class_compass/feature/fees_management/waiver_config/domain/model/waiver_config_model.dart';
import 'package:class_compass/feature/fees_management/waiver_config/presentation/widgets/waiver_config_item_widget.dart';

class WaiverConfigListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const WaiverConfigListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaiverConfigController>(
      initState: (val) => Get.find<WaiverConfigController>().getWaiverConfigList(1),
      builder: (waiverController) {
        final model = waiverController.waiverConfigModel;
        final data = model?.data;
        return GenericListSection<WaiverList>(
          showRouteSection: false,
            sectionTitle: "fees_management".tr,
            pathItems: [ "waiver_config".tr],
            headings:  const [ "name", "email", "phone", "roll", "class", "section", "fee_head_name", "waiver_name", "amount"],
            scrollController: scrollController,
            isLoading: false,
            showAction: false,
            totalSize: 0,
            offset: 1,
            onPaginate: (offset) async => {},
            items: data?.waiverList ?? [],
            itemBuilder: (item, index) => WaiverConfigItemWidget(index: index, waiverList: item));
      },
    );
  }
}