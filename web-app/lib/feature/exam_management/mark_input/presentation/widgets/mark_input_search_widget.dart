import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:class_compass/feature/academic_configuration/group/presentation/widgets/select_group_widget.dart';
import 'package:class_compass/feature/academic_configuration/subject/controller/subject_controller.dart';
import 'package:class_compass/feature/academic_configuration/subject/presentation/widgets/select_subject_widget.dart';
import 'package:class_compass/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:class_compass/feature/exam_management/exam/presentation/widgets/exam_selection_widget.dart';
import 'package:class_compass/feature/exam_management/mark_input/controller/mark_input_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class MarkInputSearchWidget extends StatelessWidget {
  const MarkInputSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<MarkInputController>(
      builder: (markInputController) {
        return Row(crossAxisAlignment: CrossAxisAlignment.end,  spacing : Dimensions.paddingSizeSmall, children: [
          const Expanded(child: SelectClassWidget()),
          const Expanded(child: ExamSelectionWidget()),
          const Expanded(child: SelectGroupWidget()),
          const Expanded(child: SelectSubjectWidget()),

          Padding(padding: const EdgeInsets.only(bottom: 9),
              child: SizedBox(width: 90, child: markInputController.isLoading?
              const Center(child: CircularProgressIndicator()):
              CustomButton(onTap: (){
                int? classId = Get.find<ClassController>().selectedClassItem?.id;
                int? examId = Get.find<ExamController>().selectedExamItem?.id;
                int? groupId = Get.find<GroupController>().groupItem?.id;
                int? subjectId = Get.find<SubjectController>().selectedSubjectItem?.id;
                if (classId == null){
                  showCustomSnackBar("select_class".tr);
                }
                else if(examId == null){
                  showCustomSnackBar("select_exam".tr);
                }
                else if(groupId == null){
                  showCustomSnackBar("select_group".tr);
                }
                else if(subjectId == null){
                  showCustomSnackBar("select_subject".tr);
                }
                else{
                  markInputController.markInputGet(classId, examId, groupId, subjectId);
                }
              }, text: "search".tr)))
        ],);
      }
    );
  }
}
