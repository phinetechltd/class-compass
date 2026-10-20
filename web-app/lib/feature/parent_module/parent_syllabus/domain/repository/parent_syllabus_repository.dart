import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class ParentSyllabusRepository{
  final ApiClient apiClient;
  ParentSyllabusRepository({required this.apiClient});


  Future<Response?> getSyllabusList() async {
    return await apiClient.getData(AppConstants.parentSyllabus);
  }

  Future<Response?> getSyllabusDetails(int id) async {
    return await apiClient.getData("${AppConstants.parentSyllabus}/$id");
  }


}