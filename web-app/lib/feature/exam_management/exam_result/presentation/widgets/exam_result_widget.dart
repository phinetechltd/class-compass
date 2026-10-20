import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/exam_management/exam_result/controller/exam_result_controller.dart';
import 'package:class_compass/feature/exam_management/exam_result/domain/models/exam_result_model.dart';
import 'package:class_compass/feature/exam_management/exam_result/presentation/widgets/exam_result_item_widget.dart';
import 'package:class_compass/feature/exam_management/exam_result/presentation/widgets/exam_result_search_widget.dart';

class ExamResultWidget extends StatelessWidget {
  final ScrollController scrollController;
  const ExamResultWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamResultController>(
      builder: (examResultController) {
        ExamResultModel? examResultModel = examResultController.examResultModel;
        var examResult = examResultModel?.data;
        return Column(children: [
          GenericListSection<ExamResultItem>(
            topWidget: const ExamResultSearchWidget(),
            sectionTitle: "exam_management".tr,
            pathItems: ["result".tr],
            showAction: false,
            headings: const ["exam_name", "student_name","grade_point", "grade","total_marks"],

            scrollController: scrollController,
            isLoading: false,
            totalSize:  0,
            offset:  1,
            onPaginate: (offset) async => await examResultController.getExamResult(1),

            items: examResult ?? [],
            itemBuilder: (item, index) => ExamResultItemWidget(index: index, resultItem: item),
          ),
        ],);
      }
    );
  }
}
