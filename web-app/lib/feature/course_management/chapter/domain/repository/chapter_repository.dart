import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/course_management/chapter/domain/model/chapter_body.dart';
import 'package:class_compass/util/app_constants.dart';

class ChapterRepository {
  final ApiClient apiClient;

  ChapterRepository({required this.apiClient});
  
  Future<Response?> getChapter(int page, {int? subjectId}) async {
    return await apiClient.getData("${AppConstants.chapters}?page=$page&perPage=20&subject_id=$subjectId");
  }

  Future<Response?> createChapter(ChapterBody body) async {
    return await apiClient.postData(AppConstants.chapters, body.toJson());
  }

  Future<Response?> editChapter(ChapterBody body, int id) async {
    return await apiClient.postData("${AppConstants.chapters}/$id",body.toJson());
  }

  Future<Response?> deleteChapter(int id) async {
    return await apiClient.deleteData("${AppConstants.chapters}/$id");
  }

}
  