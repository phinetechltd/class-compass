import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/quiz_setting/domain/model/quiz_setting_model.dart';
import 'package:class_compass/util/app_constants.dart';

class QuizSettingRepository {
  final ApiClient apiClient;

  QuizSettingRepository({required this.apiClient});


  Future<Response?> createQuizSetting(QuizSettingBody body) async {
    return await apiClient.postData(AppConstants.quizManage, body.toJson());
  }
  Future<Response?> updateQuizSetting(QuizSettingBody body, int id) async {
    return await apiClient.postData("${AppConstants.quizManage}/$id", body.toJson());
  }

  Future<Response?> addQuestionToQuiz(List<int> questionIds, int id) async {
    return await apiClient.postData("${AppConstants.quizManage}/$id/questions", {"question_ids": questionIds, "_method":"PUT"});
  }

}
  