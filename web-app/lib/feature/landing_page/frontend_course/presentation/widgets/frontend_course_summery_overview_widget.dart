
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/video_section/universal_video_player.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/feature/cms_management/cms_settings/controller/frontend_settings_controller.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/my_course_details_model.dart';
import 'package:class_compass/helper/price_converter.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class FrontendCourseSummeryOverviewWidget extends StatelessWidget {
  final MyCourseDetailsModel courseDetailsModel;
  const FrontendCourseSummeryOverviewWidget({super.key, required this.courseDetailsModel});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Get.find<FrontendSettingsController>().primaryColor;
    return CustomContainer(horizontalPadding: 0,verticalPadding: 0,
        width: ResponsiveHelper.isDesktop(context)?350: Get.width-30,
        child: Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start, children: [
          (courseDetailsModel.data?.courseVideoType == "upload")?
          UniversalVideoPlayer(
            onTap: (){
              // Get.dialog(CustomDialogWidget(child: CoursePreviewPlayerWidget(
              //   courseTitle: "", videos: courseDetailsModel.data?.courseChapters?.first.contents ??[],)));

            },
              videoUrl: "${AppConstants.baseUrl}/storage/lessons/${courseDetailsModel.data?.courseUploadedVideoPath ?? ""}"):
          UniversalVideoPlayer(videoUrl: "${courseDetailsModel.data?.courseVideoUrl}"),
          const CustomDivider(),

          Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                spacing: Dimensions.paddingSizeDefault, children: [
              const SizedBox(height: Dimensions.paddingSizeDefault),
              Text(PriceConverter.convertPrice(context, courseDetailsModel.data?.courseOfferPrice??0),
                  style: textHeavy.copyWith(fontSize: Dimensions.fontSizeExtraOverLarge)),

              Row(spacing: Dimensions.paddingSizeDefault, children: [
                Expanded(child: CustomButton(buttonColor: Theme.of(context).cardColor,
                    showBorderOnly: true,
                    borderWidth: .5,
                    fontWeight: FontWeight.w700,
                    borderColor: primaryColor,
                    textColor: primaryColor,
                    onTap: () async {}, text: "add_to_cart".tr)),

                Expanded(child: CustomButton(onTap: () async {}, text: "buy_now".tr))])
            ],),
          )

        ]));
  }
}
