import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:class_compass/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:class_compass/feature/academic_configuration/subject/controller/subject_controller.dart';
import 'package:class_compass/feature/academic_configuration/subject/presentation/widgets/select_subject_widget.dart';
import 'package:class_compass/feature/routine_management/class_routine/domain/models/class_routine_body.dart';
import 'package:class_compass/feature/routine_management/class_routine/logic/class_routine_controller.dart';
import 'package:class_compass/feature/routine_management/class_routine/presentation/widgets/select_day_widget.dart';
import 'package:class_compass/feature/staff_information/teacher/controller/teacher_controller.dart';
import 'package:class_compass/feature/staff_information/teacher/presentation/widgets/teacher_selection_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class AddNewClassRoutineWidget extends StatelessWidget {
  const AddNewClassRoutineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClassRoutineController>(
      builder: (classRoutineController) {
        return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(spacing: Dimensions.paddingSizeDefault,mainAxisSize: MainAxisSize.min, children: [
            const Row(spacing: Dimensions.paddingSizeDefault, children: [
              Expanded(child: SelectClassWidget()),
              Expanded(child: SelectSectionWidget()),
            ],),
            const Row(spacing: Dimensions.paddingSizeDefault, children: [
              Expanded(child: SelectSubjectWidget()),
              Expanded(child: SelectTeacherWidget()),
            ],),

            Row(spacing: Dimensions.paddingSizeDefault, children: [
              const Expanded(child: SelectDayWidget()),
              Expanded(
                child: Row(children: [
                  Expanded(child: InkWell(onTap: ()=> classRoutineController.pickTime(),
                      child: CustomTextField(title: "start_time".tr,
                          isEnabled : false,
                          suffix: const Icon(Icons.access_time, size: 20),
                          hintText: classRoutineController.formatTimeForDisplay(
                            classRoutineController.selectedTime,
                          )))),
                  const SizedBox(width: Dimensions.paddingSizeSmall),

                  Expanded(child: InkWell(onTap: ()=> classRoutineController.pickTime(checkOut: true),
                      child: CustomTextField(title: "end_time".tr,
                          isEnabled : false,
                          suffix: const Icon(Icons.access_time, size: 20),
                          hintText: classRoutineController.formatTimeForDisplay(
                            classRoutineController.selectedCheckoutTime,
                          ))))],
                ),
              ),


            ],),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            Align(alignment: Alignment.centerRight,
              child: SizedBox(width: 100,
                child: CustomButton(onTap: (){
                  int? classId = Get.find<ClassController>().selectedClassItem?.id;
                  int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                  int? subjectId = Get.find<SubjectController>().selectedSubjectItem?.id;
                  int? teacherId = Get.find<TeacherController>().selectedTeacherItem?.id;
                  String? day = classRoutineController.selectedDay;
                  String? startTime = classRoutineController.formatTimeForApi(classRoutineController.selectedTime);
                  String? endTime = classRoutineController.formatTimeForApi(classRoutineController.selectedCheckoutTime);

                  if(classId == null){
                    showCustomSnackBar("select_class".tr);
                  }
                  else if(sectionId == null){
                    showCustomSnackBar("select_section".tr);
                  }
                  else if(subjectId == null){
                    showCustomSnackBar("select_subject".tr);
                  }
                  else if(teacherId == null){
                    showCustomSnackBar("select_teacher".tr);
                  }

                  else{
                    Get.back();
                    ClassRoutineBody body = ClassRoutineBody(
                      routine: [
                        Routine(classId: classId,
                          sectionId: sectionId,
                          subjectId: subjectId,
                          teacherId: teacherId, day: day,
                          startTime: startTime,
                          endTime: endTime,
                    )]);
                    classRoutineController.addNewClassRoutine(body);
                  }



                }, text: "submit".tr),
              ),
            )
          ]),
        );
      }
    );
  }
}
