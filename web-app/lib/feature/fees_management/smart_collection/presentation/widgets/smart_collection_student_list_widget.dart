import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:class_compass/feature/fees_management/smart_collection/controller/smart_collection_controller.dart';
import 'package:class_compass/feature/fees_management/smart_collection/presentation/widgets/smart_collection_search_widget.dart';
import 'package:class_compass/feature/fees_management/smart_collection/presentation/widgets/smart_collection_student_item.dart';
import 'package:class_compass/feature/fees_management/smart_collection/domain/model/smart_collection_model.dart';

class SmartCollectionStudentListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const SmartCollectionStudentListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartCollectionController>(
      builder: (smartCollectionController) {
        final smartCollectionModel = smartCollectionController.smartCollectionModel;
        final studentData = smartCollectionModel?.data?.students;
        int? classId = Get.find<ClassController>().selectedClassItem?.id;
        int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
        return GenericListSection<StudentItem>(
          sectionTitle: "fees_management".tr,
          pathItems: ["smart_collection".tr, ],
          topWidget: const SmartCollectionSearchWidget(),
          headings: const ["id", "roll", "name", "class", "group"],
          scrollController: scrollController,
          isLoading: false,
          totalSize: studentData?.total ?? 0,
          offset: studentData?.currentPage ?? 0,
          onPaginate: (offset) async => await smartCollectionController.getStudentListForSmartCollection(classId!, sectionId!, offset ?? 1),
          items: studentData?.data ?? [],
          itemBuilder: (item, index) => SmartCollectionStudentItemWidget(index: index, studentItem: item),

        );
      },
    );
  }
}
