import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/administrator/system_settings/presentation/widgets/style_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class ThemeColorWidget extends StatelessWidget {
  const ThemeColorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SystemSettingsController>(
      builder: (systemSettingsController) {
        return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: CustomContainer(
            child: Column(spacing: Dimensions.paddingSizeSmall, children: [
              ColorPickerField(
                initialColor: systemSettingsController.primaryColor,
                label: 'primary_color'.tr,
                onChanged: (val){
                  int hexInt = val.toARGB32();
                  String hexColor = '0x${hexInt.toRadixString(16).padLeft(8, '0').toUpperCase()}';
                  log("Primary Color is ==> $hexColor");
                  systemSettingsController.updatePrimaryColor(hexColor);
                },
              ),
              ColorPickerField(
                initialColor: systemSettingsController.sidebarColor,
                label: 'sidebar_color'.tr,
                onChanged: (val){
                  int hexInt = val.toARGB32();
                  String hexColor = '0x${hexInt.toRadixString(16).padLeft(8, '0').toUpperCase()}';
                  log("Sidebar Color is ==> $hexColor");
                  systemSettingsController.updateSidebarColor(hexColor);
                },
              ),
              ColorPickerField(
                initialColor: systemSettingsController.sidebarTextColor,
                label: 'sidebar_text_color'.tr,
                onChanged: (val){
                  int hexInt = val.toARGB32();
                  String hexColor = '0x${hexInt.toRadixString(16).padLeft(8, '0').toUpperCase()}';
                  log("Sidebar Text Color is ==> $hexColor");
                  systemSettingsController.updateSidebarTextColor(hexColor);
                },
              ),
            ],),
          ),
        );
      }
    );
  }
}
