import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class GroupRepository{
  final ApiClient apiClient;
  GroupRepository({required this.apiClient});

  Future<Response?> getGroupList(int page, {int? classId}) async {
    if(classId != null){
      return await apiClient.getData("${AppConstants.group}?per_page=10&page=$page&class_id=$classId");
    }else {
      return await apiClient.getData("${AppConstants.group}?per_page=10&page=$page");
    }
  }
  Future<Response?> addNewGroup(String name) async {
    return await apiClient.postData(AppConstants.group, {
      "group_name": name,

    });
  }



  Future<Response?> groupEdit(String name, int id) async {
    return await apiClient.postData("${AppConstants.group}/$id",
        {
          "group_name": name,
          "_method" : "PUT"
        });
  }

  Future<Response?> deleteGroup(int id) async {
    return await apiClient.deleteData("${AppConstants.group}/$id");
  }
}