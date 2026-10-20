import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/domain/models/about_us_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/about_us/about_us_loading_screen.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/about_us/web_about_us_info_section.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class AboutUsWidget extends StatelessWidget {
  const AboutUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(initState: (val){
        final landingPageController = Get.find<LandingPageController>();
        if (landingPageController.aboutUsModel == null) {
          landingPageController.getAboutData();
        }
      },
      builder: (landingPageController) {
        AboutUsModel? aboutUsModel = landingPageController.aboutUsModel;

        return Container(
          color: Theme.of(context).primaryColorDark.withValues(alpha: 0.1),
          padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.isDesktop(context) ? 50 :
          Dimensions.paddingSizeExtraLarge),
          child: ResponsiveHelper.isDesktop(context) ? Center(
            child: aboutUsModel != null?
            SizedBox(width: Dimensions.webMaxWidth,
              child: LandingAboutUsSection(aboutUsModel: aboutUsModel.data),
            ):const AboutUsLoadingScreen()) :
              aboutUsModel != null?
          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(spacing: Dimensions.paddingSizeDefault,children: [
                CustomImage( width: Get.width, image: "${AppConstants.imageBaseUrl}/about_us/${aboutUsModel.data?.image}"),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                Text('about_us'.tr, style: textMedium.copyWith(
                    fontSize: Dimensions.paddingSizeDefault, color: systemLandingPagePrimaryColor())),
                Text(aboutUsModel.data?.title ?? '',style: textBold.copyWith(
                    color: systemLandingPagePrimaryColor(),
                    fontSize: Dimensions.fontSizeExtraLarge),),
                Text(aboutUsModel.data?.description ?? '',maxLines: 5,overflow: TextOverflow.ellipsis,
                  style: textRegular.copyWith(color: Theme.of(context).hintColor),),

                const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                SizedBox(width: 200, child:
                    CustomButton(onTap: () {

                    }, text: "learn_more_about_us".tr)),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge),
              ],
            ),
          ):const AboutUsLoadingScreen(),
        );
      },
    );
  }


}