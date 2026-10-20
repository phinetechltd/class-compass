import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/fees_management/fees_date/domain/model/fees_date_body.dart';
import 'package:class_compass/util/app_constants.dart';

class FeesDateRepository{
  final ApiClient apiClient;
  FeesDateRepository({required this.apiClient});

  Future<Response?> getFeesDateList(int page, {String? feeHeadId}) async {
    if(feeHeadId != null){
      return await apiClient.getData("${AppConstants.feesDate}?per_page=10&page=$page&fee_head_id=$feeHeadId");
    }else{
    return await apiClient.getData("${AppConstants.feesDate}?per_page=10&page=$page");
    }
  }

  Future<Response?> feeDateConfigStore(FeesDateBody body) async {
   return await apiClient.postData(AppConstants.feesDate, body.toJson());
  }

  Future<Response?> getAbsentFineList(int page) async {
    return await apiClient.getData("${AppConstants.absentFine}?per_page=10&page=$page");
  }

  Future<Response?> addNewFeesDate(FeesDateBody feesDateBody) async {
    return await apiClient.postData(AppConstants.feesDate, feesDateBody.toJson());
  }

  Future<Response?> updateFeesDate(String payableDate, String fineActiveDate, int id) async {
    return await apiClient.postData("${AppConstants.feesDate}/$id",
        {
          "payable_date": payableDate,
          "fine_active_date": fineActiveDate,
          "_method": "put"
        });
  }

  Future<Response?> deleteFeesDate( int id) async {
    return await apiClient.deleteData("${AppConstants.feesDate}/$id");
  }

  Future<Response?> getFeeDateConfigSearchByFeeHead(int feeHeadId) async {
    return await apiClient.postData(AppConstants.feesDateConfigSearch,
        {"fee_head_id": feeHeadId});
  }


}