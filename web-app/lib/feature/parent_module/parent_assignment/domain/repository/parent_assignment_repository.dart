import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';


class ParentAssignmentRepository{
  final ApiClient apiClient;
  ParentAssignmentRepository({required this.apiClient});


  Future<Response?> getChildrenAssignment(int page) async {
    return await apiClient.getData("${AppConstants.childrenAssignment}?page=$page&perPage=10");
  }

  Future<Response?> getSubmittedAssignmentList(int page) async {
    return await apiClient.getData("${AppConstants.submittedAssignmentList}?page=$page&perPage=10");
  }
}