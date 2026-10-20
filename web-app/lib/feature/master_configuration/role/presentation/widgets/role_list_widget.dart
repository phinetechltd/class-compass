import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/master_configuration/role/controller/role_controller.dart';
import 'package:class_compass/feature/master_configuration/role/domain/models/role_model.dart';
import 'package:class_compass/feature/master_configuration/role/presentation/widgets/create_new_role_widget.dart';
import 'package:class_compass/feature/master_configuration/role/presentation/widgets/role_item.dart';

class RoleListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const RoleListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoleController>(
      initState: (val) => Get.find<RoleController>().getRoleList(1),
      builder: (roleController) {
        final roleModel = roleController.roleModel;
        final roleData = roleModel?.data;

        return GenericListSection<RoleItem>(
          sectionTitle: "master_configuration".tr,
          pathItems: ["role_list".tr],
          addNewTitle: "add".tr,
          onAddNewTap: () => Get.dialog(const Dialog(child: CreateNewRoleWidget())),
          headings: const ["name"],

          scrollController: scrollController,
          isLoading: roleModel == null,
          totalSize: roleData?.total ?? 0,
          offset: roleData?.currentPage ?? 0,
          onPaginate: (offset) async => await roleController.getRoleList(offset ?? 1),

          items: roleData?.data ?? [],
          itemBuilder: (item, index) => RoleItemWidget(roleItem: item, index: index),
        );
      },
    );
  }
}
