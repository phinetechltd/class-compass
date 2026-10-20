import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class StudentSyllabusRepository{
  final ApiClient apiClient;
  StudentSyllabusRepository({required this.apiClient});


  Future<Response?> getSyllabusList() async {
    return await apiClient.getData(AppConstants.studentSyllabus);
  }

  Future<Response?> getSyllabusDetails(int id) async {
    return await apiClient.getData("${AppConstants.studentSyllabus}/$id");
  }


}