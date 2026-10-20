import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class QuestionBankYearRepository {
  final ApiClient apiClient;

  QuestionBankYearRepository({required this.apiClient});
  
  Future<Response?> getQuestionBankYear(int page) async {
    return await apiClient.getData("${AppConstants.questionBankYear}?page=$page&perPage=20");
  }

  Future<Response?> createQuestionBankYear(String year) async {
    return await apiClient.postData(AppConstants.questionBankYear, {"year": year});
  }

  Future<Response?> editQuestionBankYear(String year, int id) async {
    return await apiClient.postData("${AppConstants.questionBankYear}/$id", {"year": year, "_method": "PUT"});
  }

  Future<Response?> deleteQuestionBankYear(int id) async {
    return await apiClient.deleteData("${AppConstants.questionBankYear}/$id");
  }
}
  