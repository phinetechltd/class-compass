import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class QuizResultRepository{
  final ApiClient apiClient;
  QuizResultRepository({required this.apiClient});


  Future<Response?> getQuizResultList() async {
    return await apiClient.getData(AppConstants.quizResult);
  }

  Future<Response?> getQuizReport (int id) async {
    return await apiClient.deleteData("${AppConstants.quizResult}/$id");
  }
}