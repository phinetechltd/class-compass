import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/staff_information/teacher/domain/model/teacher_body.dart';
import 'package:class_compass/util/app_constants.dart';

class StaffRepository{
  final ApiClient apiClient;
  StaffRepository({required this.apiClient});

  Future<Response?> getStaffList(int page ) async {
    return await apiClient.getData("${AppConstants.staff}?per_page=10&page=$page");
  }



  Future<Response?> addNewStaff(TeacherBody staffBody, XFile? profileImage ) async {
    return await apiClient.postMultipartData(AppConstants.staff,
        staffBody.toJson(),[],MultipartBody('image', profileImage),[]
    );
  }

  Future<Response?> updateStaff(TeacherBody staffBody, XFile? profileImage, int id ) async {
    return await apiClient.postMultipartData("${AppConstants.staff}/$id",
        staffBody.toJson(),[],MultipartBody('image', profileImage),[]
    );
  }

  Future<Response?> staffDetails(int id ) async {
    return await apiClient.getData("${AppConstants.staff}/$id");
  }

  Future<Response?> deleteStaff(int id ) async {
    return await apiClient.deleteData("${AppConstants.staff}/$id");
  }
}