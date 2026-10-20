import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:class_compass/feature/exam_management/exam_startup/controller/exam_startup_controller.dart';
import 'package:class_compass/feature/exam_management/exam_startup/domain/model/exam_assign_store_body.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class ExamAssignSubmitButtonWidget extends StatelessWidget {
  const ExamAssignSubmitButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamStartupController>(
      builder: (examStartupController) {
        return GetBuilder<ExamController>(
          builder: (examController) {
            return Align(alignment: Alignment.centerRight,
                child: CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
                  onTap: (){

                    int? classId = Get.find<ClassController>().selectedClassItem?.id;

                    List<String> selectedExams = [];
                    if(examController.selectedExamList.isNotEmpty){
                      selectedExams = examController.selectedExamList.map((e) => e.id!.toString()).toList();
                    }

                    if(classId == null){
                      showCustomSnackBar("select_class".tr);
                    }
                    else if(selectedExams.isEmpty){
                      showCustomSnackBar("select_exam".tr);
                    }
                    else if(examStartupController.selectedMeritProcessType == null){
                      showCustomSnackBar("select_merit_process_type".tr);
                    }
                    else{
                      ExamAssignStoreBody body = ExamAssignStoreBody(classId: classId.toString(), examIds: selectedExams, meritProcessTypeId:examStartupController.selectedMeritProcessType?.id.toString());
                      examStartupController.examAssignStore(body);
                    }
                  },
                  horizontalPadding: 20,
                  color: systemPrimaryColor(),
                  child: examStartupController.isLoading?
                  const Center(child: CircularProgressIndicator()):
                  Text("confirm".tr, style: textRegular.copyWith(color: Colors.white)),));
          }
        );
      }
    );
  }
}
