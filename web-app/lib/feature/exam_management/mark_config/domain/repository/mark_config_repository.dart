import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/exam_management/mark_config/domain/model/general_exam_store_body.dart';
import 'package:class_compass/feature/exam_management/mark_config/domain/model/grand_final_exam_percentage_store_body.dart';
import 'package:class_compass/util/app_constants.dart';

class MarkConfigRepository{
  final ApiClient apiClient;
  MarkConfigRepository({required this.apiClient});

  Future<Response?> getGeneralExamList(int classId, int groupId) async {
    return await apiClient.getData("${AppConstants.getGeneralExamList}?class_id=$classId&group_id=$groupId");
  }

  Future<Response?> storeGeneralExam(GeneralExamStoreBody body) async {
    return await apiClient.postData(AppConstants.storeGeneralExam, body.toJson());
  }


  Future<Response?> classWseExam(int classId) async {
    return await apiClient.getData("${AppConstants.getGeneralExamList}?class_id=$classId");
  }

  Future<Response?> markConfigView(int classId, int examId, int groupId) async {
    return await apiClient.getData("${AppConstants.getGeneralExamList}?type=mark_config_view&class_id=$classId&group_id=$groupId&exam_id=$examId");
  }


  Future<Response?> getGrandFinalPercentage(int classId) async {
    return await apiClient.getData("${AppConstants.getGrandFinalExamPercentage}/$classId");
  }


  Future<Response?> storeGrandFinalExamPercentage(GrandFinalExamPercentageStoreBody body) async {
    return await apiClient.postData(AppConstants.storeGrandFinalExam, body.toJson());
  }





}