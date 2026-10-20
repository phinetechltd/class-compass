import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/course_dropdown.dart';

class SelectCourseWidget extends StatefulWidget {
  final String? title;
  const SelectCourseWidget({super.key, this.title});

  @override
  State<SelectCourseWidget> createState() => _SelectCourseWidgetState();
}

class _SelectCourseWidgetState extends State<SelectCourseWidget> {
  @override
  void initState() {
    if(Get.find<CourseController>().courseModel == null) {
      Get.find<CourseController>().getCourse(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if(widget.title != "")
      const CustomTitle(title: "course"),
      GetBuilder<CourseController>(
          builder: (courseController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CourseDropdown(width: Get.width, title: "select_course".tr,
                items: courseController.courseModel?.data?.data??[],
                selectedValue:  courseController.selectedCourseItem,
                onChanged: (val){
                  courseController.setSelectCourseItem(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
