import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/domain/model/class_model.dart';
import 'package:class_compass/feature/exam_management/mark_config/presentation/widgets/grand_final_exam_item.dart';

class GrandFinalWidget extends StatelessWidget {
  final ScrollController scrollController;
  const GrandFinalWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClassController>(
      initState: (val) => Get.find<ClassController>().getClassList(page: 1),
      builder: (classController) {
        final classModel = classController.classModel;
        final classData = classModel?.data;

        return GenericListSection<ClassItem>(
          showRouteSection: false,
          sectionTitle: "exam_management".tr,
          pathItems: ["grand_final_exam".tr],
          headings: const ["name",],
          scrollController: scrollController,
          isLoading: classData == null,
          totalSize: classData?.total ?? 0,
          offset: classData?.currentPage ?? 0,
          onPaginate: (offset) async => await classController.getClassList(page: offset ?? 1),
          items: classData?.data ?? [],
          itemBuilder: (item, index) => GrandFinalExamItemWidget(index: index, examItem: item));
      },
    );
  }
}
