import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/widget/paginated_list_widget.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/course_item_card_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import '../../domain/model/my_course_model.dart';

class AllCourseListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const AllCourseListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FrontendCourseController>(
        initState: (value){
          if(Get.find<FrontendCourseController>().courseModel == null){
            Get.find<FrontendCourseController>().getCourse(1);
          }
        },
        builder: (courseController) {
          ApiResponse<CourseItem>? courseModel = courseController.courseModel;
          final courseList = courseModel?.data?.data ?? [];

          return Center(
            child: SizedBox(width: Dimensions.webMaxWidth,
              child: PaginatedListWidget(scrollController: scrollController,
                  onPaginate: (int? page) async => await courseController.getCourse(page??1),
                  offset: courseModel?.data?.currentPage??1,
                  totalSize: courseModel?.data?.total??0,
                  itemView: MasonryGridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisSpacing: Dimensions.paddingSizeDefault,
                      mainAxisSpacing: Dimensions.paddingSizeDefault,
                      itemCount: courseList.length,
                      padding: EdgeInsets.zero,
                      gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 400),
                      itemBuilder: (context, index){
                        return CourseItemCardWidget(courses: courseList[index]);
                      })),
            ),
          );
        }
    );
  }
}
