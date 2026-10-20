import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/fees_management/fees_amount_config/controller/fees_controller.dart';
import 'package:class_compass/feature/fees_management/fees_amount_config/domain/model/absent_fine_model.dart';
import 'package:class_compass/feature/fees_management/fees_amount_config/presentation/widgets/absent_fine_item_widget.dart';
import 'package:class_compass/feature/fees_management/fees_amount_config/presentation/widgets/config_absent_fine.dart';

class AbsentFineListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const AbsentFineListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesController>(
        initState: (val) => Get.find<FeesController>().getAbsentFineList(1),
        builder: (feesController) {
          final absentFineModel = feesController.absentFineModel;
          final  absentFine = absentFineModel?.data;

          return GenericListSection<AbsentFineItem>(
            addNewTitle: "absent_fine_config".tr,
            onAddNewTap: (){
              Get.dialog(const Dialog(child: NewAbsentFineConfigWidget()));
            },
            showAction: false,
            sectionTitle: "fees_management".tr,
            pathItems: ["absent_fine".tr],
            headings: const ["class", "period", "amount", ],
            scrollController: scrollController,
            isLoading: absentFineModel == null,
            totalSize: absentFine?.total ?? 0,
            offset: absentFine?.currentPage ?? 0,
            onPaginate: (offset) async => await feesController.getFeesList(offset ?? 1),
            items: absentFine?.data ?? [],
            itemBuilder: (item, index) => AbsentFineItemWidget(absentFineItem: item, index: index),
          );
        });
  }
}
