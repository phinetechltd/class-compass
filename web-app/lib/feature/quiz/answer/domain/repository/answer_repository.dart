import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class AnswerRepository{
  final ApiClient apiClient;
  AnswerRepository({required this.apiClient});


  Future<Response?> getAnswerList() async {
    return await apiClient.getData(AppConstants.answers);
  }

  Future<Response?> deleteAnswer (int id) async {
    return await apiClient.deleteData("${AppConstants.answers}/$id");
  }
}