import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/common/widget/heading_menu_widget.dart';
import 'package:class_compass/common/widget/no_data_found.dart';
import 'package:class_compass/feature/fees_management/waiver_config/presentation/widgets/waiver_stident_item_widget.dart';
import 'package:class_compass/feature/students_information/student/controller/student_controller.dart';
import 'package:class_compass/feature/students_information/student/presentation/widgets/student_item.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class StudentListWidget extends StatelessWidget {
  final bool fromWaiver;
  const StudentListWidget({super.key, this.fromWaiver = false});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<StudentController>(
        builder: (studentController) {
          var student = studentController.studentModel?.data;
          return Column(children: [
            if(ResponsiveHelper.isDesktop(context))...[
              (fromWaiver)?
              const HeadingMenu(headings: ["image", "roll",  "name"]):
              const HeadingMenu(headings: ["image", "roll", "reg_no", "name", "phone", "gender", "guardian", "status",]),
            ],
            studentController.studentModel != null? (studentController.studentModel!.data!= null
                && studentController.studentModel?.data?.data?.isNotEmpty == true)?
            ListView.separated(
                itemCount: student?.data?.length??0,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return fromWaiver?
                  WaiverStudentItemWidget(index: index, studentItem: student?.data?[index]):
                  StudentItemWidget(index: index, studentItem: student?.data?[index],);
                }, separatorBuilder: (BuildContext context, int index) {
                  return ResponsiveHelper.isDesktop(context)? const CustomDivider() :
                  const SizedBox(height: Dimensions.paddingSizeSmall);
            },):
            Padding(padding: ThemeShadow.getPadding(),
                child: const Center(child: NoDataFound())):
            const SizedBox(),
          ],);
        }
    );
  }
}
