import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/coutom_royte_path/custom_route_path_widget.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/administrator/system_settings/presentation/screens/system_settings_widget.dart';
import 'package:class_compass/feature/administrator/system_settings/presentation/widgets/select_logo_widget.dart';
import 'package:class_compass/feature/administrator/system_settings/presentation/widgets/system_settings_heading_section_widget.dart';
import 'package:class_compass/feature/administrator/system_settings/presentation/widgets/theme_color_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class SystemSettingScreen extends StatefulWidget {
  const SystemSettingScreen({super.key});

  @override
  State<SystemSettingScreen> createState() => _SystemSettingScreenState();
}

class _SystemSettingScreenState extends State<SystemSettingScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: "system_settings".tr),
      body: CustomWebScrollView(slivers: [

         SliverToBoxAdapter(child: GetBuilder<SystemSettingsController>(
           builder: (systemSettingsController) {

             return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: CustomRoutePathWidget(title: "master_configuration".tr)),

              const SystemSettingsHeadingSectionWidget(),
              if(systemSettingsController.settingsTypeIndex == 0)
              const SystemSettingWidget(),

               if(systemSettingsController.settingsTypeIndex == 1)
                 const SelectLogoWidget(),

               if(systemSettingsController.settingsTypeIndex == 2)
                 const ThemeColorWidget(),



             ],);
           }
         ),)
      ],),
    );
  }
}
