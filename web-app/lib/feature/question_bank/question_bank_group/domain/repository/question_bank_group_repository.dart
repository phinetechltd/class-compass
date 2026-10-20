import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class QuestionBankGroupRepository {
  final ApiClient apiClient;

  QuestionBankGroupRepository({required this.apiClient});
  
  Future<Response?> getQuestionBankGroup(int page) async {
    return await apiClient.getData("${AppConstants.questionBankGroup}?perPage=20&page=$page");
  }

  Future<Response?> createQuestionBankGroup(String classId, String name) async {
    return await apiClient.postData(AppConstants.questionBankGroup, {
      "class_id": classId,
      "name": name});
  }

  Future<Response?> editQuestionBankGroup(String classId,String name, int id) async {
    return await apiClient.postData("${AppConstants.questionBankGroup}/$id",
        {"name": name,  "class_id": classId, "_method": "PUT"});
  }

  Future<Response?> deleteQuestionBankGroup(int id) async {
    return await apiClient.deleteData("${AppConstants.questionBankGroup}/$id");
  }
}
  