import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/routine_management/exam_routine/domain/model/exam_routine_body.dart';
import 'package:class_compass/util/app_constants.dart';

class ExamRoutineRepository{
  final ApiClient apiClient;
  ExamRoutineRepository({required this.apiClient});

  Future<Response?> getExamRoutineList(int classId, int examId, int groupId) async {
    return await apiClient.getData("${AppConstants.examRoutine}?class_id=$classId&exam_id=$examId&group_id=$groupId");
  }



  Future<Response?> storeExamRoutine(ExamRoutineBody body) async {
    return await apiClient.postData(AppConstants.examRoutineStore, body.toJson());
  }

}