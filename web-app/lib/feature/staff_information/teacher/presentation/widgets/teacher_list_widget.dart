import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/staff_information/staff/domain/models/staff_model.dart';
import 'package:class_compass/feature/staff_information/teacher/controller/teacher_controller.dart';
import 'package:class_compass/feature/staff_information/teacher/presentation/widgets/add_new_teacher_widget.dart';
import 'package:class_compass/feature/staff_information/teacher/presentation/widgets/teacher_item.dart';

import '../../domain/model/teacher_model.dart';


class TeacherListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const TeacherListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeacherController>(
      initState: (val) => Get.find<TeacherController>().getTeacherList(1),
      builder: (teacherController) {
        TeacherModel? teacherModel = teacherController.teacherModel;
        final teacherData = teacherModel?.data;
        return GenericListSection<StaffItem>(
          sectionTitle: "staff_information".tr,
          pathItems: ["teacher_list".tr],
          addNewTitle: "add_new_teacher".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "teacher".tr,width: 900,
              child: const AddNewTeacherWidget(fromStaff: false))),
          headings: const ["image", "name", "phone", "email", "designation"],
          scrollController: scrollController,
          isLoading: teacherModel == null,
          totalSize: teacherData?.total ?? 0,
          offset: teacherData?.currentPage ?? 0,
          onPaginate: (offset) async =>
          await teacherController.getTeacherList(offset ?? 1),
          items: teacherData?.data ?? [],
          itemBuilder: (item, index) => TeacherItemWidget(index: index, teacherItem: item),
        );
      },
    );
  }
}
