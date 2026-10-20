import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_generic_dropdown.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/students_information/student/controller/student_controller.dart';
import 'package:class_compass/feature/students_information/student/domain/model/student_model.dart';



class SelectStudentWidget extends StatelessWidget {
  const SelectStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const CustomTitle(title: "student"),
        GetBuilder<StudentController>(builder: (studentController) {
            final studentModel = studentController.studentModel;
            List<StudentItem> students = studentModel?.data?.data ?? [];

            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomGenericDropdown<StudentItem>(
                title: "select_student",
                items: students,
                selectedValue: studentController.selectedStudentItem,
                onChanged: (val) {
                  studentController.setSelectedStudent(val!);
                },
                getLabel: (item) => item.name ?? '',
              ),
            );
          },
        ),
      ],
    );
  }
}
