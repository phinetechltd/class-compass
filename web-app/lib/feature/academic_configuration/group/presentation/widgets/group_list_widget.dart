import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:class_compass/feature/academic_configuration/group/domain/model/group_model.dart';
import 'package:class_compass/feature/academic_configuration/group/presentation/widgets/create_new_group_dialog.dart';
import 'package:class_compass/feature/academic_configuration/group/presentation/widgets/group_item.dart';

class GroupListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const GroupListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupController>(
      initState: (val) => Get.find<GroupController>().getGroupList(1),
      builder: (groupController) {
        final groupModel = groupController.groupModel;
        final groupData = groupModel?.data;

        return GenericListSection<GroupItem>(
          sectionTitle: "academic_configuration".tr,
          pathItems: ["group".tr],
          addNewTitle: "add_new_group".tr,
          widget: const SizedBox(width:200, child: SelectClassWidget(title: "empty",)),
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "group".tr,
              child: const CreateNewGroupDialog())),
          headings: const ["group"],

          scrollController: scrollController,
          isLoading: groupModel == null,
          totalSize: groupData?.total ?? 0,
          offset: groupData?.currentPage ?? 0,
          onPaginate: (offset) async =>
          await groupController.getGroupList(offset ?? 1),

          items: groupData?.data ?? [],
          itemBuilder: (item, index) => GroupItemWidget(groupItem: item, index: index),
        );
      },
    );
  }
}