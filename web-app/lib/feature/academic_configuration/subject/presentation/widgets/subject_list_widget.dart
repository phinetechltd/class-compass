import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/subject/controller/subject_controller.dart';
import 'package:class_compass/feature/academic_configuration/subject/domain/model/subject_model.dart';
import 'package:class_compass/feature/academic_configuration/subject/presentation/widgets/add_new_subject_widget.dart';
import 'package:class_compass/feature/academic_configuration/subject/presentation/widgets/subject_item_widget.dart';

class SubjectListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const SubjectListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectController>(
      initState: (val) => Get.find<SubjectController>().getSubjectList(1),
      builder: (subjectController) {
        final subjectModel = subjectController.subjectModel;
        final subjectData = subjectModel?.data;

        return GenericListSection<SubjectItem>(
          sectionTitle: "academic_configuration".tr,
          pathItems: ["subject_list".tr],
          addNewTitle: "add_new_subject".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(
            title: "subject".tr,
              child: const AddNewSubjectWidget())),
          headings: const ["name", "code", "class", "full_mark", "pass_mark",],
          widget: const SizedBox(width: 200, child: SelectClassWidget(title: "empty",)),
          scrollController: scrollController,
          isLoading: subjectModel == null,
          totalSize:  0,
          offset: 1,
          onPaginate: (offset) async => await subjectController.getSubjectList(offset ?? 1),

          items: subjectData?.data ?? [],
          itemBuilder: (item, index) => SubjectItemWidget(index: index, subjectItem: item),
        );
      },
    );
  }
}