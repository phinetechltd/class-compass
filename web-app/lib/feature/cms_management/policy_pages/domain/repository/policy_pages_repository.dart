import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class PagesRepository {
  final ApiClient apiClient;

  PagesRepository({required this.apiClient});
  
  Future<Response?> getPages() async {
    return await apiClient.getData(AppConstants.policies);
  }

  Future<Response?> editPages() async {
    return await apiClient.getData(AppConstants.policies);
  }

}
  