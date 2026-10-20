import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/payroll_management/payroll_mapping/domain/models/payroll_mapping_model.dart';
import 'package:class_compass/feature/payroll_management/payroll_mapping/logic/payroll_mapping_controller.dart';
import 'package:class_compass/feature/payroll_management/payroll_mapping/presentation/screens/create_payroll_mapping_screen.dart';
import 'package:class_compass/feature/payroll_management/payroll_mapping/presentation/widgets/payroll_mapping_item_widget.dart';

class PayrollMappingWidget extends StatelessWidget {
  final ScrollController scrollController;

  const PayrollMappingWidget({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayrollMappingController>(builder: (payrollMappingController) {
        PayrollMappingModel? payrollMappingModel = payrollMappingController.payrollMappingModel;
        var payrollMappingData = payrollMappingModel?.data;

        return GenericListSection<PayrollMappingItem>(
          sectionTitle: "payroll_management".tr,
          pathItems: ["payroll_mapping".tr],
          addNewTitle: "add_new_payroll_mapping".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "payroll_mapping".tr,
              child: const CreatePayrollMappingScreen())),
          headings: const ["ledger", "fund"],
          showAction: false,
          scrollController: scrollController,
          isLoading: payrollMappingModel == null,
          totalSize:  0,
          offset:  0,
          onPaginate: (offset) async => await payrollMappingController.getPayrollMappingList(offset ?? 1),
          items: payrollMappingData ?? [],
          itemBuilder: (item, index) {
            return PayrollMappingItemWidget(payrollMappingItem: item, index: index);
          },
        );
      },
    );
  }
}