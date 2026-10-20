import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/domain/models/student_attendance_body.dart';
import 'package:class_compass/util/app_constants.dart';

class StudentAttendanceRepository{
  final ApiClient apiClient;
  StudentAttendanceRepository({required this.apiClient});



  Future<Response?> getStudentListForAttendance(
      int classId, int? sectionId, int? periodId, String date) async {

    Map<String, dynamic> query = {'class_id': classId, 'date': date};

    if (sectionId != null) {
      query['section_id'] = sectionId;
    }

    if (periodId != null) {
      query['period_id'] = periodId;
    }

    final uri = Uri.parse(AppConstants.studentAttendance).replace(queryParameters: query.map(
            (key, value) => MapEntry(key, value.toString())));
    return await apiClient.getData(uri.toString());
  }


  Future<Response?> createNewStudentAttendance(StudentAttendanceBody attendanceBody) async {
    return await apiClient.postData(AppConstants.studentAttendance, attendanceBody.toJson());
  }

  Future<Response?> updateAttendance(StudentAttendanceBody attendanceBody, int id) async {
    return await apiClient.putData("${AppConstants.attendance}/$id", attendanceBody.toJson());
  }

  Future<Response?> deleteAttendance (int id) async {
    return await apiClient.deleteData("${AppConstants.attendance}/$id");
  }

  Future<Response?> studentQrAttendance (String qrCode) async {
    return await apiClient.postData(AppConstants.qrAttendance,{
      "qr_code": qrCode,
    });
  }


  Future<Response?> studentAttendanceReport({
    required int classId, required int sectionId,
    int? studentId, String? fromDate,
    String? toDate, String? percentage}) async {
    final queryParams = {
      'class_id': classId.toString(),
      'section_id': sectionId.toString(),
      if (studentId != null) 'student_id': studentId.toString(),
      if (fromDate != null && fromDate.isNotEmpty) 'from_date': fromDate,
      if (toDate != null && toDate.isNotEmpty) 'to_date': toDate,
      if (percentage != null && percentage.isNotEmpty) 'percentage': percentage,
    };
    final uri = Uri.parse(AppConstants.studentAttendanceReport).replace(queryParameters: queryParams);
    return await apiClient.getData(uri.toString());
  }


  Future<Response?> monthlyStudentAttendanceReport({
    required int classId,
    required int sectionId,
    int? period,
    required String month,
    required String year,
  }) async {

    Map<String, String> body = {
      'class_id': classId.toString(),
      'section_id': sectionId.toString(),
      'month': "$month/$year",
    };

    if (period != null) {
      body['period_id'] = period.toString();
    }

    return await apiClient.postData(
      AppConstants.studentAttendanceMonthlyReport,
      body,
    );
  }




  Future<Response?> studentAbsentFineReport({
    required int classId, required int sectionId,
    int? studentId, String? fromDate,
    String? toDate, String? percentage}) async {
    final queryParams = {
      'class_id': classId.toString(),
      'section_id': sectionId.toString(),
      if (studentId != null) 'student_id': studentId.toString(),
      if (fromDate != null && fromDate.isNotEmpty) 'from_date': fromDate,
      if (toDate != null && toDate.isNotEmpty) 'to_date': toDate,

    };
    final uri = Uri.parse(AppConstants.studentAbsentFineReport).replace(queryParameters: queryParams);
    return await apiClient.getData(uri.toString());
  }



}