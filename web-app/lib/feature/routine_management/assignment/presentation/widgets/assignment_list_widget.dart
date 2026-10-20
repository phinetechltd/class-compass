import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/routine_management/assignment/controller/assignment_controller.dart';
import 'package:class_compass/feature/routine_management/assignment/domain/models/assignment_model.dart';
import 'package:class_compass/feature/routine_management/assignment/presentation/widgets/assignment_item_widget.dart';
import 'package:class_compass/feature/routine_management/assignment/presentation/widgets/create_new_assignment_widget.dart';

class AssignmentListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const AssignmentListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssignmentController>(
      initState: (state) => Get.find<AssignmentController>().getAssignmentList(1),
      builder: (assignmentController) {
        final assignmentModel = assignmentController.assignmentModel;
        final assignmentData = assignmentModel?.data;
        return GenericListSection<AssignmentItem>(
          sectionTitle: "routine_management".tr,
          pathItems: [ "assignment".tr],
          addNewTitle: "add_new_assignment".tr,
          onAddNewTap: () => Get.dialog(
             CustomDialogWidget(title: "assignment".tr,
                child: const CreateNewAssignmentWidget())),
          headings: const ["file", "assignment", "description", "deadline", "class", "section", "subject"],
          scrollController: scrollController,
          isLoading: assignmentModel == null,
          totalSize: assignmentData?.total ?? 0,
          offset: assignmentData?.currentPage ?? 0,
          onPaginate: (offset) async =>
          await assignmentController.getAssignmentList(offset ?? 1),
          items: assignmentData?.data ?? [],
          itemBuilder: (item, index) => AssignmentItemWidget(index: index, assignmentItem: item),
        );
      },
    );
  }
}
