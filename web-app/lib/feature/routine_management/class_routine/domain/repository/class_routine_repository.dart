
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/routine_management/class_routine/domain/models/class_routine_body.dart';
import 'package:class_compass/util/app_constants.dart';

class ClassRoutineRepository{
  final ApiClient apiClient;
  ClassRoutineRepository({required this.apiClient});


  Future<Response?> getClassRoutine(int classId, int sectionId) async {
    return await apiClient.getData("${AppConstants.classRoutine}?class_id=$classId&section_id=$sectionId");
  }

  Future<Response?> addNewClassRoutine(ClassRoutineBody body) async {
    return await apiClient.postData(AppConstants.classRoutine, body.toJson());
  }

}