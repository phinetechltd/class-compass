import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/academic_configuration/shift/controller/shift_controller.dart';
import 'package:class_compass/feature/academic_configuration/shift/domain/models/shift_model.dart';
import 'package:class_compass/feature/academic_configuration/shift/presentation/screens/create_new_shift_screen.dart';
import 'package:class_compass/feature/academic_configuration/shift/presentation/widgets/shift_item_widget.dart';

class ShiftListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const ShiftListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShiftController>(
      initState: (val) => Get.find<ShiftController>().getShiftList(),
      builder: (shiftController) {
        final shiftModel = shiftController.shiftModel;
        final shiftData = shiftModel?.data;

        return GenericListSection<ShiftItem>(
          sectionTitle: "academic_configuration".tr,
          pathItems: ["shift_list".tr],
          addNewTitle: "add_new_shift".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "shift".tr,
              child: const CreateNewShiftScreen())),
          headings: const ["shift", ],

          scrollController: scrollController,
          isLoading: shiftModel == null,
          totalSize: shiftData?.length ?? 0,
          offset: 1,
          onPaginate: (offset) async {},
          items: shiftData ?? [],
          itemBuilder: (item, index) => ShiftItemWidget(index: index, shiftItem: item,),
        );
      },
    );
  }
}