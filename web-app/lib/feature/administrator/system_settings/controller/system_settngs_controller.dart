
import 'dart:developer';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/academic_configuration/session/controller/session_controller.dart';
import 'package:class_compass/feature/administrator/system_settings/domain/model/general_settings_model.dart';
import 'package:class_compass/feature/administrator/system_settings/domain/repository/system_settings_repository.dart';
import 'package:class_compass/helper/image_size_checker.dart';
import 'package:class_compass/util/app_constants.dart';

class SystemSettingsController extends GetxController implements GetxService{
  final SystemSettingsRepository systemSettingsRepository;
  SystemSettingsController({required this.systemSettingsRepository});





  Color sidebarColor = const Color(0xFF043268);
  Color sidebarTextColor = const Color(0xFFFFFFFF);
  Color primaryColor = const Color(0xFF016DF6);

  bool loading = false;
  String? currentSessionId;
  String logoUrl = "";
  GeneralSettingModel? generalSettingModel;
  Future<void> getGeneralSetting() async {
    log("Current session id: $currentSessionId");
    Response? response = await systemSettingsRepository.getGeneralSetting();
    if (response?.statusCode == 200) {
      generalSettingModel = GeneralSettingModel.fromJson(response?.body);
      if (generalSettingModel != null) {
        logoUrl = "${AppConstants.baseUrl}/storage/logos/${generalSettingModel?.data?.logo}";
        sidebarColor = Color(int.parse(generalSettingModel?.data?.sidebarColor ?? "0xFF043268"));
        primaryColor = Color(int.parse(generalSettingModel?.data?.primaryColor ?? "0xFF016DF6"));
        sidebarTextColor = Color(int.parse(generalSettingModel?.data?.sidebarTextColor ?? "0xFFFFFFFF"));
        currentSessionId = generalSettingModel?.data?.academicYear;
        if(currentSessionId != null) {
          Get.find<SessionController>().getSessionNameFromSessionId(int.parse(currentSessionId!));
        }
      }
      log("Current session id: $currentSessionId");
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }





  Future<void>updateGeneralSetting(SettingItem body) async {
    loading = true;
    update();
    Response? response = await systemSettingsRepository.updateGeneralSetting(body);
    if (response?.statusCode == 200) {
      loading = false;
      getGeneralSetting();
      showCustomSnackBar("updated_successfully".tr, isError: false);
    }else{
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> updateSidebarColor(String color) async {
    loading = true;
    update();
    Response? response = await systemSettingsRepository.sideBarColorUpdate(color);
    if (response?.statusCode == 200) {
      loading = false;
      getGeneralSetting();
      showCustomSnackBar("updated_successfully".tr, isError: false);
    }else{
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> updateBulkSmsBd(String bulkSmsApiKey, String bulkSmsSenderId) async {
    loading = true;
    update();
    Response? response = await systemSettingsRepository.updateBulkSmsBd(bulkSmsApiKey, bulkSmsSenderId);
    if (response?.statusCode == 200) {
      loading = false;
      getGeneralSetting();
      showCustomSnackBar("updated_successfully".tr, isError: false);
    }else{
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> updateTwilioConfig (String twilioSid, String twilioToken, String twilioFromNumber) async {
    loading = true;
    update();
    Response? response = await systemSettingsRepository.updateTwilioSms(twilioSid, twilioToken, twilioFromNumber);
    if (response?.statusCode == 200) {
      loading = false;
      getGeneralSetting();
      showCustomSnackBar("updated_successfully".tr, isError: false);
    }else{
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }



  Future<void> updateSidebarTextColor(String color) async {
    loading = true;
    update();
    Response? response = await systemSettingsRepository.sideBarTextColorUpdate(color);
    if (response?.statusCode == 200) {
      loading = false;
      getGeneralSetting();
      showCustomSnackBar("updated_successfully".tr, isError: false);
    }else{
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  Future<void> updatePrimaryColor(String color) async {
    loading = true;
    update();
    Response? response = await systemSettingsRepository.primaryColorUpdate(color);
    if (response?.statusCode == 200) {
      loading = false;
      getGeneralSetting();
      showCustomSnackBar("updated_successfully".tr, isError: false);
    }else{
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }



  Future<void> uploadLogo() async {
    loading = true;
    update();
    Response? response = await systemSettingsRepository.uploadLogo(thumbnail);
    if (response?.statusCode == 200) {
      loading = false;
      getGeneralSetting();
      showCustomSnackBar("logo_uploaded_successfully".tr, isError: false);
    }else{
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }



  int settingsTypeIndex = 0;
  void setSelectedSettingsTypeIndex(int typeIndex){
    settingsTypeIndex = typeIndex;
    update();
  }


  XFile? thumbnail;
  XFile? pickedImage;
  void pickImage() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    double imageSizeIs = await ImageSize.getImageSize(pickedImage!);
    log("Here is image size ==> $imageSizeIs");
    if(imageSizeIs > 1){
      showCustomSnackBar("please_choose_image_size_less_than_2_mb".tr);
    }else{
      thumbnail = pickedImage;
    }
    update();
  }

  Future<void> setDefaultSmsGateway(String type) async {
    loading = true;
    update();
    Response? response = await systemSettingsRepository.setDefaultSmsGateway(type);
    if (response?.statusCode == 200) {
      loading = false;
      getGeneralSetting();
      showCustomSnackBar("updated_successfully".tr, isError: false);
    }else{
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


}