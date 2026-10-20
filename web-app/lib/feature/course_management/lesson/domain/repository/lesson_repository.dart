import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/course_management/lesson/domain/model/lesson_body.dart';
import 'package:class_compass/util/app_constants.dart';

class LessonRepository {
  final ApiClient apiClient;

  LessonRepository({required this.apiClient});
  
  Future<Response?> getLesson(int page) async {
    return await apiClient.getData("${AppConstants.lessons}?page=$page&perPage=20");
  }

  Future<Response?> createLesson(LessonBody body, XFile? image, MultipartDocument? videoFile, List<MultipartDocument> exerciseFiles) async {
    return await apiClient.postMultipartData(AppConstants.lessons, body.toJson(), [], MultipartBody("thumbnail_image", image), exerciseFiles, videoFile: videoFile);
  }



  Future<Response?> editLesson(LessonBody body, XFile? image, MultipartDocument? videoFile,List<MultipartDocument> exerciseFiles, int id) async {
    return await apiClient.postMultipartData("${AppConstants.lessons}/$id",body.toJson(), [], MultipartBody("thumbnail_image", image), exerciseFiles, videoFile: videoFile);
  }

  Future<Response?> deleteLesson(int chapterId, int contentId) async {
    return await apiClient.postData(AppConstants.deleteContent, {
      "chapter_id": chapterId,
      "content_id": contentId
    });
  }

}
  