import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/cms_management/cms_settings/controller/frontend_settings_controller.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';

class LogoSectionWidget extends StatelessWidget {
  const LogoSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FrontendSettingsController>(
      initState: (value){
        if(Get.find<FrontendSettingsController>().settingModel == null){
          Get.find<FrontendSettingsController>().getPublicSetting();
        }
      },
      builder: (settingController) {
        return InkWell(onTap: (){
          Get.toNamed(RouteHelper.getInitialRoute());
        }, child: Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
          // School logos are made for light backgrounds; this sits on the coloured app bar.
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: CustomImage(image: settingController.logo, height: 30, fit: BoxFit.contain, placeholder: Images.logoWithName),
          ),
        ));
      }
    );
  }
}
