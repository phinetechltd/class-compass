
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/cms_management/cms_settings/controller/frontend_settings_controller.dart';


class SystemSettingScreen extends StatefulWidget {
  const SystemSettingScreen({super.key});

  @override
  State<SystemSettingScreen> createState() => _SystemSettingScreenState();
}

class _SystemSettingScreenState extends State<SystemSettingScreen> {
  @override
  void initState() {
    if(Get.find<FrontendSettingsController>().settingModel == null){
      Get.find<FrontendSettingsController>().getPublicSetting();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: "system_setting".tr),
      body: CustomWebScrollView(slivers: [

         SliverToBoxAdapter(child: GetBuilder<FrontendSettingsController>(
           builder: (systemSettingsController) {

             return const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

               
             ],);
           }
         ),)
      ],),
    );
  }
}
