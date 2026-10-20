import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class QuestionBankTypesRepository {
  final ApiClient apiClient;

  QuestionBankTypesRepository({required this.apiClient});
  
  Future<Response?> getQuestionBankTypes(int page) async {
    return await apiClient.getData("${AppConstants.questionBankType}?page=$page&perPage=10");
  }

  Future<Response?> createQuestionBankTypes(String name) async {
    return await apiClient.postData(AppConstants.questionBankType, {"type_name": name});
  }

  Future<Response?> editQuestionBankTypes(String name, int id) async {
    return await apiClient.postData("${AppConstants.questionBankType}/$id", {"type_name": name, "_method": "put"});
  }

  Future<Response?> deleteQuestionBankTypes(int id) async {
    return await apiClient.deleteData("${AppConstants.questionBankType}/$id");
  }
}
  