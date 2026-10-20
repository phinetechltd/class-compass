
import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/profile/domain/model/profile_model.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:get/get.dart';
import 'package:class_compass/util/images.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        initState: (val){
          if(Get.find<ProfileController>().profileModel == null){
            Get.find<ProfileController>().getProfileInfo();
          }
        },
      builder: (profileController) {
          bool isDesktop = ResponsiveHelper.isDesktop(context);
        return GetBuilder<SystemSettingsController>(
            builder: (systemSettingsController) {
              ProfileModel? profileModel = profileController.profileModel;
              String roleType = profileModel?.data?.role ?? '';
            return Center(child: InkWell(onTap: () => Get.toNamed(RouteHelper.getDashboardRoute()),
              child: Padding(padding: EdgeInsets.all(isDesktop? Dimensions.paddingSizeDefault : 0),
                child: roleType == "SAAS Admin"? const CustomImage(image: Images.logoOnDark, localAsset: true, height: 45,):
                // A school's own logo is usually designed for light backgrounds: show it on a white chip.
                Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: CustomImage(height: 36, image: systemSettingsController.logoUrl, fit: BoxFit.contain)),
              ),
            ),
            );
          }
        );
      }
    );
  }
}
