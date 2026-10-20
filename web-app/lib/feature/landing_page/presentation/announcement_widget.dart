import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:class_compass/feature/cms_management/cms_settings/controller/frontend_settings_controller.dart';
import 'package:class_compass/feature/cms_management/cms_settings/domain/model/frontend_setting_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class AnnouncementWidget extends StatelessWidget {
  const AnnouncementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FrontendSettingsController>(
      initState: (val){
        Get.find<FrontendSettingsController>().getPublicSetting();
      },
      builder: (settingController) {
        FrontendSettingModel? settingModel = settingController.settingModel;
        String announcement = settingModel?.data?.headerNotice ?? 'Submit applications before the final date.';
        return (settingModel != null && settingModel.data?.headerNotice?.isNotEmpty == true)?
        Container(decoration: BoxDecoration(color: Theme.of(context).secondaryHeaderColor),
            width: double.infinity, height: 30,
            child: Center(child: Marquee(
                text: announcement,
                style:  textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeDefault),
                scrollAxis: Axis.horizontal,
                blankSpace: 20.0,
                velocity: 25.0,
                pauseAfterRound: const Duration(seconds: 1),
                startPadding: 10.0,
                accelerationDuration: Duration.zero,
                decelerationDuration: Duration.zero,
                accelerationCurve: Curves.linear,
                decelerationCurve: Curves.easeOut))):const SizedBox(height: 15);
      }
    );
  }
}
