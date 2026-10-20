import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/payroll_management/salary/domain/models/salary_model.dart';
import 'package:class_compass/feature/payroll_management/salary/logic/salary_controller.dart';
import 'package:class_compass/feature/payroll_management/salary/presentation/widgets/salary_item_widget.dart';

class SalaryListWidget extends StatelessWidget {
  final ScrollController scrollController;

  const SalaryListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalaryController>(builder: (salaryController) {
        SalaryModel? salaryModel = salaryController.salaryModel;
        var salaryData = salaryModel?.data;

        return GenericListSection<SalarySlips>(
          sectionTitle: "payroll_management".tr,
          pathItems: ["salary_processing".tr],
          headings: const ["employee",  "net_salary"],

          scrollController: scrollController,
          isLoading: false,
          totalSize:  0,
          offset: 1,
          onPaginate: (offset) async {},
          items: salaryData?.salarySlips ?? [],
          itemBuilder: (item, index) {
            return SalaryItemWidget(salaryItem: item, index: index);
          },
        );
      },
    );
  }
}
