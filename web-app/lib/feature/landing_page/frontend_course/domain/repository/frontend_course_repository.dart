import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/quiz_submit_body.dart';
import 'package:class_compass/util/app_constants.dart';

class FrontendCourseRepository {
  final ApiClient apiClient;

  FrontendCourseRepository({required this.apiClient});
  
  Future<Response?> getCourse(int page) async {
    return await apiClient.getData("${AppConstants.frontendCourses}?perPage=10&page=$page");
  }


  Future<Response?> getMyCourse() async {
    return await apiClient.getData(AppConstants.myCourse);
  }

  Future<Response?> getMyCourseDetails(String tag)  async {
    return await apiClient.getData("${AppConstants.myCourseDetails}/$tag");
  }

  Future<Response?> getMyCourseLessonDetails(String type, String typeId)  async {
    return await apiClient.postData(AppConstants.myCourseLessonDetails, {
      "type": type, "type_id": typeId});
  }

  Future<Response?> getCategoryWiseCourse() async {
    return await apiClient.getData(AppConstants.frontendCategoryWiseCourses);
  }

  Future<Response?> frontendCourseDetails(String tag) async {
    return await apiClient.getData("${AppConstants.frontendCourseDetails}/$tag");
  }


  Future<Response?> getQuizDetails(int typeId) async {
    return await apiClient.getData("${AppConstants.quizDetails}$typeId");
  }

  Future<Response?> quizAttempt(int quizId) async {
    return await apiClient.postData(AppConstants.quizStart,{
      "quiz_id": quizId
    });
  }

  Future<Response?> quizAnswerSubmit(QuizSubmitBody body) async {
    return await apiClient.postData(AppConstants.quizSubmit, body.toJson());
  }

  Future<Response?> quizResults(int quizId, int attemptId) async {
    return await apiClient.postData(AppConstants.quizResults, {"quiz_id": quizId, "attempt_id": attemptId});
  }

  Future<Response?> videoCipher(String name, String email, String videoId) async {
    return await apiClient.postData(AppConstants.videoCipher, {"name": name, "email": email, "video_id": videoId});
  }






}
  