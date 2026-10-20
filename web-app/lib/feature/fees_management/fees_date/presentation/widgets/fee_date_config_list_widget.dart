
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/fees_management/fees_date/controller/fees_date_controller.dart';
import 'package:class_compass/feature/fees_management/fees_date/domain/model/fees_date_model.dart';
import 'package:class_compass/feature/fees_management/fees_date/presentation/widgets/add_new_date_config_widget.dart';
import 'package:class_compass/feature/fees_management/fees_date/presentation/widgets/fees_date_card_widget.dart';

class FeeDateConfigListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const FeeDateConfigListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesDateController>(
      initState: (_) => Get.find<FeesDateController>().getFeesDateList(1),
      builder: (controller) {
        FeesDateModel? model = controller.feesDateModel;
        final data = model?.data;

        return GenericListSection<FeesDateItem>(
          addNewTitle: "new_date_config".tr,
          onAddNewTap: (){
            Get.dialog(CustomDialogWidget(title: "new_date_config".tr,
                child: const AddNewDateConfigWidget()));
          },
          sectionTitle: "fees_management".tr,
          pathItems: ["fee_date_config".tr],

          headings: const ["name", "fee_payable_date", "fee_activation_date"],
          scrollController: scrollController,
          isLoading: model == null,
          totalSize: data?.total ?? 0,
          offset: data?.currentPage ?? 0,
          onPaginate: (offset) => controller.getFeesDateList(offset ?? 1),
          items: data?.data ?? [],
          itemBuilder: (item, index) => FeesDateCardWidget(index: index, feesDateItem: item),

        );
      },
    );
  }
}
