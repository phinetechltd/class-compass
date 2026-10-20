import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/master_configuration/employee/controller/employee_controller.dart';
import 'package:class_compass/feature/master_configuration/employee/domain/models/employee_model.dart';
import 'package:class_compass/feature/master_configuration/employee/presentation/widgets/create_new_employee_widget.dart';
import 'package:class_compass/feature/master_configuration/employee/presentation/widgets/employee_item_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class EmployeeListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const EmployeeListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmployeeController>(
      initState: (state) => Get.find<EmployeeController>().getEmployeeList(1),
      builder: (employeeController) {
        final employeeModel = employeeController.employeeModel;
        final employeeData = employeeModel?.data;
        return GenericListSection<EmployeeItem>(
          sectionTitle: "employee".tr,
          addNewTitle: "add_new_employee".tr,
          onAddNewTap: () => Get.dialog(Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault)),
              child: const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: CreateNewEmployeeWidget(),
              ))),
          headings: const ["name", "role", "phone", "department"],
          scrollController: scrollController,
          isLoading: employeeModel == null,
          totalSize: employeeData?.total ?? 0,
          offset: employeeData?.currentPage ?? 0,
          onPaginate: (offset) async => await employeeController.getEmployeeList(offset ?? 1),
          items: employeeData?.data ?? [],
          itemBuilder: (item, index) => EmployeeItemWidget(index: index, employeeItem: item),
        );
      },
    );
  }
}
