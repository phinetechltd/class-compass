import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/responsive_grid_widget.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:class_compass/feature/branch/controller/branch_controller.dart';
import 'package:class_compass/feature/branch/presentation/widgets/branch_change_widget.dart';
import 'package:class_compass/feature/students_information/student/controller/student_controller.dart';
import 'package:class_compass/feature/students_information/student/presentation/widgets/select_student_widget.dart';
import 'package:class_compass/feature/students_information/student_migration/controller/student_migration_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:get/get.dart';

class StudentBranchMigrationWidget extends StatefulWidget {
  const StudentBranchMigrationWidget({super.key});

  @override
  State<StudentBranchMigrationWidget> createState() => _StudentBranchMigrationWidgetState();
}

class _StudentBranchMigrationWidgetState extends State<StudentBranchMigrationWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentMigrationController>(builder: (controller) {
        return CustomContainer(verticalPadding: Dimensions.paddingSizeDefault,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Dimensions.paddingSizeDefault, children: [
             ResponsiveMasonryGrid(width: 300,children: [
              const SelectClassWidget(),
              const SelectSectionWidget(),
              const SelectStudentWidget(),
              ChangeBranchWidget(change: false, title: "branch".tr),
            ]),

            controller.isLoading? const Center(child: CircularProgressIndicator()):
            CustomButton(onTap: (){
              int? studentId = Get.find<StudentController>().selectedStudentItem?.id;
              int? branchId = Get.find<BranchController>().selectedBranchItem?.id;

              if(studentId == null){
                showCustomSnackBar("select_student".tr);
              }else if(branchId == null){
                showCustomSnackBar("select_branch".tr);
              }else{
                controller.studentBranchMigration(studentId, branchId);
              }
            }, text: "confirm".tr)
          ]),
        );
      }
    );
  }
}
