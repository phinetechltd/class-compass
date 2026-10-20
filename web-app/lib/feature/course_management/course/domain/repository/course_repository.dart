import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/course_management/course/domain/model/chapter_reorder_body.dart';
import 'package:class_compass/feature/course_management/course/domain/model/content_reorder_body.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_body.dart';
import 'package:class_compass/util/app_constants.dart';

class CourseRepository {
  final ApiClient apiClient;

  CourseRepository({required this.apiClient});
  
  Future<Response?> getCourseList(int page, {int? categoryId}) async {
    if (categoryId == null) {
      return await apiClient.getData("${AppConstants.courses}?page=$page&per_page=30");
    }else {
      return await apiClient.getData("${AppConstants.courses}?page=$page&per_page=30&course_category_id=$categoryId");
    }
  }
  Future<Response?> getCourseDetails(String id) async {
    return await apiClient.getData("${AppConstants.courses}/$id");
  }

  Future<Response?> getCourseLessonDetails(String type, String typeId)  async {
    return await apiClient.postData(AppConstants.courseLessonDetails, {
      "type": type, "type_id": typeId});
  }

  Future<Response?> createCourse(CourseBody body, XFile? thumbnail, MultipartDocument? videoFile) async {
    return await apiClient.postMultipartData(AppConstants.courses, body.toJson(), [], MultipartBody("image", thumbnail), [], videoFile: videoFile);
  }

  Future<Response?> editCourse(CourseBody body, XFile? thumbnail, MultipartDocument? videoFile,int id) async {
    return await apiClient.postMultipartData("${AppConstants.courses}/$id", body.toJson(), [], MultipartBody("image", thumbnail), [], videoFile: videoFile);
  }

  Future<Response?> deleteCourse(int id) async {
    return await apiClient.deleteData("${AppConstants.courses}/$id");
  }
  Future<Response?> updatePriority() async {
    return await apiClient.getData("");
  }
  Future<Response?> chapterReorder(ChapterReorderBody body) async {
    return await apiClient.postData(AppConstants.chapterReorder, body.toJson());
  }
  Future<Response?> contentReorder(ContentReorderBody body) async {
    return await apiClient.postData(AppConstants.contentReorder, body.toJson());
  }
  Future<Response?> videoCipher(String name, String email, String videoId) async {
    return await apiClient.postData(AppConstants.videoCipher, {"name": name, "email": email, "video_id": videoId});
  }
}
  