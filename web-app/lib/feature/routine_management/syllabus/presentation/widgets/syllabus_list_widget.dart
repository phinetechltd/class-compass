import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/routine_management/syllabus/controller/syllabus_controller.dart';
import 'package:class_compass/feature/routine_management/syllabus/domain/models/syllabus_model.dart';
import 'package:class_compass/feature/routine_management/syllabus/presentation/widgets/syllabus_item_widget.dart';
import 'package:class_compass/feature/routine_management/syllabus/presentation/widgets/create_new_syllabus_widget.dart';

class SyllabusListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const SyllabusListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SyllabusController>(
      initState: (state) => Get.find<SyllabusController>().getSyllabusList(1),
      builder: (syllabusController) {
        final syllabusModel = syllabusController.syllabusModel;
        final syllabusData = syllabusModel?.data;
        return GenericListSection<SyllabusItem>(
          sectionTitle: "routine_management".tr,
          pathItems: ["syllabus".tr],
          addNewTitle: "add_new_syllabus".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(
            title: "syllabus".tr,
              child: const CreateNewSyllabusWidget())),
          headings: const ["file","name", "description"],
          scrollController: scrollController,
          isLoading: syllabusModel == null,
          totalSize: syllabusData?.total ?? 0,
          offset: syllabusData?.currentPage ?? 0,
          onPaginate: (offset) async => await syllabusController.getSyllabusList(offset ?? 1),
          items: syllabusData?.data ?? [],
          itemBuilder: (item, index) => SyllabusItemWidget(index: index, syllabusItem: item),
        );
      },
    );
  }
}
