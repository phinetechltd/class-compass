import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/cms_management/cms_settings/controller/frontend_settings_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class FooterLeftPortion extends StatelessWidget {
  const FooterLeftPortion({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FrontendSettingsController>(
      builder: (settingController) {
        return Padding(padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: ResponsiveHelper.isDesktop(context)? CrossAxisAlignment.start : CrossAxisAlignment.center, children: [

              CustomImage(height: 40, image: settingController.logo),
               SizedBox(height: ResponsiveHelper.isDesktop(context)? 30 : Dimensions.paddingSizeDefault),
              Text(Get.find<FrontendSettingsController>().settingModel?.data?.siteTitle ?? AppConstants.slogan,
                style: textRegular.copyWith(color: Theme.of(context).hintColor),),
               SizedBox(height: ResponsiveHelper.isDesktop(context)? 40: Dimensions.paddingSizeDefault),
               Row(spacing: Dimensions.paddingSizeDefault,
                 mainAxisAlignment: ResponsiveHelper.isDesktop(context)? MainAxisAlignment.start: MainAxisAlignment.center,
                 children: [
                InkWell(onTap: (){},
                    child: FaIcon(FontAwesomeIcons.facebook, color: Theme.of(context).hintColor, size: 20)),
                InkWell(onTap: (){

                },
                    child: FaIcon(FontAwesomeIcons.twitter, color: Theme.of(context).hintColor, size: 20)),
                InkWell(onTap: (){

                },
                    child: FaIcon(FontAwesomeIcons.linkedin, color: Theme.of(context).hintColor, size: 20)),
              ],
              )
            ],
          ),
        );
      }
    );
  }
}
