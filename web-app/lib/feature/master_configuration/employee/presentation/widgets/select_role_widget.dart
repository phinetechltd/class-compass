import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_generic_dropdown.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/master_configuration/role/controller/role_controller.dart';
import 'package:class_compass/feature/master_configuration/role/domain/models/role_model.dart';

class SelectRoleWidget extends StatelessWidget {
  const SelectRoleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "role"),
      GetBuilder<RoleController>(initState: (val){
        if(Get.find<RoleController>().roleModel == null){
          Get.find<RoleController>().getRoleList(1);
        }
      },
        builder: (roleController) {
        RoleModel? model = roleController.roleModel;
        List<RoleItem> roles = model?.data?.data ?? [];

        return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: CustomGenericDropdown<RoleItem>(
            title: "select_role",
            items: roles,
            selectedValue: roleController.selectedRoleItem,
            onChanged: (val) {
              roleController.setRoleItem(val!);
            },
            getLabel: (item) => item.name??'',
          ),
        );
      },
      ),
    ],
    );
  }
}