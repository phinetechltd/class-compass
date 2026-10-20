

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/feature/cms_management/cms_settings/domain/model/frontend_setting_model.dart';
import 'package:class_compass/feature/cms_management/cms_settings/domain/repository/frontend_settings_repository.dart';
import 'package:class_compass/util/app_constants.dart';

class FrontendSettingsController extends GetxController implements GetxService{
  final FrontendSettingsRepository frontendSettingsRepository;
  FrontendSettingsController({required this.frontendSettingsRepository});


  Color primaryColor = const Color(0xFF016DF6);

  FrontendSettingModel? settingModel;
  String? logo;
  Future<void> getPublicSetting() async {
    Response? response = await frontendSettingsRepository.getSetting();
    if (response?.statusCode == 200) {
      settingModel = FrontendSettingModel.fromJson(response?.body);
      logo = "${AppConstants.imageBaseUrl}/logos/${settingModel?.data?.logo}";
      primaryColor = AppConstants.parseHexColor((settingModel?.data?.primaryColor ?? "0xFF016DF6"));
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }


}