import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/sms/sent_sms/domain/model/sent_sms_body.dart';
import 'package:class_compass/util/app_constants.dart';

class SentSmsRepository{
  final ApiClient apiClient;
  SentSmsRepository({required this.apiClient});

  Future<Response?> sentSms(SentSmsBody body) async {
    return await apiClient.postData(AppConstants.sendSms, body.toJson());
  }

  Future<Response?> getUsersForSms(String type) async {
    return await apiClient.getData("${AppConstants.userListForSms}?user_type=$type");
  }

  Future<Response?> sentSmsReport(int page, String? from, String? to) async {
    final queryParams = {
      'per_page': '10',
      'page': page.toString(),
      if (from != null && from.isNotEmpty) 'from': from,
      if (to != null && to.isNotEmpty) 'to': to,
    };

    final queryString = Uri(queryParameters: queryParams).query;

    return await apiClient.getData("${AppConstants.smsReport}?$queryString");
  }


  Future<Response?> getDateWiseAbsentStudentForSms(int classId, int sectionId, String date) async {
    return await apiClient.getData("${AppConstants.dateWiseAbsentStudentList}"
        "?class_id=$classId&section_id=$sectionId&date=$date");
  }

  Future<Response?> sendAbsentSms(List<int> students) async {
    return await apiClient.postData(AppConstants.sendAbsentSms,
    {
      "student_ids" : students
    });
  }

}