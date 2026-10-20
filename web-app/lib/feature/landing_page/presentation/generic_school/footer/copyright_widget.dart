import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/cms_management/cms_settings/controller/frontend_settings_controller.dart';
import 'package:class_compass/feature/cms_management/cms_settings/domain/model/frontend_setting_model.dart';
import 'package:class_compass/feature/landing_page/presentation/policy_enum.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class CopyrightWidget extends StatelessWidget {
  const CopyrightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FrontendSettingsController>(
      initState: (val){
        if(Get.find<FrontendSettingsController>().settingModel == null){
          Get.find<FrontendSettingsController>().getPublicSetting();
        }
      },
      builder: (settingController) {
        FrontendSettingModel? frontendSettingsModel = settingController.settingModel;
        String copyright = frontendSettingsModel?.data?.copyrightText ?? '© All Rights Reserved.';
        return Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
          color: Theme.of(context).cardColor,
          child: Center(child: SizedBox(width: Dimensions.webMaxWidth,
            child: Row(spacing: Dimensions.paddingSizeDefault, children: [
              Expanded(child: Text(copyright, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).hintColor))),
              InkWell(onTap: ()=> Get.toNamed(RouteHelper.getPolicyRoute(PolicyEnum.termsOfService)),
                  child: Text("terms_and_conditions".tr, style: textRegular.copyWith(color: Theme.of(context).hintColor))),
              InkWell(onTap: () => Get.toNamed(RouteHelper.getPolicyRoute(PolicyEnum.privacyPolicy)),
                  child: Text("privacy_policy".tr, style: textRegular.copyWith(color: Theme.of(context).hintColor))),

            ],
            ),
          ),
          ),
        );
      }
    );
  }
}
