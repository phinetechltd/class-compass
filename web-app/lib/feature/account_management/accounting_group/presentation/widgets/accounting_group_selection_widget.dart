import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/account_management/accounting_group/logic/account_group_controller.dart';
import 'package:class_compass/feature/account_management/accounting_group/presentation/widgets/accounting_group_dropdown.dart';
import 'package:class_compass/feature/academic_configuration/department/controller/department_controller.dart';

class SelectAccountingGroupWidget extends StatefulWidget {
  const SelectAccountingGroupWidget({super.key});

  @override
  State<SelectAccountingGroupWidget> createState() => _SelectAccountingGroupWidgetState();
}

class _SelectAccountingGroupWidgetState extends State<SelectAccountingGroupWidget> {
  @override
  void initState() {
    if(Get.find<DepartmentController>().departmentModel == null){
      Get.find<DepartmentController>().getDepartmentList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "accounting_group"),
      GetBuilder<AccountingGroupController>(
          builder: (accountingGroupController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: AccountingGroupDropdown(width: Get.width, title: "select".tr,
                items: accountingGroupController.accountingGroupModel?.data?.data??[],
                selectedValue: accountingGroupController.selectedAccountingGroupItem,
                onChanged: (val){
                  accountingGroupController.selectAccountGroupItem(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
