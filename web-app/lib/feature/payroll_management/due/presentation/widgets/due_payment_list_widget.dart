import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/payroll_management/due/logic/due_controller.dart';
import 'package:class_compass/feature/payroll_management/due/presentation/widgets/due_payment_item_widget.dart';
import 'package:class_compass/feature/payroll_management/due/presentation/widgets/due_payment_widget.dart';

class DuePaymentListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const DuePaymentListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DueController>(
      initState: (val) => Get.find<DueController>().getDue(),
      builder: (dueController) {
        final model = dueController.dueModel;
        final data = model?.data;
        return GenericListSection(
          sectionTitle: "salary_management".tr,
          pathItems: [ "due_payment".tr],
          addNewTitle: "due_payment".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(
            title: "due_payment".tr,
              child: const DuePaymentWidget())),

          headings:  const ["image", "name", "designation", "amount",],
          scrollController: scrollController,
          isLoading: false,
          showAction: false,
          totalSize: 0,
          offset: 1,
          onPaginate: (offset) async => {},
          items: data?.userPayroll ?? [],
          itemBuilder: (item, index) => DueItemWidget(index: index, dueUserPayroll: item));
      },
    );
  }
}