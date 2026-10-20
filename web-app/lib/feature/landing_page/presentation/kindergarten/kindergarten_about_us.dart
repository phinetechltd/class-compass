import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/domain/models/about_us_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/about_us/about_us_loading_screen.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class KindergartenAboutUsWidget extends StatelessWidget {
  const KindergartenAboutUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      initState: (val){
        final landingPageController = Get.find<LandingPageController>();
        if (landingPageController.aboutUsModel == null) {
          landingPageController.getAboutData();
        }
      },
      builder: (landingPageController) {
        AboutUsModel? aboutUsModel = landingPageController.aboutUsModel;

        return Container(
          padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.isDesktop(context) ? 50 : Dimensions.paddingSizeExtraLarge),
          child: ResponsiveHelper.isDesktop(context) ? Center(
            child: aboutUsModel != null?
            SizedBox(width: Dimensions.webMaxWidth,
              child: Row(spacing: 40, children: [

                  Expanded(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(aboutUsModel.data?.title ?? '',
                            style: textBold.copyWith(color: Theme.of(context).colorScheme .primary, fontSize: 40)),
                        Text( aboutUsModel.data?.description ?? 'We provide a nurturing environment, a challenging curriculum, and a dedicated faculty to ensure student success.',
                          maxLines: 5, overflow: TextOverflow.ellipsis,
                          style: textRegular.copyWith(color: Theme.of(context).hintColor),),
                        const SizedBox(height: 50),
                        SizedBox(width: 200,child: CustomButton(buttonColor: Theme.of(context).secondaryHeaderColor,
                            onTap: () {}, text: "learn_more_about_us".tr)),
                      ],
                    ),
                  ),
                CustomImage(width: 445,height: 450, image: "${AppConstants.imageBaseUrl}/about_us/${aboutUsModel.data?.image}"),

              ]),
            ):const AboutUsLoadingScreen()) :
              aboutUsModel != null?
          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault), child: Column(children: [
                CustomImage( width: Get.width, image: aboutUsModel.data?.image ?? ''),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                Text('about_us'.tr, style: textMedium.copyWith(
                    fontSize: Dimensions.paddingSizeDefault, color: systemLandingPagePrimaryColor())),
                Text(aboutUsModel.data?.title ?? '',style: textBold.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeExtraLarge),),
                Text(aboutUsModel.data?.description ?? '',maxLines: 5,overflow: TextOverflow.ellipsis,style: textRegular.copyWith(color: Theme.of(context).hintColor),),
                SizedBox(width: 200,
                    child:
                    CustomButton(buttonColor: Theme.of(context).secondaryHeaderColor,
                        onTap: () {}, text: "learn_more_about_us".tr)),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge),
              ],
            ),
          ):const AboutUsLoadingScreen(),
        );
      },
    );
  }


}