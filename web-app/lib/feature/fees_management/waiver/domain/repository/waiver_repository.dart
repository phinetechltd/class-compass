import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class WaiverRepository{
  final ApiClient apiClient;
  WaiverRepository({required this.apiClient});

  Future<Response?> getWaiverList(int page) async {
    return await apiClient.getData("${AppConstants.waiver}?per_page=20&page=$page");
  }

  Future<Response?> addNewWaiver(String name) async {
    return await apiClient.postData(AppConstants.waiver, {"waiver": name});
  }

  Future<Response?> editWaiver(String name, int id) async {
    return await apiClient.postData("${AppConstants.waiver}/$id",
        {"waiver": name, "_method" : "put"});
  }

  Future<Response?> deleteWaiver(int id) async {
    return await apiClient.deleteData("${AppConstants.waiver}/$id");
  }

}