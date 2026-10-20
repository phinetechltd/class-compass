
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/my_course_details_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/zoom_item_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class FrontendMyCourseDetailsLiveClassWidget extends StatelessWidget {
  const FrontendMyCourseDetailsLiveClassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FrontendCourseController>(
      builder: (courseController) {
        MyCourseDetailsModel? courseDetailsModel = courseController.myCourseDetailsModel;
        return Padding(padding: const EdgeInsets.only(top : Dimensions.paddingSizeDefault),
          child: Column(spacing: Dimensions.paddingSizeExtraSmall, children: [

            if(courseDetailsModel?.data?.zoomMeetings != null && courseDetailsModel!.data!.zoomMeetings!.isNotEmpty)
              Column(mainAxisSize: MainAxisSize.min,
                children: [
                  if(ResponsiveHelper.isDesktop(context))
                  Row(spacing: Dimensions.paddingSizeSmall, children: [
                    Expanded(child: Text("title".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),)),
                    Expanded(child: Text('start_time'.tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),)),
                    Expanded(child: Text('duration'.tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),)),
                    Expanded(child: Text('join_url'.tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),)),
                  ]),
                  if(ResponsiveHelper.isDesktop(context))
                  const CustomDivider(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: courseDetailsModel.data?.zoomMeetings?.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, index){
                    return ZoomItemWidget(zoomItem: courseDetailsModel.data?.zoomMeetings?[index], index: index,);
                  },),
                ],
              )
          ],
          ),
        );
      }
    );
  }
}
