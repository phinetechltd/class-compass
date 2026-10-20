import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/coutom_royte_path/custom_route_path_widget.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/sms/sms_config/bulk_sms_config_widget.dart';
import 'package:class_compass/feature/sms/sms_config/twilio_sms_config_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class SmsSettingScreen extends StatefulWidget {
  const SmsSettingScreen({super.key});

  @override
  State<SmsSettingScreen> createState() => _SmsSettingScreenState();
}

class _SmsSettingScreenState extends State<SmsSettingScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: CustomAppBar(title: "sms_configuration".tr),
      body: CustomWebScrollView(slivers: [

        SliverToBoxAdapter(child: GetBuilder<SystemSettingsController>(
            initState: (val){
              if(Get.find<SystemSettingsController>().generalSettingModel == null){
                Get.find<SystemSettingsController>().getGeneralSetting();
              }

            }, builder: (systemSettingsController) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: CustomRoutePathWidget(title: "sms_configuration".tr)),


            const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: CustomContainer(child: Column(spacing: Dimensions.paddingSizeDefault, children: [
                  BulkSmsSettingsWidget(),
                  TwilioSmsSettingsWidget()
                ])))
          ],);
        }
        ),)
      ],),
    );
  }
}
