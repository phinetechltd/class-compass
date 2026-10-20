import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/routine_management/assignment/domain/models/assignment_body.dart';
import 'package:class_compass/util/app_constants.dart';

class AssignmentRepository{
  final ApiClient apiClient;
  AssignmentRepository({required this.apiClient});


  Future<Response?> getAssignmentList(int page) async {
    return await apiClient.getData("${AppConstants.assignment}?page=$page&per_page=10");
  }

  Future<Response?> createNewAssignment( AssignmentBody assignmentBody ,
      List<MultipartDocument> attachments) async {
    return await apiClient.postMultipartData(
        AppConstants.assignment, assignmentBody.toJson(), [], null, attachments);
  }

  Future<Response?> updateAssignment( AssignmentBody assignmentBody,
      List<MultipartDocument> attachments, int id,) async {

    return await apiClient.postMultipartData("${AppConstants.assignment}/$id",
        assignmentBody.toJson(), [], null, attachments);
  }
  

  Future<Response?> deleteAssignment (int id) async {
    return await apiClient.deleteData("${AppConstants.assignment}/$id");
  }
}