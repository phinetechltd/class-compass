import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/no_data_found.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:class_compass/feature/academic_configuration/subject/controller/subject_controller.dart';
import 'package:class_compass/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:class_compass/feature/exam_management/mark_input/controller/mark_input_controller.dart';
import 'package:class_compass/feature/exam_management/mark_input/domain/models/mark_input_body.dart';
import 'package:class_compass/feature/exam_management/mark_input/domain/models/mark_input_model.dart';
import 'package:class_compass/feature/exam_management/mark_input/presentation/widgets/mark_input_card_widget.dart';
import 'package:class_compass/feature/exam_management/mark_input/presentation/widgets/mark_input_search_widget.dart';
import 'package:class_compass/feature/exam_management/mark_input/presentation/widgets/mark_input_student_card_widget.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class MarkInputWidget extends StatelessWidget {
  final ScrollController scrollController;
  const MarkInputWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        SectionHeaderWithPath(sectionTitle: "exam_management".tr, pathItems: ["mark_input".tr],),
        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: CustomContainer(
            child: GetBuilder<MarkInputController>(builder: (markInputController) {
                MarkInputModel? markInputModel = markInputController.markInputModel;
                var markInputItem = markInputModel?.data;
                return Column(spacing: Dimensions.paddingSizeSmall, children: [


                  const MarkInputSearchWidget(),

                  if(markInputModel != null &&  markInputModel.data!= null)
                  GenericListSection<MarkConfig>(showRouteSection: false,
                    sectionTitle: "mark_input_list".tr,
                    scrollController: scrollController,
                    isLoading: false,
                    totalSize: 0,
                    offset: 1,
                    onPaginate: (int? page) async {},
                    showAction: false,
                    headings: const ["exam_code_title", "total", "pass_mark", "acceptance"],
                    items: markInputItem?.markConfig,
                    itemBuilder: (item, index) => MarkInputCardWidget(markConfig: item, index: index),
                  ),



                  if (markInputModel != null) ...[
                    CustomContainer(color: systemPrimaryColor().withValues(alpha: .2),
                      verticalPadding: Dimensions.paddingSizeDefault,borderRadius: 5,
                      child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                        SizedBox(width: 50, child: CustomItemTextWidget(text: 'sl'.tr)),
                           Expanded(child: CustomItemTextWidget(text: 'roll'.tr)),
                           Expanded(child: CustomItemTextWidget(text: 'name'.tr)),
                          ...((markInputModel.data?.markConfig ?? []).map(
                                (config) => SizedBox(width: 90,
                              child: CustomItemTextWidget(text: config.markConfigExamCode?.title ?? 'Exam')))),
                        ]),
                    ),
                  ],

                  markInputModel != null? (markInputModel.data!= null && markInputModel.data!.students!.isNotEmpty)?
                  ListView.builder(
                      itemCount: markInputItem?.students?.length??0,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return MarkInputStudentCardWidget(students: markInputItem?.students?[index], index: index,
                          markConfigItem: markInputItem,);
                      }) :
                  const Padding(padding: EdgeInsets.only(top: 100),
                      child: Center(child: NoDataFound())):

                  const SizedBox(),

                  if(markInputModel != null && markInputModel.data!= null && markInputModel.data!.students!.isNotEmpty)
                  Align(alignment: Alignment.centerRight, child: SizedBox(width: 100,
                      child: markInputController.isLoading?
                      const Center(child: CircularProgressIndicator()):
                      CustomButton(onTap: (){
                    int? classId = Get.find<ClassController>().selectedClassItem?.id;
                    int? groupId = Get.find<GroupController>().groupItem?.id;
                    int? subjectId = Get.find<SubjectController>().selectedSubjectItem?.id;
                    int? examId = Get.find<ExamController>().selectedExamItem?.id;

                    final List<Marks> marksList = [];
                    if (markInputController.markInputModel?.data?.students != null &&
                        markInputController.markInputModel?.data?.markConfig != null) {

                      for (var student in markInputController.markInputModel!.data!.students!) {
                        final Map<int, String> studentMarks = {};

                        for (var markConfig in markInputController.markInputModel!.data!.markConfig!) {
                          final examCodeId = markConfig.markConfigExamCode?.id ?? 0;
                          final key = '${student.id}_$examCodeId';
                          final controller = markInputController.markControllers[key];

                          if (controller != null) {
                            studentMarks[examCodeId] = controller.text;
                          }
                        }

                        marksList.add(Marks(
                          studentId: student.id,
                          mark1: studentMarks.values.isNotEmpty ? studentMarks.values.elementAt(0) : null,
                          mark2: studentMarks.values.length > 1 ? studentMarks.values.elementAt(1) : null,
                          mark3: studentMarks.values.length > 2 ? studentMarks.values.elementAt(2) : null,
                          mark4: studentMarks.values.length > 3 ? studentMarks.values.elementAt(3) : null,
                          mark5: studentMarks.values.length > 4 ? studentMarks.values.elementAt(4) : null,
                          mark6: studentMarks.values.length > 5 ? studentMarks.values.elementAt(5) : null,
                        ));
                      }
                    }
                    MarkInputBody body = MarkInputBody(
                      classId: classId,
                      groupId: groupId,
                      subjectId: subjectId,
                      examId: examId,
                      marks: marksList,
                    );

                    markInputController.markInput(body);




                  }, text: "Save".tr)))

                ],);
              }
            ),
          ),
        ),
      ],
    );
  }
}

class DynamicMarks {
  int? studentId;
  Map<int, String> marks; // key: examCodeId, value: mark

  DynamicMarks({this.studentId, required this.marks});

  Map<String, dynamic> toJson() {
    final data = {'student_id': studentId};
    marks.forEach((examCodeId, value) {
      data['mark_$examCodeId'] = int.parse(value);
    });
    return data;
  }
}