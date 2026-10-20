import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class CourseCategoryRepository {
  final ApiClient apiClient;

  CourseCategoryRepository({required this.apiClient});
  
  Future<Response?> getCourseCategory(int page) async {
    return await apiClient.getData("${AppConstants.courseCategories}?page=$page");
  }

  Future<Response?> createCourseCategory(String? name, String? description, String? parentId, XFile? image) async {
    return await apiClient.postMultipartData(AppConstants.courseCategories, {
      "name": name??'',
      "description": description??'',
      "parent_id": parentId??'',
    }, [], MultipartBody("image", image), []);
  }

  Future<Response?> editCourseCategory(String? name, String? description, String? parentId,XFile? image, int id) async {
    return await apiClient.postMultipartData("${AppConstants.courseCategories}/$id",{
      "name": name??'',
      "description": description??'',
      "parent_id": parentId??'',
      "_method":"PUT"
    }, [], MultipartBody("image", image), []);
  }

  Future<Response?> deleteCourseCategory(int id) async {
    return await apiClient.deleteData("${AppConstants.courseCategories}/$id");
  }
  Future<Response?> updatePriority() async {
    return await apiClient.getData("");
  }
}
  