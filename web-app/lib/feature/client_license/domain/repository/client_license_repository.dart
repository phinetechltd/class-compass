import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class ClientLicenseRepository {
  final ApiClient apiClient;
  ClientLicenseRepository({required this.apiClient});

  Future<Response?> getLicenseList(int page, {String? status, String? search}) async {
    String uri = "${AppConstants.clientLicenses}?page=$page&perPage=10";
    if (status != null && status.isNotEmpty) uri += "&status=$status";
    if (search != null && search.isNotEmpty) uri += "&search=$search";
    return await apiClient.getData(uri);
  }

  Future<Response?> getInstituteList(int page) async {
    return await apiClient.getData("${AppConstants.institutes}?page=$page&perPage=100");
  }

  Future<Response?> getPlanList(int page) async {
    return await apiClient.getData("${AppConstants.plans}?page=$page&perPage=100");
  }

  Future<Response?> generateLicenseKey() async {
    return await apiClient.getData(AppConstants.clientLicenseGenerateKey);
  }

  Future<Response?> createLicense(Map<String, dynamic> body) async {
    return await apiClient.postData(AppConstants.clientLicenses, body);
  }

  Future<Response?> updateLicense(Map<String, dynamic> body, int id) async {
    return await apiClient.putData("${AppConstants.clientLicenses}/$id", body);
  }

  Future<Response?> deleteLicense(int id) async {
    return await apiClient.deleteData("${AppConstants.clientLicenses}/$id");
  }

  Future<Response?> changeStatus(int id) async {
    return await apiClient.getData("${AppConstants.clientLicenseStatusUpdate}/$id");
  }
}
