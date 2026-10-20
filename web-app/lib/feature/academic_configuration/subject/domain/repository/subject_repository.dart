import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/academic_configuration/subject/domain/model/subject_body.dart';
import 'package:class_compass/util/app_constants.dart';

class SubjectRepository{
  final ApiClient apiClient;
  SubjectRepository({required this.apiClient});


  Future<Response?> getSubjectList(int page, {int? classId}) async {
    if(classId != null){
      return await apiClient.getData("${AppConstants.subjects}?page=$page&per_page=100&class_id=$classId");
    }else {
      return await apiClient.getData("${AppConstants.subjects}?page=$page&per_page=100");
    }
  }

  Future<Response?> addNewSubject(SubjectBody subjectBody) async {
    return await apiClient.postData(AppConstants.subjects, subjectBody.toJson());
  }

  Future<Response?> updateSubject(SubjectBody subjectBody, int id) async {
    return await apiClient.postData("${AppConstants.subjects}/$id", subjectBody.toJson());
  }

  Future<Response?> deleteSubject(int classId) async {
    return await apiClient.deleteData("${AppConstants.subjects}/$classId");
  }
}