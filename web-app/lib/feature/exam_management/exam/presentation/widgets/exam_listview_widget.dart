import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:class_compass/feature/exam_management/exam/presentation/widgets/create_new_exam_dialog.dart';
import 'package:class_compass/feature/exam_management/exam/presentation/widgets/exam_card_widget.dart';
import 'package:class_compass/feature/exam_management/exam/domain/model/exam_model.dart';
  class ExamListviewWidget extends StatelessWidget {
    final ScrollController scrollController;
    const ExamListviewWidget({super.key, required this.scrollController});

    @override
    Widget build(BuildContext context) {
      return GetBuilder<ExamController>(
        initState: (val) => Get.find<ExamController>().getExamList(1),
        builder: (examController) {
          final examModel = examController.examModel;
          final examData = examModel?.data;

          return GenericListSection<ExamItem>(
            sectionTitle: "exam_management".tr,
            pathItems: ["exam".tr],
            addNewTitle: "add_new_exam".tr,
            onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "exam".tr,
                child: const CreateNewExamDialog())),
            headings: const ["name"],
            scrollController: scrollController,
            isLoading: examModel == null,
            totalSize: examData?.total ?? 0,
            offset: examData?.currentPage ?? 1,
            onPaginate: (offset) async => await examController.getExamList(offset ?? 1),
            items: examData?.data ?? [],
            itemBuilder: (item, index) => ExamCardWidget(examItem: item, index: index),
          );
        },
      );
    }
  }