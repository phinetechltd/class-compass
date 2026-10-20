import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/parent_module/parent_exam/controller/parent_exam_controller.dart';
import 'package:class_compass/feature/parent_module/parent_exam/domain/model/parent_exam_model.dart';
import 'package:class_compass/feature/parent_module/parent_exam/presentation/widgets/parent_exam_item_widget.dart';

class ParentExamScreen extends StatelessWidget {
  const ParentExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(appBar: CustomAppBar(title: "exams".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: GetBuilder<ParentExamController>(
          initState: (_) => Get.find<ParentExamController>().getExamList(),
          builder: (examController) {
            final examModel = examController.examModel;
            final exams = examModel?.data ?? [];

            return GenericListSection<ParentExamItem>(
              sectionTitle: "exams".tr,
              showAction: false,
              headings: const ["exam_name","result_type", "position","result"],
              scrollController: scrollController,
              isLoading: examModel == null,
              totalSize:0,
              offset: 1,
              onPaginate: (offset) async {
                await examController.getExamList();
              },
              items: exams,
              itemBuilder: (item, index) => ParentExamItemWidget(index: index, examItem: item));
              },
            ),
          ),
        ],
      ),
    );
  }
}
