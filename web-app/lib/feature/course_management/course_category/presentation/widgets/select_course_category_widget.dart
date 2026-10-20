import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/course_management/course_category/logic/course_category_controller.dart';
import 'package:class_compass/feature/course_management/course_category/presentation/widgets/course_category_dropdown.dart';

class SelectCourseCategoryWidget extends StatefulWidget {
  final String? title;
  final String? hint;
  const SelectCourseCategoryWidget({super.key, this.title, this.hint});

  @override
  State<SelectCourseCategoryWidget> createState() => _SelectCourseCategoryWidgetState();
}

class _SelectCourseCategoryWidgetState extends State<SelectCourseCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
       CustomTitle(title: widget.title?? "course_category"),
      GetBuilder<CourseCategoryController>(
        initState: (val) => Get.find<CourseCategoryController>().getCourseCategory(1),
          builder: (courseCategoryController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CourseCategoryDropdown(width: Get.width, title: widget.hint?? "select".tr,
                items: courseCategoryController.courseCategoryModel?.data?.data??[],
                selectedValue:  courseCategoryController.selectedCourseCategoryItem,
                onChanged: (val){
                courseCategoryController.setSelectCourseCategoryItem(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
