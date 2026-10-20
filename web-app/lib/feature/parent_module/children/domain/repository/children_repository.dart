import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:get/get.dart' as get_type;

class ChildrenRepository{
  final ApiClient apiClient;
  ChildrenRepository({required this.apiClient});

  Future<Response?> getChildrenList() async {
    return await apiClient.getData(AppConstants.children);
  }

  Future<Response?> setDefaultChildren(String id) async {
    return await apiClient.postData(AppConstants.setDefaultChildren, {'student_id': id});
  }

  Future<Response?> getChildrenBehaviors(int page) async {
    final String? userType = get_type.Get.find<ProfileController>().profileModel?.data?.role;
    if(userType == AppConstants.parent){
      return await apiClient.getData("${AppConstants.childrenBehaviors}?page=$page&perPage=10");
    }else {
      return await apiClient.getData("${AppConstants.studentBehaviour}?page=$page&perPage=10");
    }

  }

}