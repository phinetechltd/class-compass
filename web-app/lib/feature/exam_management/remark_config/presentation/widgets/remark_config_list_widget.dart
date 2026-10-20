import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/exam_management/remark_config/controller/re_mark_config_controller.dart';
import 'package:class_compass/feature/exam_management/remark_config/domain/model/remark_config_model.dart';
import 'package:class_compass/feature/exam_management/remark_config/presentation/widgets/create_new_remark_config_dialog.dart';
import 'package:class_compass/feature/exam_management/remark_config/presentation/widgets/remrk_config_item_widget.dart';

class ReMarkConfigListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const ReMarkConfigListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReMarkConfigController>(
      initState: (state) => Get.find<ReMarkConfigController>().getRemarkConfigList(1),
      builder: (remarkConfigController) {
        final reMarkConfigModel = remarkConfigController.reMarkConfigModel;
        final remarkData = reMarkConfigModel?.data;
        return GenericListSection<RemarkConfigItem>(
          sectionTitle: "remark_config".tr,
          addNewTitle: "add_remark_config".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "remark".tr,
              child: const CreateNewReMarkConfigDialog())),
          headings: const ["title", "remark", ],
          scrollController: scrollController,
          isLoading: reMarkConfigModel == null,
          totalSize: remarkData?.total ?? 0,
          offset: remarkData?.currentPage ?? 0,
          onPaginate: (offset) async => await remarkConfigController.getRemarkConfigList(offset ?? 1),
          items: remarkData?.data ?? [],
          itemBuilder: (item, index) => ReMarkConfigItemWidget(index: index, remarkConfigItem: item),
        );
      },
    );
  }
}
