import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:class_compass/feature/exam_management/mark_config/controller/mark_config_controller.dart';
import 'package:class_compass/feature/exam_management/mark_config/domain/model/general_exam_store_body.dart';
import 'package:class_compass/util/dimensions.dart';
class ExamCodeListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const ExamCodeListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarkConfigController>(
      builder: (markConfigController) {
        List<ExamCodeBody>? examCodes = markConfigController.examCodeBodyList;
        return Column(children: [
            GenericListSection<ExamCodeBody>(
              showRouteSection: false,
              sectionTitle: "exam_code".tr,
              headings: const ["title", "total_mark", "pass_mark", "accept_percent",],
              scrollController: scrollController,
              isLoading: examCodes == null,
              totalSize: examCodes?.length??0,
              offset: 1,
              onPaginate: (offset) async {},
              items: examCodes ?? [],
              itemBuilder: (item, index) => ExamCodeItemWidget(index: index, examCodeItem: item)),

          Align(alignment: Alignment.centerRight,
              child: IntrinsicWidth(child: CustomButton(width: 100, onTap: (){

                int? classId = Get.find<ClassController>().selectedClassItem?.id;
                int? groupId = Get.find<GroupController>().groupItem?.id;
                List<String>? selectedSubjects = [];
                List<ExamCodes>? examCodeList = [];
                List<String>? selectedExams = [];
                for(int i = 0; i < examCodes!.length; i++){
                  examCodeList.add(ExamCodes(
                    title: examCodes[i].title?.text,
                    totalMarks: examCodes[i].totalMarks?.text,
                    passMark: examCodes[i].passMark?.text,
                    acceptance: examCodes[i].acceptance?.text,
                  ));
                }

                selectedSubjects = markConfigController.generalExamModel?.data?.subjects
                    ?.where((subject) => subject.isSelected == true) // only selected
                    .map((subject) => subject.id?.toString() ?? "")
                    .toList()
                    ?? [];

                selectedExams = markConfigController.generalExamModel?.data?.classExams
                    ?.where((exam) => exam.selected == true) // only selected
                    .map((exam) => exam.exam?.id?.toString() ?? "")
                    .toList()
                    ?? [];


                if(classId == null){
                  showCustomSnackBar("select_class".tr);
                }
                else if(groupId == null){
                  showCustomSnackBar("select_group".tr);
                }
                else if(examCodeList.isEmpty){
                  showCustomSnackBar("no_exam_code_added".tr);
                }
                else if(selectedSubjects.isEmpty){
                  showCustomSnackBar("no_subject_selected".tr);
                }
                else if(selectedExams.isEmpty){
                  showCustomSnackBar("no_exam_selected".tr);
                }
                else{
                  GeneralExamStoreBody generalExamStoreBody = GeneralExamStoreBody(
                    classId: classId.toString(),
                    groupId: groupId.toString(),
                    selectedSubjects: selectedSubjects,
                    examCodes: examCodeList,
                    selectedExams: selectedExams,
                  );
                  markConfigController.storeGeneralExam(generalExamStoreBody);
                }



              }, text: "save".tr)))


          ],
        );
      },
    );
  }
}

class ExamCodeItemWidget extends StatelessWidget {
  final int index;
  final ExamCodeBody? examCodeItem;
  const ExamCodeItemWidget({super.key, required this.index, this.examCodeItem});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault,children: [
      NumberingWidget(index: index),
      Expanded(child: CustomTextField(controller: examCodeItem?.title)),
      Expanded(child: CustomTextField(controller: examCodeItem?.totalMarks)),
      Expanded(child: CustomTextField(controller: examCodeItem?.passMark)),
      Expanded(child: CustomTextField(controller: examCodeItem?.acceptance)),
      IconButton(onPressed: (){
        Get.find<MarkConfigController>().removeExamCode(index);
      }, icon: const Icon(Icons.clear))


    ]);
  }
}
