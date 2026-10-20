import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class ExamResultRepository{
  final ApiClient apiClient;
  ExamResultRepository({required this.apiClient});

  Future<Response?> getExamResult(
      int classId,
      int? groupId,
      int? examId,
      int page,
      ) async {
    final queryParams = {
      'class_id': classId.toString(),
      if (groupId != null) 'group_id': groupId.toString(),
      if (examId != null) 'exam_id': examId.toString(),
      // if (studentId != null) 'student_id': studentId.toString(),
      'page': page.toString(),
      'perPage': '10',
    };

    final uri = Uri(
      path: AppConstants.examResult,
      queryParameters: queryParams,
    );

    return await apiClient.getData(uri.toString());
  }

}