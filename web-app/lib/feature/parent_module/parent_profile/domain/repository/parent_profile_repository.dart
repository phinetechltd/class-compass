import 'package:get/get.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class ParentProfileRepository{
  final ApiClient apiClient;
  ParentProfileRepository({required this.apiClient});


  Future<Response?> getProfileInfo() async {
    return await apiClient.getData(AppConstants.parentProfile);
  }

  /// The same overview for a parent (their selected child) or for a learner (themselves).
  Future<Response?> getDashboardData() async {
    final role = Get.find<ProfileController>().profileModel?.data?.role;
    return await apiClient.getData(role == AppConstants.studentType ? AppConstants.studentDashboardData : AppConstants.parentDashboardData);
  }

}