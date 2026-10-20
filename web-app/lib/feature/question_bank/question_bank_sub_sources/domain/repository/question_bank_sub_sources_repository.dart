import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class QuestionBankSubSourcesRepository {
  final ApiClient apiClient;

  QuestionBankSubSourcesRepository({required this.apiClient});
  
  Future<Response?> getQuestionBankSubSources(int page) async {
    return await apiClient.getData("${AppConstants.questionBankSubSource}?page=$page&perPage=10");
  }

  Future<Response?> createQuestionBankSubSources(String subSource, int sourceId) async {
    return await apiClient.postData(AppConstants.questionBankSubSource, {"sub_source_name": subSource, "source_id": sourceId});
  }

  Future<Response?> editQuestionBankSubSources(String subSource, int sourceId, int id) async {
    return await apiClient.postData("${AppConstants.questionBankSubSource}/$id", {"sub_source_name": subSource, "source_id": sourceId, "_method": "PUT"});
  }

  Future<Response?> deleteQuestionBankSubSources(int id) async {
    return await apiClient.deleteData("${AppConstants.questionBankSubSource}/$id");
  }
}
  