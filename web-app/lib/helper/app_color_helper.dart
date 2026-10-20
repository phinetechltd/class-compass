import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/cms_management/cms_settings/controller/frontend_settings_controller.dart';


Color systemPrimaryColor() {
  return Get.find<SystemSettingsController>().primaryColor;
}

Color systemSidebarColor() {
  return Get.find<SystemSettingsController>().sidebarColor;
}


Color systemLandingPagePrimaryColor() {
  return Get.find<FrontendSettingsController>().primaryColor;
}
