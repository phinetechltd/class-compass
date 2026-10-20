import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/fees_management/waiver_config/domain/model/waiver_config_body.dart';
import 'package:class_compass/util/app_constants.dart';

class WaiverConfigRepository{
  final ApiClient apiClient;
  WaiverConfigRepository({required this.apiClient});

  Future<Response?> getWaiverAssignListList(int page) async {
    return await apiClient.getData("${AppConstants.waiver}?per_page=10&page=$page");
  }

  Future<Response?> getWaiverConfigList(int page) async {
    return await apiClient.getData("${AppConstants.waiverConfig}?per_page=20&page=$page");
  }

  Future<Response?> waiverConfig(WaiverConfigBody body) async {
    return await apiClient.postData(AppConstants.waiverConfig,body.toJson());
  }
}