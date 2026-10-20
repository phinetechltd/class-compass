import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class PackageRepository{
  final ApiClient apiClient;
  PackageRepository({required this.apiClient});


  Future<Response?> getPackageList(int page) async {
    return await apiClient.getData("${AppConstants.plans}?page=$page&perPage=10");
  }



  Future<Response?> subscriptionPlanUpdate(int planId, int instituteId) async {
    return await apiClient.postData(AppConstants.subscriptionPlanUpdate,{
      "plan_id": planId,
      "institute_id": instituteId,
    });
  }


  Future<Response?> getSaasPaymentGateway() async {
    return await apiClient.getData(AppConstants.saasPayment);
  }

}