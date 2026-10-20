import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class FrontendSettingsRepository{
  final ApiClient apiClient;
  FrontendSettingsRepository({required this.apiClient});


  Future<Response?> getSetting () async {
    return await apiClient.getData(AppConstants.frontendSettings);
  }

  Future<Response?> setDefaultTheme (int id) async {
    return await apiClient.getData(AppConstants.institutes);
  }

  Future<Response?> getDefaultTheme () async {
    return await apiClient.getData(AppConstants.getDefaultTheme);
  }
}