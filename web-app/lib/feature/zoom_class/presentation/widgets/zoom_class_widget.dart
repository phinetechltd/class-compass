import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/zoom_class/logic/zoom_class_controller.dart';
import 'package:class_compass/feature/zoom_class/domain/model/zoom_class_model.dart';
import 'package:class_compass/feature/zoom_class/presentation/widgets/zoom_item_widget.dart';
import 'package:class_compass/feature/zoom_class/presentation/widgets/create_new_zoom_class_widget.dart';

class ZoomClassWidget extends StatelessWidget {
  final ScrollController scrollController;
  const ZoomClassWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZoomClassController>(
      initState: (val) => Get.find<ZoomClassController>().getZoomClass(1),
      builder: (zoomClassController) {
        final zoomModel = zoomClassController.zoomModel;
        final zoomData = zoomModel?.data;

        return GenericListSection<ZoomItem>(
          sectionTitle: "live_class_list".tr,
          addNewTitle: "add".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(
            title: "live_class".tr,
              child: const CreateNewZoomClassWidget())),
          headings: const ["topic", "agenda", "start_time", "duration", "join_url", "start_url",],

          scrollController: scrollController,
          isLoading: zoomModel == null,
          totalSize: zoomData?.total ?? 0,
          offset: zoomData?.currentPage ?? 0,
          onPaginate: (offset) async => await zoomClassController.getZoomClass(offset ?? 1),

          items: zoomData?.data ?? [],
          itemBuilder: (item, index) => ZoomItemWidget(index: index, zoomItem: item),
        );
      },
    );
  }
}