import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class StudentSubjectRepository{
  final ApiClient apiClient;
  StudentSubjectRepository({required this.apiClient});

  Future<Response?> getMySubjectList() async {
    return await apiClient.getData(AppConstants.studentSubjectList);
  }
}