import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_generic_dropdown.dart';
import 'package:class_compass/feature/master_configuration/employee/controller/employee_controller.dart';
import 'package:class_compass/util/styles.dart';

class SelectEmployeeWidget extends StatefulWidget {
  const SelectEmployeeWidget({super.key});

  @override
  State<SelectEmployeeWidget> createState() => _SelectEmployeeWidgetState();
}

class _SelectEmployeeWidgetState extends State<SelectEmployeeWidget> {
  @override
  void initState() {
    if(Get.find<EmployeeController>().employeeModel == null){
      Get.find<EmployeeController>().getEmployeeList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmployeeController>(builder: (employeeController) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text("select_employee".tr, style: textMedium)),
        CustomGenericDropdown(width: Get.width,
          title: "${"employee".tr}: ${employeeController.selectedEmployee?.name??""}",
          items: employeeController.employeeModel?.data?.data??[],
          selectedValue: employeeController.selectedEmployee,
          onChanged: (val){
          employeeController.selectEmployee(val!);
          }, getLabel: (item) => item.name ?? ''),
      ]);
    });
  }
}
