import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/course_management/course_category/logic/course_category_controller.dart';
import 'package:class_compass/feature/course_management/course_category/domain/model/course_category_model.dart';
import 'package:class_compass/feature/course_management/course_category/presentation/widgets/course_category_item_widget.dart';
import 'package:class_compass/feature/course_management/course_category/presentation/widgets/create_new_course_category_widget.dart';

class CourseCategoryListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const CourseCategoryListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseCategoryController>(
      initState: (state) => Get.find<CourseCategoryController>().getCourseCategory(1),
      builder: (controller) {
        final courseCategoryModel = controller.courseCategoryModel;
        final courseCategoryData = courseCategoryModel?.data?.data ?? [];

        return GenericListSection<CourseCategoryItem>(
          sectionTitle: "course_management".tr,
          pathItems: ["category".tr],
          addNewTitle: "add_new_category".tr,
          onAddNewTap: () => Get.dialog(const Dialog(child: CreateNewCourseCategoryWidget())),
          headings: const ["image", "name", "description", "count", ],
          scrollController: scrollController,
          isLoading: courseCategoryModel == null,
          totalSize: courseCategoryModel?.data?.total ?? 0,
          offset: courseCategoryModel?.data?.currentPage ?? 0,
          onPaginate: (offset) async => await controller.getCourseCategory(offset ?? 1),
          items: courseCategoryData,
          itemBuilder: (item, index) => CourseCategoryItemWidget(
            index: index,
            courseCategoryItem: item,
          ),
        );
      },
    );
  }
}
