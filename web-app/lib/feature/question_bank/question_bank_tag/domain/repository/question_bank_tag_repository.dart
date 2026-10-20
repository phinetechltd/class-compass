import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class QuestionBankTagRepository {
  final ApiClient apiClient;

  QuestionBankTagRepository({required this.apiClient});
  
  Future<Response?> getQuestionBankTag(int page) async {
    return await apiClient.getData("${AppConstants.questionBankTag}?page=$page&perPage=20");
  }

  Future<Response?> createQuestionBankTag(String year) async {
    return await apiClient.postData(AppConstants.questionBankTag, {"tag_name": year});
  }

  Future<Response?> editQuestionBankTag(String year, int id) async {
    return await apiClient.postData("${AppConstants.questionBankTag}/$id", {"tag_name": year, "_method": "PUT"});
  }

  Future<Response?> deleteQuestionBankTag(int id) async {
    return await apiClient.deleteData("${AppConstants.questionBankTag}/$id");
  }
}
  