import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/exam_management/mark_input/domain/models/mark_input_body.dart';
import 'package:class_compass/util/app_constants.dart';

class MarkInputRepository{
  final ApiClient apiClient;
  MarkInputRepository({required this.apiClient});



  Future<Response?> getMarkInput(int classId, int examId, int groupId, int subjectId) async {
    return await apiClient.getData("${AppConstants.getMarkInput}$classId?exam_id=$examId&group_id=$groupId&subject_id=$subjectId");
  }


  Future<Response?> markInput(MarkInputBody body) async {
    return await apiClient.postData(AppConstants.sectionWiseMarkInput, body.toJson());
  }


}