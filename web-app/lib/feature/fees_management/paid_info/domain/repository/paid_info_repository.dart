import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class PaidInfoRepository{
  final ApiClient apiClient;
  PaidInfoRepository({required this.apiClient});

  Future<Response?> getPaidInfo(int classId, String from, String to) async {
    return await apiClient.getData("${AppConstants.paidReport}?class_id=$classId&from_date=$from&to_date=$to");
  }

  Future<Response?> getUnPaidInfo(int classId, int? sectionId) async {
    return await apiClient.getData("${AppConstants.unPaidReport}?class_id=$classId&section_id=$sectionId",);
  }

}