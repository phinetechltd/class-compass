import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class ProfileRepository{
  final ApiClient apiClient;
  ProfileRepository({required this.apiClient});


  Future<Response?> getProfileInfo() async {
    return await apiClient.getData(AppConstants.profile);
  }

  Future<Response?> updateProfile(String name, String email) async {
    return await apiClient.postData(AppConstants.updateProfile, {
      'name': name,
      'email': email,
    });
  }

  Future<Response?> changePassword(String oldPassword, String newPassword) async {
    return await apiClient.postData(AppConstants.changePassword, {
      'current_password': oldPassword,
      'password': newPassword,
      'password_confirmation': newPassword,
    });
  }
  Future<Response?> uploadImage(XFile? file) async {
    return await apiClient.uploadFile(AppConstants.galleries, {}, MultipartBody('image', file));
  }

}