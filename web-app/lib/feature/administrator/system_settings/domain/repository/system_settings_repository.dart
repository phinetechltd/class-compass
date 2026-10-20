import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/administrator/system_settings/domain/model/general_settings_model.dart';
import 'package:class_compass/util/app_constants.dart';

class SystemSettingsRepository{
  final ApiClient apiClient;
  SystemSettingsRepository({required this.apiClient});


  Future<Response?> getGeneralSetting () async {
    return await apiClient.getData(AppConstants.generalSetting);
  }

    Future<Response?> getGeneralPublicSetting () async {
    return await apiClient.getData(AppConstants.publicSetting);
  }



  Future<Response?> updateGeneralSetting (SettingItem body) async {
    return await apiClient.postData(AppConstants.generalSetting, {
      "school_name" : body.schoolName,
      "site_title" : body.siteTitle,
      "phone" : body.phone,
      "email" : body.email,
      "institute_code" : body.instituteCode,
      "address" : body.address,
      "tuition_fee_phone" : body.tuitionFeePhone,
      "exam_result_phone" : body.examResultPhone,
      "eiin_code" : body.eiinCode,
      "header_notice" : body.headerNotice,
      "tc_amount" : body.tcAmount,
      "app_version" : body.appVersion,
      "app_url" : body.appUrl,
      "exam_result_status": body.examResultStatus,
      "admission_display_status": body.admissionDisplayStatus,
      "currency_symbol" : body.currencySymbol,
    });
  }

  Future<Response?> sideBarColorUpdate (String color) async {
    return await apiClient.postData(AppConstants.generalSetting, {
      "sidebar_color" : color,
    });
  }

  Future<Response?> updateBulkSmsBd (String bulkSmsApiKey, String bulkSmsSenderId) async {
    return await apiClient.postData(AppConstants.generalSetting, {
      "bulk_sms_api_key" : bulkSmsApiKey,
      "bulk_sms_sender_id" : bulkSmsSenderId
    });
  }


  Future<Response?> updateTwilioSms (String twilioSid, String twilioToken, String twilioFromNumber) async {
    return await apiClient.postData(AppConstants.generalSetting, {
      "twilio_sid" : twilioSid,
      "twilio_token" : twilioToken,
      "twilio_from_number" : twilioFromNumber,
    });
  }


  Future<Response?> sideBarTextColorUpdate (String color) async {
    return await apiClient.postData(AppConstants.generalSetting, {
      "sidebar_text_color" : color,
    });
  }

  Future<Response?> primaryColorUpdate (String color) async {
    return await apiClient.postData(AppConstants.generalSetting, {
      "primary_color" : color,
    });
  }



  Future<Response?> uploadLogo (XFile? logo) async {
    return await apiClient.postMultipartData(AppConstants.uploadLogo, {"logo" : "logo"}, [], MultipartBody("logo", logo), []);
  }

  Future<Response?> setDefaultSmsGateway (String type) async {
    return await apiClient.postData(AppConstants.generalSetting, {
      "sms_gateway" : type,
    });
  }

}