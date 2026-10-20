import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_model.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/course_item_widget.dart';
import 'package:class_compass/helper/route_helper.dart';

class CourseListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const CourseListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(
      initState: (val) => Get.find<CourseController>().getCourse(1),
      builder: (courseController) {
        final courseModel = courseController.courseModel;
        final courseData = courseModel?.data;
        return GenericListSection<CourseItem>(
          sectionTitle: "course_management".tr,
          pathItems: ["courses".tr],
          addNewTitle: "add_new_course".tr,
          onAddNewTap: () {
            Get.toNamed(RouteHelper.getAddNewCourseRoute());
          },
          headings: const ["image","title", "category",  "author", "price", "date", "course_status",],
          scrollController: scrollController,
          isLoading: courseModel == null,
          totalSize: courseData?.total ?? 0,
          offset: courseData?.currentPage ?? 0,
          onPaginate: (offset) async => await courseController.getCourse(offset ?? 1),
          items: courseData?.data ?? [],
          itemBuilder: (item, index) => CourseItemWidget(index: index, courseItem: item),
        );
      },
    );
  }
}
