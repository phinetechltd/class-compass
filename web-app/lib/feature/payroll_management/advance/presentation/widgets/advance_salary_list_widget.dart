import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/payroll_management/advance/domain/models/advance_salary_model.dart';
import 'package:class_compass/feature/payroll_management/advance/logic/advance_controller.dart';
import 'package:class_compass/feature/payroll_management/advance/presentation/widgets/add_advance_salary_widget.dart';
import 'package:class_compass/feature/payroll_management/advance/presentation/widgets/advance_salary_item_widget.dart';

class AdvanceSalaryListWidget extends StatelessWidget {
  final ScrollController scrollController;

  const AdvanceSalaryListWidget({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdvanceController>(
      initState: (val) => Get.find<AdvanceController>().getAdvanceSalaryList(1),
      builder: (advanceController) {
        AdvanceSalaryModel? advanceSalaryModel = advanceController.advanceSalaryModel;
        var advanceSalaryData = advanceSalaryModel?.data;

        return GenericListSection<UserPayroll>(
          sectionTitle: "payroll_management".tr,
          pathItems: ["advance_salary".tr],
          addNewTitle: "add_advance_salary".tr,
          onAddNewTap: () => Get.dialog( CustomDialogWidget(
            title: "advance_salary".tr, child: const AddAdvanceSalaryWidget())),
          headings: const ["employee", "advanced", "date", "net_salary", ],
          showAction: false,
          scrollController: scrollController,
          isLoading: false,
          totalSize: 0,
          offset: 1,
          onPaginate: (offset) async => await advanceController.getAdvanceSalaryList(offset ?? 1),

          items: advanceSalaryData?.userPayroll ?? [],
          itemBuilder: (item, index) {
            return AdvanceSalaryItemWidget(advanceSalaryItem: item, index: index);
          },
        );
      },
    );
  }
}
