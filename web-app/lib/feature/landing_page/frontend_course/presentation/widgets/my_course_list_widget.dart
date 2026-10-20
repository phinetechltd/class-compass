import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/coutom_royte_path/custom_route_path_widget.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/common/widget/no_data_found.dart';
import 'package:class_compass/feature/authentication/logic/authentication_controller.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/my_course_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/my_course_item_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';



class MyCourseListWidget extends StatefulWidget {
  final ScrollController scrollController;
  const MyCourseListWidget({super.key, required this.scrollController});

  @override
  State<MyCourseListWidget> createState() => _MyCourseListWidgetState();
}

class _MyCourseListWidgetState extends State<MyCourseListWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    return GetBuilder<FrontendCourseController>(
      initState: (val){
        if(Get.find<AuthenticationController>().isLoggedIn()) {
          Get.find<FrontendCourseController>().getMyCourse();
        }
      },
        builder: (courseController)  {

          final screenWidth = MediaQuery.of(context).size.width;
          const maxItemWidth = 400;
          const largeScreenThreshold = 2000;
          final crossAxisCount = screenWidth >= largeScreenThreshold ? 6 : (screenWidth / maxItemWidth).floor().clamp(1, 5);


          MyCourseModel? myCourseModel = courseController.myCourseModel;
          var course = myCourseModel?.data;
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if(isDesktop)
              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: CustomRoutePathWidget(title: "course_management".tr, subWidget: Row(children: [
                  PathItemWidget(title: "courses".tr,color: Theme.of(context).secondaryHeaderColor),
                ])),
              ),

              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: CustomContainer(showShadow: false,
                  child: Column(spacing: Dimensions.paddingSizeSmall, children: [

                    if(isDesktop)
                    const CustomTitle(title: "my_course"),
                    myCourseModel != null? (myCourseModel.data!= null && myCourseModel.data!.isNotEmpty)?
                    MasonryGridView.count(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: course?.length ?? 0,
                      itemBuilder: (context, index) {
                        return MyCourseItemWidget(courses: course?[index]);
                      }, // Dynamic height
                    ):
                    Padding(padding: ThemeShadow.getPadding(), child: const Center(child: NoDataFound())):
                    Padding(padding: ThemeShadow.getPadding(), child: const Center(child: CircularProgressIndicator())),
                  ],),
                ),
              ),
            ],
          );
        }
    );
  }
}
