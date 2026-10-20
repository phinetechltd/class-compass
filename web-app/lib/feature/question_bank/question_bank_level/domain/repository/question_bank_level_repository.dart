import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class QuestionBankLevelRepository {
  final ApiClient apiClient;

  QuestionBankLevelRepository({required this.apiClient});
  
  Future<Response?> getQuestionBankLevel(int page) async {
    return await apiClient.getData("${AppConstants.questionBankLevel}?page=$page&perPage=10");
  }

  Future<Response?> createQuestionBankLevel(String name, int chapterId) async {
    return await apiClient.postData(AppConstants.questionBankLevel, {"level_name": name, "chapter_id": chapterId});
  }

  Future<Response?> editQuestionBankLevel(String name, int chapterId, int id) async {
    return await apiClient.postData("${AppConstants.questionBankLevel}/$id", {"level_name": name, "chapter_id": chapterId, "id": id, "_method": "put"});
  }

  Future<Response?> deleteQuestionBankLevel(int id) async {
    return await apiClient.getData("${AppConstants.questionBankLevel}/$id");
  }
}
  