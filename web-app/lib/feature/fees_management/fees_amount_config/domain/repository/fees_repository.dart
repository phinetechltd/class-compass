import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/fees_management/fees_amount_config/domain/model/absent_fine_body.dart';
import 'package:class_compass/feature/fees_management/fees_amount_config/domain/model/fees_body.dart';
import 'package:class_compass/util/app_constants.dart';

class FeesRepository{
  final ApiClient apiClient;
  FeesRepository({required this.apiClient});

  Future<Response?> getFeesList(int page) async {
    return await apiClient.getData("${AppConstants.fees}?per_page=10&page=$page");
  }

  Future<Response?> addNewFees(FeesBody feesBody) async {
    return await apiClient.postData(AppConstants.fees, feesBody.toJson());
  }

  Future<Response?> updateFees(FeesBody feesBody, int id) async {
    return await apiClient.postData("${AppConstants.fees}/$id", {
      ...feesBody.toJson(),
      "_method": "PUT"
    });
  }

  Future<Response?> deleteFees(int id) async {
    return await apiClient.deleteData("${AppConstants.fees}/$id");
  }

  Future<Response?> getAbsentFineList(int page) async {
    return await apiClient.getData("${AppConstants.absentFine}?per_page=10&page=$page");
  }

  Future<Response?> addNewAbsentFine(AbsentFineBody body) async {
    return await apiClient.postData(AppConstants.absentFine, body.toJson());
  }

  Future<Response?> updateFeesDate(AbsentFineBody body, int id) async {
    return await apiClient.postData("${AppConstants.absentFine}/$id", body.toJson());
  }

  Future<Response?> deleteFeesDate( int id) async {
    return await apiClient.deleteData("${AppConstants.absentFine}/$id");
  }

}