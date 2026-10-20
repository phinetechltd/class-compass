import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:class_compass/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:class_compass/feature/exam_management/exam_startup/presentation/widgets/select_section_widget.dart';
import 'package:class_compass/feature/academic_configuration/group/presentation/widgets/select_group_widget.dart';
import 'package:class_compass/feature/fees_management/waiver/controller/waiver_controller.dart';
import 'package:class_compass/feature/fees_management/waiver_config/presentation/widgets/waiver_config_amount_widget.dart';
import 'package:class_compass/feature/students_information/student/controller/student_controller.dart';
import 'package:class_compass/feature/students_information/student/presentation/widgets/student_list_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class WaiverAssignWidget extends StatelessWidget {
  const WaiverAssignWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaiverController>(builder: (waiverConfigController) {
          return GetBuilder<StudentController>(builder: (studentController) {
              return Column(children: [
                ResponsiveHelper.isDesktop(context)?
                Row(crossAxisAlignment: CrossAxisAlignment.end, spacing: Dimensions.paddingSizeSmall, children: [
                  const Expanded(child: SelectClassWidget()),
                  const Expanded(child: SelectGroupWidget()),
                  const Expanded(child: SelectSectionWidget()),
                  Padding(padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(width: 90, child: CustomButton(onTap: (){

                      int? classId = Get.find<ClassController>().selectedClassItem?.id;
                      int? groupId = Get.find<GroupController>().groupItem?.id;
                      int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                      if(classId == null){
                        showCustomSnackBar("select_class".tr);
                      }else if(groupId == null){
                        showCustomSnackBar("select_group".tr);
                      }else{
                        studentController.getStudentList(classId, groupId:groupId, sectionId:sectionId);
                      }
                    }, text: "process".tr)))
                ]):
                Column( children: [
                    const Row(crossAxisAlignment: CrossAxisAlignment.end, spacing: Dimensions.paddingSizeSmall, children: [
                      Expanded(child: SelectClassWidget()),
                      Expanded(child: SelectGroupWidget()),

                   ]),
                    Row(crossAxisAlignment: CrossAxisAlignment.end, spacing: Dimensions.paddingSizeSmall, children: [
                      const Expanded(child: SelectSectionWidget()),
                      Padding(padding: const EdgeInsets.only(bottom: 8),
                          child: SizedBox(width: 90, child: CustomButton(onTap: (){
                            int? classId = Get.find<ClassController>().selectedClassItem?.id;
                            int? groupId = Get.find<GroupController>().groupItem?.id;
                            int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                            if(classId == null){
                              showCustomSnackBar("select_class".tr);
                            }else{
                              studentController.getStudentList(classId, groupId:groupId, sectionId:sectionId);
                            }
                          }, text: "process")))
                    ]),
                  ],
                ),

                const StudentListWidget(fromWaiver: true),

                Align(alignment: Alignment.centerRight,
                    child: SizedBox(width: 90,
                      child: CustomButton(onTap: (){
                        Get.dialog(CustomDialogWidget(title: "waiver_config".tr,
                            child: const WaiverConfigAmountWidget()));
                      }, text: "process".tr),
                    ))

              ],);
            }
          );
        }
    );
  }
}
