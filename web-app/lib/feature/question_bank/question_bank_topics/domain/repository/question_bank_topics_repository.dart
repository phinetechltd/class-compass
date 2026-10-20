import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class QuestionBankTopicsRepository {
  final ApiClient apiClient;

  QuestionBankTopicsRepository({required this.apiClient});
  
  Future<Response?> getQuestionBankTopics(int page, {int? chapterId}) async {
    return await apiClient.getData("${AppConstants.questionBankTopic}?page=$page&perPage=50&chapter_id=$chapterId");
  }

  Future<Response?> createQuestionBankTopics(String name, int chapterId) async {
    return await apiClient.postData(AppConstants.questionBankTopic, {"name": name, "chapter_id": chapterId});
  }

  Future<Response?> editQuestionBankTopics(String name, int chapterId, id) async {
    return await apiClient.postData("${AppConstants.questionBankTopic}/$id", {"name": name, "chapter_id": chapterId, "id": id, "_method": "put"});
  }

  Future<Response?> deleteQuestionBankTopics(int id) async {
    return await apiClient.deleteData("${AppConstants.questionBankTopic}/$id");
  }
}
  