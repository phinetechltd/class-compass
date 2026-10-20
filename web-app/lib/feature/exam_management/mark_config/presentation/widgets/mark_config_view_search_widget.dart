import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:class_compass/feature/academic_configuration/group/presentation/widgets/select_group_widget.dart';
import 'package:class_compass/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:class_compass/feature/exam_management/exam/presentation/widgets/exam_selection_widget.dart';
import 'package:class_compass/feature/exam_management/mark_config/controller/mark_config_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class MarkConfigViewSearchWidget extends StatelessWidget {
  const MarkConfigViewSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarkConfigController>(
      builder: (markConfigController) {
        return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end,spacing: Dimensions.paddingSizeSmall, children: [
            const Expanded(child: SelectClassWidget()),
            const Expanded(child: SelectGroupWidget()),
            const Expanded(child: ExamSelectionWidget()),
            SizedBox(width: 90, child: Padding(padding: const EdgeInsets.only(bottom: 8.0),
                child: markConfigController.isLoading?
                    const Center(child: CircularProgressIndicator()):
                CustomButton(onTap: (){
                  int? classId = Get.find<ClassController>().selectedClassItem?.id;
                  int? groupId = Get.find<GroupController>().groupItem?.id;
                  int? examId = Get.find<ExamController>().selectedExamItem?.id;
                  if(classId == null){
                    showCustomSnackBar("select_class".tr);
                  }
                  else if(groupId == null){
                    showCustomSnackBar("select_group".tr);
                  }
                  else if(examId == null){
                    showCustomSnackBar("select_exam".tr);
                  }else{
                    Get.find<MarkConfigController>().getMarkViewReport(classId, groupId, examId);
                  }
                }, text: "search".tr)))
          ]),
        );
      }
    );
  }
}
