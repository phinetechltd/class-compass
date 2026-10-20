import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class QuestionBankSourcesRepository {
  final ApiClient apiClient;

  QuestionBankSourcesRepository({required this.apiClient});
  
  Future<Response?> getQuestionBankSources(int page) async {
    return await apiClient.getData("${AppConstants.questionBankSource}?page=$page&perPage=10");
  }

  Future<Response?> createQuestionBankSources(String sourceName) async {
    return await apiClient.postData(AppConstants.questionBankSource, {"source_name": sourceName});
  }

  Future<Response?> editQuestionBankSources(String sourceName, int id) async {
    return await apiClient.postData("${AppConstants.questionBankSource}/$id", {"source_name": sourceName, "_method": "PUT"});
  }

  Future<Response?> deleteQuestionBankSources(int id) async {
    return await apiClient.deleteData("${AppConstants.questionBankSource}/$id");
  }
}
  