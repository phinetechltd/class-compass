import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class QuestionBankBoardRepository {
  final ApiClient apiClient;

  QuestionBankBoardRepository({required this.apiClient});
  
  Future<Response?> getQuestionBankBoard(int page) async {
    return await apiClient.getData("${AppConstants.questionBankBoard}?page=$page&perPage=20");
  }

  Future<Response?> createQuestionBankBoard(String board, String shortName) async {
    return await apiClient.postData(AppConstants.questionBankBoard, {"board": board, "short_name": shortName});
  }

  Future<Response?> editQuestionBankBoard(String board, String shortName, int id) async {
    return await apiClient.postData("${AppConstants.questionBankBoard}/$id", {"board": board, "short_name": shortName, "_method":"PUT"});
  }

  Future<Response?> deleteQuestionBankBoard(int id) async {
    return await apiClient.deleteData("${AppConstants.questionBankBoard}/$id");
  }
}
  